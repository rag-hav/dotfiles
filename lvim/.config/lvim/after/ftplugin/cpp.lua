require("which-key").register(
    {
        r={
            name = "Run",
            r={"<CMD>w | TermExec cmd=\"make %:r && ./%:r \" direction=vertical size=50 <CR>", "Run"},
            i={"<CMD>w | TermExec cmd=\"make %:r && ./%:r < in \" direction=vertical size=50 <CR>", "Input file (in)"},

            -- these are setup specific functions
            t={"<CMD>w | TermExec cmd=\"tester %:r \" direction=vertical size=50 <CR>", "Filetester"},
            f={"<CMD>w | TermExec cmd=\"ftester %:r \" direction=vertical size=50 <CR>", "Filetester"},
            q={"<CMD>w | TermExec cmd=\"qtester %:r \" direction=vertical size=50 <CR>", "Filetester"},
        }
    },
    { prefix ='<leader>', buffer = 0})

