return {
	"dhruvasagar/vim-table-mode",
	cmd = { "TableModeToggle", "TableModeRealign", "Tableize" },

	config = function()
		vim.g.table_mode_corner_corner = "+"
		-- vim.g.table_mode_header_fillchar = "="

	end,
}
