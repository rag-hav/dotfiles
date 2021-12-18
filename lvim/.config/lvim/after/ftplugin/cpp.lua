require("which-key").register(
    {
        r={
            name = "Run",
            r={"<CMD>w | TermExec cmd=\"make %:r && ./%:r \" direction=vertical size=50 <CR>", "Run"},
            i={"<CMD>w | TermExec cmd=\"make %:r && ./%:r < in \" direction=vertical size=50 <CR>", "Input file (in)"},

            -- these are setup specific functions
            c={"<CMD>1TermExec cmd=\"clear\" open=0 <CR>", "Filetester"},
            f={"<CMD>w | 1TermExec cmd=\"ftester %:r \" direction=vertical size=50 <CR>", "Filetester"},
            t={"<CMD>w | 1TermExec cmd=\"tester %:r \" direction=vertical size=50 <CR>", "Filetester"},
            q={"<CMD>w | 1TermExec cmd=\"qtester %:r \" direction=vertical size=50 <CR>", "Filetester"},
        }
    },
    { prefix ='<leader>', buffer = 0})

