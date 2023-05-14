vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
	callback = function()
		vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR> 
      set nobuflisted 
    ]])
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

vim.cmd("autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif")

vim.api.nvim_create_autocmd({ "VimResized" }, {
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

vim.api.nvim_create_autocmd({ "CmdWinEnter" }, {
	callback = function()
		vim.cmd("quit")
	end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "*.java" },
	callback = function()
		vim.lsp.codelens.refresh()
	end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
	callback = function()
		vim.cmd("hi link illuminatedWord LspReferenceText")
	end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	callback = function()
		local line_count = vim.api.nvim_buf_line_count(0)
		if line_count >= 5000 then
			vim.cmd("IlluminatePauseBuf")
		end
	end,
})

-- Create an autocmd User PackerCompileDone to update it every time packer is compiled
vim.api.nvim_create_autocmd("User", {
	pattern = "PackerCompileDone",
	callback = function()
		vim.cmd("CatppuccinCompile")
		vim.defer_fn(function()
			vim.cmd("colorscheme catppuccin")
		end, 0) -- Defered for live reloading
	end,
})

vim.api.nvim_create_autocmd("VimEnter", {
	desc = "Start Alpha when vim is opened with no arguments",
	group = vim.api.nvim_create_augroup("AlphaLazyLoad", { clear = true }),
	callback = function()
		-- optimized start check from https://github.com/goolord/alpha-nvim
		local should_skip = false
		if vim.fn.argc() > 0 or vim.fn.line2byte("$") ~= -1 or not vim.o.modifiable then
			should_skip = true
		else
			for _, arg in pairs(vim.v.argv) do
				if arg == "-b" or arg == "-c" or vim.startswith(arg, "+") or arg == "-S" then
					should_skip = true
					break
				end
			end
		end
		if not should_skip then
			local alpha_avail, alpha = pcall(require, "alpha")
			if alpha_avail then
				alpha.start(false)
			end
		end
		vim.api.nvim_del_augroup_by_name("AlphaLazyLoad")
	end,
})
vim.api.nvim_create_autocmd({ "BufRead" }, {
	group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
	callback = function()
		vim.fn.system("git -C " .. vim.fn.expand("%:p:h") .. " rev-parse")
		if vim.v.shell_error == 0 then
			vim.api.nvim_del_augroup_by_name("GitSignsLazyLoad")
			vim.schedule(function()
				require("packer").loader("gitsigns.nvim")
			end)
		end
	end,
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead", "TabEnter", "TermOpen" }, {
	pattern = "*",
	group = vim.api.nvim_create_augroup("TabuflineLazyLoad", {}),
	callback = function()
		if #vim.fn.getbufinfo({ buflisted = 1 }) >= 2 or #vim.api.nvim_list_tabpages() >= 2 then
			vim.api.nvim_del_augroup_by_name("TabuflineLazyLoad")
			vim.schedule(function()
				require("packer").loader("bufferline.nvim")
			end)
		end
	end,
})
