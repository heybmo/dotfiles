-- Heavily borrowing from LazyVim

local diagnosticIcons = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " ",
  }

local keymaps = {

}

-- Every server must have the following keys:
-- * settings
-- * 
local servers = {

}

local M = {
    "neovim/nvim-lspconfig",
    event = { "BufRead", "BufWritePre", "BufReadPre", "InsertEnter" },
    dependencies = {
        {
            "hrsh7th/cmp-nvim-lsp",
            cond = function()
              return require("lazyvim.util").has("nvim-cmp")
            end,
        },
        "mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },

    opts = {
        diagnostics = {
            underline = true,
            update_in_insert = false,
            virtual_text = {
              spacing = 4,
              source = "if_many",
              prefix = "●",
              -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
              -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
              -- prefix = "icons",
            },
            severity_sort = true,
        },
        autoformat = true,
    },

    config = function(_, opts)
        local lsp = require("lspconfig")
        local util = require("lspconfig.util")
        local handlers = require("plugins.lsp.handlers")
        local cmp_nvim = require("cmp_nvim_lsp")
        local capabilities = cmp_nvim.default_capabilities(vim.lsp.protocol.make_client_capabilities())

        -- Set up keymaps
        local register_capability = vim.lsp.handlers["client/registerCapability"]
        vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
            local ret = register_capability(err, res, ctx)
            local client_id = ctx.client_id
            local client = vim.lsp.get_client_by_id(client_id)
            local buffer = vim.api.nvim_get_current_buf()
            
            local keymapOpts = {
                buffer = buffer,
            }

            for _, keys in pairs(keymaps) do
                vim.keymap.set(keys.mode or "n", keys[1], keys[2], keymapOpts)
            end
            
            return ret
        end
    
        -- diagnostics
        for name, icon in pairs(diagnosticIcons) do
            -- Define the icon signs using the icons from above
            name = "DiagnosticSign" .. name
            vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
        end

        if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
            opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
              or function(diagnostic)
                for d, icon in pairs(diagnosticIcons) do
                  if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                    return icon
                  end
                end
              end
          end
    
        vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
    end
}