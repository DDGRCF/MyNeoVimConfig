return {
  name = "g++ build",
  builder = function()
    -- Full path to current file (see :help expand())
    local file = vim.fn.expand("%:p")
    local file_noext = string.gsub(file, "%.%w+$", "")
    local cmd = { "g++", "-g", file, "-o", file_noext }
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
