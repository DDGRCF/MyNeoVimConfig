local status_comment, comment = pcall(require, "Comment")
if not status_comment then
  require("notify")("can't find Comment")
  return
end

comment.setup({})
