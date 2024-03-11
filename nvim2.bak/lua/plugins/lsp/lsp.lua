local M = {
  "neovim/nvim-lspconfig",
  event = { "BufRead", "BufWritePre", "BufReadPre", "InsertEnter" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "folke/which-key.nvim",
  },
  version = false,
  config = function(_, _)
    local lspconfig = require("lspconfig")

    --------------------------------
    -- LANGUAGE SERVERS
    --------------------------------
    lspconfig.sqlls.setup({})

    lspconfig.eslint.setup({})

    lspconfig.jsonls.setup({})

    lspconfig.pyright.setup({})

    --- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
    lspconfig.gopls.setup({
      settings = {
        gopls = {
          gofumpt = true,
          codelenses = {
            generate = true,
            gc_details = false,
            test = true,
            tidy = true,
          },
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
          analyses = {
            unusedparams = true,
          },
          semanticTokens = true,
          usePlaceholders = true,
          completeUnimported = true,
          staticcheck = true,
          directoryFilters = { '-node_modules', '-vendor' },
        },
      },
    })

    lspconfig.sourcekit.setup({
      filetypes = { 'swift', 'objective-c', 'objective-cpp' },
    })

    lspconfig.yamlls.setup({
      settings = {
        yaml = {
          customTags = {
            '!reference sequence', -- necessary for gitlab-ci.yaml files
          },
        },
      },
    })

    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          codeLens = { enable = true },
          hint = { enable = true, arrayIndex = 'Disable', setType = false, paramName = 'Disable', paramType = true },
          format = { enable = false },
          diagnostics = {
            globals = { 'vim', 'P', 'describe', 'it', 'before_each', 'after_each', 'packer_plugins', 'pending' },
          },
          completion = { keywordSnippet = 'Replace', callSnippet = 'Replace' },
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      }
    })

    -- Set up icons for diagnostics
    vim.fn.sign_define("DiagnosticSignError",
      {text = " ", texthl = "DiagnosticSignError"})
    vim.fn.sign_define("DiagnosticSignWarn",
      {text = " ", texthl = "DiagnosticSignWarn"})
    vim.fn.sign_define("DiagnosticSignInfo",
      {text = " ", texthl = "DiagnosticSignInfo"})
    vim.fn.sign_define("DiagnosticSignHint",
      {text = "󰌵", texthl = "DiagnosticSignHint"})

    -- Set up keymaps
    -- Global mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    -- vim.keymap.set('n', '<space>wl', function()
    --  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
  end,
}

return M
