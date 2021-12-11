local lsp_installer_servers = require("nvim-lsp-installer.servers")
local _, requested_server = lsp_installer_servers.get_server("clangd")
local cmd = table.insert(requested_server._default_options.cmd, '-std=c++17')

local opts = {
  cmd = cmd
}

return opts
