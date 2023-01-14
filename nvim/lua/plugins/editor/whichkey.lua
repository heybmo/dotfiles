local M = {
  'folke/which-key.nvim',
  lazy = false,
  opts = {
    plugins = { spelling = true },
    key_labels = { ['<leader>'] = 'SPC' },
  },
}

function M.config(_, opts)
  local wk = require('which-key')
  wk.setup(opts)
  wk.register({
    mode = { 'n', 'v' },
    ['g'] = { name = '+goto' },
    [']'] = { name = '+next' },
    ['['] = { name = '+prev' },
    ['<leader><tab>'] = { name = '+tabs' },
    ['<leader>b'] = { name = '+buffer' },
    ['<leader>c'] = { name = '+code' },
    ['<leader>f'] = { name = '+file/find' },
    ['<leader>g'] = { name = '+git' },
    ['<leader>gh'] = { name = '+hunks' },
    ['<leader>n'] = { name = '+noice' },
    ['<leader>q'] = { name = '+quit/clear/session' },
    ['<leader>s'] = { name = '+search' },
    ['<leader>u'] = { name = '+ui' },
    ['<leader>w'] = { name = '+windows' },
    ['<leader>x'] = { name = '+diagnostics/quickfix' },
  })
  -- Visual keymaps
  wk.register({
    c = { '"d', 'Cut' },
    -- d = {'"_d', 'Delete without yanking' },
    -- p = {'"_dP', 'paste replace visual selection WITHOUT copying it'}
    [','] = {
      name = '+code actions',
      r = { '<cmd>lua vim.lsp.buf.range_formatting()<CR>', 'Format range' },
    },
  }, { mode = 'v' })

  -- Normal keymaps
  wk.register({
    [','] = {
      name = '+diagnostic/language actions',
      d = {vim.diagnostic.open_float, 'create floating window for diagnostics', },
      p = {vim.diagnostic.goto_prev, 'go to previous diagnostic', },
      n = {vim.diagnostic.goto_next, 'go to next diagnostic', },
      l = {vim.diagnostic.setloclist, 'diagnostic location list', },
      ['='] = {
        ['='] = {'<cmd>lua (function() vim.lsp.buf.format { async = true } end)()<CR>', 'format buffer'},
      },
    },
    ['<leader>'] = {
      ['<Left>'] = { '<cmd>:bp<CR>', 'Previous Buffer' },
      ['<Right>'] = { '<cmd>:bn<CR>', 'Next Buffer' },
      ['/'] = { '<cmd>Telescope grep_string<CR>', 'Search for code match' },
      ['<Tab>'] = { '<C-^><CR>', 'Toggle between buffers' },
      q = {
        name = '+quit/clear',
        h = { '<cmd>:noh<CR>', 'Clear highlights until next search' },
        q = { '<cmd>qa<CR>', 'Quit all, abort for unsaved files' },
        ['!'] = { '<cmd>q!<CR>', 'Quit all, forcefully.' },
      },
      u = {
        name = '+ui',
        s = {
          name = '+set',
          c = { ':set colorcolumn=80<CR>', 'Set visual column at col 80' },
          C = { ':set colorcolumn=<CR>', 'Clear an existing visual column(s)' },
        },
      },
      w = {
        name = '+window',
        ['<Right>'] = { '<C-w><Right>', 'Go to window on the right' },
        ['<Left>'] = { '<C-w><Left>', 'Go to window on the left' },
        ['<Up>'] = { '<C-w><Up>', 'Go to window above' },
        ['<Down>'] = { '<C-w><Down>', 'Go to window below' },
        [']'] = { '<C-w>>', 'Increase window size' },
        ['['] = { '<C-w><', 'Decrease window size' },
        ['+'] = { '<C-w>+', 'Increase window size' },
        ['-'] = { '<C-w>-', 'Decrease window size' },
        d = { '<cmd>bd<CR>', 'Delete current window' },
        h = { '<C-w><Left>', 'Go to window on the left' },
        l = { '<C-w><Right>', 'Go to window on the right' },
        j = { '<C-w><Down>', 'Go to window below' },
        k = { '<C-w><Up>', 'Go to window above' },
        S = { '<C-w>x', 'Swap window with next one' },
        s = { '<C-w>s', 'Split window horizontally' },
        v = { '<C-w>v', 'Split window vertically' },
        ['<TAB>'] = { '<C-^><CR>', 'Toggle between buffers' },
      },
    },
  }, { mode = 'n' })
end

return M
