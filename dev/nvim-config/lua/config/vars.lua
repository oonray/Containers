local vars = {
    key_map = {
       {[[<Leader>p]],  '"0p'}
      ,{[[<Leader>v]],  '"+p'}
      ,{[[<Leader>y]],  '"+y', "v"}
      ,{[[<Leader>c]],  '"+y', "v"}
      ,{[[<Leader>q]],  ":wa | wq<CR>"}
      ,{[[<Leader>wq]], ":waq<CR>"}
      ,{[[<Leader>wa]], ":wa<CR>"}
      ,{[[<Leader>bda]],"%bd|#e<CR>"}
      ,{[[<Leader>ws]], "<C-W>s"}
      ,{[[<Leader>wv]], "<C-W>v"}
      ,{[[<Leader>wj]], "<C-W>j"}
      ,{[[<Leader>wk]], "<C-W>k"}
      ,{[[<Leader>wl]], "<C-W>l"}
      ,{[[<Leader>wh]], "<C-W>h"}
      ,{[[<Leader>wwj]],[[:res-5<CR>]]}
      ,{[[<Leader>wwk]],[[:res+5<CR>]]}
      ,{[[<Leader>wwh]],[[:vert res +5<CR>]]}
      ,{[[<Leader>wwl]],[[:vert res -5<CR>]]}
      ,{[[<Leader>tn]], [[:tab split<CR>]]}
      ,{[[<Leader>tq]], [[:tabclose<CR>]]}
      ,{[[<Leader>to]], [[:tabonly<CR>]]}
      ,{[[<Leader>tl]], [[:tabnext<CR>]]}
      ,{[[<Leader>th]], [[:tabprevious<CR>]]}
      ,{[[<Leader>tmh]],[[:-tabmove<CR>]]}
      ,{[[<Leader>tml]],[[:itabmove<CR>]]}
      ,{[[<Leader>wa]], [[:WorkspacesAdd<CR>]]}
      ,{[[<Leader>wrm]],[[:WorkspacesRemove<CR>]]}
      ,{[[<Leader>mv]], [[:mkview<CR>]]}
      ,{[[<Leader>lv]], [[:loadview<CR>]]}
      ,{[[<Leader>tg]], [[:NERDTreeToggle<CR>]]}
      ,{[[<Leader>tc]], [[:NERDTreeFocus<CR>]]}
      ,{[[<Leader>tf]], [[:NERDTreeFind<CR>]]}
      ,{[[<Leader>tt]], [[:TagbarToggle<CR>]]}
      ,{[[<Leader>gi]], [[:lua vim.lsp.buf.implementation()<cr>]]}
      ,{[[<Leader>k]],  [[:lua vim.lsp.buf.hover()<cr>]]}
      ,{[[<Leader>rn]], [[:lua vim.lsp.buf.rename()<cr>]]}
      ,{[[<Leader>vb]], [[:lua vim.diagnostic.open_float(0, {})<CR>]]}
      ,{[[<Leader>vel]],[[:lua vim.diagnostic.open_float(0, {"line"})<CR>]] }

      ,{[[<leader>fs]],
          [[:lua vim.lsp.buf.format({async=true}) <CR>]]}

        ,{[[<leader>fb]],
          [[:lua vim.lsp.buf.format({async=true}) <CR>]]}

        ,{[[<leader>ss]], [[:SessionsSave <CR>]]}
        ,{[[<leader>sl]], [[:SessionsLoad <CR>]]}
        ,{[[<leader>tt]], [[:tab split | terminal<CR><CR>]]}
        ,{[[<leader>dbr]],[[:Dap toggle_breakpoint<CR>]]}
        ,{[[<leader>dc]], [[:Dap run_to_cursor<CR>]]}
        ,{[[<leader>dbc]],[[:Dap continue<CR>]]}
        ,{[[<leader>dbs]],[[:Dap step_into<CR>]]}
        ,{[[<leader>dbo]],[[:Dap step_over<CR>]]}
        ,{[[<leader>dbq]],[[:Dap step_out<CR>]]}
        ,{[[<leader>dbb]],[[:Dap step_back<CR>]]}
        ,{[[<leader>dbr]],[[:Dap restart<CR>]]}
        ,{[[<leader>ft]], [[:Telescope tags theme=ivy<CR>]]}
        ,{[[<leader>fm]], [[:Telescope marks theme=ivy<CR>]]}
        ,{[[<leader>mn]], [[:Telescope man_pages theme=ivy<CR>]]}
        ,{[[<leader>sg]], [[:Telescope spell_suggest theme=ivy<CR>]]}
        ,{[[<leader>,]],  [[:Telescope buffers theme=ivy<CR>]]}
        ,{[[<leader>.]],  [[:Telescope find_files theme=ivy<CR>]]}
        ,{[[<leader>ftc]],[[:Telescope commands theme=ivy<CR>]]}
        ,{[[<leader>gs]], [[:Telescope lsp_document_symbols theme=ivy<CR>]]}
        ,{[[<leader>gws]],[[:Telescope lsp_workspace_symbols theme=ivy<CR>]]}
        ,{[[<leader>lg]], [[:Telescope live_grep theme=ivy<CR>]]}
        ,{[[<leader>m]],  [[:Telescope workspaces theme=ivy<CR>]]}

        ,{[[<leader>n]],
            [[:Telescope telescope-tabs list_tabs theme=ivy<CR>]]}

        ,{[[<leader>gib]], [[:Telescope git_branches theme=ivy<CR>]]}
        ,{[[<leader>gic]], [[:Telescope git_commits theme=ivy<CR>]]}
        ,{[[<leader>gis]], [[:Telescope git_status  theme=ivy<CR>]]}
        ,{[[<leader>ge]],  [[:Telescope diagnostics theme=ivy<CR>]]}

        ,{[[<leader>fb]],
            [[:Telescope current_buffer_fuzzy_find theme=ivy<CR>]]}

        ,{[[<leader>goc]], [[:Telescope lsp_outgoing_calls theme=ivy<CR>]]}
        ,{[[<leader>gr]],  [[:Telescope lsp_references theme=ivy<CR>]]}
        ,{[[<leader>gc]],  [[:Telescope lsp_incoming_calls theme=ivy<CR>]]}
        ,{[[<leader>gd]],  [[:Telescope lsp_definitions theme=ivy<CR>]]}
        ,{[[<leader>gi]],  [[:Telescope lsp_implementations theme=ivy<CR>]]}
        ,{[[<leader>gD]],
            [[:Telescope lsp_type_definitions theme=ivy<CR>]]}

        ,{[[<leader>dcm]], [[:Telescope dap commands theme=ivy<CR>]] }
        ,{[[<leader>dc]],
            [[:Telescope dap configurations theme=ivy<CR>]]}
        ,{[[<leader>db]],
            [[:Telescope dap list_breakpoints theme=ivy<CR>]]}

        ,{[[<leader>dv]],  [[:Telescope dap variables theme=ivy<CR>]]}
        ,{[[<leader>dg]],  [[:Telescope dap frames theme=ivy<CR>]]}
        ,{[[<leader>tst]], [[:Telescope treesitter theme=ivy<CR>]]}
        ,{[[<leader>tsh]], [[:TSHighlightCapturesUnderCursor<CR>]]}
        ,{[[<leader>tsc]], [[:TSNodeUnderCursor<CR>]]}
        ,{[[<leader>tsp]], [[:TSPlaygroundToggle<CR>]]}

        ,{[[<leader>cm]],   [[gc<CR>]],[[v]]}

        ,{[[<Esc>]],       [[CTRL-\ CTRL-n]],  "t"}
        ,{[[<leader>q]],   [[CTRL-\ CTRL-n]],  "t"}
        ,{[[<leader>wq]],  [[CTRL-\  | :bd!]], "t"}
        ,{[[<leader>wl]],  [[CTRL-\ CTRL-n  | :tabprevious<CR>]], "t"}
        ,{[[<leader>wh]],  [[CTRL-\ CTRL-n  | :tabnext<CR>]], "t"}
    },
    ignore_patterns = {
        wildignore = {'*.o', '*.a', '__pycache__',"node_modules","node%_modules/.*",".git/.*","*cache*","build*/"},
        regex = [[.*node.*_modules.*|^build.*\|.*cache.*\|\.\(Z\|gz\|bz2\|zip\|bin\|o\|tgz\|git\|a\)$]],
        lua = {[[.git/]],[[build/]]},
    }
}

return vars
