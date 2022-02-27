function RunTerminal(_cmd)
	pcall(function()
		vim.api.nvim_command("write")
	end)
	require("toggleterm.terminal").Terminal
		:new({ cmd = _cmd, direction = "vertical", close_on_exit = false })
		:open(vim.g.exec_width)
end
