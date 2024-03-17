vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- 复用 opt 参数 和 map 函数
local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true, desc = "Unname" }
local pluginKeys = {}

-- canel
vim.api.nvim_set_keymap(
  "n", "s", "",
  vim.tbl_extend("force", opt, { desc = "cancel" })
)

-- windows 分屏快捷键
vim.api.nvim_set_keymap(
  "n", "sv", ":vsp<CR>",
  vim.tbl_extend("force", opt, { desc = "split vertically" })
)
vim.api.nvim_set_keymap(
  "n", "sh", ":sp<CR>",
  vim.tbl_extend("force", opt, { desc = "split horizontally" })
)

-- 关闭其他
vim.api.nvim_set_keymap(
  "n", "so", "<C-w>o",
  vim.tbl_extend("force", opt, { desc = "close other window" })
)

-- 关闭当前
vim.api.nvim_set_keymap(
  "n", "q", "<C-w>c",
  vim.tbl_extend("force", opt, { desc = "close current window" })
)

-- Window jump
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
vim.keymap.set("n", "<Leader>'", function()
  vim.cmd("ToggleTerm direction=horizontal")
end, vim.tbl_extend("force", opt, { desc = "[ToggleTerm] open horizontally" }))
vim.keymap.set("n", "<Leader>v'", function()
  vim.cmd("ToggleTerm direction=vertical")
end, vim.tbl_extend("force", opt, { desc = "[ToggleTerm] open vertically" }))
vim.keymap.set("n", "<Leader>f'", function()
  vim.cmd("ToggleTerm direction=float")
end, vim.tbl_extend("force", opt, { desc = "[ToggleTerm] open float" }))
vim.keymap.set("n", "<Leader>s'", function()
  vim.cmd("TermSelect")
end, vim.tbl_extend("force", opt, { desc = "[ToggleTerm] select open terminal" }))
map("t", "<Esc>", [[<C-\><C-N>]], opt)
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
vim.keymap.set("n", "<Leader>fm",
  function() vim.cmd("Neotree toggle show filesystem") end,
  vim.tbl_extend("force", opt, { desc = "[Neotree] open filesystem" }))
vim.keymap.set("n", "<Leader>fd",
  function() vim.cmd("Neotree toggle show document_symbols") end,
  vim.tbl_extend("force", opt, { desc = "[Neotree] open document_symbols" }))
vim.keymap.set("n", "<Leader>ft",
  function() vim.cmd("Neotree toggle focus git_status") end,
  vim.tbl_extend("force", opt, { desc = "[Neotree] open git_status" }))
vim.keymap.set("n", "<Leader>fo",
  function() vim.cmd("Neotree reveal") end,
  vim.tbl_extend("force", opt, { desc = "[Neotree] focus current file position" }))

pluginKeys.neoTree = {
	window = {
		mappings = {
			["<space>"] = "",
			["I"] = "focus_preview",
			["P"] = { "toggle_preview", config = { use_float = false, use_image_nvim = true } },
			["<"] = "prev_source",
			[">"] = "next_source",
			["z"] = "close_all_nodes",
			["Z"] = "expand_all_nodes",
      ["y"] = "",
      ["Y"] = "",
      ["l"] = "",
      ["h"] = ""
		},
	},
	filesystem = {
    commands = {
			my_close_node = function(state)
				local node = state.tree:get_node()
				if node.type == "directory" and node:is_expanded() then
					require("neo-tree.sources.filesystem").toggle_directory(state, node)
				else
					require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
				end
			end,
			my_open_node = function(state)
				local node = state.tree:get_node()
				if node.type == "directory" then
					if not node:is_expanded() then
						require("neo-tree.sources.filesystem").toggle_directory(state, node)
					elseif node:has_children() then
						require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
					end
				end
			end,
			my_copy_filepath_to_clipboard = function(state)
				local node = state.tree:get_node()
				local filepath = node:get_id()
				local filename = node.name
				local modify = vim.fn.fnamemodify

				local results = {
					filepath,
					modify(filepath, ":."),
					modify(filepath, ":~"),
					filename,
					modify(filename, ":r"),
					modify(filename, ":e"),
				}
        local plugin = "Neo-tree"
				vim.ui.select({
					"[1] Absolute path: " .. results[1],
					"[2] Path relative to CWD: " .. results[2],
					"[3] Path relative to HOME: " .. results[3],
					"[4] Filename: " .. results[4],
					"[5] Filename without extension: " .. results[5],
					"[6] Extension of the filename: " .. results[6],
				}, { prompt = "Choose to copy to clipboard:" }, function(choice)
					if choice then
						local i = tonumber(choice:sub(2, 2))
						if i then
							local result = results[i]
							vim.fn.setreg('"', result)
              vim.notify("Copied: ".. result, "info", { title = plugin })
						else
              vim.notify("Invalid selection", "info", { title = plugin })
						end
					else
            vim.notify("Selection cancelled", "info", { title = plugin })
					end
				end)
			end,
      my_copy_file_to_clipboard = function(state)
        require("neo-tree.sources.common.commands").copy_to_clipboard(state)
      end,
      my_cut_file_to_clipboard = function(state)
        require("neo-tree.sources.common.commands").cut_to_clipboard(state)
      end
    },
		window = {
      mappings = {
        ["y"] = "my_copy_file_to_clipboard",
        ["Y"] = "my_copy_filepath_to_clipboard",
        ["x"] = "my_cut_file_to_clipboard",
        ["h"] = "my_close_node",
        ["l"] = "my_open_node"
      },
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
        ["z"] = "",
        ["Z"] = "",
			},
		},
	},
	document_symbols = {
    commands = {
      my_open_node = function(state)
        local node = state.tree:get_node()
        if not node:is_expanded() then
          require("neo-tree.sources.common.commands").toggle_node(state)
        else
          require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
        end
      end,
      my_close_node = function(state)
        local node = state.tree:get_node()
        if node:is_expanded() then
          require("neo-tree.sources.common.commands").toggle_node(state)
        else
          require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
        end
      end,
    },
		window = {
			mappings = {
        ["l"] = "my_open_node",
        ["h"] = "my_close_node",
        ["z"] = "",
        ["Z"] = "",
			},
		},
	},
}

-- Bufferline
vim.keymap.set("n", "<C-h>",
  function() vim.cmd("BufferLineCyclePrev") end,
  vim.tbl_extend("force", opt, { desc = "[Bufferline] prev tab"}))
vim.keymap.set("n", "<C-l>",
  function() vim.cmd("BufferLineCycleNext") end,
  vim.tbl_extend("force", opt, { desc = "[Bufferline] next tab"}))
vim.keymap.set("n", "<Leader>bl",
  function() vim.cmd("BufferLineCloseRight") end,
  vim.tbl_extend("force", opt, { desc = "[Bufferline] close right tab"}))
vim.keymap.set("n", "<Leader>bh",
  function() vim.cmd("BufferLineCloseLeft") end,
  vim.tbl_extend("force", opt, { desc = "[Bufferline] close left tab"}))
vim.keymap.set("n", "<Leader>bo",
  function() vim.cmd("BufferLineCloseOthers") end,
  vim.tbl_extend("force", opt, { desc = "[Bufferline] close others"}))
vim.keymap.set("n", "<Leader>bc",
  function() vim.cmd("BufferLinePickClose") end,
  vim.tbl_extend("force", opt, { desc = "[Bufferline] close pick"}))
vim.keymap.set("n", "<Leader>bp",
  function() vim.cmd("BufferLineTogglePin") end,
  vim.tbl_extend("force", opt, { desc = "[Bufferline] toggle pin"}))
vim.keymap.set("n", "<Leader>bk",
  function()
    local bd = require("mini.bufremove").delete
    if vim.bo.modified then
      local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
      if choice == 1 then -- Yes
        vim.cmd.write()
        bd(0)
        vim.notify("Delete and save " .. vim.fn.bufname(), "info", { title= "BufferRemove" })
      elseif choice == 2 then -- No
        bd(0, true)
        vim.notify("Delete and drop " .. vim.fn.bufname(), "info", { title = "BufferRemove" })
      else
        vim.notify("Cancel bufermove action", "info",  { title = "BufferRemove" })
      end
    else
      bd(0)
    end
  end,
  vim.tbl_extend("force", opt, { desc = "[BufferLine] Delete buffer"}))
vim.keymap.set("n", "<Leader>bK",
  function()
    require("mini.bufremove").delete(0, true)
    vim.notify("Delete and drop " .. vim.fn.bufname(), "warn", { title = "BufferRemove" })
  end,
  vim.tbl_extend("force", opt, { desc = "[BufferLine] Delete buffer force"}))

-- Telescope
vim.keymap.set("n", "<Leader>ff",
  function() vim.cmd("Telescope find_files") end,
  vim.tbl_extend("force", opt, { desc = "[Telescope] find files"}))
vim.keymap.set("n", "<Leader>fg",
  function() vim.cmd("Telescope live_grep") end,
  vim.tbl_extend("force", opt, { desc = "[Telescope] live grep"}))
vim.keymap.set("n", "<Leader>fc",
  function() vim.cmd("Telescope current_buffer_fuzzy_find") end,
  vim.tbl_extend("force", opt, { desc = "[Telescope] current buffer fuzzy find"}))
vim.keymap.set("n", "<Leader>fb",
  function() vim.cmd("Telescope buffers") end,
  vim.tbl_extend("force", opt, { desc = "[Telescope] buffers"}))
vim.keymap.set("n", "<Leader>fh",
  function() vim.cmd("Telescope help_tags") end,
  vim.tbl_extend("force", opt, { desc = "[Telescope] help tags"}))
vim.keymap.set("n", "<Leader>fp",
  function() vim.cmd("Telescope projects") end,
  vim.tbl_extend("force", opt, { desc = "[Telescope] projects"}))
vim.keymap.set("n", "<Leader>fs",
  function()
    require('telescope.builtin').lsp_document_symbols({ bufnr = 0 })
  end,
  vim.tbl_extend("force", opt, { desc = "[Telescope] lsp document symbols"}))
-- Bookmarks
vim.keymap.set("n", "ma",
  function()
    require("telescope").extensions.vim_bookmarks.all()
  end,
  vim.tbl_extend("force", opt, { desc = "[Telescope] all vim_bookmarks"}))
vim.keymap.set("n", "mf",
  function()
    require("telescope").extensions.vim_bookmarks.all()
  end,
  vim.tbl_extend("force", opt, { desc = "[Telescope] current vim_bookmarks"}))

-- Telescope Key
local telescope_flash = function (prompt_bufnr)
  require("flash").jump({
    pattern = "^",
    label = { after = { 0, 0 } },
    search = {
      mode = "search",
      exclude = {
        function(win)
          return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
        end,
      },
    },
    action = function(match)
      local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
      picker:set_selection(match.pos[1] - 1)
    end,
  })
end

local find_files_no_ignore = function()
  local action_state = require("telescope.actions.state")
  local line = action_state.get_current_line()
  require("telescope.builtin").find_files({ no_ignore = true, default_text = line })
end
local find_files_with_hidden = function()
  local action_state = require("telescope.actions.state")
  local line = action_state.get_current_line()
  require("telescope.builtin").find_files({ hidden = true, default_text = line })
end

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
		["<C-e>"] = "close",
		-- 预览窗口上下滚动
		["<C-u>"] = "preview_scrolling_up",
		["<C-d>"] = "preview_scrolling_down",

		["<C-h>"] = "which_key",
    ["<C-s>"] = telescope_flash,
    ["<A-i>"] = find_files_no_ignore,
    ["<A-h>"] = find_files_with_hidden
	},
	n = {
		["<j>"] = "move_selection_next",
		["<k>"] = "move_selection_previous",
		["q"] = "close",
		["n"] = "cycle_history_next",
		["p"] = "cycle_history_prev",
		["h"] = "which_key",
    ["s"] = telescope_flash
	},
}

-- lsp 回调函数快捷键设置
pluginKeys.mapLSP = function(mapbuf)
	-- rename
	mapbuf("n", "<Leader>rn", ":lua vim.lsp.buf.rename()<CR>", vim.tbl_extend("force", opt, { desc = "[LSP] rename variable" }))
	-- code action
	mapbuf("n", "<Leader>ca", ":lua vim.lsp.buf.code_action()<CR>", vim.tbl_extend("force", opt, { desc = "[LSP] code action" }))
	-- go xx
	mapbuf("n", "gd", ":lua require('telescope.builtin').lsp_definitions(require('telescope.themes').get_dropdown({}))<CR>",
    vim.tbl_extend("force", opt, { desc = "[LSP] goto definitions" }))
  mapbuf("n", "gD", ":lua vim.lsp.buf.declaration()<CR>", vim.tbl_extend("force", opt, { desc = "[LSP] goto declarations" }))
	mapbuf("n", "gh", ":lua vim.lsp.buf.hover()<CR>", vim.tbl_extend("force", opt, { desc = "[LSP] hover" }))
	mapbuf("n", "gi", ":lua require('telescope.builtin').lsp_implementations(require('telescope.themes').get_dropdown({}))<CR>",
    vim.tbl_extend("force", opt, { desc = "[LSP] goto implementations" }))
  mapbuf("n", "gt", ":lua require('telescope.builtin').lsp_type_definitions(require('telescope.themes').get_dropdown({}))<CR>",
    vim.tbl_extend("force", opt, { desc = "[LSP] goto type definitions" }))
	mapbuf("n", "gr", ":lua require('telescope.builtin').lsp_references(require('telescope.themes').get_dropdown({}))<CR>",
    vim.tbl_extend("force", opt, { desc = "[LSP] goto references" }))

  -- goto-preview
  mapbuf("n", "gpd", ":lua require('goto-preview').goto_preview_definition()<CR>",
    vim.tbl_extend("force", opt, { desc = "[LSP] goto-preview definitions" }))
  mapbuf("n", "gpi", ":lua require('goto-preview').goto_preview_implementation()<CR>",
    vim.tbl_extend("force", opt, { desc = "[LSP] goto-preview implementations" }))
  mapbuf("n", "gpD", ":lua require('goto-preview').goto_preview_declaration()<CR>",
    vim.tbl_extend("force", opt, { desc = "[LSP] goto-preview declarations" }))
  mapbuf("n", "gpr", ":lua require('goto-preview').goto_preview_references()<CR>",
    vim.tbl_extend("force", opt, { desc = "[LSP] goto-preview references" }))
  mapbuf("n", "gP", ":lua require('goto-preview').close_all_win()<CR>",
    vim.tbl_extend("force", opt, { desc = "[LSP] goto-preview close all windows" }))

	-- diagnostic
	mapbuf("n", "gnn", ":lua vim.diagnostic.open_float()<CR>",
    vim.tbl_extend("force", opt, { desc = "[LSP] goto-preview open diagnostic float" }))
	mapbuf("n", "gnk", ":lua vim.diagnostic.goto_prev()<CR>",
    vim.tbl_extend("force", opt, { desc = "[LSP] goto-preview goto prev diagnostic " }))
	mapbuf("n", "gnj", ":lua vim.diagnostic.goto_next()<CR>",
    vim.tbl_extend("force", opt, { desc = "[LSP] goto-preview goto next diagnostic " }))

  -- completion
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

-- Neogen
vim.keymap.set("n", "<Leader>nf", function()
  require('neogen').generate()
end, vim.tbl_extend("force", opt, { desc = "[Neogen] generate doc" }))

-- Surround
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

-- Autopairs
pluginKeys.autopairs = {
	fast_wrap = "<A-n>",
}

-- dap 调试快捷键
vim.keymap.set("n", "<Leader>dc", function()
  require("dap").continue()
end, vim.tbl_extend("force", opt, { desc = "[Dap] continue" }))
vim.keymap.set("n", "<Leader>do", function()
  require("dap").step_over()
end, vim.tbl_extend("force", opt, { desc = "[Dap] step over" }))
vim.keymap.set("n", "<Leader>di", function()
  require("dap").step_into()
end, vim.tbl_extend("force", opt, { desc = "[Dap] step into" }))
vim.keymap.set("n", "<Leader>dt", function()
  require("dap").step_out()
end, vim.tbl_extend("force", opt, { desc = "[Dap] step into" }))
vim.keymap.set("n", "<Leader>db", function()
  require("dap").toggle_breakpoint()
end, vim.tbl_extend("force", opt, { desc = "[Dap] toggle breakpoint" }))
vim.keymap.set("n", "<Leader>dl", function()
  require("dap").run_to_cursor()
end, vim.tbl_extend("force", opt, { desc = "[Dap] run to current line" }))
vim.keymap.set("n", "<Leader>dL", function()
  require("dap").goto_(vim.api.nvim_win_get_cursor(0)[1])
end, vim.tbl_extend("force", opt, { desc = "[Dap] goto current line" }))
vim.keymap.set("n", "<Leader>dk", function()
	require("dap").close()
	require("dapui").close()
end, vim.tbl_extend("force", opt, { desc = "[Dap] close dap and dap-ui" }))
vim.keymap.set("n", "<Leader>dr", function()
  require("dap").run_last()
end, vim.tbl_extend("force", opt, { desc = "[Dap] run last choice" }))
vim.keymap.set("n", "<Leader>dI", function()
  vim.ui.input({ prompt = "Enter message for breakpoint: "}, function(input)
    require("dap").set_breakpoint(nil, nil, input)
  end)
end, vim.tbl_extend("force", opt, { desc = "[Dap] set message breakpoint" }))
vim.keymap.set("n", "<Leader>dK", function()
  require("dap").close()
end, vim.tbl_extend("force", opt, { desc = "[Dap] close dap" }))
vim.keymap.set("n", "<Leader>dh", function()
  require("dapui").eval(nil, { enter = true })
end, vim.tbl_extend("force", opt, { desc = "[Dap] eval current variable" }))
vim.keymap.set("n", "<Leader>dC", function()
  require("dapui").close()
end, vim.tbl_extend("force", opt, { desc = "[Dap] close dap-ui" }))
vim.keymap.set("n", "<Leader>dO", function()
  require("dapui").open()
end, vim.tbl_extend("force", opt, { desc = "[Dap] open dap-ui" }))

-- Dap Float Element
vim.keymap.set("n", "<Leader>df", function()
  require("dapui").float_element("stacks",
    { position = "center", width = 80, height = 20, enter = true })
end, vim.tbl_extend("force", opt, { desc = "[Dap] float stacks element" }))

vim.keymap.set("n", "<Leader>ds", function()
  require("dapui").float_element("scopes",
    { position = "center", width = 80, height = 20, enter = true })
end, vim.tbl_extend("force", opt, { desc = "[Dap] float scopes element" }))

vim.keymap.set("n", "<Leader>dw", function()
  require("dapui").float_element("watches",
    { position = "center", width = 80, height = 20, enter = true })
end, vim.tbl_extend("force", opt, { desc = "[Dap] float watches element" }))

vim.keymap.set("n", "<Leader>dB", function()
  require("dapui").float_element("breakpoints",
    { position = "center", width = 80, height = 20, enter = true })
end, vim.tbl_extend("force", opt, { desc = "[Dap] float breakpoints element" }))

-- Python Dap
vim.keymap.set("n", "<Leader>dpm", function()
  require('dap-python').test_method()
end, vim.tbl_extend("force", opt, { desc = "[Dap] python test method" }))
vim.keymap.set("n", "<Leader>dpc", function()
  require('dap-python').test_class()
end, vim.tbl_extend("force", opt, { desc = "[Dap] python test class" }))
vim.api.nvim_set_keymap("v", "<Leader>dps",
  "<ESC>:lua require('dap-python').debug_selection()<CR>",
  vim.tbl_extend("force", opt, { desc = "[Dap] python debug selected code" }))

pluginKeys.dapui = {
	window = {
		expand = { "<CR>", "<2-LeftMouse>" },
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

-- overseer
vim.keymap.set("n", "<Leader>or",
  function() vim.cmd("OverseerRun") end,
  vim.tbl_extend("force", opt, { desc = "[Overseer] Run" }))
vim.keymap.set("n", "<Leader>oo",
  function() vim.cmd("OverseerToggle") end,
  vim.tbl_extend("force", opt, { desc = "[Overseer] Toggle" }))

-- conform 代码格式化
vim.keymap.set("v", "<Leader>cm", function()
	require("conform").format({ lsp_fallback = true, timeout_ms = 500 },
  function(err, did_edit)
    if not err and did_edit then
      vim.notify("Format current selected lines", "info", { title = "Conform" })
    end
  end)
end, vim.tbl_extend("force", opt, { desc = "[Conform] format selected lines" }))
vim.keymap.set("n", "<Leader>cM", function()
	require("conform").format({ lsp_fallback = true, timeout_ms = 500 },
  function(err, did_edit)
    if not err and did_edit then
      vim.notify("Format current buffer", "info", { title = "Conform" })
    end
  end)
end, vim.tbl_extend("force", opt, { desc = "[Conform] format current buffer" }))

-- gitsigns
vim.keymap.set("n", "<Leader>hs", require("gitsigns").stage_hunk,
  vim.tbl_extend("force", opt, { desc = "[GitSigns] hunk stage current line" }))
vim.keymap.set("n", "<Leader>hr", require("gitsigns").reset_hunk,
  vim.tbl_extend("force", opt, { desc = "[GitSigns] reset stage current line" }))
vim.keymap.set("v", "<Leader>hs", function()
	require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
end, vim.tbl_extend("force", opt, { desc = "[GitSigns] hunk stage selected line" }))
vim.keymap.set("v", "<Leader>hr", function()
	require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
end, vim.tbl_extend("force", opt, { desc = "[GitSigns] reset stage selected line" }))
vim.keymap.set("n", "<Leader>hS", function()
    require("gitsigns").stage_buffer()
    vim.notify("Hunk current buffer stage", "info", { title = "GitSigns" })
  end, vim.tbl_extend("force", opt, { desc = "[GitSigns] hunk stage current buffer" }))
vim.keymap.set("n", "<Leader>hu", function()
    require("gitsigns").undo_stage_hunk()
    vim.notify("Undo current buffer stage", "info", { title = "GitSigns" })
  end, vim.tbl_extend("force", opt, { desc = "[GitSigns] undo stage current buffer" }))
vim.keymap.set("n", "<Leader>hR", function()
  require("gitsigns").reset_buffer()
  vim.notify("Reset current buffer stage", "info", { title = "GitSigns" })
  end, vim.tbl_extend("force", opt, { desc = "[GitSigns] reset stage current buffer" }))
vim.keymap.set("n", "<Leader>hp", require("gitsigns").preview_hunk,
  vim.tbl_extend("force", opt, { desc = "[GitSigns] preview stage hunk" }))
vim.keymap.set("n", "<Leader>hb", function()
	require("gitsigns").blame_line({ full = true })
end, vim.tbl_extend("force", opt, { desc = "[GitSigns] stage blame current line" }))
vim.keymap.set("n", "<Leader>tb", require("gitsigns").toggle_current_line_blame,
  vim.tbl_extend("force", opt, { desc = "[GitSigns] toggle current line blame" }))
vim.keymap.set("n", "<Leader>hd", require("gitsigns").diffthis,
  vim.tbl_extend("force", opt, { desc = "[GitSigns] diff this buffer" }))
vim.keymap.set("n", "<Leader>hD", function()
	require("gitsigns").diffthis("~")
end, vim.tbl_extend("force", opt, { desc = "[GitSigns] diff all buffers" }))
vim.keymap.set("n", "<Leader>td", require("gitsigns").toggle_deleted,
  vim.tbl_extend("force", opt, { desc = "[GitSigns] toggle deleted lines" }))

-- Lauange Specify
-- Cpp
vim.keymap.set("n", "<A-o>",
  function() vim.cmd("ClangdSwitchSourceHeader") end,
  vim.tbl_extend("force", opt, { desc = "[Cpp] source and header switch" } ))

-- Python
vim.keymap.set("n", "<Leader>vs",
  function() vim.cmd("VenvSelect") end,
  vim.tbl_extend("force", opt, { desc = "[Python] select env" } ))
vim.keymap.set("n", "<Leader>vc",
  function() vim.cmd("VenvSelectCached") end,
  vim.tbl_extend("force", opt, { desc = "[Python] use cached env" } ))

return pluginKeys
