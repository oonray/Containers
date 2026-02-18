local auto = {
    files  = {
        {[[*.Ansible.*]],'yaml.ansible','unix'},
        {[[*.sh]],'bash','unix'},
        {[[*make*]],'make','unix'},
        {[[*Make*]],'make','unix'},
        {[[*.h]],'c','unix'},
        {[[*.c]],'c','unix'},
    },
}

function auto:load()
    for i,val in pairs(self.files)
    do
        vim.api.nvim_create_autocmd(
            {'BufRead','BufNewFile','BufEnter'}, {
            pattern = val[1],
            callback = function()
                vim.api.nvim_set_option_value(
                        'filetype',
                        val[2],
                        { buf = ev_buf })
                vim.api.nvim_set_option_value(
                        'fileformat',
                        val[3],
                        { buf = ev_buf })
                vim.treesitter.start()
            end,
        })
    end
end

auto:load()
