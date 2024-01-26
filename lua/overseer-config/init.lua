local status, overseer = pcall(require, "overseer")
if not status then
  vim.notify("没有找到 overseer")
  return
end

overseer.setup({
  strategy = "toggleterm"
})

overseer.register_template(
  require("overseer-config.template.user.run_script"),
  require("overseer-config.template.user.cpp_build")
)
