local libs = {
    names = {
        "c","c_sharp","lua","vim","vimdoc","query","markdown",
        "markdown_inline","arduino","asm","bash","make","cpp","php",
        "go","http","jinja","javascript","jq","llvm","python",
        "ssh_config","tmux","typescript","yaml"
    },
    started = {}
}

function libs:filetype(ev)
      local er,_ = pcall(function()
          return vim.filetype.match({buf=ev.buf})
      end)
      if er then
          er,_ = pcall(function()
              return vim.filetype.match({filename=ev.file})
          end)
      end
      return er;
end

function libs:start(ev)
    local err,_ = pcall(function()
         vim.treesitter.start(ev.buf)
    end)
    if not err then vim.bo[ev.buf].syntax = 'on' end
    return err
end

function libs:stop(ev)
    vim.treesitter.stop(ev.buf)
end

function libs:setup()
    require ('nvim-treesitter').setup {
        ensure_installed = self.names,

        auto_install = true,
        sync_install = false,

        additional_vim_regex_highlighting = false,

        highlight = { enable = true },
        indent = { enable = true },
    }

    vim.api.nvim_create_user_command("TSInstallAll", function()
      require("nvim-treesitter").install(self.names)
    end, {})

    vim.api.nvim_create_autocmd(
       {'BufEnter','BufRead','BufNew'}, {
           callback = function(ev)
                if not self:filetype(ev) then
                    self:start(ev)
                end
           end
       }
    )

    vim.api.nvim_create_autocmd(
       {'FileType' }, {
           pattern=[[*]],
           callback = function(ev)
               self:start(ev)
           end
       }
    )

    vim.api.nvim_create_autocmd(
        {'BufUnload','BufDelete'}, {
        callback = function(ev)
               self:stop(ev)
        end
        }
    )
    vim.api.nvim_create_autocmd(
    { "UIEnter", "BufReadPost", "BufNewFile" }, {
      group = vim.api.nvim_create_augroup("NvFilePost", { clear = true }),
      callback = function(args)
        local file = vim.api.nvim_buf_get_name(args.buf)
        local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })

        if not vim.g.ui_entered and args.event == "UIEnter" then
          vim.g.ui_entered = true
        end

        if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
          vim.api.nvim_exec_autocmds("User", { pattern = "FilePost", modeline = false })
          vim.api.nvim_del_augroup_by_name "NvFilePost"

          vim.schedule(function()
            vim.api.nvim_exec_autocmds("FileType", {})

            if vim.g.editorconfig then
              require("editorconfig").config(args.buf)
            end
          end)
        end
      end,
    })
end

return libs
