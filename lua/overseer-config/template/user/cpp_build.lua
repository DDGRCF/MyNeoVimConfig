return {
  name = "g++ build",
  builder = function()
    -- Full path to current file (see :help expand())
    local file = vim.fn.expand("%:p")
    local cmd = { "g++", "-g", file }
    return {
      cmd = cmd,
      components = {
        {
          "on_output_quickfix", open = true
        }, "default"
      },
    }
  end,
  condition = {
    filetype = { "cpp" },
  },
}
