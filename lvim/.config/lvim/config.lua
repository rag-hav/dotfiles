lvim.log.level = "warn"
-- lvim.format_on_save = true
lvim.colorscheme = "rose-pine"
lvim.builtin.lualine.theme = 'rose-pine';
vim.opt.timeoutlen = 1000
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




-- Autocommands (https://neovim.io/doc/user/autocmd.html)
lvim.autocommands.custom_groups = {
  {"CursorHold", "*", "lua vim.lsp.diagnostic.show_line_diagnostics({ focusable=false})"},
  {"FileType", "cpp", "nnoremap <F5> :w <bar> :TermExec cmd=\"make %:r && ./%:r < in \" direction=vertical size=50 <CR>" },
  {"BufWinEnter", "*.md,*.txt", "lua Text()" },
  {"BufWinEnter", "*.md", 'lua require("which-key").register({m={"<cmd>MarkdownPreviewToggle <CR>", "MarkdownPreview"}},  { prefix = "<leader>" })' },
}

lvim.builtin.cmp.completion = {
  completeopt = 'menu,menuone,noinsert,preview',
}

require("plugin")
require("cached_format")
require("keymaps")
require("abzlualine").config()
require("functions")
require("plugins/dashboard")
require("plugins/whichkey")
