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
      "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
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
    "nvim-telescope/telescope.nvim", tag = "0.1.5",
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
    "williamboman/mason.nvim"
  },
  {
    "williamboman/mason-lspconfig.nvim"
  },
  {
    'stevearc/overseer.nvim',
    opts = {},
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
    "hrsh7th/cmp-vsnip"
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
    opts = {}, -- this is equalent to setup({}) function
  },
}
require("lazy").setup(plugins)
