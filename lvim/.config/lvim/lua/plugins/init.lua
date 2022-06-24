lvim.plugins = {
	require("plugins._stickybuf"),
	require("plugins._lsp_signature"),
	require("plugins._colorizer"),
	require("plugins._markdown-preview"),

	{ "tpope/vim-fugitive" },
	{ "wellle/targets.vim" },
	{ "junegunn/goyo.vim", ft = { "text" } },
	{ "voldikss/vim-browser-search" },
	{ "stevearc/dressing.nvim" },
	{ "f3fora/cmp-spell", requires = "hrsh7th/nvim-cmp" },
	{ "felipec/vim-sanegx" },
	{ "folke/tokyonight.nvim" },
	{ "tpope/vim-repeat" },

	{
		"navarasu/onedark.nvim",
		config = function()
			require("onedark").setup({
				style = "warm",
			})
		end,
	},
	{
		"stevearc/aerial.nvim",
		config = function()
			require("aerial").setup()
		end,
	},
	{
		"SmiteshP/nvim-gps",
		requires = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-gps").setup()
		end,
	},

	{
		"mattn/vim-gist",
		requires = "mattn/webapi-vim",
		setup = function()
			vim.g.gist_open_browser_after_post = 1
		end,
	},
	{
		"max397574/better-escape.nvim",
		config = function()
			require("better_escape").setup({
				mapping = { "jk", "kj" },
				timeout = 100,
				clear_empty_lines = true,
				keys = "<Esc>",
			})
		end,
	},
	{
		"rose-pine/neovim",
		as = "rose-pine",
	},
	{
		"tpope/vim-surround",
		keys = { "c", "d", "y" },
	},

	{
		"mattn/emmet-vim",
		ft = "html",
		setup = function()
			vim.g.user_emmet_leader_key = ","
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		ft = "html",
		event = "InsertEnter",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		"folke/todo-comments.nvim",
		event = "BufRead",
		config = function()
			require("todo-comments").setup()
		end,
	},
}

-- settings for builtin plugins
require("plugins.builtins")
