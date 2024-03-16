-- 如果找不到lualine 组件，就不继续执行
local status, lualine = pcall(require, "lualine")
if not status then
  vim.notify("can't find lualine", "error", { title = "Plugin" })
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
      preference = nil,
    },
    icons = icons,
    separator = "  ",
    highlight = true,
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

local colors = {
  yellow = '#ECBE7B',
  cyan = '#008080',
  darkblue = '#081633',
  green = '#98be65',
  orange = '#FF8800',
  violet = '#a9a1e1',
  magenta = '#c678dd',
  blue = '#51afef',
  red = '#ed8796'
}

-- 不同地方的模块 - [a, b, c, x, y, z]
lualine.setup({
  options = {
    theme = "auto",
    globalstatus = true,
    component_separators = { left = "\\", right = "/" },
    -- section_separators = { left = " ", right = "" },
    -- section_separators = { left = "", right = "" },
    section_separators = { left = '', right = '' },
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
      { "filename", icon = { "", color = { fg = "#8aadf4" } } },
      {
        "navic",
        color_correction = "static",
      },
      {
        "lsp_progress",
        spinner_symbols =
        { "🌑",
          "🌒",
          "🌓",
          "🌔",
          "🌕",
          "🌖",
          "🌗",
          "🌘"
        },
        colors = {
          percentage      = colors.cyan,
          title           = colors.cyan,
          message         = colors.cyan,
          spinner         = colors.cyan,
          lsp_client_name = colors.magenta,
          use             = true,
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
      "encoding",
      "filetype",
    },
  },
})
