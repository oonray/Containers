local system = require("config.system")

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
            "nvim-lua/plenary.nvim",
            { 'nvim-mini/mini.nvim', version = '*' },
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
  print("Checking vars... ")
  if vim.loop.fs_stat(self.base) then
    self.is.base = true;
    if vim.loop.fs_stat(self.path) then
       self.is.inst = true
    end
  end
  if vim.g.plugins_ready then
    self.is.load = true
  end
end

function lazy:mkdir()
    if self.is.base then return true end
    print('lazy.nvim Making base path.... '..self.path)
    vim.fn.system({
        'mkdir','-p',
        self.base,
    })
    self.is.base = true
end

function lazy:install()
      print('Installing lazy.nvim....')
    if self.is.inst then return end
      self:mkdir()
      vim.opt.rtp:prepend(lazy.path)
      vim.fn.system({
          'git',
          'clone',
          '--filter=blob:none',
          self.repo,
          '--branch=stable', -- latest stable release
          self.path,
      })
      self.is.inst = true
      return self.is.inst
end

function lazy:load()
    print("Importing lazy...")
    self:check()
    self:mkdir()
    if self:install()
    then
        require("lazy").setup(lazy.libs, {})
        vim.g.plugins_ready = true
        self.is.load = true
    end

    self.try = self.try + 1
    return self.is.load
end

function lazy:setup()
   if not system:load() then return false end
   if not self.is.load or self.try < 3
   then
        self:load()
   end
   return self
end

return lazy:setup()
