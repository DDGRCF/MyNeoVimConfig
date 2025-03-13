local common_inlay_hints = {
    padding = true,
    parameterHints = {
        enabled = true
    },
    variableTypes = {
        enabled = true
    },
    parameterNames = {
        enabled = true,
        suppressParameterNames = {}
    }
}

return {
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
        "-j=8"
    },
    offsetEncoding = { "utf-8", "utf-16" },
    init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true,
        inlayHints = common_inlay_hints
    },
    root_dir = function(fname)
        local root_patterns = {
            "Makefile",
            "configure.ac",
            "configure.in",
            "config.h.in",
            "meson.build",
            "meson_options.txt",
            "build.ninja"
        }
        local root = require("lspconfig.util").root_pattern(unpack(root_patterns))(fname)
        if root then
            return root
        end
        root = require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(fname)
        if root then
            return root
        end
        return require("lspconfig.util").find_git_ancestor(fname)
    end,
    handlers = common_handlers
}
