return {
	{
		"nvim-telescope/telescope.nvim",
		keys = {
			{ "<leader>p", "<cmd>Telescope commands<cr>", desc = "Commands" },
			{ "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search" },

			{ "<leader>f:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
			{ "<leader>fC", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme" },
			{ "<leader>fc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
			{ "<leader>fd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
			{ "<leader>fD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
			{ "<leader>fH", "<cmd>Telescope highlights<cr>", desc = "Highlight Groups" },
			{ "<leader>fj", "<cmd>Telescope jumplist<cr>", desc = "Jumplist" },
			{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
			{ "<leader>fM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
			{ "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
			{ "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
			{ "<leader>fO", "<cmd>Telescope vim_options<cr>", desc = "Options" },
			{ "<leader>fr", "<cmd>Telescope resume<cr>", desc = "Resume" },
			{ "<leader>fS", "<cmd>Telescope lsp_workspace_dynamic_symbols<CR>", desc = "All Symbols", },
			{ "<leader>fs", "<cmd>Telescope lsp_workspace_symbols<CR>", desc = "Symbols", },
			{ "<leader>fW", "<cmd>Telescope grep_string<CR>", desc = "Word (cwd)" },
			{ "<leader>fW", "<cmd>Telescope grep_string<CR>", mode = "v", desc = "Selection (cwd)" },
		},
		opts = {
			defaults = {
				prompt_prefix = " ",
				selection_caret = " ",
				mappings = {
					i = {
						-- ["<c-t>"] = function(...)
						-- 	return require("trouble.providers.telescope").open_with_trouble(...)
						-- end,
						-- ["<a-t>"] = function(...)
						-- 	return require("trouble.providers.telescope").open_selected_with_trouble(...)
						-- end,
					},
					n = {
						q = function(...)
							return require("telescope.actions").close(...)
						end,

						J = function(...)
							return require("telescope.actions").preview_scrolling_down(...)
						end,

						K = function(...)
							return require("telescope.actions").preview_scrolling_up(...)
						end,
					},
				},
			},
		},
	},
}
