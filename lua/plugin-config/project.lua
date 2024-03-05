local status, project = pcall(require, "project_nvim")
if not status then
  require("notify")("can't find project_nvim")
  return
end

project.setup({
  detection_methods = { "pattern", "lsp" },
  patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", ".sln" },
})

local status_telescope, telescope = pcall(require, "telescope")
if status_telescope then
  telescope.load_extension("projects")
else
  vim.notify("can't find telescope")
end
