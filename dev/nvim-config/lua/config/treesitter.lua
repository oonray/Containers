local libs = {
        "c","c_sharp","lua","vim","vimdoc","query","markdown",
        "markdown_inline","arduino","asm","bash","make","cpp","php",
        "go","http","jinja","javascript","jq","llvm","python",
        "ssh_config","tmux","typescript","yaml"}


require('nvim-treesitter').setup {
    ensure_installed = libs,
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
    fold = { enable = true },
    install_dir = os.getenv("HOME") .. "git/.treesitter/",
}
