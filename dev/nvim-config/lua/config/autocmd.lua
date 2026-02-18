local auto = {
}

function auto:load()
        vim.api.nvim_create_autocmd(
            {'BufEnter'}, {
            callback = function()
                vim.opt.fileformat = 'unix'
            end
            }
        )
        vim.api.nvim_create_autocmd(
            {'BufEnter'}, {
            pattern = {"*.h","*.c"},
            callback = function(ev)
                vim.opt.filetype = 'c'
                vim.treesitter.start(ev.buf,'c')
            end
            }
        )
end

auto:load()
