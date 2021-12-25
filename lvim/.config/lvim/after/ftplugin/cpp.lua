local template_cmd =
	"<CMD>w | lua require('toggleterm.terminal').Terminal:new({ cmd = '%s', direction = 'vertical', close_on_exit = false }):open(50)<CR>"

require("which-key").register({
	r = {
		name = "Run",
		r = {
			string.format(template_cmd, "make " .. vim.fn.expand("%:r") .. " && ./" .. vim.fn.expand("%:t:r")),
			"Run",
		},
		i = {
			string.format(
				template_cmd,
				"make " .. vim.fn.expand("%:r") .. " && ./" .. vim.fn.expand("%:t:r") .. " < in"
			),
			"Run with input",
		},

		-- these are setup specific functions
		f = { string.format(template_cmd, "source ~/.funcs.sh; ftester " .. vim.fn.expand("%:t:r")), "Full tester" },
		q = { string.format(template_cmd, "source ~/.funcs.sh; qtester " .. vim.fn.expand("%:t:r")), "Quiet tester" },
		t = { string.format(template_cmd, "source ~/.funcs.sh; tester " .. vim.fn.expand("%:t:r")), "Tester" },
		s = { string.format(template_cmd, "source ~/.funcs.sh; submit " .. vim.fn.expand("%:t:r")), "Tester" },
	},
}, { prefix = "<leader>", buffer = 0 })
