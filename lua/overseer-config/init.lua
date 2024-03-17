local status_overseer, overseer = pcall(require, "overseer")
if not status_overseer then
	vim.notify("can't find overseer", "error", { title = "Plugin" })
	return
end

overseer.setup({
	strategy = {
    "toggleterm",
    -- load your default shell before starting the task
    use_shell = false,
    -- overwrite the default toggleterm "direction" parameter
    direction = "horizontal",
    -- overwrite the default toggleterm "highlights" parameter
    highlights = nil,
    -- overwrite the default toggleterm "auto_scroll" parameter
    auto_scroll = false,
    -- have the toggleterm window close and delete the terminal buffer
    -- automatically after the task exits
    close_on_exit = false,
    -- have the toggleterm window close without deleting the terminal buffer
    -- automatically after the task exits
    -- can be "never, "success", or "always". "success" will close the window
    -- only if the exit code is 0.
    quit_on_exit = "never",
    -- open the toggleterm window when a task starts
    open_on_start = true,
    -- mirrors the toggleterm "hidden" parameter, and keeps the task from
    -- being rendered in the toggleable window
    hidden = false,
    -- command to run when the terminal is created. Combine with `use_shell`
    -- to run a terminal command before starting the task
    on_create = function()
      vim.cmd("stopinsert")
    end,
	},
})

overseer.register_template(require("overseer-config.template.user.run_script"))
overseer.register_template(require("overseer-config.template.user.cpp_build"))
