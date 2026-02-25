local auto = {
}

function auto:load()
        vim.api.nvim_create_autocmd(
           {'BufEnter','BufRead','BufNew'}, {
            pattern=[[.*\..*]],
            callback = function(ev)
                pcall(vim.filetype.match,{buf=ev.buf})
                vim.opt.fileformat = 'unix'
            end
            }
        )
        vim.api.nvim_create_autocmd(
            {'BufEnter','BufRead','BufNew'}, {
            pattern = {[[.*\.h]],[[.*\.c]]},
            callback = function()
                vim.opt.filetype = 'c'
            end
            }
        )
end

auto:load()
