local libs = {
        path = Basepath .. "/.treesitter/",
        names = {
        "c","c_sharp","lua","vim","vimdoc","query","markdown",
        "markdown_inline","arduino","asm","bash","make","cpp","php",
        "go","http","jinja","javascript","jq","llvm","python",
        "ssh_config","tmux","typescript","yaml"}

}

function libs:dir()
  if not vim.loop.fs_stat(self.path) then
    vim.fn.system({
        [[mkdir]],
        [[-p]],
        self.path})
    end
end

function libs:setup()
    self:dir()

    vim.opt.rtp:append("," .. self.path)
    vim.opt.runtimepath:append("," .. self.path)

    require('nvim-treesitter').setup {
        ensure_installed = self.names,
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        fold = { enable = true },
        install_dir = self.path,
    }
end
