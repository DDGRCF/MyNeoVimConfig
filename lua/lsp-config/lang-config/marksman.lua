local opts = {
    filetypes = { "markdown", "markdown.mdx" },
    root_dir = require("lspconfig.util").root_pattern(".git", ".marksman.toml"),
    single_file_support = true,
    handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
    },
}

return opts
