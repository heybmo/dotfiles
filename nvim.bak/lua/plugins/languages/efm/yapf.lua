local M = {
  formatCommand = "yapf --style='{based_on_style: google, spaces_before_comment: 4, split_before_logical_operator: true}' --in-place",
  formatStdin = true,
}

return M
