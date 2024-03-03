local status_conform, conform = pcall(require, "conform")
if not status_conform then
	require("notify")("can't find conform")
	return
end

-- ConformInfo 检查是否安装需要手动安装
conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "yapf" },
		go = { "goimports", "gofmt" },
		cpp = { "clang_format" },
		json = { "fixjson" },
		["*"] = { "codespell" },
		["_"] = { "trim_whitespace" },
	},
	-- format_on_save = {
	-- 	-- These options will be passed to conform.format()
	-- 	timeout_ms = 500,
	-- 	lsp_fallback = true,
	-- },
	log_level = vim.log.levels.ERROR,
	notify_on_error = true,
})

conform.formatters.clang_format = {
  prepend_args = { "-style", "google" }
}

conform.formatters.yapf = {
  prepend_args = { "--style", "{ based_on_style: google }" }
}

-- vim.api.nvim_create_user_command('DiffFormat', function()
--   local lines = vim.fn.system('git diff --unified=0'):gmatch('[^\n\r]+')
--   local ranges = {}
--   for line in lines do
--     if line:find('^@@') then
--       local line_nums = line:match('%+.- ')
--       if line_nums:find(',') then
--         local _, _, first, second = line_nums:find('(%d+),(%d+)')
--         table.insert(ranges, {
--           start = { tonumber(first), 0 },
--           ['end'] = { tonumber(first) + tonumber(second), 0 },
--         })
--       else
--         local first = tonumber(line_nums:match('%d+'))
--         table.insert(ranges, {
--           start = { first, 0 },
--           ['end'] = { first + 1, 0 },
--         })
--       end
--     end
--   end
--   local format = require('conform').format
--   for _, range in pairs(ranges) do
--     format {
--       range = range,
--     }
--   end
-- end, { desc = 'Format changed lines' })
