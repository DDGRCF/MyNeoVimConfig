local status_dap, dap = pcall(require, "dap")
if not status_dap then
  require("notify")("can't find dap")
  return
end

local adapter_opts = {
  type = "executable",
  command = "/home/r/Anaconda3/bin/python3",
  args = {
    "-m",
    "debugpy.adapter",
  },
}

for _, lang in ipairs({ "python" }) do
  dap.configurations[lang] = {
    {
      type = 'python',
      request = 'launch',
      name = "Launch input file",
      program = function()
        return vim.fn.input({
          prompt = "Path to executable: ",
          default = vim.fn.getcwd() .. "/",
          completion = "file"
        })
      end,
      pythonPath = function()
        return "/home/r/Anaconda3/bin/python3"
      end,
    },
  }
end


return adapter_opts
