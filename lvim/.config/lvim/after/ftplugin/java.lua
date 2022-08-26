local template_cmd = "<CMD> lua RunTerminal('%s')<CR>"
require("which-key").register({
	r = {
		name = "Run",
		r = {
			string.format(
				template_cmd,
				"javac " .. vim.fn.expand("%") .. " && echo Running && java " .. vim.fn.expand("%:t:r")
			),
			"Run",
		},
		i = {
			string.format(
				template_cmd,
				"javac " .. vim.fn.expand("%") .. " && echo Running && java " .. vim.fn.expand("%:t:r") .. " < in"
			),
			"Run with input",
		},
	},
})
