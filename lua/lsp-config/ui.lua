-- lsp handlers
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "rounded",
})

local signs = { Error = " ", Warn = " ", Hint = "💡", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
	-- Enable virtual text
	virtual_text = true,
	-- show signs
	signs = {
		active = signs,
	},
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = true,
		header = "",
		prefix = "",
	},
})

local icons = {
	File = "󰈙",
	Module = "",
	Namespace = "󰌗",
	Package = "",
	Value = "󰎠",
	Class = "󰌗",
	Method = "󰆧",
	Snippet = "",
	Property = "",
	Field = "",
	Unit = "󰚯",
	Constructor = "",
	Reference = "",
	Color = "󰏘",
	Enum = "󰕘",
	Interface = "󰕘",
	Function = "󰊕",
	Variable = "󰆧",
	Constant = "󰏿",
	String = "󰀬",
	Number = "󰎠",
	Boolean = "",
	Array = "󰅪",
	Object = "󰅩",
	Key = "󰌋",
	Null = "󰟢",
	EnumMember = "",
	Struct = "󰌗",
	Event = "",
	Operator = "󰆕",
	TypeParameter = "󰊄",
  Supermaven = "",
}

-- lspkind
local status, lspkind = pcall(require, "lspkind")
if not status then
	require("notify")("can't find lspkind")
end
lspkind.init({
	-- default: true
	-- with_text = true,
	-- defines how annotations are shown
	-- default: symbol
	-- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
	mode = "symbol_text",
	-- default symbol map
	-- can be either 'default' (requires nerd-fonts font) or
	-- 'codicons' for codicon preset (requires vscode-codicons font)
	--
	-- default: 'default'
	preset = "codicons",
	-- override preset symbols
	--

	symbol_map = icons,
})

local M = {}
-- 为 cmp.lua 提供参数格式
M.formatting = {
	-- fields = { "kind", "abbr", "menu" }, 补全出现的顺序
	format = function(entry, item)
		local color_item = require("nvim-highlight-colors").format(entry, { kind = item.kind })
		item = lspkind.cmp_format({
			mode = "symbol_text",
			--mode = 'symbol', -- show only symbol annotations

			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			-- The function below will be called before any actual modifications from lspkind
			-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
			ellipsis_char = "...",
			before = function(local_entry, local_item)
				-- Source 显示提示来源
				local_item.menu = ({
					nvim_lsp = "[Lsp]",
					luasnip = "[Snip]",
					buffer = "[Buf]",
					path = "[Path]",
          supermaven = "[SuperMaven]"
				})[entry.source.name]
				return local_item
			end,
		})(entry, item)
		if color_item.abbr_hl_group then
			item.kind_hl_group = color_item.abbr_hl_group
			item.kind = color_item.abbr
		end
		return item
	end,
}

M.icons = icons

return M
