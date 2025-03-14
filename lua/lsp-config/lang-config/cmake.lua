local opts = {
	cmd = {
		"cmake-language-server",
	},
	filetypes = { "cmake" },
	init_options = {
		buildDirectory = "build",
	},
	root_dir = require("lspconfig.util").root_pattern(
		"CMakePresets.json",
		"CTestConfig.cmake",
		".git",
		"build",
		"cmake"
	),
	single_file_support = true
}

return opts
