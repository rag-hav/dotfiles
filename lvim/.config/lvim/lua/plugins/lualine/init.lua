local kind = require("plugins.lualine.lsp_kind")
local diag_source = "nvim_lsp"
local ok, _ = pcall(require, "vim.diagnostic")
local gps = require("nvim-gps")
if ok then
	diag_source = "nvim_diagnostic"
end

local MAX_FILENAME_SIZE = 25

local function lsp_progress()
	local messages = vim.lsp.util.get_progress_messages()
	if #messages == 0 then
		return ""
	end
	local status = {}
	for _, msg in pairs(messages) do
		table.insert(status, (msg.percentage or 0) .. "%% " .. (msg.title or ""))
	end
	-- local spinners = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
	-- local spinners = { " ", " ", " ", " ", " ", " ", " ", " ", " ", " " }
	-- local spinners = { " ", " ", " ", " ", " ", " ", " ", " ", " " }
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

local mode = function()
	local mod = vim.fn.mode()

	if mod == "n" or mod == "no" or mod == "nov" then
		return "  "
	elseif mod == "i" or mod == "ic" or mod == "ix" then
		return "  "
	elseif mod == "V" or mod == "v" or mod == "vs" or mod == "Vs" or mod == "cv" then
		return " 勇"
	elseif mod == "c" or mod == "ce" then
		return "  "
	elseif mod == "r" or mod == "rm" or mod == "r?" or mod == "R" or mod == "Rc" or mod == "Rv" or mod == "Rv" then
		return "  "
	end
	return "  "
end

local file_icon_colors = {
	Brown = "#905532",
	Aqua = "#3AFFDB",
	Blue = "#689FB6",
	DarkBlue = "#44788E",
	Purple = "#834F79",
	Red = "#AE403F",
	Beige = "#F5C06F",
	Yellow = "#F09F17",
	Orange = "#D4843E",
	DarkOrange = "#F16529",
	Pink = "#CB6F6F",
	Salmon = "#EE6E73",
	Green = "#8FAA54",
	LightGreen = "#31B53E",
	White = "#FFFFFF",
	LightBlue = "#5fd7ff",
}

local themes = require("plugins.lualine.theme").colors
local colors = themes.rose_pine_colors

-- Color table for highlights
local mode_color = {
	n = colors.blue,
	i = colors.green,
	v = colors.yellow,
	[""] = colors.purple,
	V = colors.yellow,
	c = colors.cyan,
	no = colors.magenta,
	s = colors.orange,
	S = colors.orange,
	[""] = colors.orange,
	ic = colors.yellow,
	R = colors.violet,
	Rv = colors.violet,
	cv = colors.red,
	ce = colors.red,
	r = colors.cyan,
	rm = colors.cyan,
	["r?"] = colors.cyan,
	["!"] = colors.red,
	t = colors.red,
}
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
		-- Disable sections and component separators
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		theme = {
			-- We are going to use lualine_c an lualine_x as left and
			-- right section. Both are highlighted by c theme .  So we
			-- are just setting default looks o statusline
			normal = {
				a = { fg = colors.fg, bg = colors.bg },
				b = { fg = colors.fg, bg = colors.bg },
				c = { fg = colors.fg, bg = colors.bg },
			},
			inactive = { c = { fg = colors.fg, bg = colors.bg_alt } },
		},
		disabled_filetypes = { "dashboard", "NvimTree", "Outline", "alpha", "toggleterm" },
	},
	sections = {
		lualine_a = {
			{
				function()
					vim.api.nvim_command(
						"hi! LualineMode guifg=" .. mode_color[vim.fn.mode()] .. " guibg=" .. colors.bg
					)
					return mode()
				end,
				color = "LualineMode",
				padding = { left = 1, right = 0 },
			},
		},
		lualine_b = {
			{
				"b:gitsigns_head",
				icon = " ",
				cond = conditions.check_git_workspace,
				color = { fg = colors.blue },
				padding = 0,
			},
			{
				function()
					local fname = vim.fn.expand("%:p")
					local ftype = vim.fn.expand("%:e")
					local cwd = vim.api.nvim_call_function("getcwd", {})
					local show_name = vim.fn.expand("%:t")
					if #cwd > 0 and #ftype > 0 then
						show_name = fname:sub(#cwd + 2)
					end
					if #show_name > MAX_FILENAME_SIZE then
						show_name = "..." .. show_name:sub(math.max(1, 4 + #show_name - MAX_FILENAME_SIZE))
					end
					return show_name:sub(math.max(1, 1 + #show_name - MAX_FILENAME_SIZE))
						.. "%{&readonly?'  ':''}"
						.. "%{&modified?'  ':''}"
				end,
				cond = conditions.buffer_not_empty,
				padding = { left = 1, right = 1 },
				color = { fg = colors.fg, gui = "bold" },
			},
		},
		lualine_c = {
			{
				gps.get_location,
				cond = gps.is_available,
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
			{
				provider = function()
					return testing()
				end,
				enabled = function()
					return testing() ~= nil
				end,
				hl = {
					fg = colors.fg,
				},
				left_sep = " ",
				right_sep = {
					str = " |",
					hl = { fg = colors.fg },
				},
			},

			{
				provider = function()
					if vim.g.using_persistence then
						return "  |"
					elseif vim.g.using_persistence == false then
						return "  |"
					end
				end,
				enabled = function()
					return using_session()
				end,
				hl = {
					fg = colors.fg,
				},
			},

			{
				lsp_progress,
				cond = conditions.hide_small,
			},
		},
		lualine_y = {
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
				function(msg)
					msg = msg or kind.icons.ls_inactive .. "LS Inactive"
					local buf_clients = vim.lsp.buf_get_clients()
					if next(buf_clients) == nil then
						if type(msg) == "boolean" or #msg == 0 then
							return kind.icons.ls_inactive .. "LS Inactive"
						end
						return msg
					end
					local buf_ft = vim.bo.filetype
					local buf_client_names = {}
					local trim = vim.fn.winwidth(0) < 120
					if lvim.builtin.global_status_line.active then
						trim = false
					end

					for _, client in pairs(buf_clients) do
						if client.name ~= "null-ls" then
							local _added_client = client.name
							if trim then
								_added_client = string.sub(client.name, 1, 4)
							end
							table.insert(buf_client_names, _added_client)
						end
					end

					-- add formatter
					local formatters = require("lvim.lsp.null-ls.formatters")
					local supported_formatters = {}
					for _, fmt in pairs(formatters.list_registered_providers(buf_ft)) do
						local _added_formatter = fmt
						if trim then
							_added_formatter = string.sub(fmt, 1, 4)
						end
						table.insert(supported_formatters, _added_formatter)
					end
					vim.list_extend(buf_client_names, supported_formatters)

					-- add linter
					local linters = require("lvim.lsp.null-ls.linters")
					local supported_linters = {}
					for _, lnt in pairs(linters.list_registered_providers(buf_ft)) do
						local _added_linter = lnt
						if trim then
							_added_linter = string.sub(lnt, 1, 4)
						end
						table.insert(supported_linters, _added_linter)
					end
					vim.list_extend(buf_client_names, supported_linters)

					return kind.icons.ls_active .. table.concat(buf_client_names, ", ")
				end,
				color = { fg = colors.fg },
				cond = conditions.hide_in_width,
			},

			{
				"location",
				padding = 0,
				color = { fg = colors.orange },
			},

			{
				function()
					local function format_file_size(file)
						local size = vim.fn.getfsize(file)
						if size <= 0 then
							return ""
						end
						local sufixes = { "b", "k", "m", "g" }
						local i = 1
						while size > 1024 do
							size = size / 1024
							i = i + 1
						end
						return string.format("%.1f%s", size, sufixes[i])
					end
					local file = vim.fn.expand("%:p")
					if string.len(file) == 0 then
						return ""
					end
					return format_file_size(file)
				end,
				cond = conditions.buffer_not_empty,
			},
			{
				"fileformat",
				fmt = string.upper,
				icons_enabled = true,
				color = { fg = colors.green, gui = "bold" },
				cond = conditions.hide_in_width,
			},

			{
				function()
					local current_line = vim.fn.line(".")
					local total_lines = vim.fn.line("$")
					local chars = {
						"__",
						"▁▁",
						"▂▂",
						"▃▃",
						"▄▄",
						"▅▅",
						"▆▆",
						"▇▇",
						"██",
					}
					local line_ratio = current_line / total_lines
					local index = math.ceil(line_ratio * #chars)
					return string.format("%d:%d %s", current_line, total_lines, chars[index])
				end,
				padding = 1,
				color = { fg = colors.yellow, bg = colors.bg },
				cond = nil,
			},
		},
		lualine_z = {},
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
				cond = conditions.buffer_not_empty,
				color = { fg = colors.blue, gui = "bold" },
			},
		},
		lualine_x = {},
	},
}

-- Now don't forget to initialize lualine
lvim.builtin.lualine.options = config.options
lvim.builtin.lualine.sections = config.sections
lvim.builtin.lualine.inactive_sections = config.inactive_sections
