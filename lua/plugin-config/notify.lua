local status_notify, notify = pcall(require, "notify")
if not status_notify then
	vim.print("can't find notify")
	return
end

notify.setup({
	timeout = 2000,
	level = 2,
	max_height = function()
		return math.floor(vim.o.lines * 0.75)
	end,
	max_width = function()
		return math.floor(vim.o.columns * 0.75)
	end,
	on_open = function(win)
		vim.api.nvim_win_set_config(win, { zindex = 100 })
	end,
})

vim.notify = notify
