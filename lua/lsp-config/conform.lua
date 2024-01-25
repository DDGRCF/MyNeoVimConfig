local status_conform, conform = pcall(require, "conform")
if not status_conform then
  require("notify")("can't find conform")
  return
end

-- ConformInfo 检查是否安装需要手动安装
conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black" },
    go = { "goimports", "gofmt" },
    cpp = { "clang_format" }, -- not working, using clangd
    json = { "fixjson" },
    ["*"] = { "codespell" },
    ["_"] = { "trim_whitespace" },
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
})
