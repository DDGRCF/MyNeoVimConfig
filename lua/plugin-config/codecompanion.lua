local status, codecompanion = pcall(require, "codecompanion")
if not status then
	vim.notify("can't find codecompanion", "error", { title = "Plugin" })
	return
end

codecompanion.setup({
	opts = {
	    language = "Chinese",
	},
	strategies = {
		chat = {
			adapter = "deepseek",
		},
		inline = {
			adapter = "doubao",
		},
	},
	adapters = {
		qwen = function()
			return require("codecompanion.adapters").extend("openai_compatible", {
				env = {
					url = "https://dashscope.aliyuncs.com/compatible-mode",
					api_key = "OPENAI_API_KEY",
					chat_url = "/v1/chat/completions",
				},
				schema = {
					model = {
						default = "qwen-max-latest",
					},
					choices = {
						"qwen-plus",
						"qwen-max-latest",
						"qwen2.5-coder-32b-instruct",
						"qwq-plus",
					},
				},
			})
		end,
		doubao = function()
			return require("codecompanion.adapters").extend("openai_compatible", {
				env = {
					url = "https://ark.cn-beijing.volces.com",
					api_key = "ARK_API_KEY",
					chat_url = "/api/v3/chat/completions",
				},
				schema = {
					model = {
						default = "doubao-1-5-lite-32k-250115",
					},
					choices = {
						"doubao-1-5-pro-32k-250115",
						"doubao-1-5-lite-32k-250115",
					},
				},
			})
		end,
		deepseek = function()
			return require("codecompanion.adapters").extend("openai_compatible", {
				env = {
					url = "https://ark.cn-beijing.volces.com",
					api_key = "ARK_API_KEY",
					chat_url = "/api/v3/chat/completions",
				},
				schema = {
					model = {
						default = "deepseek-v3-250324",
					},
					choices = {
            "deepseek-v3-250324"
					},
				},
			})
		end,
	},
})
