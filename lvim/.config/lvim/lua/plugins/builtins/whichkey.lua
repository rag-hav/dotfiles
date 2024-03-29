lvim.builtin.which_key.mappings["o"] = { "<cmd>Telescope oldfiles<CR>", "Recent files" }
lvim.builtin.which_key.mappings["/"] = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "Fuzzy find" }
lvim.builtin.which_key.mappings["F"] = { "<cmd>Telescope find_files<CR>", "Find Files" }
lvim.builtin.which_key.mappings[" "] = { "<cmd>ToggleTerm direction=vertical size=50<CR>", "Terminal" }
lvim.builtin.which_key.mappings["p"] = { "<cmd>Telescope resume<CR>", "Resume last picker" }
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope pickers<CR>", "Choose and resume picker" }
lvim.builtin.which_key.mappings["j"] = { "<cmd>Telescope jumplist<CR>", "Jumplist" }
lvim.builtin.which_key.mappings["t"] = lvim.builtin.which_key.mappings["s"]
lvim.builtin.which_key.mappings["s"] = { "<cmd>AerialToggle right<CR>", "Show outline of file" }
lvim.builtin.which_key.mappings["?"] = { "<cmd>Telescope grep_string<CR>", "Find word in Files" }
lvim.builtin.which_key.mappings["W"] = { "<cmd>wa<CR>", "Save All" }
lvim.builtin.which_key.mappings["f"] = { "<cmd>Telescope live_grep<CR>", "Find in Files" }
lvim.builtin.which_key.mappings["u"] = { "<cmd>UndotreeToggle<CR>", "Undo Tree" }
lvim.builtin.which_key.vmappings["s"] = { "<Plug>SearchVisual<CR>", "Search on google" }

lvim.builtin.which_key.mappings["T"] = {
	name = "Diagnostics",
	t = { "<cmd>TroubleToggle<cr>", "trouble" },
	w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace" },
	d = { "<cmd>TroubleToggle document_diagnostics<cr>", "document" },
	q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
	l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
	r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
}
