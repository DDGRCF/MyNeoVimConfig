return {
    -- 指定文件类型
    filetypes = { "python" },
    settings = {
        ruff = {
            -- 启用 ruff
            enable = true,
            -- 忽略的规则列表，这里忽略行长度限制规则 E501
            ignore = { "E501" },
            -- 启用的规则列表，这里启用未使用导入检查规则 F401
            select = { "F401" },
            -- 自动修复问题
            fix = true,
            -- 自动修复时不显示进度
            show_progress = false,
            -- 配置路径（如果需要自定义配置文件路径）
            -- config = "/path/to/your/ruff.toml",
            -- 在保存时自动检查
            run = "onSave"
        }
    },
    -- 项目根目录识别
    root_dir = function(fname)
        -- 从当前文件开始向上查找包含 pyproject.toml 或 setup.py 的目录作为项目根目录
        return require("lspconfig.util").root_pattern("pyproject.toml", "setup.py")(fname)
    end
}
