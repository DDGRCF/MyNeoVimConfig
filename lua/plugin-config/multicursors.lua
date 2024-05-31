local status_multicusors, multicursors = pcall(require, "multicursors")
if not status_multicusors then
	vim.print("can't find multicursors")
	return
end

multicursors.setup({})
