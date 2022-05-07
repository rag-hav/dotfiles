local template_cmd = "<CMD> lua RunTerminal('%s')<CR>"
require("which-key").register({
    r = {
        name = 'Run',
        r = {
            string.format(
                template_cmd,
                "sh ".. vim.fn.expand("%:p")
            ),
            "Run",
        }
    }
})
