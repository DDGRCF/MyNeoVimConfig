local status_dap, dap = pcall(require, "dap")
if not status_dap then
	vim.notify("can't find dap", "error", { title = "Plugin" })
	return
end

local status_dapui, dapui = pcall(require, "dapui")
if not status_dapui then
	vim.notify("can't find dap ui", "error", { title = "Plugin" })
	return
end

local status_dvt, dvt = pcall(require, "nvim-dap-virtual-text")
if status_dvt then
	dvt.setup({
		commented = true,
	})
else
	vim.notify("can't find nvim-dap-virtual-text", "error", { title = "Plugin" })
end

vim.api.nvim_set_hl(0, "DapStoppedSignLineHl", { underline = true })

-- 定义各种图标
vim.fn.sign_define("DapStopped", {
	text = "",
	texthl = "DiagnosticOk",
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
          id = "scopes",
          size = 0.25
        }, {
          id = "breakpoints",
          size = 0.25
        }, {
          id = "stacks",
          size = 0.25
        }, {
          id = "watches",
          size = 0.25
        } },
      position = "left",
      size = 35
    },
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

-- dap.listeners.before.attach.dapui_config = function()
-- 	dapui.open({
--     layout = 2,
--     reset = true
--   })
-- end

dap.listeners.before.launch.dapui_config = function()
	dapui.open({
    layout = 2,
    reset = true
  })
end
