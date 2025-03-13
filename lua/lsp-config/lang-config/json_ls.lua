local opts = {
	filetypes = { "json", "jsonc" },
	init_options = {
		provideFormatter = false,
	},
	root_dir = require("lspconfig.util").find_git_ancestor,
	single_file_support = true,
	handlers = {
		["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
		["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
	},
}

return opts
