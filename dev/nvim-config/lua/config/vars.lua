local vars = {
    plugins = {
    lsp = {
      "ansiblels"
      ,"bashls"
      ,"biome"
      ,"dockerls"
      ,"html"
      ,"jqls"
      ,"jsonls"
      ,"lua_ls"
      ,"ts_ls"
      ,"yamlls"
      ,"arduino_language_server"
      ,"asm_lsp"
      ,"clangd"
      ,"cmake"
      ,"csharp_ls"
      ,"helm_ls"
      ,"cypher_ls"
      ,"gopls"
      ,"markdown_oxide"
      ,"powershell_es"
      ,"pylsp"
      ,"sqlls"
    },
    tree = {
      "c"
      ,"c_sharp"
      ,"lua"
      ,"vim"
      ,"vimdoc"
      ,"query"
      ,"markdown"
      ,"markdown_inline"
      ,"arduino"
      ,"asm"
      ,"bash"
      ,"make"
      ,"cpp"
      ,"php"
      ,"go"
      ,"http"
      ,"jinja"
      ,"javascript"
      ,"jq"
      ,"llvm"
      ,"python"
      ,"ssh_config"
      ,"tmux"
      ,"typescript"
      ,"yaml"
    },
    key_map = {
        map = {
       {mode=[[n]],
        key=[[<leader>p]],trigger=[["0p]]}
      ,{mode=[[v]],key=[[<leader>p]],trigger=[["0p]]}
      ,{mode=[[t]],key=[[<leader>p]],trigger=[["0p]]}
      ,{mode=[[n]],key=[[<leader>pc]],trigger=[["+p]]}
      ,{mode=[[v]],key=[[<leader>pc]],trigger=[["+p]]}
      ,{mode=[[t]],key=[[<leader>pc]],trigger=[["+p]]}
      ,{mode=[[n]],key=[[<leader>y]],trigger=[["+y]]}
      ,{mode=[[v]],key=[[<leader>y]],trigger=[["+y]]}
      ,{mode=[[t]],key=[[<leader>y]],trigger=[["+y]]}
      ,{mode=[[n]],key=[[<leader>q]],trigger=[[:wa | wq<CR>]]}
      ,{mode=[[n]],key=[[<leader>wq]],trigger=[[:waq<CR>]]}
      ,{mode=[[n]],key=[[<leader>wa]],trigger=[[:wa<CR>]]}
      ,{mode=[[n]],key=[[<leader>bda]],trigger=[[%bd|#e<CR>]]}
      ,{mode=[[n]],key=[[<leader>ws]],trigger=[[<C-W>s]]}
      ,{mode=[[n]],key=[[<leader>wv]],trigger=[[<C-W>v]]}
      ,{mode=[[n]],key=[[<leader>wj]],trigger=[[<C-W><C-J>]]}
      ,{mode=[[n]],key=[[<leader>wk]],trigger=[[<C-W><C-K>]]}
      ,{mode=[[n]],key=[[<leader>wl]],trigger=[[<C-W><C-L>]]}
      ,{mode=[[n]],key=[[<leader>wh]],trigger=[[<C-W><C-H>]]}
      ,{mode=[[n]],key=[[<leader>w=]],trigger=[[<C-W>=<CR>]]}
      ,{mode=[[n]],key=[[<leader>wwj]],trigger=[[:res-5<CR>]]}
      ,{mode=[[n]],key=[[<leader>wwk]],trigger=[[:res+5<CR>]]}
      ,{mode=[[n]],key=[[<leader>wwh]],trigger=[[:vert res +5<CR>]]}
      ,{mode=[[n]],key=[[<leader>wwl]],trigger=[[:vert res -5<CR>]]}
      ,{mode=[[n]],key=[[<leader>tn]],trigger=":tab split<CR>"}
      ,{mode=[[n]],key=[[<leader>tq]],trigger=[[:tabclose<CR>]]}
      ,{mode=[[n]],key=[[<leader>to]],trigger=[[:tabonly<CR>]]}
      ,{mode=[[n]],key=[[<leader>tl]],trigger=[[:tabnext<CR>]]}
      ,{mode=[[n]],key=[[<leader>th]],trigger=[[:tabprevious<CR>]]}
      ,{mode=[[n]],key=[[<leader>tmh]],trigger=[[:-tabmove<CR>]]}
      ,{mode=[[n]],key=[[<leader>tml]],trigger=[[:itabmove<CR>]]}
      ,{mode=[[n]],key=[[<leader>wa]],trigger=[[:WorkspacesAdd<CR>]]}
      ,{mode=[[n]],key=[[<leader>wrm]],trigger=[[:WorkspacesRemove<CR>]]}
      ,{mode=[[n]],key=[[<leader>mv]],trigger=[[:mkview<CR>]]}
      ,{mode=[[n]],key=[[<leader>lv]],trigger=[[:loadview<CR>]]}
      ,{mode=[[n]],key=[[<leader>tg]],trigger=[[:NERDTreeToggle<CR>]]}
      ,{mode=[[n]],key=[[<leader>tc]],trigger=[[:NERDTreeFocus<CR>]]}
      ,{mode=[[n]],key=[[<leader>tf]],trigger=[[:NERDTreeFind<CR>]]}
      ,{mode=[[n]],key=[[<leader>tt]],trigger=[[:TagbarToggle<CR>]]}

      ,{mode=[[n]],key=[[<leader>gi]],
        trigger=[[:lua vim.lsp.buf.implementation()<cr>]]}

      ,{mode=[[n]],key=[[<leader>k]],
        trigger=[[:lua vim.lsp.buf.hover()<cr>]]}

      ,{mode=[[n]],key=[[<leader>rn]],
        trigger=[[:lua vim.lsp.buf.rename()<cr>]]}

      ,{mode=[[n]],key=[[<leader>vb]],
        trigger=[[:lua vim.diagnostic.open_float(0, {})<CR>]]}

      ,{mode=[[n]],
        key=[[<leader>vel]],
        trigger=[[:lua vim.diagnostic.open_float(0, {scope="line"})<CR>]]}

      ,{mode=[[n]],
        key=[[<leader>fs]],
        trigger=":[[<,]]>lua vim.lsp.buf.format({async = true})<CR>"}


        ,{mode=[[n]],
        key=[[<leader>fb]],
        trigger=[[:lua vim.lsp.buf.format({async = true})<CR>]]}

        ,{mode=[[n]],
        key=[[<leader>ss]],
        trigger=[[:SessionsSave <CR>]]}

        ,{mode=[[n]],
        key=[[<leader>sl]],
        trigger=[[:SessionsLoad <CR>]]}

        ,{mode=[[n]],
        key=[[<leader>tt]],
        trigger=[[:tab split | terminal<CR><CR>]]}

        ,{mode=[[t]],
        key=[[<Esc>]],
        trigger=[[<C-\><C-n>]]}

        ,{mode=[[t]],
        key=[[<leader>q]],
        trigger=[[<C-\><C-n>]]}

        ,{mode=[[t]],
        key=[[<leader>ws]],
        trigger=[[<C-\><C-W>s]]}

        ,{mode=[[t]],
        key=[[<leader>wv]],
        trigger=[[<C-\><C-W>v]]}

        ,{mode=[[t]],
        key=[[<leader>wq]],
        trigger=[[<C-\> | :bd!]]}

        ,{mode=[[t]],
        key=[[<leader>wj]],
        trigger=[[<C-\><C-J> | i]]}

        ,{mode=[[t]],
        key=[[<leader>wk]],
        trigger=[[<C-\><C-J> | i]]}

        ,{mode=[[t]],
        key=[[<leader>wl]],
        trigger=[[<C-\><C-n> | :tabprevious<CR>]]}

        ,{mode=[[t]],
        key=[[<leader>wh]],
        trigger=[[<C-\><C-n> | :tabnext<CR>]]}

        ,{mode=[[n]],
        key=[[<leader>dbr]],
        trigger=[[:Dap toggle_breakpoint<CR>]]}

        ,{mode=[[n]],
        key=[[<leader>dc]],
        trigger=[[:Dap run_to_cursor<CR>]]}

        ,{mode=[[n]],
        key=[[<leader>dbc]],
        trigger=[[:Dap continue<CR>]]}

        ,{mode=[[n]],
        key=[[<leader>dbs]],
        trigger=[[:Dap step_into<CR>]]}

        ,{mode=[[n]],
        key=[[<leader>dbo]],
        trigger=[[:Dap step_over<CR>]]}

        ,{mode=[[n]],
        key=[[<leader>dbq]],
        trigger=[[:Dap step_out<CR>]]}

        ,{mode=[[n]],
        key=[[<leader>dbb]],
        trigger=[[:Dap step_back<CR>]]}

        ,{mode=[[n]],
        key=[[<leader>dbr]],
        trigger=[[:Dap restart<CR>]]}

        ,{mode=[[n]],
        key=[[<leader>ft]],
        trigger=[[:Telescope tags theme=ivy<CR>]]}

        ,{mode=[[n]],
        key=[[<leader>fm]],
        trigger=[[:Telescope marks theme=ivy<CR>]]}

        ,{mode=[[n]],
        key=[[<leader>fp]],
        trigger=[[:Telescope man_pages theme=ivy<CR>]]}

        ,{mode=[[n]],
        key=[[<leader>sg]],
        trigger=[[:Telescope spell_suggest theme=ivy<CR>]]}

        ,{mode=[[n]],
        key=[[<leader>,]],
        trigger=[[:Telescope buffers theme=ivy<CR>]]}

        ,{mode=[[n]],
        key=[[<leader>.]],
        trigger=[[:Telescope find_files theme=ivy<CR>]]}

        ,{mode=[[n]],
        key=[[<leader>ftc]],
        trigger=[[:Telescope commands theme=ivy<CR>]]}

        ,{mode=[[n]],
        key=[[<leader>gs]],
        trigger=[[:Telescope lsp_document_symbols theme=ivy<CR>]]}

        ,{mode=[[n]],
        key=[[<leader>gws]],
        trigger=[[:Telescope lsp_workspace_symbols theme=ivy<CR>]]}

        ,{mode=[[n]],
        key=[[<leader>æ]],
        trigger=[[:Telescope live_grep theme=ivy<CR>]]}

        ,{mode=[[n]],
        key=[[<leader>æb]],
        trigger=[[:Telescope live_grep theme=ivy search_dirs=%:p<CR>]]}

        ,{mode=[[n]],
        key=[[<leader>m]],
        trigger=[[:Telescope workspaces previewer=false theme=ivy<CR>]]}

        ,{mode=[[n]],
        key=[[<leader>n]],
        trigger=[[:Telescope telescope-tabs list_tabs theme=ivy<CR>]]}

        ,{mode=[[n]],
        key=[[<leader>gib]],
        trigger=[[:Telescope git_branches previewer=false theme=ivy<CR>]]}

        ,{mode=[[n]],
        key=[[<leader>gic]],
        trigger=[[:Telescope git_commits previewer=false theme=ivy<CR>]]}

        ,{mode=[[n]],
        key=[[<leader>gis]],
        trigger=[[:Telescope git_status  previewer=false theme=ivy<CR>]]}

        ,{mode=[[n]],
        key=[[<leader>ge]],
        trigger=[[:Telescope diagnostics previewer=false theme=ivy<CR>]]}

        ,{mode=[[n]],
        key=[[<leader>fb]],
        trigger=[[:Telescope current_buffer_fuzzy_find theme=ivy<CR>]]}

        ,{mode=[[n]],
        key=[[<leader>goc]],
        trigger=[[:Telescope lsp_outgoing_calls theme=ivy<CR>]]}

        ,{mode=[[n]],
        key=[[<leader>gr]],
        trigger=[[:Telescope lsp_references theme=ivy<CR>]]}

        ,{mode=[[n]],
        key=[[<leader>gc]],
        trigger=[[:Telescope lsp_incoming_calls theme=ivy<CR>]]}

        ,{mode=[[n]],
        key=[[<leader>gd]],
        trigger=[[:Telescope lsp_definitions theme=ivy<CR>]]}

        ,{mode=[[n]],
        key=[[<leader>gi]],
        trigger=[[:Telescope lsp_implementations theme=ivy<CR>]]}

        ,{mode=[[n]],
        key=[[<leader>gD]],
        trigger=[[:Telescope lsp_type_definitions theme=ivy<CR>]]}

        ,{mode=[[n]],
        key=[[<leader>dcm]],
        trigger=[[:Telescope dap commands theme=ivy<CR>]] }

        ,{mode=[[n]],
        key=[[<leader>dc]],
        trigger=[[:Telescope dap configurations theme=ivy<CR>]]}

        ,{mode=[[n]],
        key=[[<leader>db]],
        trigger=[[:Telescope dap list_breakpoints theme=ivy<CR>]]}

        ,{mode=[[n]],
        key=[[<leader>dv]],
        trigger=[[:Telescope dap variables theme=ivy<CR>]]}

        ,{mode=[[n]],
        key=[[<leader>dg]],
        trigger=[[:Telescope dap frames theme=ivy<CR>]]}

        ,{mode=[[n]],
        key=[[<leader>tst]],
        trigger=[[:Telescope treesitter theme=ivy<CR>]]}

        ,{mode=[[n]],
        key=[[<leader>tsp]],
        trigger=[[:TSPlaygroundToggle<CR>]]}

        ,{mode=[[n]],
        key=[[<leader>tsh]],
        trigger=[[:TSHighlightCapturesUnderCursor<CR>]]}

        ,{mode=[[n]],
        key=[[<leader>tsc]],
        trigger=[[:TSNodeUnderCursor<CR>]]}
        },
        }
    },
    ignore_patterns = {
        wildignore = {'*.o', '*.a', '__pycache__',"node_modules","node%_modules/.*",".git/.*","*cache*","build*/"},
        regex = [[.*node.*_modules.*|^build.*\|.*cache.*\|\.\(Z\|gz\|bz2\|zip\|bin\|o\|tgz\|git\|a\)$]],
        lua = {[[.git/]],[[build/]]},
    }
}


return vars
