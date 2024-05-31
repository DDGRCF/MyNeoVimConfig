local status, db = pcall(require, "dashboard")
if not status then
	vim.notify("can't find dashboard", "error", { title = "Plugin" })
	return
end

db.setup({
	theme = "hyper",
	config = {
		header = {
			[[]],
			[[                                                                                      ]],
			[[  ███╗   ██╗███████╗ ██████╗       ██████╗ ██████╗  ██████╗ ██████╗  ██████╗███████╗  ]],
			[[  ████╗  ██║██╔════╝██╔═══██╗      ██╔══██╗██╔══██╗██╔════╝ ██╔══██╗██╔════╝██╔════╝  ]],
			[[  ██╔██╗ ██║█████╗  ██║   ██║█████╗██║  ██║██║  ██║██║  ███╗██████╔╝██║     █████╗    ]],
			[[  ██║╚██╗██║██╔══╝  ██║   ██║╚════╝██║  ██║██║  ██║██║   ██║██╔══██╗██║     ██╔══╝    ]],
			[[  ██║ ╚████║███████╗╚██████╔╝      ██████╔╝██████╔╝╚██████╔╝██║  ██║╚██████╗██║       ]],
			[[  ╚═╝  ╚═══╝╚══════╝ ╚═════╝       ╚═════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝ ╚═════╝╚═╝       ]],
			[[                                  [  version : 1.0.0 ]                               ]],
			[[]],
			[[]],
		},
		footer = {
			[[]],
			[[]],
			[[]],
			[[]],
			[[]],
			[[]],
			[[]],
			[[]],
			[[   Good Morning Good Afternoon Good Evening  ]],
			[[]],
			[[]],
		},
		week_header = {
			enable = false,
		},
		packages = {
			enable = true,
		},
		shortcut = {
			{
				action = "Telescope find_files",
				desc = " Find file",
				icon = " ",
				group = "Statement",
				key = "f",
			},
			{
				action = "ene | startinsert",
				desc = " New file",
				icon = " ",
				group = "Special",
				key = "n",
			},
			{
				action = "Neotree position=current",
				desc = " Enter Tree",
				icon = " ",
				group = "String",
				key = "t",
			},
			{
				desc = " Projects",
				icon = " ",
				group = "Tag",
				action = "Telescope projects",
				key = "p",
			},
		},
	},
})

-- https://vi.stackexchange.com/questions/36457/how-can-i-switch-to-the-no-name-buffer
-- local function is_no_name_buf(buf)
--   return
--     vim.api.nvim_buf_is_loaded(buf)
--     and vim.api.nvim_buf_get_option(buf, "buflisted")
--     and vim.api.nvim_buf_get_name(buf) == ""
--     and vim.api.nvim_buf_get_option(buf, "buftype") == ""
--     and vim.api.nvim_buf_get_option(buf, "filetype") == ""
-- end
--
-- local mydashboard = vim.api.nvim_create_augroup("MyDashBoard", { clear = true })
-- vim.api.nvim_create_autocmd("BufEnter", {
--   group = mydashboard,
--   pattern = "*",
--   callback = function(ev)
--     if is_no_name_buf(vim.api.nvim_get_current_buf()) then
--       require("dashboard"):instance()
--     end
--   end
-- })
