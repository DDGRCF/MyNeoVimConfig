-- Local variable for filetypes
local filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" }

-- Function to calculate root directory
local function get_root_dir(fname)
	return require("lspconfig.util").root_pattern("tsconfig.json", "jsconfig.json", "package.json", ".git")(fname)
end

return {
	init_options = {
		vue = {
			hybridMode = true,
			experimentalTemplateCompiler = true,
		},
	},
	filetypes = filetypes,
	cmd = { "vue-language-server", "--stdio" },
	single_file_support = true,
	root_dir = get_root_dir,
}
