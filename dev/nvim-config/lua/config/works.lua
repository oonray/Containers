local works = {
    path =  Basepath .. "/workspaces",
    mru_sort = true,
    auto_open = true,
    auto_dir = true,
    hooks = {
        open_pre = {
          "SessionsStop",
          "silent %bd!",
        },
        open = function()
            require("sessions").load(nil, {silent=true})
        end,
    }
}

function works:dir()
    vim.fn.system({
       "powershell","-c",
        [["mkdir]] .. self.path .. [["]]})
end

function works:load()
    self:dir()
    require("telescope").load_extension("workspaces")
    require("workspaces").setup(self)
end

return works
