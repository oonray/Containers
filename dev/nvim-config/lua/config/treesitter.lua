local libs = {
    ts = nil,
    names = {
        "c","c_sharp","lua","vim","vimdoc","query","markdown",
        "markdown_inline","arduino","asm","bash","make","cpp","php",
        "go","http","jinja","javascript","jq","llvm","python",
        "ssh_config","tmux","typescript","yaml"
    }
}

function libs:setup()
    self.ts = require ('nvim-treesitter')

    ts.setup {
        ensure_installed =
        {"c","c_sharp","lua","vim","vimdoc","query","markdown",
        "markdown_inline","arduino","asm","bash","make","cpp","php",
        "go","http","jinja","javascript","jq","llvm","python",
        "ssh_config","tmux","typescript","yaml"},

        auto_install = true,
        sync_install = false,

        additional_vim_regex_highlighting = true,
        parser_install_dir = nil,
        highlight = { enable = true },
        indent = { enable = true },
    }
    vim.api.nvim_create_autocmd(
       {'BufEnter','BufRead','BufNew'}, {
           callback = function(ev)
                local er,ft = pcall(vim.filetype.match,{buf=ev.buf})
                if er then
                    vim.bo[ev.buf].syntax = 'on'
                end
                pcall(vim.treesitter.start,ev.buf,ft)
           end
       }
    )

    vim.api.nvim_create_autocmd(
       {'FileType' }, {
           callback = function(ev)
              local er,ft = pcall(vim.filetype.match,{buf=ev.buf})
              if er then
                vim.bo[ev.buf].syntax = 'on'
              end
              pcall(vim.treesitter.start,ev.buf,ft)
           end
       }
    )

    vim.api.nvim_create_autocmd(
       {'FileType' }, {
           pattern=[[.*\.h"]],
           callback = function(ev)
               pcall(vim.treesitter.start,ev.buf,'c')
           end
       }
    )

    vim.api.nvim_create_autocmd(
        {'BufUnload','BufDelete'}, {
        callback = function(ev)
            pcall(vim.treesitter.stop, ev.buf)
        end
        }
    )

end

return libs
