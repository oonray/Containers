local vars = require("config.vars")
local keys = require("config.keys")

vim.o.laststatus        = 3
vim.o.cursorline        = true
vim.o.cursorlineopt     = 'number'

vim.o.number            = true
vim.o.numberwidth       = 2
vim.o.ruler             = true
vim.o.ignorecase        = true
vim.o.smartcase         = true
vim.o.signcolumn        = "yes"

vim.opt.fillchars       = {eob = " "}

vim.o.clipboard         = 'unnamedplus'
-- INDENT
vim.o.expandtab         = true
vim.o.autoindent        = true
vim.o.smartindent       = true
vim.o.tabstop           = 2
vim.o.softtabstop       = 2
vim.o.shiftwidth        = 2
--timeout
vim.o.updatetime        = 250
vim.o.timeoutlen        = 400
vim.o.undofile          = true
-- font
--vim.opt.guifont           = "{{ font }}\\ NFM:h10"
-- numbered lines

vim.opt.showmatch       = true
vim.opt.hlsearch        = true
vim.opt.incsearch       = true
vim.opt.wildmenu        = true
vim.opt.wildmode        = "list:longest"

-- indent
-- Show Cursor position line
-- vim.opt.relativenumber = true
vim.opt.hidden          = true
vim.opt.cmdheight       = 2
vim.opt.updatetime      = 300
vim.opt.timeoutlen      = 500
vim.opt.mouse           ='a'

--vim.opt.spell           = true
vim.opt.list            = true

vim.opt.showbreak       ='↪'
vim.opt.ambiwidth       = 'single'
vim.opt.listchars       ={ trail='', tab="|->"}



-- split
vim.o.showmode          = false
vim.o.splitkeep         = "screen"
vim.o.splitbelow        = true
vim.o.splitright        = true

-- files
-- default file format
vim.opt.fileformat      = 'unix'

---theme
--
vim.o.termguicolors   =true
vim.o.background      ='dark'
vim.cmd 'colorscheme forestbones'

vim.cmd.highlight('Normal guifg=#e7dcc4 guibg=#1F1F28')

--vim.cmd 'colorscheme zenwritten'
--vim.cmd 'colorscheme kanagawabones'
--vim.cmd 'colorscheme rosebones'
--vim.cmd 'colorscheme zenbones'
--vim.cmd 'colorscheme rose-pine'

vim.opt.wildignore = {'*.o', '*.a', '__pycache__',"node_modules","node%_modules/.*",".git/.*","*cache*","build*/"}
vim.g.ft_ignore_pat = [[.*node.*_modules.*|^build.*\|.*cache.*\|\.\(Z\|gz\|bz2\|zip\|bin\|o\|tgz\|\.git\|a\)$]]

vim.g.loaded_node_provider      = 0
vim.g.loaded_python3_provider   = 0
vim.g.loaded_perl_provider      = 0
vim.g.loaded_ruby_provider      = 0
vim.opt.shortmess:append        "sI"

keys:setup(vars.key_map)

