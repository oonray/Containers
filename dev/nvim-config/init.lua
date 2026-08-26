System = require("config.system")
System:checkOS()

if System.linux
then
Basepath = os.getenv("HOME") .. "/git"
else
Basepath = os.getenv("USERPROFILE")
end

Lazy = require("config.install")
Lazy:setup()

Nvm = require("config.neovim")
Nvm:setup()

Works = require("config.works")
Works:load()

require("config.sess")
require("config.dap")
require("config.tele")

Ts = require("config.treesitter")
Ts:setup()


AU = require("config.autocmd")
AU:setup()
