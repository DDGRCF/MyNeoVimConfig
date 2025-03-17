local opts = {
	filetypes = { "python" },
	settings = {
		pyright = {
			disableOrganizeImports = true, -- Using Ruff
		},
		python = {
			analysis = {
				ignore = { "*" }, -- Using Ruff
				autoSearchPaths = true,
				diagnosticMode = "openFilesOnly", -- workspace
				useLibraryCodeForTypes = true,
				typeCheckingMode = "off",
				exclude = {
					"**/data/**",
					"**/datasets/**",
					"**/datasets/**",
				},
			},
		},
	},
	single_file_support = true,
}

return opts
