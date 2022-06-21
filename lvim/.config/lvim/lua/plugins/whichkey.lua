lvim.builtin.which_key.mappings["O"] = { "<cmd>Telescope oldfiles<CR>", "Recent files" }
lvim.builtin.which_key.mappings["o"] = { "<cmd>AerialToggle right<CR>", "Show outline of file" }
lvim.builtin.which_key.mappings["/"] = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "Fuzzy find" }
lvim.builtin.which_key.mappings["f"] = { "<cmd>Telescope live_grep <CR>", "Find in files" }
lvim.builtin.which_key.mappings["F"] = { "<cmd>Telescope find_files <CR>", "Find files" }
lvim.builtin.which_key.mappings["t"] = { "<cmd>ToggleTerm direction=vertical size=50<CR>", "Terminal" }
lvim.builtin.which_key.mappings["r"] = { "<cmd>Telescope resume<CR>", "Resume Search" }
lvim.builtin.which_key.vmappings["s"] = { "<Plug>SearchVisual<CR>", "Search on google" }

-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
-- }
