local system = require("config.system")

local libs = {
        { "zenbones-theme/zenbones.nvim",
            dependencies="rktjmp/lush.nvim"},
        "nvim-lua/plenary.nvim","echasnovski/mini.nvim",
        "sheerun/vim-polyglot","tpope/vim-fugitive",
        "tpope/vim-surround","nvim-treesitter/nvim-treesitter",
        "nvim-treesitter/playground","preservim/nerdtree",
        "ryanoasis/vim-devicons","natecraddock/workspaces.nvim",
        "natecraddock/sessions.nvim","preservim/tagbar",
        "nvim-telescope/telescope.nvim",
        "nvim-telescope/telescope-live-grep-args.nvim",
        "nvim-telescope/telescope-dap.nvim",
        "LukasPietzschmann/telescope-tabs","rose-pine/neovim",
        "vim-airline/vim-airline","pacha/vem-tabline",
        "neovim/nvim-lspconfig","VonHeikemen/lsp-zero.nvim",
        "williamboman/mason.nvim","williamboman/mason-lspconfig.nvim",
        "mfussenegger/nvim-dap","leoluz/nvim-dap-go",
        "rcarriga/nvim-dap-ui","theHamsta/nvim-dap-virtual-text",
        "nvim-neotest/nvim-nio","jay-babu/mason-nvim-dap.nvim",
        "hrsh7th/cmp-buffer","neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp","hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path","hrsh7th/cmp-cmdline","hrsh7th/nvim-cmp",
        "glench/vim-jinja2-syntax","universal-ctags/ctags",
        "stevearc/vim-arduino","rhysd/vim-clang-format"}

local path = os.getenv("HOME") .. 'git/.lazy'
local Lazy = {}

function Lazy:install()
      if not vim.loop.fs_stat(path) then
        print('Installing lazy.nvim....')
        vim.fn.system({
          'git',
          'clone',
          '--filter=blob:none',
          'https://github.com/folke/lazy.nvim.git',
          '--branch=stable', -- latest stable release
          path,
        })
      end
    end

function Lazy:setup()
      vim.opt.rtp:prepend(path)
      require("lazy").setup(libs, {})
      vim.g.plugins_ready = true
end

system:checkOS()
system:setVars()

if not vim.g.plugins_ready then
    Lazy:install()
    Lazy:setup()
end

if vim.g.plugins_ready then
    require('mini.align').setup {
        mappings = {
            start = '',
            start_with_preview = '<leader>g=' }
    }
end
