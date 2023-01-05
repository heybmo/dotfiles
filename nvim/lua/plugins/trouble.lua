require('trouble').setup({
  position = 'bottom', -- position of the list can be: bottom, top, left, right
    height = 10, -- height of the trouble list when position is top or bottom
    width = 50, -- width of the list when position is left or right
    icons = true, -- use devicons for filenames
    mode = 'workspace_diagnostics',
    auto_open = false,
    auto_preview = true,
    auto_close = true
})
