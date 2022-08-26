local template_cmd = "<CMD> lua RunTerminal('%s')<CR>"
local debug_cmd = "g++ -ggdb -o "
	.. vim.fn.expand("%:r")
	.. " "
	.. vim.fn.expand("%")
	.. ' && gdb -q -ex "set args < '
	.. "."
	.. vim.fn.expand("%:t:r")
	.. "_in%d"
	.. '" '
	.. vim.fn.expand("%:t:r")

require("which-key").register({
	r = {
		name = "Run",
		r = {
			string.format(template_cmd, "make %:r && echo Running && %:p:r"),
			"Run",
		},
		i = {
			string.format(template_cmd, "make %:r && echo Running && %:p:r < in"),
			"Run with input",
		},

		g = {
			name = "GBD",
			g = {
				string.format(
					template_cmd,
					"g++ -ggdb -o "
						.. vim.fn.expand("%:r")
						.. " "
						.. vim.fn.expand("%")
						.. " && gdb -q "
						.. vim.fn.expand("%:t:r")
				),
				"GBD",
			},
			a = {

				string.format(template_cmd, string.format(debug_cmd, 1)),
				"Input file 1",
			},
			b = {
				string.format(template_cmd, string.format(debug_cmd, 2)),
				"Input file 2",
			},
			c = {
				string.format(template_cmd, string.format(debug_cmd, 3)),
				"Input file 3",
			},
			d = {
				string.format(template_cmd, string.format(debug_cmd, 4)),
				"Input file 4",
			},
		},

		-- these are setup specific functions
		f = {
			string.format(template_cmd, "source ~/.funcs.sh; ftester " .. vim.fn.expand("%:t:r")),
			"Full tester",
		},
		q = {
			string.format(template_cmd, "source ~/.funcs.sh; qtester " .. vim.fn.expand("%:t:r")),
			"Quiet tester",
		},
		t = {
			string.format(template_cmd, "source ~/.funcs.sh; tester " .. vim.fn.expand("%:t:r")),
			"Tester",
		},
		s = {
			string.format(template_cmd, "source ~/.funcs.sh; submit " .. vim.fn.expand("%:t:r")),
			"Tester",
		},
	},
}, { prefix = "<leader>", buffer = 0 })
