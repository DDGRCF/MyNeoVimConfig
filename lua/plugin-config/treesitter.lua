local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
	vim.notify("can't find nvim-treesitter", "error", { title = "Plugin" })
	return
end

treesitter.setup({
	-- 安装 language parser
	sync_install = false,
	auto_install = true,
	modules = {},
	ignore_install = {},
	ensure_installed = {
		"bash",
		"c",
		"diff",
		"html",
		"javascript",
		"jsdoc",
		"json",
		"jsonc",
		"lua",
		"luadoc",
		"luap",
		"markdown",
		"markdown_inline",
		"python",
		"query",
		"regex",
		"toml",
		"tsx",
		"typescript",
		"vim",
		"vimdoc",
		"xml",
		"yaml",
		"ninja",
		"toml",
		"rst",
        "css",
        "vue"
	},
	-- 启用代码高亮模块
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = true,
	},
	-- 启用增量选择模块
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<CR>",
			node_incremental = "<CR>",
			node_decremental = "<BS>",
			scope_incremental = "<TAB>",
		},
	},
	indent = {
		enable = false,
	},
	autopairs = {
		enable = true,
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
	disable = function(lang, buf)
		local max_filesize = 32 * 1024 -- 128 kb
		local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
		if ok and stats and stats.size > max_filesize then
			return true
		end
	end,
})
