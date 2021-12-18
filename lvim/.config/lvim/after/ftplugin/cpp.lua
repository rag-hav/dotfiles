local template_cmd = "<CMD>lua require('toggleterm.terminal').Terminal:new({ cmd = '%s', direction = 'vertical', close_on_exit = false }):open(50)<CR>"

require("which-key").register(
    {
        r = {
            name = "Run",
            r = {string.format(template_cmd, "make " .. vim.fn.expand("%:r") .. " && ./" .. vim.fn.expand("%:r")), "Run"},
            i = {string.format(template_cmd, "make " .. vim.fn.expand("%:r") .. " && ./" .. vim.fn.expand("%:r") .. " < in"), "Run with input"},
            -- r={"<CMD>w | TermExec cmd=\"make %:r && ./%:r \" direction=vertical size=50 <CR>", "Run"},
            -- i={"<CMD>w | TermExec cmd=\"make %:r && ./%:r < in \" direction=vertical size=50 <CR>", "Input file (in)"},

            -- these are setup specific functions
            f = {string.format(template_cmd, "source ~/.funcs.sh; ftester " .. vim.fn.expand("%:r")), "Full tester"},
            q = {string.format(template_cmd, "source ~/.funcs.sh; qtester " .. vim.fn.expand("%:r")), "Quiet tester"},
            t = {string.format(template_cmd, "source ~/.funcs.sh; tester " .. vim.fn.expand("%:r")), "Tester"},
        }
    },
    { prefix = '<leader>', buffer = 0})

