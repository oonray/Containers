local vars = require("config.vars")
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

--vim.cmd 'colorscheme zenwritten'
--vim.cmd 'colorscheme kanagawabones'
--vim.cmd 'colorscheme rosebones'
vim.cmd 'colorscheme forestbones'
--vim.cmd 'colorscheme zenbones'
--vim.cmd 'colorscheme rose-pine'

vim.cmd 'set termguicolors'
vim.cmd 'highlight Normal guifg=#e7dcc4 guibg=#1F1F28'

-- Secrets
require("nvim-dap-virtual-text").setup {
        display_callback = function(variable)
          local name = string.lower(variable.name)
          local value = string.lower(variable.value)
          if name:match "secret" or name:match "api" or value:match "secret" or value:match "api" then
            return "*****"
          end

          if #variable.value > 15 then
            return " " .. string.sub(variable.value, 1, 15) .. "... "
          end

          return " " .. variable.value
        end,
}

vim.opt.wildignore = vars.ignore_patterns.wildignore
vim.g.mapleader        = " " --','
for i,key in pairs(vars.plugins.key_map.map)
do
    vim.keymap.set(key.mode,key.key,key.trigger, { nowait= true })
end
vim.g.ft_ignore_pat = vars.ignore_patterns.regex
-- dap

vim.g.ft_ignore_pat = vars.ignore_patterns.regex
