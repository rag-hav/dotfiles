lvim.plugins = {
	-- require("plugins._stickybuf"),
	require("plugins._lsp_signature"),
	require("plugins._colorizer"),
	require("plugins._markdown-preview"),
	require("plugins._table_mode"),
	-- require("plugins._instant"),
	require("plugins._confiture"),
	-- require("plugins._mind"),
	-- require("plugins._orgmode"),
	-- require("plugins._notetaking"),
	-- require("plugins._obsidian"),
	require("plugins._clipboard-image"),
	require("plugins._surround"),
	require("plugins._subsitute"),
	require("plugins._treesitter_textobjs"),
	require("plugins._various_textobjs"),
    {"ellisonleao/gruvbox.nvim", priority = 1000},
	{
		"letieu/hacker.nvim",
		config = function()
			require("hacker").setup({
				speed = { -- characters insert each time, random from min -> max
					min = 2,
					max = 5,
				},
				is_popup = false, -- show random float window when typing
				popup_after = 5,
			})
		end,
	},
	-- {
	-- 	"NMAC427/guess-indent.nvim",
	-- 	config = function()
	-- 		require("guess-indent").setup({})
	-- 	end,
	-- },
	{
		"andrewferrier/wrapping.nvim",
		config = function()
			require("wrapping").setup()
		end,
	},
	{
		"toppair/peek.nvim",
		build = "deno task --quiet build:fast",
		config = function()
			require("peek").setup({
				auto_load = false, -- whether to automatically load preview when
				-- entering another markdown buffer
				close_on_bdelete = true, -- close preview window on buffer delete

				syntax = true, -- enable syntax highlighting, affects performance

				theme = "dark", -- 'dark' or 'light'

				update_on_change = true,

				-- relevant if update_on_change is true
				throttle_at = 200000, -- start throttling when file exceeds this
				-- amount of bytes in size
				throttle_time = "auto", -- minimum amount of time in milliseconds
				-- that has to pass before starting new render
			})
		end,
	},
	{
		"metakirby5/codi.vim",
		cmd = { "Codi" },
		init = function()
			vim.cmd([[let g:codi#autocmd="InsertLeave"]])
		end,
		config = function()
			vim.api.nvim_set_keymap("n", "<S-CR>", ":CodiExpand<CR>", {})
		end,
	},
	-- { "MaximilianLloyd/ascii.nvim", dependencies = {
	-- 	"MunifTanjim/nui.nvim",
	-- } },
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = { { "williamboman/mason.nvim" }, { "mfussenegger/nvim-dap" } },
		config = function()
			require("mason").setup()
			require("mason-nvim-dap").setup({
				automatic_setup = true,
			})

			-- require("mason-nvim-dap").setup()
		end,
	},
	{ "nvim-telescope/telescope-media-files.nvim" },
	{ "nvim-telescope/telescope-symbols.nvim" },
	{ "mfussenegger/nvim-jdtls" },
	{ "mbbill/undotree", cmd = "UndotreeToggle" },
	{ "shortcuts/no-neck-pain.nvim", cmd = "NoNeckPain" },
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
	-- {
	-- 	"SmiteshP/nvim-gps",
	-- 	dependencies = "nvim-treesitter/nvim-treesitter",
	-- 	config = function()
	-- 		require("nvim-gps").setup()
	-- 	end,
	-- },
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
