-- Define local variables for repeated values
local filetypes = { "javascript", "typescript", "vue" }
local vue_typescript_plugin = require("mason-registry").get_package("vue-language-server"):get_install_path()
	.. "/node_modules/@vue/language-server"
	.. "/node_modules/@vue/typescript-plugin"

-- Function to get the root directory
local function get_root_dir(fname)
	return require("lspconfig.util").root_pattern("tsconfig.json", "jsconfig.json", "package.json", ".git")(fname)
end

return {
	init_options = {
		plugins = {
			{
				name = "@vue/typescript-plugin",
				location = vue_typescript_plugin,
				languages = filetypes,
			},
		},
	},
	filetypes = filetypes,
	single_file_support = true,
	root_dir = get_root_dir,
}
