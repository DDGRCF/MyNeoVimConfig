local status_mason_dap, mason_dap = pcall(require, "mason-nvim-dap")
if not status_mason_dap then
    vim.notify("can't find mason-nvim-dap", "error", { title = "Plugin" })
    return
end

local dap_handlers = {}

mason_dap.setup({
    automatic_installation = true,
    ensure_installed = {
        "codelldb",
        "python",
        "cppdbg",
        "delve"
    },
    handlers = dap_handlers,
})

local status_dap_python, dap_python = pcall(require, "dap-python")
if status_dap_python then
    local path = require("mason-registry").get_package("debugpy"):get_install_path()
    dap_python.setup(path .. "/venv/bin/python")
end

local status_dap_go, dap_go = pcall(require, "dap-go")
if status_dap_go then
    dap_go.setup()
end

-- load vscode config
local status_dap_vscode, dap_vscode = pcall(require, "dap.ext.vscode")
if status_dap_vscode then
    dap_vscode.type_to_filetypes = {
        codelldb = { "rust", "c", "cpp" },
        cppdbg = { "rust", "c", "cpp" },
        python = { "python" },
        go = { "go" }
    }
    local status_json5, json5 = pcall(require, "overseer.json")
    if status_json5 then
        dap_vscode.json_decode = json5.decode
    end
    dap_vscode.load_launchjs()
else
    vim.notify("can't load dap vscode extension", "error", { title = "Plugin" })
end

-- for codelldb stop on start
-- "initCommands": [
--     "breakpoint set -n main -N entry"
-- ],
-- "exitCommands": [
--     "breakpoint delete entry"
-- ]
