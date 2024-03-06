local status_mason_dap, mason_dap = pcall(require, "mason-nvim-dap")
if not status_mason_dap then
  require("notify")("can't find mason-nvim-dap")
  return
end

local dap_handlers = {}

mason_dap.setup({
  automatic_installation = true,
  ensure_installed = {
    "codelldb", "python", "cppdbg"
  },
  handlers = dap_handlers,
})

local status_dap_python, dap_python = pcall(require, "dap-python")
if status_dap_python then
local path = require("mason-registry").get_package("debugpy"):get_install_path()
  dap_python.setup(path .. "/venv/bin/python")
end

-- load vscode config
local status_dap_vscode, dap_vscode = pcall(require, "dap.ext.vscode")
if status_dap_vscode then
  dap_vscode.type_to_filetypes = {
    codelldb = { "rust", "c", "cpp" },
    cppdbg = { "rust", "c", "cpp" },
    python = { "python" }
  }
  local status_json5, json5 = pcall(require, "overseer.json")
  if status_json5 then
    dap_vscode.json_decode = json5.decode
  end
  dap_vscode.load_launchjs()
else
  require("notify")("can't load dap vscode extension")
end

-- for codelldb stop on start
-- "initCommands": [
--     "breakpoint set -n main -N entry"
-- ],
-- "exitCommands": [
--     "breakpoint delete entry"
-- ]



