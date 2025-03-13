-- Require mason and mason-null-ls
local status_mason, mason = pcall(require, "mason")
local status_mason_null_ls, mason_null_ls = pcall(require, "mason-null-ls")
local status_conform, conform = pcall(require, "conform")

if not status_conform then
	vim.notify("can't find conform", "error", { title = "Plugin" })
	return
end

if status_mason and status_mason_null_ls then
	mason.setup()
	mason_null_ls.setup({
		automatic_installation = true,
		ensure_installed = {
			"stylua",
			"isort",
			"yapf",
			"clang_format",
			"fixjson",
			"yamlfmt",
			"goimports",
			"gofumpt",
			"trim_whitespace",
			"prettier",
		},
	})
end

-- ConformInfo 检查是否安装需要手动安装
conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "yapf" },
		cpp = { "clang_format" },
		json = { "fixjson" },
		yaml = { "yamlfmt" },
		go = { "goimports", "gofumpt" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		html = { "prettier" },
		css = { "prettier" },
		["_"] = { "trim_whitespace" },
	},
	-- format_on_save = {
	-- 	timeout_ms = 1000,
	-- 	lsp_fallback = true,
	-- },
	log_level = vim.log.levels.ERROR,
	notify_on_error = true,
})

conform.formatters.clang_format = {
	prepend_args = { "-style", "{ BasedOnStyle: google, IndentWidth: 4 }" },
}

conform.formatters.yapf = {
	prepend_args = { "--style", "{ based_on_style: google }" },
}

conform.formatters.fixjson = {
	prepend_args = { "--indent", "4" },
}

conform.formatters.yapffix = {}

vim.api.nvim_create_user_command("ConformDiffFormat", function()
	local lines = vim.fn.system("git diff --unified=0"):gmatch("[^\n\r]+")
	local ranges = {}
	for line in lines do
		if line:find("^@@") then
			local line_nums = line:match("%+.- ")
			if line_nums:find(",") then
				local _, _, first, second = line_nums:find("(%d+),(%d+)")
				table.insert(ranges, {
					start = { tonumber(first), 0 },
					["end"] = { tonumber(first) + tonumber(second), 0 },
				})
			else
				local first = tonumber(line_nums:match("%d+"))
				table.insert(ranges, {
					start = { first, 0 },
					["end"] = { first + 1, 0 },
				})
			end
		end
	end
	local format = require("conform").format
	for _, range in pairs(ranges) do
		format({
			range = range,
		})
	end
end, { desc = "Format changed lines" })
