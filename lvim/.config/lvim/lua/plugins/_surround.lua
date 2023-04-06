return {
	"kylechui/nvim-surround",
	version = "*",
	config = function()
		require("nvim-surround").setup({
			aliases = {
				["t"] = ">",
				["r"] = ")",
				["c"] = "}",
				["q"] = { '"', "'", "`" },
				["b"] = { "}", "]", ")" },
				["s"] = { "}", "]", ")", ">", '"', "'", "`" },
			},
		})
	end,
}
