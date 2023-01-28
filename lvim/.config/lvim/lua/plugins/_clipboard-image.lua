return {
	"ekickx/clipboard-image.nvim",

	config = function()
		require("clipboard-image").setup({
			-- Default configuration for all filetype
			default = {
				img_dir = "images",
				img_dir_txt = "images",
				img_name = function()
					local inp = vim.fn.input({ prompt= "Enter the name for the image: " })
					return #inp and inp or os.date("%Y-%m-%d-%H-%M-%S")
				end, -- Example result: "2021-04-13-10-04-18"
				affix = "<\n  %s\n>", -- Multi lines affix
				-- img_handler = function(img)
				-- 	vim.ui.input({ prompt = "Make image transparent (y/N): " }, function(inp)
				-- 		if inp == "y" then
				-- 			os.execute(string.format("convert %s -fuzz 2%% -transparent white %s", img.path, img.path))
				-- 		end
				-- 	end)
				-- end,
			},

			markdown = {
				affix = "![](%s)",
			},
		})
	end,
}
