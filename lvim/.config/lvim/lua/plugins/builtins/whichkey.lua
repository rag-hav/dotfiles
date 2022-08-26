lvim.builtin.which_key.mappings["o"] = { "<cmd>Telescope oldfiles<CR>", "Recent files" }
lvim.builtin.which_key.mappings["/"] = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "Fuzzy find" }
lvim.builtin.which_key.mappings["F"] = { "<cmd>Telescope find_files<CR>", "Find Files" }
lvim.builtin.which_key.mappings["t"] = { "<cmd>ToggleTerm direction=vertical size=50<CR>", "Terminal" }
lvim.builtin.which_key.mappings["p"] = { "<cmd>Telescope resume<CR>", "Resume last picker" }
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope pickers<CR>", "Choose and resume picker" }
lvim.builtin.which_key.mappings["j"] = { "<cmd>Telescope jumplist<CR>", "Jumplist" }
lvim.builtin.which_key.mappings["T"] = lvim.builtin.which_key.mappings["s"]
lvim.builtin.which_key.mappings["s"] = { "<cmd>AerialToggle right<CR>", "Show outline of file" }
lvim.builtin.which_key.vmappings["s"] = { "<Plug>SearchVisual<CR>", "Search on google" }
lvim.builtin.which_key.mappings["f"] = { "<cmd>Telescope grep_string<CR>", "Find in Files" }
