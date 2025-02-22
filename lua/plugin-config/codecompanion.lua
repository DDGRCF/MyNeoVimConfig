local status, codecompanion = pcall(require, "codecompanion")
if not status then
    vim.notify("can't find codecompanion", "error", { title = "Plugin" })
    return
end

codecompanion.setup({
    strategies = {
        chat = {
            adapter = "gemini",
        },
        inline = {
            adapter = "qwen",
        },
    },
    adapters = {
        qwen = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
                env = {
                    url = "https://dashscope.aliyuncs.com/compatible-mode",
                    api_key = "OPENAI_API_KEY",
                    chat_url = "/v1/chat/completions"
                },
                schema = {
                    model = {
                        default = "qwen2.5-coder-32b-instruct"
                    },
                    choices = {
                        "qwen-plus",
                        "qwen-max-latest",
                        "qwen2.5-coder-32b-instruct"
                    }
                }
            })
        end,
        deepseek = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
                env = {
                    url = "https://ark.cn-beijing.volces.com",
                    api_key = "ARK_API_KEY",
                    chat_url = "/api/v3/chat/completions"
                },
                schema = {
                    model = {
                        default = "ep-20250217221008-rhj6l"
                    },
                    choices = {
                        "ep-20250217221008-rhj6l",
                    }
                }
            })
        end,
        doubao = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
                env = {
                    url = "https://ark.cn-beijing.volces.com",
                    api_key = "ARK_API_KEY",
                    chat_url = "/api/v3/chat/completions"
                },
                schema = {
                    model = {
                        default = "ep-20250217222529-mkfpk"
                    },
                    choices = {
                        "ep-20250217222529-mkfpk",
                    }
                }
            })
        end
    }
})
