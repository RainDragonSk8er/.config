
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- set linenumbers
vim.o.number = true
vim.o.relativenumber = true

-- enable mouse?
vim.o.mouse = "a"
vim.o.so = 10

-- sync clipboard with OS
vim.schedule(function()
	vim.o.clipboard = 'unnamedplus'
end)

-- Plugin Manager: [Lazy]

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
	vim.fn.getchar()
	os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim

require("lazy").setup("plugins")
