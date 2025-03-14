-- Local variable for filetypes
local filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" }

-- Function to calculate root directory
local function get_root_dir(fname)
	return require("lspconfig.util").root_pattern("tsconfig.json", "jsconfig.json", "package.json", ".git")(fname)
end

-- Get Mason installed TypeScript path
-- local mason_registry = require("mason-registry")
-- local typescript_package = mason_registry.get_package("typescript-language-server")
-- local typescript_path = typescript_package:get_install_path() .. "/node_modules/typescript/lib"

return {
	init_options = {
		vue = {
			hybridMode = true,
			experimentalTemplateCompiler = true,
		},
		-- typescript = {
		-- 	tsdk = typescript_path,
		-- },
	},
	settings = {
		typescript = {
			inlayHints = {
				enumMemberValues = {
					enabled = true,
				},
				functionLikeReturnTypes = {
					enabled = true,
				},
				propertyDeclarationTypes = {
					enabled = true,
				},
				parameterTypes = {
					enabled = true,
					suppressWhenArgumentMatchesName = true,
				},
				variableTypes = {
					enabled = true,
				},
			},
		},
	},
	filetypes = filetypes,
	single_file_support = true,
	root_dir = get_root_dir,
}
