local status_comment, comment = pcall(require, "Comment")
if not status_comment then
	vim.notify("can't find Comment", "error", { title = "Plugin" })
	return
end

comment.setup({})
