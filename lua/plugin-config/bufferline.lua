local status, bufferline = pcall(require, "bufferline")
if not status then
  vim.notify("can't find bufferline", "error", { title = "Plugin" })
  return
end

local status_bufremove, bufremove = pcall(require, "mini.bufremove")
if not status_bufremove then
  require("notify")("can't find bufremove")
end

vim.api.nvim_set_hl(0, "NeoTreeDirectory", { link = "lualine_a_normal" })

-- bufferline 配置
bufferline.setup({
  options = {
    mode = "buffers",
    style_preset = bufferline.style_preset.default,
    -- 关闭 Tab 的命令
    close_command = function(n)
      if bufremove then
        bufremove.delete(n, false)
      end
    end,
    right_mouse_command = function(n)
      if bufremove then
        bufremove.delete(n, false)
      end
    end,
    middle_mouse_command = nil,
    indicator = {
      style = "none",
    },
    enforce_regular_tabs = true,
    -- 侧边栏配置
    offsets = {
      {
        filetype = "neo-tree",
        text = " File Explorer",
        highlight = "NeoTreeDirectory",
        text_align = "left",
        separator = true -- use a "true" to enable the default, or set your own character
      },
    },
    diagnostics = "nvim_lsp",
    ---@diagnostic disable-next-line: unused-local
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local s = " "
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and " " or (e == "warning" and " " or "")
        s = s .. n .. sym
      end
      return s
    end,
    -- groups
    groups = {
      items = {
        require("bufferline.groups").builtin.pinned:with({ icon = "" })
      }
    }
  },
})
