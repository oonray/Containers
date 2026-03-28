local auto = {

}

function auto:ui_load(ev)
  if ev.event == "UIEnter"
  then vim.g.ui_entered=true end
end

function auto:buftype(ev)
   return vim.api.nvim_get_option_value("buftype", { buf = ev.buf })
end

function auto:bufname(ev)
    return vim.api.nvim_buf_get_name(ev.buf)
end

function auto:setup()

   vim.api.nvim_create_autocmd(
      {
         'UIEnter',
         'BufNew',
         'BufNewFile',
         'BufEnter',
         'BufRead',
         'BufWinEnter'
      },
      {
      group = vim.api.nvim_create_augroup("CDev",{ clear = true }),
      pattern = {"*.c","*.h"},
      callback = function(ev)
          vim.bo[ev.buf].filetype = 'c'
      end
      }
   )
   vim.api.nvim_create_autocmd({ 'UIEnter' },
      {
        group = vim.api.nvim_create_augroup("CUI",
          { clear = true }),
        callback = function()
            if not vim.g.ui_entered
            then
                vim.g.ui_entered=true
            end
        end
      }
    )
end

return auto
