local system = {
    linux = true,
}

function system:checkOS()
    if vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1
    then 
        self.linux = false
    end
end

function system:isLinux()
    return self.linux
end

function system:isWindows()
    return self.linux ~= true
end

function system:setVars()
    if self.linux then
        vim.g.os = string.gsub(vim.fn.system('uname'), '\n', '')
        vim.opt.runtimepath:append(',~/.config/nvim/')
    else
        vim.g.os = "Windows"
        vim.opt.runtimepath:append(',~/AppData/local/nvim/')
    end
end

function system:winTerm()
  vim.o.shell='pwsh'
  vim.o.shellcmdflag = "-NoLogo -NonInteractive -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';"
  vim.o.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
  vim.o.shellpipe  = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
  vim.o.shellquote= ""
  vim.o.shellxquote= ""
end

if system:isWindows()
then
  system:winTerm()
end

return system

