local libs = {
        path = Basepath .. '/.lazy.nvim',
        names = {
        "c","c_sharp","lua","vim","vimdoc","query","markdown",
        "markdown_inline","arduino","asm","bash","make","cpp","php",
        "go","http","jinja","javascript","jq","llvm","python",
        "ssh_config","tmux","typescript","yaml"}

}

function libs:setup()
   vim.opt.rtp:append("," .. self.path)
   vim.opt.runtimepath:append("," .. self.path)

    require('nvim-treesitter').setup {
        ensure_installed = self.names,
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        install_dir = self.path
    }
    vim.api.nvim_create_autocmd('FileType', {
      callback = function() vim.treesitter.start() end,
    })
end

libs:setup()

return libs
