local works = {
    folder =  Basepath .. "/.workspaces/",
    conf = {
        path =  Basepath .. "/.workspaces/workspaces.nvim",
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
}

function works:dir()
  if not vim.loop.fs_stat(self.folder)
  then
    vim.fn.system({
        [[mkdir]],
        [[-p]],
        self.folder})
  end
end

function works:load()
    self:dir()
    require("telescope").load_extension("workspaces")
    require("workspaces").setup(self.conf)
end

return works
