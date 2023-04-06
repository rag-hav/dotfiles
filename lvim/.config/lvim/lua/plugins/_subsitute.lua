return {
	"gbprod/substitute.nvim",
	config = function()
        local substitute = require("substitute")
		substitute.setup({
			on_substitute = nil,
			yank_substituted_text = false,
			highlight_substituted_text = {
				enabled = false,
				timer = 500,
			},
			range = {
				prefix = "s",
				prompt_current_text = false,
				confirm = false,
				complete_word = false,
				motion1 = false,
				motion2 = false,
				suffix = "",
			},
			exchange = {
				motion = false,
				use_esc_to_cancel = true,
			},
		})

		vim.keymap.set("n", "s", substitute.operator, { noremap = true })
		vim.keymap.set("n", "ss", substitute.line, { noremap = true })
		vim.keymap.set("n", "S", substitute.eol, { noremap = true })
		vim.keymap.set("x", "s", substitute.visual, { noremap = true })
	end,
}
