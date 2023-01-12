lvim.plugins = {
	require("plugins._stickybuf"),
	require("plugins._lsp_signature"),
	require("plugins._colorizer"),
	require("plugins._markdown-preview"),
	require("plugins._table_mode"),
	-- require("plugins._instant"),
	require("plugins._mind"),
	-- require("plugins._orgmode"),
	{
		"jayp0521/mason-nvim-dap.nvim",
		dependencies = { { "williamboman/mason.nvim" }, { "mfussenegger/nvim-dap" } },
		config = function()
			require("mason").setup()
			require("mason-nvim-dap").setup({
				automatic_setup = true,
			})

			require("mason-nvim-dap").setup_handlers()
		end,
	},
	{ "mfussenegger/nvim-jdtls" },
	{ "mbbill/undotree", cmd = "UndotreeToggle" },
	{ "shortcuts/no-neck-pain.nvim", cmd = "NoNeckPain" },
	{ "romainchapou/confiture.nvim", cmd = "Confiture" },
	{ "tpope/vim-fugitive" },
	{ "wellle/targets.vim" },
	{ "junegunn/goyo.vim", ft = { "text" }, cmd = "Goyo" },
	{ "voldikss/vim-browser-search" },
	{ "stevearc/dressing.nvim" },
	{ "f3fora/cmp-spell", dependencies = "hrsh7th/nvim-cmp" },
	{ "felipec/vim-sanegx" },
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
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-gps").setup()
		end,
	},
	{
		"mattn/vim-gist",
		dependencies = "mattn/webapi-vim",
		init = function()
			vim.g.gist_open_browser_after_post = 1
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
	},
	{
		"tpope/vim-surround",
		keys = { "c", "d", "y" },
	},
	{
		"mattn/emmet-vim",
		ft = "html",
		init = function()
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
