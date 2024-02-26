local opts = {
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	on_attach = function(client, bufnr)
		local function buf_set_keymap(...)
			vim.api.nvim_buf_set_keymap(bufnr, ...)
		end
		-- 绑定快捷键
		require("keybindings").mapLSP(buf_set_keymap)
		local status, illuminate = pcall(require, "illuminate")
		if not status then
			return
		end
		illuminate.on_attach(client)
	end,
  cmd = {
    "cmake-language-server"
  },
  filetypes = { "cmake" },
  init_options = {
    buildDirectory = "build"
  },
  root_dir= require("lspconfig.util").root_pattern('CMakePresets.json', 'CTestConfig.cmake', '.git', 'build', 'cmake'),
  single_file_support = true
}

return opts
