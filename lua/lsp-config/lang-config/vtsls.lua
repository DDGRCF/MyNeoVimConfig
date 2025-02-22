local vue_typescript_plugin = require("mason-registry").get_package("vue-language-server"):get_install_path()
    .. "/node_modules/@vue/language-server"
    .. "/node_modules/@vue/typescript-plugin"

local opts = {
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    on_attach = function(client, bufnr)
        local function buf_set_keymap(...)
            vim.api.nvim_buf_set_keymap(bufnr, ...)
        end

        require("keybindings").mapLSP(buf_set_keymap)
        local status_illuminate, illuminate = pcall(require, "illuminate")
        if status_illuminate then
            illuminate.on_attach(client)
        end

        local status_navic, navic = pcall(require, "nvim-navic")
        if status_navic and client.server_capabilities.documentSymbolProvider then
            navic.attach(client, bufnr)
        end
    end,
    init_options = {
        hostInfo = "neovim"
    },
    tsserver = {
        globalPlugins = {
            {
                name = '@vue/typescript-plugin',
                location = vue_typescript_plugin,
                languages = { 'vue' },
                configNamespace = "typescript",
                enableForWorkspaceTypeScriptVersions = true,
            },
        },
    },
    cmd = { "vtsls", "--stdio" },
    filetypes = { "javascript", "typescript", "vue" },
    single_file_support = true,
    root_dir = function(fname)
        return require("lspconfig.util").root_pattern(
            "tsconfig.json", "jsconfig.json", "package.json", ".git"
        )(fname)
    end,
    handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
    },
}

return opts
