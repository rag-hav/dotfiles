local kind = require("plugins.builtins.lualine.lsp_kind")
local diag_source = "nvim_lsp"
local ok, _ = pcall(require, "vim.diagnostic")
local isgps, gps = pcall(require, "nvim-gps")
if ok then
	diag_source = "nvim_diagnostic"
end

local function lsp_progress()
	local messages = vim.lsp.util.get_progress_messages()
	if #messages == 0 then
		return ""
	end
	local status = {}
	for _, msg in pairs(messages) do
		table.insert(status, (msg.percentage or 0) .. "%% " .. (msg.title or ""))
	end
	local spinners = {
		" ",
		" ",
		" ",
		" ",
		" ",
		" ",
		" ",
		" ",
		" ",
		" ",
		" ",
		" ",
		" ",
		" ",
		" ",
		" ",
		" ",
		" ",
		" ",
		" ",
		" ",
		" ",
		" ",
		" ",
		" ",
		" ",
		" ",
		" ",
	}
	local ms = vim.loop.hrtime() / 1000000
	local frame = math.floor(ms / 60) % #spinners
	return spinners[frame + 1] .. " " .. table.concat(status, " | ")
end

vim.cmd([[autocmd User LspProgressUpdate let &ro = &ro]])

local function diff_source()
	local gitsigns = vim.b.gitsigns_status_dict
	if gitsigns then
		return {
			added = gitsigns.added,
			modified = gitsigns.changed,
			removed = gitsigns.removed,
		}
	end
end

local function testing()
	if vim.g.testing_status == "running" then
		return " "
	end
	if vim.g.testing_status == "fail" then
		return ""
	end
	if vim.g.testing_status == "pass" then
		return " "
	end
	return nil
end
local function using_session()
	return (vim.g.using_persistence ~= nil)
end

local themes = require("plugins.builtins.lualine.theme").colors
local colors = themes.onedarker_colors

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80 or lvim.builtin.global_status_line.active
	end,
	hide_small = function()
		return vim.fn.winwidth(0) > 150 or lvim.builtin.global_status_line.active
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand("%:p:h")
		local gitdir = vim.fn.finddir(".git", filepath .. ";")
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}

-- Config
local config = {
	options = {
		icons_enabled = true,
		component_separators = nil,
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "dashboard", "NvimTree", "Outline", "alpha", "toggleterm", "aerial" },
	},
	sections = {
		lualine_a = {
			{
				"mode",
				fmt = function()
					return " "
				end,
				padding = 0,
			},
		},
		lualine_b = {
			{
				"branch",
				icon = " ",
				cond = conditions.check_git_workspace,
				color = { fg = colors.blue },
				padding = 1,
			},
			{
				"filetype",
				colored = true,
				icon_only = true,
				padding = { left = 1, right = 0 },
			},
			{
				"filename",
				file_status = true,
				path = 1,
				shorting_target = 150,
				symbols = {
					modified = "  ", -- Text to show when the file is modified.
					readonly = "  ", -- Text to show when the file is non-modifiable or readonly.
					unnamed = "[No Name]", -- Text to show for unnamed buffers.
				},
			},
		},
		lualine_c = {
			{
				gps.get_location,
				cond = isgps and gps.is_available,
			},
		},

		lualine_x = {
			{
				"diff",
				source = diff_source,
				symbols = { added = "  ", modified = "柳", removed = " " },
				diff_color = {
					added = { fg = colors.git.add },
					modified = { fg = colors.git.change },
					removed = { fg = colors.git.delete },
				},
				color = {},
				cond = nil,
			},

			{
				"diagnostics",
				sources = { diag_source },
				symbols = {
					error = kind.icons.error,
					warn = kind.icons.warn,
					info = kind.icons.info,
					hint = kind.icons.hint,
				},
				cond = conditions.hide_in_width,
			},

			{
				lsp_progress,
				cond = conditions.hide_small,
			},
		},
		lualine_y = {
			{
				function()
					local utils = require("lvim.core.lualine.utils")
					if vim.bo.filetype == "python" then
						local venv = os.getenv("CONDA_DEFAULT_ENV")
						if venv then
							return string.format("  (%s)", utils.env_cleanup(venv))
						end
						venv = os.getenv("VIRTUAL_ENV")
						if venv then
							return string.format("  (%s)", utils.env_cleanup(venv))
						end
						return ""
					end
					return ""
				end,
				color = { fg = colors.green },
				cond = conditions.hide_in_width,
			},
			-- {
			-- 	testing,
			-- 	cond = function()
			-- 		return testing() ~= nil
			-- 	end,
			-- 	color = { fg = colors.red },
			-- },

			-- {
			-- 	provider = function()
			-- 		if vim.g.using_persistence then
			-- 			return "  |"
			-- 		elseif vim.g.using_persistence == false then
			-- 			return "  |"
			-- 		end
			-- 	end,
			-- 	enabled = function()
			-- 		return using_session()
			-- 	end,
			-- 	hl = {
			-- 		fg = colors.fg,
			-- 	},
			-- },
			{
				function()
					if not vim.bo.readonly or not vim.bo.modifiable then
						return ""
					end
					return "" -- """
				end,
				color = { fg = colors.red },
			},

			{
				"fileformat",
				color = { fg = colors.green, gui = "bold" },
				cond = conditions.hide_in_width,
			},
			{ "filesize" },
			{
				function()
					return vim.fn.wordcount()["visual_chars"] or ""
				end,
			},
		},
		lualine_z = {
			{ "location", padding = 0 },
			{ "progress", padding = 1 },
		},
	},
	inactive_sections = {
		-- these are to remove the defaults
		lualine_a = {},
		lualine_v = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {
			{
				"filename",
				file_status = true,
				cond = conditions.buffer_not_empty,
				symbols = {
					modified = "  ", -- Text to show when the file is modified.
					readonly = "  ", -- Text to show when the file is non-modifiable or readonly.
					unnamed = "[No Name]", -- Text to show for unnamed buffers.
				},
			},
		},
		lualine_x = {},
	},
}

-- Now don't forget to initialize lualine
lvim.builtin.lualine.options = config.options
lvim.builtin.lualine.sections = config.sections
lvim.builtin.lualine.inactive_sections = config.inactive_sections
