local opts = {
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	on_attach = function(client, bufnr)
		local function buf_set_keymap(...)
			vim.api.nvim_buf_set_keymap(bufnr, ...)
		end
		require("keybindings").mapLSP(buf_set_keymap)
		local status, illuminate = pcall(require, "illuminate")
		if not status then
			return
		end
		illuminate.on_attach(client)
		local status_navic, navic = pcall(require, "nvim-navic")
		if status_navic and client.server_capabilities.documentSymbolProvider then
			navic.attach(client, bufnr)
		end
	end,
	cmd = { "bash-language-server", "start" },
	filetypes = { "sh" },
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
