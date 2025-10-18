-- font
vim.opt.guifont        = "{{ font }}\\ NFM:h10"
-- numbered lines
vim.opt.number         = true
--show matching
vim.opt.showmatch      = true
--case insensitive
vim.opt.ignorecase     = true
--highlight search
vim.opt.hlsearch       = true
--incremental search
vim.opt.incsearch      = true
-- wildcard menu
vim.opt.wildmenu       = true
vim.opt.wildmode       = "list:longest"

-- indent
-- see multiple spaces as tabstops so <BS> does the right thing
vim.opt.softtabstop    = 4
-- width for autoindents
vim.opt.shiftwidth     = 4
-- converts tabs to white space
vim.opt.expandtab      = true
-- indent a new line the same amount as the line just typed
vim.opt.autoindent     = true
-- The cursor line is highlighed
vim.opt.cursorline     = true
-- Show Cursor position line
vim.opt.ruler          = true
-- vim.opt.relativenumber = true
vim.opt.hidden         = true
vim.opt.cmdheight      = 2
vim.opt.updatetime     = 300
vim.opt.timeoutlen     = 500

vim.opt.mouse='a'

-- visual characters
vim.opt.spell= true
vim.opt.list = true
vim.opt.showbreak='↪'
vim.opt.ambiwidth = 'single'
vim.opt.listchars={ trail='', tab="|->"}

-- slipt
vim.opt.splitbelow = true
vim.opt.splitright = true

-- files
-- default file format
vim.opt.fileformat = 'unix'

---theme
--
vim.opt.background = 'dark'
vim.cmd 'set termguicolors'
vim.cmd 'colorscheme kanagawabones'
--vim.cmd 'colorscheme zenwritten'
--vim.cmd 'colorscheme zenbones'
--vim.cmd 'colorscheme rose-pine'

