-- auto install packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync 
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
  return
end
 

-- add list of plugins to install
return packer.startup(function(use)
  use("wbthomason/packer.nvim")

  use("nvim-lua/plenary.nvim")

  use("morhetz/gruvbox")
  -- use("joshdick/onedark.vim")

  -- use("bluz71/vim-nightfly-guicolors")

  use("szw/vim-maximizer")

  use("nvim-tree/nvim-tree.lua")

  use("kyazdani42/nvim-web-devicons")

  use("nvim-lualine/lualine.nvim")

  use("junegunn/fzf")
  use("junegunn/fzf.vim")

    -- fuzzy finding w/ telescope
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
  use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- fuzzy finder
  use { "nvim-telescope/telescope-file-browser.nvim" }

    -- autocompletion
  use("hrsh7th/nvim-cmp") -- completion plugin
  use("hrsh7th/cmp-buffer") -- source for text in buffer
  use("hrsh7th/cmp-path") -- source for file system paths

    -- snippets
  use("L3MON4D3/LuaSnip") -- snippet engine
  use("saadparwaiz1/cmp_luasnip") -- for autocompletion
  use("rafamadriz/friendly-snippets") -- useful snippets

    -- managing & installing lsp servers, linters & formatters
  use("williamboman/mason.nvim") -- in charge of managing lsp servers, linters & formatters
  use("williamboman/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig

    -- configuring lsp servers
  use("neovim/nvim-lspconfig") -- easily configure language servers
  use("hrsh7th/cmp-nvim-lsp") -- for autocompletion
  use({ "glepnir/lspsaga.nvim", branch = "main" }) -- enhanced lsp uis
  use("jose-elias-alvarez/typescript.nvim") -- additional functionality for typescript server (e.g. rename file & update imports)

 
  -- using packer.nvim
  use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'}

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  use('tpope/vim-fugitive')
  use('tpope/vim-rhubarb')
  use('lukas-reineke/indent-blankline.nvim')
  use('lewis6991/gitsigns.nvim')

  use('tpope/vim-bundler')
  use('vim-ruby/vim-ruby')
  use('tpope/vim-rake')
  use('tpope/vim-rails')
  use('tpope/vim-commentary')
  use('mtdl9/vim-log-highlighting')
  use('RRethy/nvim-treesitter-endwise')
  use('windwp/nvim-autopairs')
  use('fatih/vim-go')
  use {
    'romgrk/barbar.nvim',
    requires = {'kyazdani42/nvim-web-devicons'}
  }
  use {
      "lazytanuki/nvim-mapper",
      config = function() require("nvim-mapper").setup{} end,
      before = "telescope.nvim"
  }
  if packer_bootstrap then
    require("packer").sync()
  end
end)
