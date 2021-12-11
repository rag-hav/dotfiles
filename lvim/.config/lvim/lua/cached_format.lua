local function select_client(method)
    local clients = vim.tbl_values(vim.lsp.buf_get_clients());
    clients = vim.tbl_filter(function (client)
        return client.supports_method(method)
    end, clients)
    -- better UX when choices are always in the same order (between restarts)
    table.sort(clients, function (a, b) return a.name < b.name end)

    if #clients > 1 then
        local choices = {}
        for k,v in pairs(clients) do
            table.insert(choices, string.format("%d %s", k, v.name))
        end
        local user_choice = vim.fn.confirm(
        "Select a language server:",
        table.concat(choices, "\n"),
        0,
        "Question"
        )
        if user_choice == 0 then return nil end
        return clients[user_choice]
    elseif #clients < 1 then
        return nil
    else
        return clients[1]
    end
end

-- https://stackoverflow.com/a/44058905
local cached_select_client = (function()
    local cache={}
    return function(method)
        local buffer_name=vim.api.nvim_get_current_buf()
        local res=cache[buffer_name]
        if not res then
            res = select_client(method)
            cache[buffer_name]=res
        end
        return res
    end
end)()

function Cached_formatter(options)
    local client = cached_select_client("textDocument/formatting")
    if client == nil then return end

    local params = vim.lsp.util.make_formatting_params(options)
    return client.request("textDocument/formatting", params, nil, vim.api.nvim_get_current_buf())

end

function NoFormat()
    vim.cmd([[
        augroup cached_autoformat
        autocmd!
        augroup END
    ]])
end


lvim.format_on_save = false

vim.cmd([[
    augroup cached_autoformat
    autocmd!
    autocmd BufWritePre * :lua Cached_formatter()
    augroup END
]])

