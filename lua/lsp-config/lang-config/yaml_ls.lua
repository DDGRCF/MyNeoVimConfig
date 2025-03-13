return {
	filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
	init_options = {
		provideFormatter = false,
	},
	{
		redhat = {
			telemetry = {
				enabled = false,
			},
		},
	},
	root_dir = require("lspconfig.util").find_git_ancestor,
	single_file_support = true,
	handlers = {
		["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
		["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
	},
}
