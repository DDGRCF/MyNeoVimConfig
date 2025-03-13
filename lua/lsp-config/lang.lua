-- 通用插件加载函数
local function load_plugin(plugin_name)
	local status, plugin = pcall(require, plugin_name)
	if not status then
		vim.notify("can't find " .. plugin_name, "error", { title = "Plugin" })
		return nil
	end
	return plugin
end

-- 加载必要插件
local plugins = { "mason", "lspconfig", "mason-lspconfig", "cmp_nvim_lsp", "illuminate", "nvim-navic" }
local loaded_plugins = {}
for _, plugin in ipairs(plugins) do
	local loaded = load_plugin(plugin)
	if not loaded then
		return
	end
	loaded_plugins[plugin] = loaded
end

-- 拆分 on_attach 逻辑
local function setup_inlay_hints(client, bufnr)
	if client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end
end

local function setup_illuminate(client)
	if loaded_plugins["illuminate"] then
		loaded_plugins["illuminate"].on_attach(client)
	end
end

local navic_attached = false
local function setup_navic(client, bufnr)
	if loaded_plugins["nvim-navic"] and client.server_capabilities.documentSymbolProvider and not navic_attached then
		loaded_plugins["nvim-navic"].attach(client, bufnr)
		navic_attached = true
	end
end

local function setup_keybindings(bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	require("keybindings").mapLSP(buf_set_keymap)
end

-- 通用 LSP 配置
local common_config = {
	capabilities = loaded_plugins["cmp_nvim_lsp"].default_capabilities(),
	on_attach = function(client, bufnr)
		setup_inlay_hints(client, bufnr)
		setup_illuminate(client)
		setup_navic(client, bufnr)
		setup_keybindings(bufnr)
	end,
	handlers = {
		["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
		["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
	},
}

-- Mason 配置
loaded_plugins["mason"].setup({
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

-- 待安装的 LSP 服务器列表
local servers = {
	"lua_ls",
	"pyright",
	"clangd",
	"cmake",
	"jsonls",
	"marksman",
	"bashls",
	"yamlls",
	"volar",
	"gopls",
	"ts_ls",
	"ruff",
	"unocss",
}
loaded_plugins["mason-lspconfig"].setup({
	ensure_installed = servers,
})

-- 服务器特定配置映射
local server_config_map = {
	lua_ls = "lsp-config.lang-config.lua_ls",
	clangd = "lsp-config.lang-config.clangd",
	pyright = "lsp-config.lang-config.pyright",
	cmake = "lsp-config.lang-config.cmake",
	marksman = "lsp-config.lang-config.marksman",
	jsonls = "lsp-config.lang-config.json_ls",
	bashls = "lsp-config.lang-config.bash_ls",
	yamlls = "lsp-config.lang-config.yaml_ls",
	gopls = "lsp-config.lang-config.gopls",
	volar = "lsp-config.lang-config.volar",
	ts_ls = "lsp-config.lang-config.tsls",
	ruff = "lsp-config.lang-config.ruff",
	unocss = "lsp-config.lang-config.unocss",
}

-- 设置 LSP 服务器处理函数
loaded_plugins["mason-lspconfig"].setup_handlers({
	function(server_name)
		local server_specific_config = server_config_map[server_name] and require(server_config_map[server_name]) or {}
		loaded_plugins["lspconfig"][server_name].setup(
			vim.tbl_deep_extend("force", {}, common_config, server_specific_config)
		)
	end,
})
