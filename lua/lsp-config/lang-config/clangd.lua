local caps = require("cmp_nvim_lsp").default_capabilities()

local opts = {
	capabilities = caps,
	on_attach = function(client, bufnr)
		local function buf_set_keymap(...)
			vim.api.nvim_buf_set_keymap(bufnr, ...)
		end

		-- 绑定快捷键
		require("keybindings").mapLSP(buf_set_keymap)
		local status_illuminate, illuminate = pcall(require, "illuminate")
		if status_illuminate then
			illuminate.on_attach(client)
		end
	end,
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
    "--clang-tidy-checks=performance-*, bugprone-*, misc-*, google-*, modernize-*, readability-*, portability-*",
		"--header-insertion=iwyu",
		"--completion-style=detailed",
		"--function-arg-placeholders",
		"--fallback-style=google",
    "--inlay-hints",
    "--all-scopes-completion",
    "--offset-encoding=utf-16",
    "-j=4"
	},
	init_options = {
		usePlaceholders = true,
		completeUnimported = true,
		clangdFileStatus = true,
	},
	root_dir = function(fname)
		return require("lspconfig.util").root_pattern(
			"Makefile",
			"configure.ac",
			"configure.in",
			"config.h.in",
			"meson.build",
			"meson_options.txt",
			"build.ninja"
		)(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(fname) or require(
			"lspconfig.util"
		).find_git_ancestor(fname)
	end,
}

return opts
