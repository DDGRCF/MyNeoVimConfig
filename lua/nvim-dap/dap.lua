local status_mason_dap, mason_dap = pcall(require, "mason-nvim-dap")
if not status_mason_dap then
  require("notify")("can't find mason-nvim-dap")
  return
end

local dap_handlers = {
  function(config)
    mason_dap.default_setup(config)
  end,
  python = function(config)
    config.adapters = require("nvim-dap.dap-config.python")
    mason_dap.default_setup(config)
  end,
  codelldb = function(config)
    config.adapters = require("nvim-dap.dap-config.codelldb")
    mason_dap.default_setup(config)
  end,
}

mason_dap.setup({
  automatic_installation = true,
  ensure_installed = {
    "codelldb", "python", "cppdbg"
  },
  handlers = dap_handlers,
})

-- load vscode config
local status_dap_vscode, dap_vscode = pcall(require, "dap.ext.vscode")
if status_dap_vscode then
  local status_json5, json5 = pcall(require, "overseer.json")
  if status_json5 then
    dap_vscode.json_decode = json5.decode
  end
  dap_vscode.load_launchjs()
else
  require("notify")("can't load dap vscode extension")
end
