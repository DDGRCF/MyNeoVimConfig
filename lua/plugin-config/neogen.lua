local status_neogen, neogen = pcall(require, "neogen")
if not status_neogen then
  require("neogen")("can't find neogen")
  return
end

neogen.setup({
  enabled = true,
  snippet_engine = "luasnip",
  input_after_comment = true,
})
