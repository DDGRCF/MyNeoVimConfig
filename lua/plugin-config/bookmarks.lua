vim.api.nvim_set_hl(0, "BookmarkSign", { link = "WarningMsg" })
vim.api.nvim_set_hl(0, "BookmarkAnnotationSign", { link = "DiagnosticOk" })

vim.g["bookmark_sign"] = ""
vim.g["bookmark_annotation_sign"] = ""

local status_telescope, telescope = pcall(require, "telescope")
if status_telescope then
  telescope.load_extension("vim_bookmarks")
end
