return {
  -- 指定处理 SCSS 文件
  filetypes = { "css", "scss" },
  settings = {
    css = {
      validate = true,
      lint = {
        unknownAtRules = "ignore"
      }
    },
    scss = {
      validate = true
    }
  }
}
