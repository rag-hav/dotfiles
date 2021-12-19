local function select_client(method, on_choice)
  vim.validate {
    on_choice = { on_choice, 'function', false },
  }
  local clients = vim.tbl_values(vim.lsp.buf_get_clients())
  clients = vim.tbl_filter(function(client)
    return client.supports_method(method)
  end, clients)
  -- better UX when choices are always in the same order (between restarts)
  table.sort(clients, function(a, b)
    return a.name < b.name
  end)

  if #clients > 1 then
    vim.ui.select(clients, {
      prompt = 'Select a language server:',
      format_item = function(client)
        return client.name
      end,
    }, on_choice)
  elseif #clients < 1 then
    on_choice(nil)
  else
    on_choice(clients[1])
  end
end

-- https://stackoverflow.com/a/44058905
local cached_select_client = (function()
    local cache={}
    return function(method, on_choice)
        local buffer_name=vim.api.nvim_get_current_buf()
        local res=cache[buffer_name]
        if not res then
            res = select_client(method, on_choice)
            cache[buffer_name]=res
        end
        return res
    end
end)()

function Cached_formatter(options)
  local params = vim.lsp.util.make_formatting_params(options)
  local bufnr = vim.api.nvim_get_current_buf()
  cached_select_client('textDocument/formatting', function(client)
    if client == nil then
      return
    end

    return client.request('textDocument/formatting', params, nil, bufnr)
  end)

end

function Cached_formatting_sync(options, timeout_ms)
  local params = vim.lsp.util.make_formatting_params(options)
  local bufnr = vim.api.nvim_get_current_buf()
  cached_select_client('textDocument/formatting', function(client)
    if client == nil then
      return
    end

    local result, err = client.request_sync('textDocument/formatting', params, timeout_ms, bufnr)
    if result and result.result then
      vim.lsp.util.apply_text_edits(result.result, bufnr)
    elseif err then
      vim.notify('vim.lsp.buf.formatting_sync: ' .. err, vim.log.levels.WARN)
    end
  end)
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
    autocmd BufWritePre * :lua Cached_formatting_sync()
    augroup END
]])

