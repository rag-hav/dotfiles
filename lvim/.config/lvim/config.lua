lvim.log.level = "warn"
lvim.leader = "space"

-- lvim.format_on_save = true
-- vim.o.background = "dark"
lvim.colorscheme = "onedark"
-- lvim.builtin.lualine.theme = "onedark"
vim.g.tokyonight_transparent = true
vim.opt.timeoutlen = 1000
vim.opt.cmdheight = 1
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.wrap = true
vim.opt.autochdir = true
vim.opt.relativenumber = true
vim.g.exec_width = 70

lvim.builtin.alpha.active = true
lvim.builtin.terminal.active = true
lvim.builtin.global_status_line = { active = true }

local cmp_types = require("cmp.types.cmp")
local ConfirmBehavior = cmp_types.ConfirmBehavior
local SelectBehavior = cmp_types.SelectBehavior

local cmp = require("lvim.utils.modules").require_on_index("cmp")
local luasnip = require("lvim.utils.modules").require_on_index("luasnip")
local cmp_window = require("cmp.config.window")
local cmp_mapping = require("cmp.config.mapping")

local confirm_opts = {
	behavior = require("cmp.types.cmp").ConfirmBehavior.Insert,
	select = false,
}
lvim.builtin.cmp.completion = {
	completeopt = "menu,menuone,noinsert,preview",
	confirm_opts = confirm_opts,
}
lvim.builtin.cmp.mapping = cmp_mapping.preset.insert({
	["<C-k>"] = cmp_mapping(cmp_mapping.select_prev_item(), { "i", "c" }),
	["<C-j>"] = cmp_mapping(cmp_mapping.select_next_item(), { "i", "c" }),
	["<Down>"] = cmp_mapping(cmp_mapping.select_next_item({ behavior = SelectBehavior.Select }), { "i" }),
	["<Up>"] = cmp_mapping(cmp_mapping.select_prev_item({ behavior = SelectBehavior.Select }), { "i" }),
	["<C-d>"] = cmp_mapping.scroll_docs(-4),
	["<C-f>"] = cmp_mapping.scroll_docs(4),
	["<C-y>"] = cmp_mapping({
		i = cmp_mapping.confirm({ behavior = ConfirmBehavior.Replace, select = false }),
		c = function(fallback)
			if cmp.visible() then
				cmp.confirm({ behavior = ConfirmBehavior.Replace, select = false })
			else
				fallback()
			end
		end,
	}),
	-- ["<Tab>"] = cmp_mapping(function(fallback)
	--   if cmp.visible() then
	--     cmp.select_next_item()
	--   elseif luasnip.expand_or_locally_jumpable() then
	--     luasnip.expand_or_jump()
	--   elseif jumpable(1) then
	--     luasnip.jump(1)
	--   elseif has_words_before() then
	--     -- cmp.complete()
	--     fallback()
	--   else
	--     fallback()
	--   end
	-- end, { "i", "s" }),
	-- ["<S-Tab>"] = cmp_mapping(function(fallback)
	--   if cmp.visible() then
	--     cmp.select_prev_item()
	--   elseif luasnip.jumpable(-1) then
	--     luasnip.jump(-1)
	--   else
	--     fallback()
	--   end
	-- end, { "i", "s" }),
	["<C-Space>"] = cmp_mapping.complete(),
	["<C-e>"] = cmp_mapping.abort(),
	-- ["<CR>"] = cmp_mapping(function(fallback)
	--   if cmp.visible() then
	--     local confirm_opts = vim.deepcopy(lvim.builtin.cmp.confirm_opts) -- avoid mutating the original opts below
	--     local is_insert_mode = function()
	--       return vim.api.nvim_get_mode().mode:sub(1, 1) == "i"
	--     end
	--     if is_insert_mode() then -- prevent overwriting brackets
	--       confirm_opts.behavior = ConfirmBehavior.Insert
	--     end
	--     local entry = cmp.get_selected_entry()
	--     local is_copilot = entry and entry.source.name == "copilot"
	--     if is_copilot then
	--       confirm_opts.behavior = ConfirmBehavior.Replace
	--       confirm_opts.select = true
	--     end
	--     if cmp.confirm(confirm_opts) then
	--       return -- success, exit early
	--     end
	--   end
	--   fallback() -- if not exited early, always fallback
	-- end),

	["<Tab>"] = cmp_mapping(function(fallback)
		if cmp.visible() then
			cmp.confirm(confirm_opts)
		elseif luasnip.expand_or_locally_jumpable() then
			luasnip.expand_or_jump()
			-- elseif jumpable(1) then
			-- 	luasnip.jump(1)
			-- elseif has_words_before() then
			-- 	-- cmp.complete()
			-- 	fallback()
			else
			fallback()
		end
	end, { "i", "s" }),
	-- ["<CR>"] = cmp_mapping(function(fallback)
		-- fallback() -- if not exited early, always fallback
	-- end),
})
-- org mode
table.insert(lvim.builtin.cmp.sources, { name = "copilot" })

lvim.builtin.treesitter.highlight.additional_vim_regex_highlighting = { "markdown" }

lvim.builtin.nvimtree.setup.diagnostics.icons.hint = ""
lvim.builtin.nvimtree.setup.diagnostics.icons.info = ""

vim.lsp.handlers["textDocument/references"] = require("telescope.builtin").lsp_references
vim.lsp.handlers["textDocument/declaration"] = require("telescope.builtin").lsp_implementations

table.insert(lvim.lsp.automatic_configuration.skipped_servers, "jdtls")
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ name = "black" },
	-- {
	--   name = "prettier",
	--   ---@usage arguments to pass to the formatter
	--   -- these cannot contain whitespace
	--   -- options such as `--line-width 80` become either `{"--line-width", "80"}` or `{"--line-width=80"}`
	--   args = { "--print-width", "100" },
	--   ---@usage only start in these filetypes, by default it will attach to all filetypes it supports
	--   filetypes = { "typescript", "typescriptreact" },
	-- },
})
-- lvim.lsp.diagnostics.virtual_text = false

-- vim.api.nvim_create_autocmd("CursorHold", {
-- pattern = "*",
-- command = "lua vim.diagnostic.open_float({focusable=true})",
-- })

require("funcs")
require("plugins")
require("formatters")
require("keymaps")
