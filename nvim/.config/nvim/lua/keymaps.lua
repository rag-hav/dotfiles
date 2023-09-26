local function map(mode, lhs, rhs, desc)
  local options = { noremap=true, silent=true }
  if desc then
    options.desc = desc 
  end
  vim.keymap.set(mode, lhs, rhs, options)
end


-- Clear highlights on Enter
map('n', '<CR>', ':nohl<CR><CR>')

-- Move around windows
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- Let escape work in terminal mode
map('t', '<Esc><Esc>', '<C-\\><C-n>')
