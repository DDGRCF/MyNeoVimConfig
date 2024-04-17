local status_mason, mason = pcall(require, "mason")
if not status_mason then
	vim.notify("can't find mason.nvim", "error", { title = "Plugin" })
	return
end

local status_lspconfig, lspconfig = pcall(require, "lspconfig")
if not status_lspconfig then
	vim.notify("can't find lspconfig", "error", { title = "Plugin" })
	return
end

local status_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_mason_lspconfig then
	vim.notify("can't find mason_lspconfig.nvim", "error", { title = "Plugin" })
	return
end

mason.setup({
	ui = {
		border = "rounded",
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
})

local lsp_handlers = {
	function(server_name)
		lspconfig[server_name].setup({})
	end,
	["lua_ls"] = function()
		lspconfig.lua_ls.setup(require("lsp-config.lang-config.lua_ls"))
	end,
	["clangd"] = function()
		lspconfig.clangd.setup(require("lsp-config.lang-config.clangd"))
	end,
	["pyright"] = function()
		lspconfig.pyright.setup(require("lsp-config.lang-config.pyright"))
	end,
	-- ["gopls"] = function()
	-- 	lspconfig.gopls.setup(require("lsp-config.lang-config.gopls"))
	-- end,
	["cmake"] = function()
		lspconfig.cmake.setup(require("lsp-config.lang-config.cmake"))
	end,
  ["marksman"] = function()
    lspconfig.marksman.setup(require("lsp-config.lang-config.marksman"))
  end,
  ["jsonls"] = function()
    lspconfig.jsonls.setup(require("lsp-config.lang-config.json_ls"))
  end
}

mason_lspconfig.setup({
  ensure_installed = { "lua_ls", "pyright", "clangd", "cmake", "jsonls", "marksman" },
  handlers = lsp_handlers
})
