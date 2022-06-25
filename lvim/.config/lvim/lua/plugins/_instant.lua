return {
	"rag-hav/instant.nvim",
	config = function()
		vim.g.instant_username = "raghav"
		vim.api.nvim_set_hl(0, "InstantUser1", { fg = "#1bafa8", reverse = true })
		vim.api.nvim_set_hl(0, "InstantUser2", { fg = "#5454e4", reverse = true })
		vim.api.nvim_set_hl(0, "InstantUser3", { fg = "#ab6f7a", reverse = true })
		vim.api.nvim_set_hl(0, "InstantUser4", { fg = "#ab1fb1", reverse = true })
		vim.g.instant_name_hl_group_user1 = "InstantUser1"
		vim.g.instant_name_hl_group_user2 = "InstantUser2"
		vim.g.instant_name_hl_group_user3 = "InstantUser3"
		vim.g.instant_name_hl_group_user4 = "InstantUser4"
		vim.g.instant_cursor_hl_group_user1 = "InstantUser1"
		vim.g.instant_cursor_hl_group_user2 = "InstantUser2"
		vim.g.instant_cursor_hl_group_user3 = "InstantUser3"
		vim.g.instant_cursor_hl_group_user4 = "InstantUser4"
	end,
	cmd = {
		"InstantStartSingle",
		"InstantJoinSingle",
		"InstantStop",
		"InstantStartSession",
		"InstantJoinSession",
		"InstantStatus",
		"InstantFollow",
		"InstantStopFollow",
		"InstantOpenAll",
		"InstantSaveAll",
		"InstantStartServer",
		"InstantStopServer",
		"InstantMark",
		"InstantMarkClear",
	},
}
