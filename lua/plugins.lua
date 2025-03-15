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
	-- Theme
	-- {
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- },
    {
		"rebelot/kanagawa.nvim",
		-- name = "catppuccin",
		lazy = false,
		priority = 1000,
    },

	-- UI
	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			{
				"s1n7ax/nvim-window-picker",
				name = "window-picker",
				event = "VeryLazy",
				version = "2.*",
			},
		},
	},
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"akinsho/bufferline.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"echasnovski/mini.bufremove",
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"arkav/lualine-lsp-progress",
		},
	},
	{
		"SmiteshP/nvim-navic",
		lazy = true,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
	},
	{
		"akinsho/toggleterm.nvim",
	},
	{
		"rcarriga/nvim-notify",
		event = "VeryLazy",
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
	{
		"stevearc/dressing.nvim",
	},

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
		},
	},
	{
		"ahmedkhalf/project.nvim",
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
	},
	{
		"windwp/nvim-ts-autotag",
	},

	-- LSP
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
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
	},
	{
		"stevearc/conform.nvim",
	},

	-- Completion
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
		"brenoprata10/nvim-highlight-colors",
	},

	-- DAP
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
		"mfussenegger/nvim-dap-python",
		event = "VeryLazy",
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
	},
	{
		"leoluz/nvim-dap-go",
	},

	-- Utility
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
	},
	{
		"RRethy/vim-illuminate",
	},
	{
		"numToStr/Comment.nvim",
		lazy = false,
	},
	{
		"echasnovski/mini.surround",
	},
	{
		"MattesGroeger/vim-bookmarks",
		dependencies = {
			"tom-anders/telescope-vim-bookmarks.nvim",
		},
	},
	{
		"danymat/neogen",
		event = "VeryLazy",
	},
	{
		"folke/neodev.nvim",
	},
	{
		"lewis6991/gitsigns.nvim",
	},
	{
		"rmagatti/goto-preview",
		event = "VeryLazy",
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
	},
	{
		"LunarVim/bigfile.nvim",
	},
	{
		"smoka7/multicursors.nvim",
		event = "VeryLazy",
		dependencies = {
			"smoka7/hydra.nvim",
		},
		cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown", "codecompanion" },
	},

	-- Other
	{
		"folke/flash.nvim",
		event = "VeryLazy",
	},
	{
		"linux-cultist/venv-selector.nvim",
		branch = "regexp",
		event = "VeryLazy",
	},
	{
		"stevearc/overseer.nvim",
	},
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
            "echasnovski/mini.diff"
		},
	},
}

require("lazy").setup(plugins, {
	ui = {
		border = "rounded",
	},
})
