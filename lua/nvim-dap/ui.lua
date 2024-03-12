local status_dap, dap = pcall(require, "dap")
if not status_dap then
	require("notify")("can't find dap")
	return
end

local status_dapui, dapui = pcall(require, "dapui")
if not status_dapui then
	require("notify")("can't find dap ui")
	return
end

local status_dvt, dvt = pcall(require, "nvim-dap-virtual-text")
if status_dvt then
	dvt.setup({
		commented = true,
	})
else
	require("notify")("can't find nvim-dap-virtual-text")
end

vim.api.nvim_set_hl(0, "DapStoppedSignLineHl", { underline = true })
vim.api.nvim_set_hl(0, "DapStoppedSignTextHl", { fg = "#a6da95" })

-- 定义各种图标
vim.fn.sign_define("DapStopped", {
	text = "",
	texthl = "DapStoppedSignTextHl",
	linehl = "DapStoppedSignLineHl",
	numhl = "LspDiagnosticsSignInformation",
})

vim.fn.sign_define("DapBreakpointRejected", {
	text = "",
	texthl = "LspDiagnosticsSignHint",
	linehl = "",
	numhl = "",
})

vim.fn.sign_define("DapBreakpoint", {
  text = "",
  texthl = "DapBreakpoint",
  linehl = "",
  numhl = ""
})

vim.fn.sign_define("DapBreakpointCondition", {
  text = "󰔶",
  texthl = "DapBreakpointCondition",
  linehl = "",
  numhl = ""
})

vim.fn.sign_define("DapLogPoint", {
  text = "",
  texthl = "DapLogPoint",
  linehl = "",
  numhl = ""
})

dapui.setup({
	controls = {
		element = "repl",
		enabled = true,
		icons = {
			disconnect = "",
			pause = "",
			play = "",
			run_last = "",
			step_back = "",
			step_into = "",
			step_out = "",
			step_over = "",
			terminate = "",
		},
	},
	element_mappings = {},
	expand_lines = true,
	floating = {
		mappings = require("keybindings").dapui.floating,
		border = "rounded",
    max_height = 0.7,
    max_width = 0.7
	},
	force_buffers = true,
	icons = {
		collapsed = "",
		current_frame = "",
		expanded = "",
	},
  layouts = {
    {
      elements = {
        {
          id = "repl",
          size = 0.5
        },
        {
          id = "console",
          size = 0.5
        }
      },
      position = "bottom",
      size = 12
    }
  },
	mappings = require("keybindings").dapui.window,
	render = {
		indent = 1,
		max_type_length = nil, -- Can be integer or nil.
	},
})

dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
