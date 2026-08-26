local system = {
    linux = true,
    loaded = false,
}

function system:checkOS()
    if self.loaded then return end
    if vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1
    then
        self.linux = false
    else
        self.linux = true
    end
end

function system:linux()
    self:checkOS()
    if not self.linux then return end
    vim.g.os = string.gsub(vim.fn.system('uname'), '\n', '')
    vim.opt.runtimepath:append(',~/.config/nvim/')
end

function system:windows()
    self:checkOS()
    if self.linux then return end
    vim.g.os = "Windows"
    vim.opt.runtimepath:append(',~/AppData/local/nvim/')
    self:winTerm()
end

function system:load()
    self:linux()
    self:windows()
    self.loaded = true
    return self.loaded
end

function system:winTerm()
  vim.o.shell='pwsh'
  vim.o.shellcmdflag = "-NoLogo -NonInteractive -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();"
  vim.o.shellredir = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
  vim.o.shellpipe  = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
  vim.o.shellquote= ""
  vim.o.shellxquote= ""
end

return system

