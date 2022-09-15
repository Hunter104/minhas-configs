call plug#begin(stdpath('data') . '/plugged')

Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'folke/tokyonight.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'tpope/vim-fugitive'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', {'tag':'0.1.0'}
Plug 'preservim/nerdcommenter'

call plug#end()

colorscheme tokyonight
set number

lua << END
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup()
require("lualine").setup()
END
