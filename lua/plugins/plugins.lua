vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use 'tanvirtin/monokai.nvim'
	use {
		'nvim-telescope/telescope.nvim',
		requires = { {'nvim-lua/plenary.nvim'} }
	}
	use 'kyazdani42/nvim-web-devicons'
	use 'lukas-reineke/indent-blankline.nvim'
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}
	use {
		"startup-nvim/startup.nvim",
		requires = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"},
	}
	use 'ful1e5/onedark.nvim'
	use 'neovim/nvim-lspconfig'
	use 'ms-jpq/coq_nvim'
	use 'ms-jpq/coq.artifacts'
	use 'stevearc/overseer.nvim'
	use 'numToStr/Comment.nvim'
	use 'folke/tokyonight.nvim'
	use 'shaunsingh/nord.nvim'
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}
	use "https://git.sr.ht/~whynothugo/lsp_lines.nvim"
	use {
		'akinsho/bufferline.nvim',
		tag = "v2.*",
		requires = 'kyazdani42/nvim-web-devicons'
	}
	use {
		'nvim-tree/nvim-tree.lua',
		requires = {
			'nvim-tree/nvim-web-devicons',
		},
	}	
	use 'norcalli/nvim-colorizer.lua'
	use "windwp/nvim-autopairs"
end)
