local vars = require("config.vars")
local lazy = require("config.lazy")
local system = require("config.system")

system:checkOS()
system:setVars()

lazy:setup()

local req = require("config.require")

local conf = {
ansibug = {
  {
    type = "ansible",
    request = "launch",
    name = "Debug playbook",
    playbook = "${file}"
  },
},

workspace = require("config.workspaces")
}




---
--- NEOVIM Config
---
-- font
require("config.neovim")

vim.opt.wildignore = vars.ignore_patterns.wildignore

-- Key settings
vim.g.mapleader        = " " --','
for i,key in pairs(vars.plugins.key_map.map) do
    vim.keymap.set(key.mode,key.key,key.trigger, {nowait= true})
end

if system:isWindows()
then
  system:winTerm()
end

-- mini allign
require('mini.align').setup { mappings = { start = '', start_with_preview = '<leader>g=' }}

--[[ TreeSitter
require('nvim-treesitter')
require('nvim-treesitter.configs').setup {
    ensure_installed = vars.plugins.tree,
    auto_install = true,
    highlight = {
        enable = true,
    },
    indent = { enable = true }
}
--]]

-- <Esc>  to exit
--DAP
req.dap.ui.setup()
req.dap.go.setup()

--Debug-DAP
req.dap.dap.listeners.before.attach.dapui_config = function()
    req.dap.dapui.open()
  end
req.dap.dap.listeners.before.launch.dapui_config = function()
    req.dap.dapui.open()
end
req.dap.dap.listeners.before.event_terminated.dapui_config = function()
    req.dap.dapui.close()
end
req.dap.dap.listeners.before.event_exited.dapui_config = function()
    req.dap.dapui.close()
end

if system:isLinux()
then
    req.dap.dap.adapters.ansible = {
      type = "executable",
      command = "python3",
      args = { "-m", "ansibug", "dap" },
    }
    req.dap.dap.configurations["yaml.ansible"] = ansibug_configurations
end

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

--TelescopeConfig
req.tls.tls.load_extension("workspaces")
req.tls.tls.load_extension("dap")
req.tls.tls.load_extension('telescope-tabs')

req.tls.tls.setup{
    file_ignore_patterns = vars.ignore_patterns.lua,
}

-- sessions
req.sess.setup({
    events = vars.events.sessions,
    session_filepath = vim.fn.stdpath("data") .. "/ws/sessions",
    absolute = true,
})
-- Workspaces
-- TODO
-- workspaces.add(path: string, name: string)
req.ws.setup(conf.workspace)

--- LSP
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '✘',
      [vim.diagnostic.severity.WARN] = '▲',
      [vim.diagnostic.severity.HINT] = '⚑',
      [vim.diagnostic.severity.INFO] = '»',
    },
  },
})

--CAPABILLITIES
local capabilities = req.cmp.lsp.default_capabilities()

req.lsp.zero.setup{}
req.cmp.cmp.setup({
  capabilites = capabilities,
  mapping = req.cmp.cmp.mapping.preset.insert({
    ['<CR>'] = req.cmp.cmp.mapping.confirm({select = true}),
  }),
  sources = {
    {name = 'nvim_lsp'},
    {name = 'buffer'},
  },
})

req.lsp.zero.on_attach(function(client, bufnr)
    req.lsp.zero.default_keymaps({buffer = bufnr})
end)

-- MASON
req.lsp.mason.mason.setup()
req.lsp.mason.lsp.setup({
  ensure_installed = vars.plugins.lsp,
  handlers = {
    req.lsp.zero.default_setup,
  },
})

for _,lsp in pairs(vars.plugins.lsp) do
req.lsp.conf(lsp,{
  capabilities = capabilities
})
end

req.lsp.conf('ansiblels',{
    capabilities = capabilities,
    validation = {
      lint = {
        enabled = false,
      },
    },
})

req.lsp.conf('lua_ls',{
  capabilities = capabilities,
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if path ~= vim.fn.stdpath('config') and (vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc')) then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        version = 'LuaJIT'
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
        }
      }
    })
  end,
  settings = {
    Lua = {}
  }
})
-- dap
req.dap.mason.setup{
  ensure_installed = v.plugins.dap,
  handlers = {},
}

vim.g.ft_ignore_pat = ignore_patterns.regex
require("config.autocmd")
-- dap
req.dap.mason.setup{
  ensure_installed = vars.plugins.dap,
  handlers = {},
}

vim.g.ft_ignore_pat = vars.ignore_patterns.regex

require("config.autocmd")
