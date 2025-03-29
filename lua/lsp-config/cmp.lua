-- 提取插件加载和错误处理逻辑
local function load_plugin(plugin_name)
	local status, plugin = pcall(require, plugin_name)
	if not status then
		vim.notify("can't find " .. plugin_name, "error", { title = "Plugin" })
		return nil
	end
	return plugin
end

-- 加载必要的插件
local cmp = load_plugin("cmp")
if not cmp then
	return
end
local luasnip = load_plugin("luasnip")
if not luasnip then
	return
end
local luasnip_vscode = load_plugin("luasnip.loaders.from_vscode")

luasnip.setup({
	delete_check_events = "TextChanged",
	history = true,
})

-- 加载 vscode 风格的片段
if luasnip_vscode then
	luasnip_vscode.lazy_load()
end

-- 补全措施
cmp.setup({
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	performance = {
		fetching_timeout = 5000, -- 候选获取超时时间
		confirm_resolve_timeout = 1000, -- 确认解析超时时间
		async_budget = 100, -- 异步函数最大运行时间
	},
	-- 指定 snippet 引擎
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	-- 补全源
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
    { name = "supermaven" },
	},
	-- 补全菜单设置
	formatting = require("lsp-config.ui").formatting,
	-- 快捷键设置
	mapping = cmp.mapping.preset.insert(require("keybindings").cmp(cmp, luasnip)),
})

-- / 查找模式使用 buffer 源
cmp.setup.cmdline("/", {
	-- mapping = cmp.mapping.preset.cmdline(),
	mapping = cmp.mapping.preset.cmdline(require("keybindings").cmp(cmp)),
	sources = {
		{ name = "buffer" },
	},
})

-- : 命令行模式中使用 path 和 cmdline 源.
cmp.setup.cmdline(":", {
	-- completion = { autocomplete = true },
	mapping = cmp.mapping.preset.cmdline(require("keybindings").cmp(cmp)),
	sources = {
		{ name = "path" },
		{ name = "cmdline" },
	},
})
