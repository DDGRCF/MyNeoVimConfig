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
    end,
    init_options = {
        vue = {
            hybridMode = true,
        }
    },
    filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'},
    cmd = { "vue-language-server", "--stdio" },
	single_file_support = true,
	root_dir = function(fname)
		return require("lspconfig.util").root_pattern(
        "tsconfig.json", "jsconfig.json", "package.json", ".git"
		)(fname)
	end,
}

return opts
