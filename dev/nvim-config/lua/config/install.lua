local system = require("config.system")

system:checkOS()


local lazy = {
    base = os.getenv("HOME") .. 'git/.lazy',
    path = os.getenv("HOME") .. 'git/.lazy/lazy.nvim',
    repo = 'https://github.com/folke/lazy.nvim.git',
    libs = {
            { "zenbones-theme/zenbones.nvim", dependencies="rktjmp/lush.nvim"},
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
            "stevearc/vim-arduino","rhysd/vim-clang-format"
         }
}


function lazy:install()
      if vim.loop.fs_stat(lazy.path) then
        return
      end
      if not vim.loop.fs_stat(lazy.base) then
        vim.fn.system({
            'mkdir','-p',
            lazy.base,
        })
      end
      print('Installing lazy.nvim....')
        vim.fn.system({
          'git',
          'clone',
          '--filter=blob:none',
          lazy.repo,
          '--branch=stable', -- latest stable release
          lazy.path,
      })
end

function lazy:setup()
        vim.opt.rtp:prepend(lazy.path)
        if vim.g.plugins_ready then
            return
        end
      lazy:install()
      require("lazy").setup(lazy.libs, {})
      vim.g.plugins_ready = true
end

system:setVars()
lazy:setup()


require('mini.align').setup {
    mappings = {
        start = '',
        start_with_preview = '<leader>g=' }
}
