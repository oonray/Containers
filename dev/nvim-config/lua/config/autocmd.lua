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
            {'BufEnter','BufRead'}, {
            pattern = {"*.h"},
            callback = function(ev)
                vim.opt.filetype = 'c'
                vim.treesitter.start(ev.buf,'c')
            end
            }
        )
        vim.api.nvim_create_autocmd(
            {'BufEnter','BufRead','BufNew'}, {
            pattern = {"*.c"},
            callback = function(ev)
                vim.opt.filetype = 'c'
                vim.treesitter.start(ev.buf)
            end
            }
        )
        vim.api.nvim_create_autocmd(
            {'BufEnter','BufRead','BufNew'}, {
            pattern = {"*.c"},
            callback = function(ev)
                vim.opt.filetype = 'c'
                vim.treesitter.start(ev.buf)
            end
            }
        )
        vim.api.nvim_create_autocmd(
            {'BufUnload','BufDelete'}, {
            pattern = {"*.c"},
            callback = function(ev)
                vim.treesitter.stop(ev.buf)
            end
            }
        )
end

auto:load()
