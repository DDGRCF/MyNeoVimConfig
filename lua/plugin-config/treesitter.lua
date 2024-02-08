local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
  vim.notify("can't find nvim-treesitter")
  return
end

treesitter.setup({
  -- 安装 language parser
  sync_install = false,
  auto_install = true,
  modules = {},
  ignore_install = {},
  ensure_installed = {
    "c", "cpp", "json", "json5", "jsonc", "markdown", "python",
    "html", "lua", "vimdoc", "vim", "query",
    "bash", "markdown_inline", "cmake", "toml", "yaml",
    "go", "gomod", "gowork", "gosum", "gitignore", "gitcommit", "git_config"
  },
  -- 启用代码高亮模块
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
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
    enable = true,
  },
  autopairs = {
    enable = true,
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
})
