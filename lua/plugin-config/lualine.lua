-- 如果找不到lualine 组件，就不继续执行
local status, lualine = pcall(require, "lualine")
if not status then
  require("notify")("can't find lualine")
  return
end

local status_navic, navic = pcall(require, "nvim-navic")
if status_navic then
  local icons = {}
  for key, value in pairs(require("lsp-config.ui").icons) do
    icons[key] = value .. " "
  end
  navic.setup({
    lsp = {
      auto_attach = true,
    },
    icons = icons,
  })
else
  require("notify")("can't find navic")
  return
end

local status_overseer, overseer = pcall(require, "overseer")
if not status_overseer then
  require("notify")("can't find navic")
  return
end

-- 不同地方的模块 - [a, b, c, x, y, z]
lualine.setup({
  options = {
    theme = "auto",
    globalstatus = true,
    component_separators = { left = "|", right = "|" },
    section_separators = { left = " ", right = "" },
    disabled_filetypes = { statusline = { "dashboard" } },
  },
  extensions = {
    "neo-tree",
    "toggleterm",
    "lazy",
    "mason",
    "overseer",
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = {
      "filename",
      {
        function()
          return navic.get_location()
        end,
        cond = function()
          return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
        end,
      },
      {
        "lsp_progress",
        spinner_symbols =
        { "🌑 ",
          "🌒 ",
          "🌓 ",
          "🌔 ",
          "🌕 ",
          "🌖 ",
          "🌗 ",
          "🌘 "
        },
      },
    },
    lualine_x = {
      {
        "overseer",
        label = '',     -- Prefix for task counts
        colored = true, -- Color the task icons and counts
        symbols = {
          [overseer.STATUS.FAILURE] = "F:",
          [overseer.STATUS.CANCELED] = "C:",
          [overseer.STATUS.SUCCESS] = "S:",
          [overseer.STATUS.RUNNING] = "R:",
        },
        unique = false,     -- Unique-ify non-running task count by name
        name = nil,         -- List of task names to search for
        name_not = false,   -- When true, invert the name search
        status = nil,       -- List of task statuses to display
        status_not = false, -- When true, invert the status search
      },
      "filesize",
      {
        "fileformat",
        symbols = {
          unix = '',
          dos = '',
          mac = '',
        },
      },
      "encoding",
      "filetype",
    },
  },
})
