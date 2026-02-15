local tls = require("telescope")
local builtin = require("telescope.builtin")
local lspz = require('lsp-zero')
local cmp = require('cmp')
local mason = require("mason")
local vars = require("config.vars")

tls.load_extension("dap")
tls.load_extension('telescope-tabs')

tls.setup{
    file_ignore_patterns = vars.ignore_patterns.lua,
}

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

lspz.setup{}
cmp.setup({
  capabilites = capabilities,
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({select = true}),
  }),
  sources = {
    {name = 'nvim_lsp'},
    {name = 'buffer'},
  },
})

lspz.on_attach(function(client, bufnr)
    lspz.default_keymaps({buffer = bufnr})
end)

-- MASON
mason.setup()
require("mason-lspconfig").setup({
  ensure_installed = vars.plugins.lsp,
  handlers = {
    lspz.default_setup,
  },
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

for _,lsp in pairs(vars.plugins.lsp) do
vim.lsp.config(lsp,{
  capabilities = capabilities
})
end

vim.lsp.config('ansiblels',{
    capabilities = capabilities,
    validation = {
      lint = {
        enabled = false,
      },
    },
})

vim.lsp.config('lua_ls',{
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

