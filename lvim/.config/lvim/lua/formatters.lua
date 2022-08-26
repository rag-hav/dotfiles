require("lvim.lsp.null-ls.formatters").setup({
	{ command = "black" },
	-- { command = "prettier" },
	{ command = "stylua" },
	{ command = "sqlformat" },
	{ command = "shellharden" },
})
require("lvim.lsp.null-ls.linters").setup({
	{ command = "shellcheck" },
})
