return {
	"phaazon/mind.nvim",
	branch = "v2.2",
    cmd = {"MindOpenMain", "MindOpenProject", "MindOpenSmartProject"},
	config = function()
		require("mind").setup()
	end,
}
