local M = {
	lintCommand = "go vet",
	lintIgnoreExitCode = true,
	lintFormats = { "%f:%l:%c: %m" },
	lintSource = "go vet",
}

return M
