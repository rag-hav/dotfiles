lvim.log.level = "warn"
lvim.leader = "space"
-- lvim.format_on_save = true
lvim.colorscheme = "rose-pine"
lvim.builtin.lualine.theme = 'rose-pine';
vim.opt.timeoutlen = 1000
vim.opt.cmdheight = 1
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.wrap = true
vim.opt.relativenumber = true

lvim.leader = "space"


lvim.builtin.dashboard.active = true
lvim.builtin.notify.active = true
lvim.builtin.global_status_line = { active = true }


lvim.builtin.treesitter.ensure_installed = "maintained"
lvim.builtin.terminal.active = true

lvim.lsp.diagnostics.virtual_text = false


-- keymaps
lvim.keys.normal_mode["<CR>"] = ":noh<cr><cr>"


-- Autocommands (https://neovim.io/doc/user/autocmd.html)
lvim.autocommands.custom_groups = {
  {"CursorHold", "*", "lua vim.lsp.diagnostic.show_line_diagnostics({ focusable=false})"},
}

lvim.builtin.cmp.completion = {
  completeopt = 'menu,menuone,noinsert,preview',
}

require("abzlualine").config()
require("cached_format")
require("plugin")
require("plugins/dashboard")
require("plugins/whichkey")
