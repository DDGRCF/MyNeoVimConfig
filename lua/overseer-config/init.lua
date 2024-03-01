local status, overseer = pcall(require, "overseer")
if not status then
	vim.notify("can't find overseer")
	return
end

overseer.setup({
	strategy = {
		"toggleterm",
	},
})

overseer.register_template(require("overseer-config.template.user.run_script"))
overseer.register_template(require("overseer-config.template.user.cpp_build"))
