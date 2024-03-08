vim.api.nvim_set_hl(0, "BookmarkSign", { fg = "#ee99a0" })
vim.api.nvim_set_hl(0, "BookmarkAnnotationSign", { fg = "#8aadf4" })

local status_telescope, telescope = pcall(require, "telescope")
if status_telescope then
  telescope.load_extension("vim_bookmarks")
end

