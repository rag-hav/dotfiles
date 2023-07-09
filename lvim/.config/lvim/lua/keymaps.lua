lvim.keys.normal_mode["<CR>"] = ":noh<cr><cr>"
lvim.keys.normal_mode["L"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["H"] = ":BufferLineCyclePrev<CR>"
-- lvim.keys.normal_mode["M"] = "m"
lvim.keys.term_mode["<Esc>"] = "<C-\\><C-n>"
lvim.keys.visual_mode["s"] = '"hy:%s/<C-r>h/'

-- Dont copy on delete, use Move instead for that
-- lvim.keys.normal_mode["mm"] = "dd"
-- lvim.keys.normal_mode["m"] = "d"
-- lvim.keys.normal_mode["d"] = "\"_d"
-- lvim.keys.normal_mode["dd"] = "\"_dd"
-- lvim.keys.normal_mode["c"] = "\"_c"
-- lvim.keys.normal_mode["cc"] = "\"_cc"
-- lvim.keys.normal_mode["x"] = "\"_x"
-- lvim.keys.visual_mode["d"] = "\"_d"
-- lvim.keys.visual_mode["m"] = "d"
-- lvim.keys.visual_mode["M"] = "D"
