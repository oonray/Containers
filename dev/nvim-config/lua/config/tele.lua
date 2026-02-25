local cmp     = require('cmp')
local tls     = require("telescope")
local lspz    = require('lsp-zero')
local mason   = require("mason")

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lsp = {
    "ansiblels"
    ,"bashls" ,"biome" ,"dockerls"
    ,"html" ,"jqls" ,"jsonls" ,"lua_ls"
    ,"ts_ls" ,"yamlls" ,"arduino_language_server"
    ,"asm_lsp" ,"clangd" ,"cmake" ,"csharp_ls" ,"helm_ls"
    ,"cypher_ls" ,"gopls" ,"markdown_oxide" ,"powershell_es"
    ,"pylsp" ,"sqlls"}

tls.load_extension("dap")
tls.load_extension('telescope-tabs')
tls.setup{file_ignore_patterns = {[[.git/]],[[build/]]}}

--- LSP
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.WARN] = '▲',
      [vim.diagnostic.severity.HINT] = '⚑',
      [vim.diagnostic.severity.INFO] = '»',
      [vim.diagnostic.severity.ERROR] = '✘',
    },
  },
})


lspz.setup{}
require('nvim-highlight-colors').setup({})

cmp.setup({
  capabilites = capabilities,
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({select = true}),
  }),
  sources = {
    {name = 'nvim_lsp'},
    {name = 'buffer'},
  },
  formatting = {
    format = require("nvim-highlight-colors").format
  }
})


lspz.on_attach(function(_, bufnr)
    lspz.default_keymaps({buffer = bufnr})

end)

-- MASON
mason.setup()
require("mason-lspconfig").setup({
  ensure_installed = lsp,
  handlers = {
    lspz.default_setup,
  },
})

for _,ls in pairs(lsp) do
vim.lsp.config(ls,{
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

require('mini.align').setup {
   mappings = {
    start = 'ga',
    start_with_preview = 'gA',
    },

  options = {
    split_pattern = '',
    justify_side = 'left',
    merge_delimiter = '',
  },

  steps = {
    pre_split = {},
    split = nil,
    pre_justify = {},
    justify = nil,
    pre_merge = {},
    merge = nil,
  },
  silent = false,
}
