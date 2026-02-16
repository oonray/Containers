local system = require("config.system")

system:checkOS()

local lazy = {
    base = os.getenv("HOME") .. 'git/.lazy',
    path = os.getenv("HOME") .. 'git/.lazy/lazy.nvim',
    repo = 'https://github.com/folke/lazy.nvim.git',
    try  = 0,
    is   = {
        inst = false,
        base = false,
        load = false},
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
            "stevearc/vim-arduino","rhysd/vim-clang-format"},
}

function lazy:check()
  if vim.loop.fs_stat(lazy.base) then
    lazy.is.base = true;
    if vim.loop.fs_stat(lazy.path) then
       lazy.is.inst = true
    end
  end
  if vim.g.plugins_ready then
    lazy.is.load = true
  end
end

function lazy:mkdir()
    print('lazy.nvim Making base path.... '..lazy.path)
    vim.fn.system({
        'mkdir','-p',
        lazy.base,
    })
end

function lazy:install()
      if not lazy.base then lazy:mkdir() end
      print('Installing lazy.nvim....')
      vim.opt.rtp:prepend(lazy.path)
      vim.fn.system({
          'git',
          'clone',
          '--filter=blob:none',
          lazy.repo,
          '--branch=stable', -- latest stable release
          lazy.path,
      })
end

function lazy:load()
    if not lazy.inst then lazy:install() end
    lazy.loadrequire("lazy").setup(lazy.libs, {})
    vim.g.plugins_ready = true
end

function lazy:setup()
   lazy:check()
   if not lazy.base then lazy:mkdir() end
   if not lazy.inst then lazy:install() end
   if not lazy.load then lazy:load() end
   lazy.try = lazy.try + 1
   if lazy.try < 3 then lazy:setup() end
end

system:setVars()
lazy:setup()


require('mini.align').setup {
    mappings = {
        start = '',
        start_with_preview = '<leader>g=' }
}
