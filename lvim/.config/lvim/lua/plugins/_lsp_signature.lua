return {
	"ray-x/lsp_signature.nvim",
	name = "lsp_signatue",
	config = function()
		require("lsp_signature").setup({
			bind = true, -- This is mandatory, otherwise border config won't get registered.
			doc_lines = 4, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
			floating_window = true, -- show hint in a floating window, set to false for virtual text only mode fix_pos = false,  -- set to true, the floating window will not auto-close until finish all parameters
			hint_enable = false, -- virtual hint enable
			hint_prefix = " ", -- Panda for parameter
			hint_scheme = "String",
			use_lspsaga = false, -- set to true if you want to use lspsaga popup
			hi_parameter = "Search", -- how your parameter will be highlight
			max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
			max_width = 80, -- max_width of signature floating_window, line will be wrapped if exceed max_width
			handler_opts = {
				border = "rounded", -- double, single, shadow, none
			},
			extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
		})
		require("lsp_signature").setup()
		require("lsp_signature").on_attach()
	end,
}
