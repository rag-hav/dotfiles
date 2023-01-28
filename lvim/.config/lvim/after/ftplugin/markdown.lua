vim.opt_local.spell = true
vim.api.nvim_buf_set_keymap(0, "n", "j", "gj", { noremap = true, silent = true })
vim.api.nvim_buf_set_keymap(0, "n", "k", "gk", { noremap = true, silent = true })

require('wrapping').soft_wrap_mode()
-- require("which-key").register({ m = { "<cmd>MarkdownPreviewToggle <CR>", "MarkdownPreview" } }, { prefix = "<leader>" })
