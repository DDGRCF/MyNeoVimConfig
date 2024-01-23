local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim",              -- Optional image support in preview window: See `# Preview Mode` for more information
    },
  },
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" }
  },
  {
    "akinsho/bufferline.nvim",
    version = "4.4.1",
    dependencies = { "nvim-tree/nvim-web-devicons", "moll/vim-bbye" }
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }
  },
  {
    "arkav/lualine-lsp-progress"
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" }
  },
  {
    "ahmedkhalf/project.nvim"
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  {
    "neovim/nvim-lspconfig"
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "codelldb" })
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim"
  },
  {
    'stevearc/overseer.nvim',
  },
  {
    "hrsh7th/cmp-nvim-lsp"
  },
  {
    "hrsh7th/cmp-buffer"
  },
  {
    "hrsh7th/cmp-path"
  },
  {
    "hrsh7th/cmp-cmdline"
  },
  {
    "hrsh7th/nvim-cmp"
  },
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
  },
  {
    "hrsh7th/vim-vsnip"
  },
  {
    "rafamadriz/friendly-snippets"
  },
  {
    "onsails/lspkind-nvim"
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = true
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
  },
  {
    "RRethy/vim-illuminate",
  },
  {
    "rcarriga/nvim-notify",
  },
  {
    "numToStr/Comment.nvim",
    lazy = false,
  },
  {
    "mfussenegger/nvim-dap"
  },
  {
    "theHamsta/nvim-dap-virtual-text",
  },
  {
    "rcarriga/nvim-dap-ui",
  },
  {
    "stevearc/conform.nvim",
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    -- keys = {
    --   { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
    --   { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
    --   { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
    --   { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    --   { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    -- },
  }
}
require("lazy").setup(plugins, {
  ui = {
    border = "rounded",
  },
})
