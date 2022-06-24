return {
	"iamcco/markdown-preview.nvim",
	run = "cd app && npm install",
	setup = function()
		vim.g.mkdp_filetypes = { "markdown" }
		vim.g.mkdp_browser = { "/bin/google-chrome" }
		vim.g.mkdp_echo_preview_url = 1
	end,
	ft = { "markdown" },
}
