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

Works = require("config.works")
Works:load()

require("config.sess")

Ts = require("config.treesitter")
Ts:setup()

require("config.tele")
require("config.dap")

require("config.neovim")
require("config.autocmd")
