require('neoscroll').setup({
    easing_function = "quadratic", -- Default easing function
    mappings = {},
    -- Set any other options as needed
})


local t = {}
-- Syntax: t[keys] = {function, {function arguments}}
-- Use the "sine" easing function
local scroll_up = {'scroll', {'-vim.wo.scroll', 'true', '350', [['sine']]}}
local scroll_down = {'scroll', {'-vim.wo.scroll', 'true', '350', [['sine']]}}
local scroll_bottom = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '500', [['circular']]}}
local scroll_top = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '500', [['circular']]}}

t = {
  su = scroll_up,
  sk = scroll_up,
  ['s<Up>'] = scroll_up,
  sd = scroll_down,
  sj = scroll_down,
  ['s<Down>'] = scroll_down,
  st = scroll_top,
  sb = scroll_bottom,
}

require('neoscroll.config').set_mappings(t)
