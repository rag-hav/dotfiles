lvim.log.level = "warn"
lvim.leader = "space"
-- lvim.format_on_save = true
lvim.colorscheme = "rose-pine"
lvim.builtin.lualine.theme = "rose-pine"
vim.opt.timeoutlen = 1000
vim.opt.cmdheight = 1
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.wrap = true
vim.opt.autochdir = true
vim.opt.relativenumber = true
vim.g.exec_width = 50

lvim.builtin.alpha.active = true
lvim.builtin.terminal.active = true
lvim.builtin.notify.active = true
lvim.builtin.global_status_line = { active = true }
lvim.builtin.cmp.completion = {
	completeopt = "menu,menuone,noinsert,preview",
}

lvim.builtin.project.detection_methods = { "=src", ".git", "Makefile" }

-- lvim.builtin.cmp.sources.insert({ name = "neorg" })
lvim.builtin.cmp.formatting.source_names["copilot"] = "(Copilot)"
table.insert(lvim.builtin.cmp.sources, 1, { name = "copilot" })

require("lvim.lsp.null-ls.formatters").setup({
	{ command = "black" },
	{ command = "prettier" },
	{ command = "stylua" },
	{ command = "sqlformat" },
	{ command = "shellharden" },
})
require("lvim.lsp.null-ls.linters").setup({
	{ command = "shellcheck" },
	-- { command = "proselint" },
})

-- keymaps
lvim.leader = "space"
lvim.keys.normal_mode["<CR>"] = ":noh<cr><cr>"
lvim.keys.visual_mode["*"] = '"sy/<C-R>s<CR>'
lvim.keys.visual_mode["#"] = '"sy?<C-R>s<CR>'
lvim.keys.term_mode["jk"] = "<C-\\><C-n>"
lvim.keys.term_mode["kj"] = "<C-\\><C-n>"

lvim.lsp.diagnostics.virtual_text = false
-- Autocommands (https://neovim.io/doc/user/autocmd.html)
vim.api.nvim_create_autocmd("CursorHold", {
	pattern = "*",
	command = "lua vim.diagnostic.open_float({focusable=true})",
})

require("plugin")
require("funcs")
require("plugins/lualine")
require("plugins/dashboard")
require("plugins/whichkey")
