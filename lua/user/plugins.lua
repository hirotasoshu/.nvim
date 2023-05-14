local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
	git = {
		clone_timeout = 300, -- Timeout, in seconds, for git clones
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here
	use({ "wbthomason/packer.nvim" }) -- Have packer manage itself
	use({ "nvim-lua/plenary.nvim", opt = true, module = "plenary" }) -- Useful lua functions used by lots of plugins
	use({
		"windwp/nvim-autopairs",
		opt = true,
		after = "nvim-cmp",
		config = function()
			require("user.autopairs")
		end,
	}) -- Autopairs, integrates with both cmp and treesitter
	use({
		"numToStr/Comment.nvim",
		opt = true,
		module = "Comment",
		keys = { "gc", "gb" },
		config = function()
			require("user.comment")
		end,
	})
	use({ "kyazdani42/nvim-web-devicons", opt = true, module = "nvim-web-devicons" })
	use({
		"kyazdani42/nvim-tree.lua",
		cmd = {
			"NvimTreeClipboard",
			"NvimTreeClose",
			"NvimTreeFindFile",
			"NvimTreeOpen",
			"NvimTreeRefresh",
			"NvimTreeToggle",
		},
		config = function()
			require("user.nvim-tree")
		end,
	})
	use({
		"akinsho/bufferline.nvim",
		opt = true,
		config = function()
			require("user.bufferline")
		end,
	})
	use({ "moll/vim-bbye", opt = true, cmd = { "Bdelete", "Bwipeout" } })

	use({
		"nvim-lualine/lualine.nvim",
		config = function()
			require("user.lualine")
		end,
		opt = true,
		event = "BufRead",
	})
	use({
		"akinsho/toggleterm.nvim",
		event = "BufReadPost",
		config = function()
			require("user.toggleterm")
		end,
	})
	use({ "lewis6991/impatient.nvim" })
	use({
		"lukas-reineke/indent-blankline.nvim",
		opt = true,
		event = "BufReadPost",
		config = function()
			require("user.indentline")
		end,
	})
	use({
		"goolord/alpha-nvim",
		config = function()
			require("user.alpha")
		end,
		opt = true,
		cmd = "Alpha",
		module = "alpha",
	})

	use({
		"echasnovski/mini.surround",
		config = function()
			require("mini.surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
		module = "mini.surround",
		keys = { "sa", "sd", "sf", "sF", "sh", "sr", "sn" },
	})
	-- Colorschemes
	use({
		"catppuccin/nvim",
		as = "catppuccin",
		run = ":CatppuccinCompile",
		config = function()
			require("user.colorscheme")
		end,
	})

	-- cmp plugins
	use({
		"hrsh7th/nvim-cmp",
		after = { "friendly-snippets" },
		config = function()
			require("user.cmp")
		end,
	}) -- The completion plugin
	use({ "hrsh7th/cmp-buffer", after = "cmp-nvim-lsp", opt = true }) -- buffer completions
	use({ "hrsh7th/cmp-path", after = "cmp-buffer", opt = true }) -- path completions
	use({ "saadparwaiz1/cmp_luasnip", after = { "LuaSnip" } }) -- snippet completions
	use({ "hrsh7th/cmp-nvim-lsp", after = "cmp-nvim-lua", opt = true })
	use({ "hrsh7th/cmp-nvim-lua", after = "cmp_luasnip", opt = true })

	-- snippets
	use({ "L3MON4D3/LuaSnip", opt = true, after = "nvim-cmp", wants = "friendly-snippets" }) --snippet engine
	use({ "rafamadriz/friendly-snippets", event = "InsertEnter" }) -- a bunch of snippets to useplugins

	-- LSP
	-- use { "williamboman/nvim-lsp-installer", commit = "e9f13d7acaa60aff91c58b923002228668c8c9e6" } -- simple to use language server installer
	use({
		"neovim/nvim-lspconfig",
		opt = true,
		event = "BufReadPre",
		config = function()
			require("user.lsp")
		end,
	})
	use({
		"williamboman/mason.nvim",
		opt = true,
		module = "mason",
		cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
	})
	use({ "williamboman/mason-lspconfig.nvim", opt = true, module = "mason-lspconfig" })
	use({ "jose-elias-alvarez/null-ls.nvim", opt = true, event = "BufReadPre" }) -- for formatters and linters
	use({
		"RRethy/vim-illuminate",
		opt = true,
		event = "BufReadPost",
		config = function()
			require("user.illuminate")
		end,
	})
	use({
		"dnlhc/glance.nvim",
		opt = true,
		cmd = "Glance",
		config = function()
			require("user.glance")
		end,
	})
	-- python venvs
	-- use venom fork because veom maintainer doesn't merge lua support

	-- vim.g.venom_loaded = 1
	-- use({
	-- 	"/home/hirotasoshu/code/vim-venom",
	-- 	ft = { "python" },
	-- 	config = 'require("venom").setup({})',
	-- })
	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		config = function()
			require("user.telescope")
		end,
		requires = {
			{
				"ahmedkhalf/project.nvim",
				opt = true,
				module = "project_nvim",
			},
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				run = "make",
				opt = true,
				module = "telescope._extensions.fzf",
			},
		},
		opt = true,
		cmd = "Telescope",
		module = "telescope",
	})

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("user.treesitter")
		end,
		opt = true,
		event = "BufRead",
	})
	use({ "JoosepAlviste/nvim-ts-context-commentstring", opt = true, after = "nvim-treesitter" })
	-- Git
	use({
		"lewis6991/gitsigns.nvim",
		opt = true,
		ft = "gitcommit",
		config = function()
			require("user.gitsigns")
		end,
	})

	-- DAP
	use({
		"mfussenegger/nvim-dap",
		opt = true,
		cmd = {
			"DapSetLogLevel",
			"DapShowLog",
			"DapContinue",
			"DapToggleBreakpoint",
			"DapToggleRepl",
			"DapStepOver",
			"DapStepInto",
			"DapStepOut",
			"DapTerminate",
		},
		config = function()
			require("user.dap")
		end,
	})
	use({ "rcarriga/nvim-dap-ui", opt = true, after = "nvim-dap" })
	use({
		"ravenxrz/DAPInstall.nvim",
		opt = true,
		cmd = {
			"DIInstall",
			"DIUinstall",
			"DIList",
		},
	})
	-- telekasten
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
		opt = true,
		cmd = {
			"MarkdownPreview",
			"MarkdownPreviewStop",
			"MarkdownPreviewToggle",
		},
	})

	use({
		"renerocksai/telekasten.nvim",
		opt = true,
		cmd = {
			"Telekasten",
		},
		module = "telekasten",
		config = function()
			require("user.telekasten")
		end,
		requires = {
			{
				"renerocksai/calendar-vim",
				opt = true,
				cmd = {
					"Calendar",
					"CalendarT",
					"CalendarH",
				},
			},
		},
	})
	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
