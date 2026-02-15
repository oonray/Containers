require('nvim-treesitter')
require('nvim-treesitter.configs').setup {
    ensure_installed = {
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
    auto_install = true,
    highlight = {
        enable = true,
    },
    indent = { enable = true }
}
