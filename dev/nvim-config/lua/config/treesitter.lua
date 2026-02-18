local libs = {
        names = {
        "c","c_sharp","lua","vim","vimdoc","query","markdown",
        "markdown_inline","arduino","asm","bash","make","cpp","php",
        "go","http","jinja","javascript","jq","llvm","python",
        "ssh_config","tmux","typescript","yaml"}

}

function libs:setup()
    local ts = require ('nvim-treesitter')

    ts.setup {
        ensure_installed = self.names,
        auto_install = true,
        sync_install = false,
        additional_vim_regex_highlighting = false,
        parser_install_dir = nil,
        highlight = { enable = true },
        indent = { enable = true },
    }
    vim.api.nvim_create_autocmd(
       {'FileType'}, {
           callback = function(ev)
                if(vim.filetype.match({buf = ev.buf})) then
                    vim.treesitter.start(ev.buf)
                end
           end
       }
    )
end

return libs
