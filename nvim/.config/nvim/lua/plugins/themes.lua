local colorscheme = "onedarker"

local setScheme = function() 
	vim.cmd("colorscheme ".. colorscheme)
end

return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000, 
		cond = colorscheme == "tokyonight",
		config = setScheme,
	},
	{
		"lunarvim/Onedarker.nvim",
		lazy = false,
		priority = 1000, 
		cond = colorscheme == "onedarker",
		config = setScheme,
	},

}
