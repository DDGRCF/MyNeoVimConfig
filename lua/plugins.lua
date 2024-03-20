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
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
	},
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", "arkav/lualine-lsp-progress" },
	},
	{
		"SmiteshP/nvim-navic",
		lazy = true,
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},
	{
		"ahmedkhalf/project.nvim",
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	{
		"neovim/nvim-lspconfig",
	},
	{
		"williamboman/mason.nvim",
	},
	{
		"williamboman/mason-lspconfig.nvim",
	},
	{
		"stevearc/overseer.nvim",
	},
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"hrsh7th/cmp-buffer",
	},
	{
		"hrsh7th/cmp-path",
	},
	{
		"hrsh7th/cmp-cmdline",
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
		},
	},
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		dependencies = { "rafamadriz/friendly-snippets" },
	},
	{
		"hrsh7th/vim-vsnip",
	},
	{
		"onsails/lspkind-nvim",
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
	},
	{
		"RRethy/vim-illuminate",
	},
	{
		"rcarriga/nvim-notify",
    event = "VeryLazy"
	},
	{
		"numToStr/Comment.nvim",
		lazy = false,
	},
	{
		"mfussenegger/nvim-dap",
	},
	{
		"rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" },
	},
	{
		"theHamsta/nvim-dap-virtual-text",
	},
	{
		"stevearc/conform.nvim",
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
	},
	{
		"stevearc/dressing.nvim",
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
	},
	{
		"echasnovski/mini.bufremove",
		version = "*",
	},
	{
		"echasnovski/mini.surround",
		version = "*",
	},
	{
		"MattesGroeger/vim-bookmarks",
		dependencies = {
			"tom-anders/telescope-vim-bookmarks.nvim",
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
	},
	{
		"danymat/neogen",
		event = "VeryLazy",
	},
	{
		"lewis6991/gitsigns.nvim",
	},
	{
		"folke/neodev.nvim",
	},
	{
		"mfussenegger/nvim-dap-python",
		event = "VeryLazy",
	},
	{
		"linux-cultist/venv-selector.nvim",
		event = "VeryLazy",
	},
  {
    "rmagatti/goto-preview",
    event = "VeryLazy",
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
  },
  {
    'Sam-programs/cmdline-hl.nvim',
    event = 'VimEnter',
  }
}

require("lazy").setup(plugins, {
  ui = {
    border = "rounded",
  },
})
