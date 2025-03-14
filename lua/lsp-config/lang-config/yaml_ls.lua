return {
	filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
	init_options = {
		provideFormatter = false,
	},
	{
		redhat = {
			telemetry = {
				enabled = false,
			},
		},
	},
	root_dir = require("lspconfig.util").find_git_ancestor,
	single_file_support = true
}
