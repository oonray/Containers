local auto = {
    files  = {
        {'.*Ansible.*','yaml.ansible','unix'},
        {[[.*\.sh]],'bash','unix'},
        {'.*[Mm]akefile.*','make','unix'},
        {[[.*\.make]],'make','unix'},
        {[[.*\.h]],'c','unix'},
        {[[.*\.c]],'c','unix'},
    },
}

function auto:load()
    for i,val in pairs(self.files)
    do
        vim.api.nvim_create_autocmd(
            {'BufRead','BufNewFile','BuffEnter'}, {
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
            end,
        })
    end
end

auto:load()
