local status_mason, mason = pcall(require, "mason")
if not status_mason then
  require("notify")("can't find mason.nvim")
  return
end

local status_lspconfig, lspconfig = pcall(require, "lspconfig")
if not status_lspconfig then
  require("notify")("can't find lspconfig")
  return
end

local status_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_mason_lspconfig then
  require("notify")("can't find mason_lspconfig.nvim")
  return
end

mason.setup({
  ui = {
    border = "rounded",
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
})

local lsp_handlers = {
  function(server_name)
    lspconfig[server_name].setup {}
  end,
  ["lua_ls"] = function()
    lspconfig.lua_ls.setup(
      require("lsp-config.lang-config.lua_ls")
    )
  end,
  ["clangd"] = function()
    lspconfig.clangd.setup(
      require("lsp-config.lang-config.clang")
    )
  end,
  ["pyright"] = function()
    lspconfig.pyright.setup(
      require("lsp-config.lang-config.pyright")
    )
  end,
}

mason_lspconfig.setup({
  ensure_installed = { "lua_ls", "pyright", "clangd", "gopls" },
  handlers = lsp_handlers
})
