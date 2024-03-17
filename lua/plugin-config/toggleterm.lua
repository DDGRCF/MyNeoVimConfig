local status, toggleterm = pcall(require, "toggleterm")
if not status then
  vim.notify("can't find toggleterm", "error", { title = "Plugin" })
  return
end

toggleterm.setup({
  size = function(term)
    if term.direction == "horizontal" then
      return 12
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.3
    elseif term.direction == "float" then
      return 20
    end
  end,
  hide_numbers = true,
  shade_terminals = true,
  shading_factor = 4,
  start_in_insert = true,
  insert_mappings = false, -- 这个要是设置为false，要不然会导致space很慢
  persist_size = true,
  direction = "horizontal",
  close_on_exit = true,
  shell = vim.o.shell,
  float_opts = {
    border = "curved",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
})

-- TODO: move keybindings
function _G.set_terminal_keymaps()
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(0, 't', '<Esc>', [[<C-\><C-N>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<A-h>', [[<C-\><C-N><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<A-j>', [[<C-\><C-N><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<A-k>', [[<C-\><C-N><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<A-l>', [[<C-\><C-N><C-W>l]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
