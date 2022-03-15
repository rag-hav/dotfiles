lvim.plugins = {
	-- {
	-- 	"nvim-neorg/neorg",
	-- 	config = function()
	-- 		require("neorg").setup({
	-- 			-- Tell Neorg what modules to load
	-- 			load = {
	-- 				["core.norg.completion"] = {
	-- 					config = {
	-- 						engine = "nvim-cmp", -- We current support nvim-compe and nvim-cmp only
	-- 					},
	-- 				},
	-- 				["core.defaults"] = {}, -- Load all the default modules
	-- 				["core.norg.concealer"] = {}, -- Allows for use of icons
	-- 				["core.norg.dirman"] = { -- Manage your directories with Neorg
	-- 					config = {
	-- 						workspaces = {
	-- 							my_workspace = "~/neorg",
	-- 						},
	-- 					},
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- 	requires = "nvim-lua/plenary.nvim",
	-- },
	{ "junegunn/goyo.vim", ft = { "text" } },
	{ "voldikss/vim-browser-search" },
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
		config = function()
			lvim.builtin.lualine.theme = "rose-pine"
		end,
	},
	{ "folke/tokyonight.nvim" },
	{ "tpope/vim-repeat" },
	{
		"tpope/vim-surround",
		keys = { "c", "d", "y" },
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({ "*" }, {
				RGB = true, -- #RGB hex codes
				RRGGBB = true, -- #RRGGBB hex codes
				RRGGBBAA = true, -- #RRGGBBAA hex codes
				rgb_fn = true, -- CSS rgb() and rgba() functions
				hsl_fn = true, -- CSS hsl() and hsla() functions
				css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
			})
		end,
		-- ft = { "css", "html" },
	},
	{ "f3fora/cmp-spell", requires = "hrsh7th/nvim-cmp" },
	{
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		ft = "markdown",
		config = function()
			vim.g.mkdp_auto_close = 0
		end,
	},
	-- {
	-- 	"andweeb/presence.nvim",
	-- },
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
	{
		"ray-x/lsp_signature.nvim",
		event = "BufRead",
		config = function()
			require("lsp_signature").setup()
		end,
	},
	{ "stevearc/dressing.nvim" },
	-- signature of method while typing arguments
	{
		"ray-x/lsp_signature.nvim",
		as = "lsp_signatue",
		config = function()
			require("lsp_signature").setup({
				bind = true, -- This is mandatory, otherwise border config won't get registered.
				doc_lines = 4, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
				floating_window = true, -- show hint in a floating window, set to false for virtual text only mode fix_pos = false,  -- set to true, the floating window will not auto-close until finish all parameters
				hint_enable = false, -- virtual hint enable
				hint_prefix = " ", -- Panda for parameter
				hint_scheme = "String",
				use_lspsaga = false, -- set to true if you want to use lspsaga popup
				hi_parameter = "Search", -- how your parameter will be highlight
				max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
				max_width = 80, -- max_width of signature floating_window, line will be wrapped if exceed max_width
				handler_opts = {
					border = "rounded", -- double, single, shadow, none
				},
				extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
			})
			require("lsp_signature").setup()
			require("lsp_signature").on_attach()
		end,
	},
}
