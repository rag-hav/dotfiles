lvim.log.level = "warn"
lvim.leader = "space"
-- lvim.format_on_save = true
lvim.colorscheme = "onedark"
lvim.builtin.lualine.theme = "onedark"
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

lvim.lsp.diagnostics.virtual_text = false

vim.api.nvim_create_autocmd("CursorHold", {
	pattern = "*",
	command = "lua vim.diagnostic.open_float({focusable=true})",
})

require("funcs")
require("plugins")
require("formatters")
require("keymaps")
