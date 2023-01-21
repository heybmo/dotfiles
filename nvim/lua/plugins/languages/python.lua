local lsp = require('plugins.languages.lsp')
local M = {}

local util = require('lspconfig/util')

local path = util.path

local function get_python_path(workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
  end

  local match = vim.fn.glob(path.join(workspace, 'poetry.lock'))
  if match ~= '' then
    local venv = vim.fn.trim(vim.fn.system('poetry env info -p'))
    return path.join(venv, 'bin', 'python')
  end

  -- Fallback to system Python.
  return vim.fn.exepath('python3') or vim.fn.exepath('python') or 'python'
end

local format_sync_grp = vim.api.nvim_create_augroup('BlackOnSave', {})
vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*.py',
    callback = function()
     require('black')
    end,
    group = format_sync_grp,
  })

M.lsp = {
  capabilities = lsp.capabilities,
  on_attach = lsp.on_attach,
  flags = lsp.flags,
  on_init = function(client)
    client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
  end
}

return M
