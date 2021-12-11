
lvim.builtin.which_key.mappings["o"] = { "<cmd>Telescope oldfiles<CR>", "Recent files" }
lvim.builtin.which_key.mappings["r"] = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" }
lvim.builtin.which_key.mappings["/"] = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "Fuzzy find" }
lvim.builtin.which_key.mappings["h"] = { "<cmd>Telescope help_tags<CR>", "help" }
lvim.builtin.which_key.mappings["f"] = { "<cmd>Telescope live_grep <CR>", "Find in files" }
lvim.builtin.which_key.mappings["F"] = { "<cmd>Telescope find_files <CR>", "Find files" }
lvim.builtin.which_key.mappings["t"] = { "<cmd>ToggleTerm direction=vertical size=50<CR>", "Terminal" }
lvim.builtin.which_key.vmappings["s"] = { "<Plug>SearchVisual<CR>", "Terminal" }
-- lvim.builtin.which_key.mappings["e"] = {"<cmd>Telescope buffers<CR>", "Buffers"}
-- lvim.builtin.which_key.

-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
-- }
