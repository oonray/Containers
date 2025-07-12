return {
    path =  vim.fn.stdpath("data") .. "/workspaces",
    mru_sort = true,
    auto_open = true,
    auto_dir = true,
    hooks = {
        open_pre = {
          "SessionsStop",
          "silent %bd!",
        },
        open = function()
          req.sess.load(nil,{silent=true})
        end,
    }
}
