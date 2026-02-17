local os = {
    linux = true
}

function os:checkOS()
    if vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1
    then 
        self:lunux = false
    end
end

function os:isLinux()
    return self:linux
end

function os:isWindows()
    return self:linux ~= true
end

function os:setVars()
    if os:linux then
        vim.g.os = string.gsub(vim.fn.system('uname'), '\n', '')
        vim.opt.runtimepath:append(',~/.config/nvim/')
    else then
        vim.g.os = "Windows"
        vim.opt.runtimepath:append(',~/AppData/local/nvim/')
    end
end

function os:winTerm()
  vim.o.shell='pwsh'
  vim.o.shellcmdflag = "-NoLogo -NonInteractive -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';"
  vim.o.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
  vim.o.shellpipe  = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
  vim.o.shellquote= ""
  vim.o.shellxquote= ""
end

function os:enableAnsible()
    -- ANSIBLE
    req.dap.dap.adapters.ansible = {
      type = "executable",
      command = "python3",
      args = { "-m", "ansibug", "dap" },
    }
    req.dap.dap.configurations["yaml.ansible"] = ansibug_configurations
end

return os

