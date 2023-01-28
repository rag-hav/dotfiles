return {
	"romainchapou/confiture.nvim",
	cmd = "Confiture",

	init = function()
		lvim.builtin.which_key.mappings["r"] = {
			B = { "<cmd>Confiture build<CR>", "Build project" },
			p = { "<cmd>Confiture run<CR>", "Run project" },
			b = { "<cmd>Confiture build_and_run<CR>", "Build and run project" },
		}
	end,
}
