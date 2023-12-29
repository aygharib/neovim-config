-- Tab gets converted into spaces
-- Sets the default spacing to 4 spaces
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

vim.g.mapleader = " "

-- Looks for lazy in path below
-- Installs lazy if it isn't on the system
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    {
      'nvim-telescope/telescope.nvim', tag = '0.1.5',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {"nvim-treesitter/nvim-treesitter", build= ":TSUpdate"}
}
local opts = {}

-- Call lazy's setup function, loading Lazy for us
require("lazy").setup(plugins, opts)

-- Call catppuccin package setup function and then set it as our vim color scheme
require("catppuccin").setup()
vim.cmd.colorscheme "catppuccin"

local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

local config = require("nvim-treesitter.configs")
config.setup({
    ensure_installed = { "cpp", "c" },
    highlight = { enable = true },
    indent = { enable = true },
})
