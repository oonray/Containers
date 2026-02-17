local libs = {
        names = {
        "c","c_sharp","lua","vim","vimdoc","query","markdown",
        "markdown_inline","arduino","asm","bash","make","cpp","php",
        "go","http","jinja","javascript","jq","llvm","python",
        "ssh_config","tmux","typescript","yaml"}

}

function libs:setup()
    require('nvim-treesitter').setup {
        ensure_installed = self.names,
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        fold = { enable = true },
    }
end

libs:setup()

return libs
