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
	use({ "nvim-lua/plenary.nvim" }) -- Useful lua functions used by lots of plugins
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
		event = "BufReadPost",
		config = function()
			require("user.comment")
		end,
	})
	use({ "JoosepAlviste/nvim-ts-context-commentstring", opt = true, after = "nvim-treesitter" })
	use({ "kyazdani42/nvim-web-devicons" })
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
		event = "BufReadPost",
		after = "catppuccin",
		config = function()
			require("user.bufferline")
		end,
	})
	use({ "moll/vim-bbye" })
	use({
		"nvim-lualine/lualine.nvim",
		opt = true,
		event = "BufReadPost",
		config = function()
			require("user.lualine")
		end,
	})
	use({
		"akinsho/toggleterm.nvim",
		event = "BufReadPost",
		config = function()
			require("user.toggleterm")
		end,
	})
	use({
		"ahmedkhalf/project.nvim",
		config = function()
			require("user.project")
		end,
		opt = true,
		event = "BufWinEnter",
		after = "telescope.nvim",
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
	use({ "goolord/alpha-nvim" })

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
		event = "BufReadPost",
		after = { "LuaSnip" },
		config = function()
			require("user.cmp")
		end,
	}) -- The completion plugin
	use({ "hrsh7th/cmp-buffer", after = "nvim-cmp", opt = true }) -- buffer completions
	use({ "hrsh7th/cmp-path", after = "nvim-cmp", opt = true }) -- path completions
	use({ "saadparwaiz1/cmp_luasnip", after = { "nvim-cmp", "LuaSnip" } }) -- snippet completions
	use({ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp", opt = true })
	use({ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp", opt = true })

	-- snippets
	use({ "L3MON4D3/LuaSnip", opt = true, event = "BufReadPost" }) --snippet engine
	use({ "rafamadriz/friendly-snippets", event = "InsertEnter" }) -- a bunch of snippets to use

	-- LSP
	-- use { "williamboman/nvim-lsp-installer", commit = "e9f13d7acaa60aff91c58b923002228668c8c9e6" } -- simple to use language server installer
	use({
		"neovim/nvim-lspconfig",
		opt = true,
		event = "BufReadPre",
		after = "mason.nvim",
		config = function()
			require("user.lsp")
		end,
	})
	use({ "williamboman/mason.nvim" })
	use({ "williamboman/mason-lspconfig.nvim" })
	use({ "jose-elias-alvarez/null-ls.nvim", opt = true, event = "BufReadPre" }) -- for formatters and linters
	use({
		"RRethy/vim-illuminate",
		opt = true,
		event = "BufReadPost",
		config = function()
			require("user.illuminate")
		end,
	})

	-- python venvs
	-- use venom fork because veom maintainer doesn't merge lua support

	vim.g.venom_loaded = 1
	use({
		"hirotasoshu/vim-venom",
		ft = { "python" },
		config = 'require("venom").setup()',
	})
	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		config = function()
			require("user.telescope")
		end,
	})

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("user.treesitter")
		end,
	})
	-- Git
	use({
		"lewis6991/gitsigns.nvim",
		opt = true,
		event = "BufWinEnter",
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

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
