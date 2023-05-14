local status_ok, catppuccin = pcall(require, "catppuccin")
if not status_ok then
	return
end

catppuccin.setup({
	flavour = "macchiato", -- latte, frappe, macchiato, mocha
	integrations = {
		aerial = false,
		barbar = false,
		beacon = false,
		cmp = true,
		coc_nvim = false,
		dashboard = false,
		fern = false,
		fidget = false,
		gitgutter = false,
		gitsigns = true,
		harpoon = false,
		hop = false,
		illuminate = true,
		leap = false,
		lightspeed = false,
		lsp_saga = false,
		lsp_trouble = false,
		markdown = true,
		mason = true,
		mini = false,
		neogit = false,
		neotest = false,
		neotree = false,
		noice = false,
		notify = false,
		nvimtree = true,
		overseer = false,
		pounce = false,
		semantic_tokens = false,
		symbols_outline = false,
		telekasten = true,
		telescope = true,
		treesitter = true,
		treesitter_context = true,
		ts_rainbow = false,
		vim_sneak = false,
		vimwiki = false,
		which_key = false,

		-- Special integrations, see https://github.com/catppuccin/nvim#special-integrations
		dap = {
			enabled = true,
			enable_ui = true,
		},
		indent_blankline = {
			enabled = true,
			colored_indent_levels = true,
		},
		native_lsp = {
			enabled = true,
			virtual_text = {
				errors = { "italic" },
				hints = { "italic" },
				warnings = { "italic" },
				information = { "italic" },
			},
			underlines = {
				errors = { "underline" },
				hints = { "underline" },
				warnings = { "underline" },
				information = { "underline" },
			},
		},
		navic = {
			enabled = false,
			custom_bg = "NONE",
		},
	},
})

vim.cmd([[
try
  colorscheme catppuccin
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]])
