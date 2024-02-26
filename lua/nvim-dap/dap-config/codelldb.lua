local status_dap, dap = pcall(require, "dap")
if not status_dap then
  require("notify")("can't find dap")
  return
end

local adapter_opts = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "codelldb",
    args = {
      "--port",
      "${port}",
    },
  },
}


for _, lang in ipairs({ "c", "cpp" }) do
  dap.configurations[lang] = {
    {
      type = "codelldb",
      request = "launch",
      name = "Launch input file",
      program = function()
        return vim.fn.input({
          prompt = "Path to executable: ",
          default = vim.fn.getcwd() .. "/",
          completion = "file"
        })
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = true
    },
  }
end

return adapter_opts
