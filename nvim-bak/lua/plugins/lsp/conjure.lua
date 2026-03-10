local M = {
  {
    "Olical/conjure",
    ft = { "clojure", "fennel", "edn" }, -- etc
    lazy = true,
    init = function()
      -- Set configuration options here
      -- Uncomment this to get verbose logging to help diagnose internal Conjure issues
      -- This is VERY helpful when reporting an issue with the project
      -- vim.g["conjure#debug"] = true
      vim.g["conjure#client#clojure#nrepl#connection#auto_repl#cmd"] = "lein repl"
      vim.g["conjure#client#clojure#nrepl#eval#raw_out"] = true
      --   vim.g["conjure#log#hud#open_when"] = "log-win-not-visible"
      --   vim.api.nvim_create_autocmd({ "BufNewFile" }, {
      --     group = vim.api.nvim_create_augroup("ConjureLog", { clear = true }),
      --     pattern = "conjure-log-*",
      --     callback = function(params)
      --       for i, ns in pairs(vim.diagnostic.get_namespaces()) do
      --         vim.diagnostic.reset(i, 0)
      --       end
      --     end,
      --   })
      --   -- autocmd User ConjureEval if expand("%:t") =~ "^conjure-log-" | exec "normal G" | endif
      --   vim.api.nvim_create_autocmd("BufEnter", {
      --     group = vim.api.nvim_create_augroup("ConjureEval", { clear = true }),
      --     pattern = "conjure-log-*",
      --     callback = function(params)
      --       if string.match(vim.api.nvim_buf_get_name(0), "conjure%-log%-") then
      --         vim.api.nvim_exec([[normal G]], true)
      --       end
      --     end,
      --   })
      --
      --   vim.api.nvim_create_autocmd("BufEnter", {
      --     group = vim.api.nvim_create_augroup("ConjureSmartQ", { clear = true }),
      --     pattern = "conjure-log-*",
      --     command = "nmap <buffer> q :q<CR>",
      --   })
      --
      --   vim.api.nvim_create_autocmd("BufEnter", {
      --     group = vim.api.nvim_create_augroup("ConjureSmartB", { clear = true }),
      --     pattern = "conjure-log-*",
      --     callback = function(params)
      --       vim.api.nvim_set_keymap("n", "B", "^", { noremap = true })
      --     end,
      --   })
    end,
    keys = {
      { "<leader>de",  "<cmd> ConjureCljDebugInput eval<CR>",  mode = "n", noremap = true },
      { "<leader>di",  "<cmd> ConjureCljDebugInit<CR>",        mode = "n", noremap = true },
      { "<leader>dl",  "<cmd> ConjureCljDebugInput local<CR>", mode = "n", noremap = true },
      { "<leader>dli", "<cmd> ConjureCljDebugInput in<CR>",    mode = "n", noremap = true },
      { "<leader>dlo", "<cmd> ConjureCljDebugInput out<CR>",   mode = "n", noremap = true },
    },
    config = function()
      require("conjure.main").main()
      require("conjure.mapping")["on-filetype"]()
    end,

  },

  { "Olical/aniseed" },
  { "bakpakin/fennel.vim" },
}

return M
