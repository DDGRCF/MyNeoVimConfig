-- 如果找不到lualine 组件，就不继续执行
local status, diff = pcall(require, "mini.diff")
if not status then
	vim.notify("can't find diff", "error", { title = "Plugin" })
	return
end

diff.setup({
	view = {
		style = "sign",
		signs = {
			add = "▎",
			change = "▎",
			delete = "",
		},
	},
})
