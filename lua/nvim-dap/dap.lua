local status_mason_dap, mason_dap = pcall(require, "mason-nvim-dap")
if not status_mason_dap then
	vim.notify("mason-nvim-dap not found", "error", { title = "Plugin" })
	return
end

mason_dap.setup({
	automatic_installation = true,
	ensure_installed = { "codelldb", "python", "cppdbg", "delve" },
	handlers = {},
})

local function detect_python_environment()
	local venv_env = os.getenv("VIRTUAL_ENV")
	if venv_env then
		return venv_env .. "/bin/python"
	end

	-- Check for .venv directory in project root
	local project_root = vim.fn.getcwd()
	local venv_dir = project_root .. "/.venv/bin/python"
	if vim.fn.isdirectory(project_root .. "/.venv") == 1 then
		return venv_dir
	end

	-- Check for conda environment (simplified)
	local conda_env = os.getenv("CONDA_PREFIX")
	if conda_env then
		return conda_env .. "/bin/python"
	end

	-- If no environment is found, return system python (or nil with a warning)
	vim.notify("No virtual environment detected, using system Python", vim.log.levels.WARN, { title = "DAP" })
	return "python" -- Or return nil if you prefer explicit handling
end

local dap_python_setup = function()
	local python_path = detect_python_environment()
	if python_path then
		require("dap-python").setup(python_path)
	else
		vim.notify("No Python executable found for DAP", vim.log.levels.ERROR, { title = "DAP" })
	end
end

local status_dap_python = pcall(dap_python_setup)
if not status_dap_python then
	vim.notify("Failed to setup dap-python", vim.log.levels.ERROR, { title = "DAP" })
end

local status_dap_go = pcall(require, "dap-go")
if status_dap_go then
	require("dap-go").setup()
end

local status_dap_vscode, dap_vscode = pcall(require, "dap.ext.vscode")
if not status_dap_vscode then
	vim.notify("dap vscode extension not found", "error", { title = "Plugin" })
	return
end

dap_vscode.type_to_filetypes = {
	codelldb = { "rust", "c", "cpp" },
	cppdbg = { "rust", "c", "cpp" },
	python = { "python" },
	go = { "go" },
}

local status_json5 = pcall(require, "overseer.json")
if status_json5 then
	dap_vscode.json_decode = require("overseer.json").decode
end

dap_vscode.load_launchjs()

-- for codelldb stop on start
-- "initCommands": [
--     "breakpoint set -n main -N entry"
-- ],
-- "exitCommands": [
--     "breakpoint delete entry"
-- ]
