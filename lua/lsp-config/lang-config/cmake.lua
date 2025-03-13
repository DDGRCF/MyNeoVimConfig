local opts = {
	cmd = {
		"cmake-language-server",
	},
	filetypes = { "cmake" },
	init_options = {
		buildDirectory = "build",
	},
	root_dir = require("lspconfig.util").root_pattern(
		"CMakePresets.json",
		"CTestConfig.cmake",
		".git",
		"build",
		"cmake"
	),
	single_file_support = true,
	handlers = {
		["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
		["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
	},
}

return opts
