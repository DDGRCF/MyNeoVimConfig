vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- 复用 opt 参数 和 map 函数
local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }
local pluginKeys = {}

-- 取消s默认按键
map("n", "s", "", opt)
-- windows 分屏快捷键
map("n", "sv", ":vsp<CR>", opt)
map("n", "sh", ":sp<CR>", opt)
-- 关闭其他
map("n", "so", "<C-w>o", opt)
-- 关闭当前
map("n", "q", "<C-w>c", opt)
-- 窗口跳转
-- Alt + hjkl  窗口之间跳转
map("n", "<A-h>", "<C-w>h", opt)
map("n", "<A-j>", "<C-w>j", opt)
map("n", "<A-k>", "<C-w>k", opt)
map("n", "<A-l>", "<C-w>l", opt)
-- Leader + hjkl  窗口之间跳转
map("n", "<Leader>wh", "<C-w>h", opt)
map("n", "<Leader>wj", "<C-w>j", opt)
map("n", "<Leader>wk", "<C-w>k", opt)
map("n", "<Leader>wl", "<C-w>l", opt)
-- 左右比例控制
map("n", "<C-Left>", ":vertical resize -2<CR>", opt)
map("n", "<C-Right>", ":vertical resize +2<CR>", opt)
-- 上下比例
map("n", "<C-Down>", ":resize +2<CR>", opt)
map("n", "<C-Up>", ":resize -2<CR>", opt)
-- 等比例
map("n", "s=", "<C-w>=", opt)

-- Terminal相关 有一部分在toggleterm
-- map("n", "<leader>'", ":sp | terminal<CR>", opt)
-- map("n", "<leader>v'", ":vsp | terminal<CR>", opt)
map("n", "<Leader>'", ":ToggleTerm direction=horizontal<CR>", opt)
map("n", "<Leader>v'", ":ToggleTerm direction=vertical<CR>", opt)
map("n", "<Leader>f'", ":ToggleTerm direction=float<CR>", opt)
map("n", "<Leader>s'", ":TermSelect<CR>", opt)
map("t", "<Esc>", [[<C-\><C-N>]], opt)
-- vim.api.nvim_del_keymap('t', '<Esc>')
map("t", "<A-h>", [[<C-\><C-N><C-w>h]], opt)
map("t", "<A-j>", [[<C-\><C-N><C-w>j]], opt)
map("t", "<A-k>", [[<C-\><C-N><C-w>k]], opt)
map("t", "<A-l>", [[<C-\><C-N><C-w>l]], opt)

-- visual模式下缩进代码
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)
-- 上下移动选中文本
map("v", "J", ":move '>+1<CR>gv-gv", opt)
map("v", "K", ":move '<-2<CR>gv-gv", opt)

-- neotree
map("n", "<Leader>fm", ":Neotree action=show toggle<CR>", opt)
map("n", "<Leader>fd", ":Neotree document_symbols<CR>", opt)
map("n", "<Leader>fo", ":Neotree reveal<CR>", opt)

pluginKeys.neoTree = {
	window = {
		mappings = {
			["<space>"] = "",
			["h"] = function(state)
				local node = state.tree:get_node()
				if node.type == "directory" and node:is_expanded() then
					require("neo-tree.sources.filesystem").toggle_directory(state, node)
				else
					require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
				end
			end,
			["l"] = function(state)
				local node = state.tree:get_node()
				if node.type == "directory" then
					if not node:is_expanded() then
						require("neo-tree.sources.filesystem").toggle_directory(state, node)
					elseif node:has_children() then
						require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
					end
				end
			end,
			["I"] = "focus_preview",
			["P"] = { "toggle_preview", config = { use_float = false, use_image_nvim = true } },
			-- ["<"] = "prev_source",
			-- [">"] = "next_source",
			-- ["<CR>"] = function(state)
			--   local node = state.tree:get_node()
			--   if node.type == "directory" then
			--     require("neo-tree.sources.filesystem.commands").set_root(state)
			--   end
			-- end
		},
	},
	filesystem = {
		window = {
			fuzzy_finder_mappings = {
				["<down>"] = "move_cursor_down",
				["<C-j>"] = "move_cursor_down",
				["<up>"] = "move_cursor_up",
				["<C-k>"] = "move_cursor_up",
			},
		},
	},
	git_status = {
		window = {
			position = "float",
			mappings = {
				["A"] = "git_add_all",
				["gu"] = "git_unstage_file",
				["ga"] = "git_add_file",
				["gr"] = "git_revert_file",
				["gc"] = "git_commit",
				["gp"] = "git_push",
				["gg"] = "git_commit_and_push",
				["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
				["oc"] = { "order_by_created", nowait = false },
				["od"] = { "order_by_diagnostics", nowait = false },
				["om"] = { "order_by_modified", nowait = false },
				["on"] = { "order_by_name", nowait = false },
				["os"] = { "order_by_size", nowait = false },
				["ot"] = { "order_by_type", nowait = false },
			},
		},
	},
}

-- bufferline
-- 左右Tab切换
map("n", "<C-h>", ":BufferLineCyclePrev<CR>", opt)
map("n", "<C-l>", ":BufferLineCycleNext<CR>", opt)
-- 关闭
map("n", "<Leader>bl", ":BufferLineCloseRight<CR>", opt)
map("n", "<Leader>bh", ":BufferLineCloseLeft<CR>", opt)
map("n", "<Leader>bo", ":BufferLineCloseOthers<CR>", opt)
map("n", "<Leader>bc", ":BufferLinePickClose<CR>", opt)
map("n", "<Leader>bp", ":BufferLineTogglePin<CR>", opt)
map("n", "<Leader>bk", ":lua require('mini.bufremove').delete(n, false)<CR>", opt)

-- Telescope
-- 查找文件
map("n", "<Leader>ff", ":Telescope find_files<CR>", opt)
map("n", "<Leader>fg", ":Telescope live_grep<CR>", opt)
map("n", "<Leader>fb", ":Telescope buffers<CR>", opt)
map("n", "<Leader>fh", ":Telescope help_tags<CR>", opt)
map("n", "<Leader>fp", ":Telescope projects<CR>", opt)
map(
	"n",
	"<Leader>fs",
	":lua require('telescope.builtin').lsp_document_symbols({ bufnr = OTHER_BUFFER_NUMBER })<CR>",
	opt
)
map("n", "ma", ":lua require('telescope').extensions.vim_bookmarks.all()<CR>", opt)
map("n", "mf", ":lua require('telescope').extensions.vim_bookmarks.current_file()<CR>", opt)

pluginKeys.telescopeList = {
	i = {
		-- 上下移动
		["<C-j>"] = "move_selection_next",
		["<C-k>"] = "move_selection_previous",
		["<Down>"] = "move_selection_next",
		["<Up>"] = "move_selection_previous",
		-- 历史记录
		["<C-n>"] = "cycle_history_next",
		["<C-p>"] = "cycle_history_prev",
		-- 关闭窗口
		["<C-c>"] = "close",
		-- 预览窗口上下滚动
		["<C-u>"] = "preview_scrolling_up",
		["<C-d>"] = "preview_scrolling_down",

		["<C-h>"] = "which_key",
	},
	n = {
		["<j>"] = "move_selection_next",
		["<k>"] = "move_selection_previous",
		["q"] = "close",
		["n"] = "cycle_history_next",
		["p"] = "cycle_history_prev",
		["h"] = "which_key",
	},
}

-- lsp 回调函数快捷键设置
pluginKeys.mapLSP = function(mapbuf)
	-- rename
	mapbuf("n", "<Leader>rn", ":lua vim.lsp.buf.rename()<CR>", opt)
	-- code action
	mapbuf("n", "<Leader>ca", ":lua vim.lsp.buf.code_action()<CR>", opt)
	-- go xx
	mapbuf("n", "gd", ":lua vim.lsp.buf.definition()<CR>", opt)
	mapbuf("n", "gh", ":lua vim.lsp.buf.hover()<CR>", opt)
	mapbuf("n", "gD", ":lua vim.lsp.buf.declaration()<CR>", opt)
	mapbuf("n", "gi", ":lua vim.lsp.buf.implementation()<CR>", opt)
	mapbuf("n", "gr", ":lua vim.lsp.buf.references()<CR>", opt)
	-- diagnostic
	mapbuf("n", "gp", ":lua vim.diagnostic.open_float()<CR>", opt)
	mapbuf("n", "gk", ":lua vim.diagnostic.goto_prev()<CR>", opt)
	mapbuf("n", "gj", ":lua vim.diagnostic.goto_next()<CR>", opt)
	-- mapbuf("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opt)
end

-- cmp 补全快捷键设置
pluginKeys.cmp = function(cmp, snip)
	local check_backspace = function()
		local col = vim.fn.col(".") - 1
		return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
	end
	return {
		["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
		["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
		["<C-i>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		-- Accept currently selected item. If none selected, `select` first item.
		-- Set `select` to `false` to only confirm explicitly selected items.
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif snip and snip.expandable() then
				snip.expand()
			elseif snip and snip.expand_or_jumpable() then
				snip.expand_or_jump()
			elseif check_backspace() then
				fallback()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif snip and snip.jumpable(-1) then
				snip.jump(-1)
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	}
end

-- neogen 自动文档快捷键
map("n", "<Leader>nf", ":lua require('neogen').generate()<CR>", opt)

-- surround 包围文字符号快捷键
pluginKeys.surround = {
	add = "sa", -- Add surrounding in Normal and Visual modes
	delete = "sd", -- Delete surrounding
	find = "", -- Find surrounding (to the right)
	find_left = "", -- Find surrounding (to the left)
	highlight = "", -- Highlight surrounding
	replace = "sr", -- Replace surrounding
	update_n_lines = "", -- Update `n_lines`

	suffix_last = "", -- Suffix to search with "prev" method
	suffix_next = "", -- Suffix to search with "next" method
}

-- dap 调试快捷键
map("n", "<Leader>dc", ":lua require('dap').continue()<CR>", opt)
map("n", "<Leader>do", ":lua require('dap').step_over()<CR>", opt)
map("n", "<Leader>di", ":lua require('dap').step_into()<CR>", opt)
map("n", "<Leader>dt", ":lua require('dap').step_out()<CR>", opt)
map("n", "<Leader>db", ":lua require('dap').toggle_breakpoint()<CR>", opt)
map("n", "<Leader>dl", ":lua require('dap').run_to_cursor()<CR>", opt)
map("n", "<Leader>dL", ":lua require('dap').goto_(vim.api.nvim_win_get_cursor(0)[1])<CR>", opt)
vim.keymap.set("n", "<Leader>dk", function()
	require("dap").close()
	require("dapui").close()
end, opt)
map("n", "<Leader>dr", ":lua require('dap').run_last()<CR>", opt)
map("n", "<Leader>dI", ":lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", opt)
map("n", "<Leader>dK", ":lua require('dap').close()<CR>", opt)
map("n", "<Leader>dv", ":lua require('dapui').eval()<CR>", opt)
map("n", "<Leader>dC", ":lua require('dapui').close()<CR>", opt)
map("n", "<Leader>dP", ":lua require('dapui').open()<CR>", opt)

vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
	require("dap.ui.widgets").hover()
end, opt)
vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
	require("dap.ui.widgets").preview()
end, opt)
vim.keymap.set("n", "<Leader>df", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.frames)
end, opt)
vim.keymap.set("n", "<Leader>ds", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.scopes)
end, opt)

pluginKeys.dapui = {
	window = {
		expand = { "l", "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		edit = "e",
		repl = "r",
		toggle = "t",
	},
	floating = {
		close = { "q", "<Esc>" },
	},
}

-- conform 代码格式化
vim.keymap.set("v", "<Leader>cm", function()
	require("conform").format({ lsp_fallback = true, timeout_ms = 500 })
end, opt)

-- gitsigns
vim.keymap.set("n", "<Leader>hs", require("gitsigns").stage_hunk, opt)
vim.keymap.set("n", "<Leader>hr", require("gitsigns").reset_hunk, opt)
vim.keymap.set("v", "<Leader>hs", function()
	require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
end, opt)
vim.keymap.set("v", "<Leader>hr", function()
	require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
end, opt)
vim.keymap.set("n", "<Leader>hS", require("gitsigns").stage_buffer, opt)
vim.keymap.set("n", "<Leader>hu", require("gitsigns").undo_stage_hunk, opt)
vim.keymap.set("n", "<Leader>hR", require("gitsigns").reset_buffer, opt)
vim.keymap.set("n", "<Leader>hp", require("gitsigns").preview_hunk, opt)
vim.keymap.set("n", "<Leader>hb", function()
	require("gitsigns").blame_line({ full = true })
end, opt)
vim.keymap.set("n", "<Leader>tb", require("gitsigns").toggle_current_line_blame, opt)
vim.keymap.set("n", "<Leader>hd", require("gitsigns").diffthis, opt)
vim.keymap.set("n", "<Leader>hD", function()
	require("gitsigns").diffthis("~")
end, opt)
vim.keymap.set("n", "<Leader>td", require("gitsigns").toggle_deleted, opt)

-- Lauange Specify
-- Cpp
map("n", "<A-o>", ":ClangdSwitchSourceHeader<CR>", opt) -- 头文件和源文件交换

-- Python
map("n", "<Leader>vs", ":VenvSelect<CR>", opt)
map("n", "<Leader>vc", ":VenvSelectCached<CR>", opt)

-- autopairs
pluginKeys.autopairs = {
	fast_wrap = "<A-n>",
}

return pluginKeys
