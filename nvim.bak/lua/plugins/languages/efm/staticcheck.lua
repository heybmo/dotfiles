local M = {
	lintCommand = "staticcheck",
	lintIgnoreExitCode = true,
	lintFormats = { "%f:%l:%c: %m" },
	lintSource = "staticcheck",
}

return M
