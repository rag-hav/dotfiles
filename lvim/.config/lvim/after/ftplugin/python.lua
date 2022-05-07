local template_cmd = "<CMD> lua RunTerminal('%s')<CR>"
require("which-key").register({
	r = {
		name = "Run",
		r = {
			string.format(template_cmd, "python " .. vim.fn.expand("%:p")),
			"Run",
		},
	},
})
