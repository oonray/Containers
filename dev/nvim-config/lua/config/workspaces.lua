require("telescope").load_extension("workspaces")

local config = {
    path = os.getenv("HOME") .. "/workspaces",
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

require("workspaces").setup(config)
return config
