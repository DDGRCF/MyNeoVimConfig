local status, mason = pcall(require, "mason")
if not status then
  vim.notify("没有找到 mason.nvim")
  return
end


local status, lspconfig = pcall(require, "lspconfig")
if not status then
  vim.notify("没有找到 lspconfig")
  return
end

local status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status then
  vim.notify("没有找到 mason_lspconfig.nvim")
  return
end

mason.setup()

local handlers = {
  function (server_name)
    lspconfig[server_name].setup{}
  end,
  -- Next, you can provide targeted overrides for specific servers.
  ["lua_ls"] = function ()
    lspconfig.lua_ls.setup {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" }
          }
        }
    }
  }
  end,
  ["clangd"] = function ()
    lspconfig.clangd.setup {
      cmd = {
        "clangd",
        "--header-insertion=never",
        "--query-driver=/usr/bin/clang",
        "--all-scopes-completion",
        "--completion-style=detailed",
      }
    }
  end,
  ["pyright"] = function ()
    lspconfig.pyright.setup {
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            diagnosticMode = "workspace",
            useLibraryCodeForTypes = true,
            typeCheckingMode = false,
          },
        }
      }
    }
  end,
}


mason_lspconfig.setup({
  ensure_installed = { "lua_ls", "pyright", "clangd", "gopls", },
  handlers = handlers
})
