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

function libs:setup()
    require ('nvim-treesitter').setup {
        ensure_installed = self.names,

        auto_install = true,
        sync_install = false,

        additional_vim_regex_highlighting = false,

        highlight = { enable = true },
        indent = { enable = true },
    }

    vim.o.foldexpr   = "v:lua.vim.treesitter.foldexpr()"
    vim.o.foldmethod = "expr"
    vim.o.foldlevel  = 99
    vim.o.foldlevelstart  = 99

    vim.api.nvim_create_user_command("TSInstallAll", function()
      require("nvim-treesitter").install(self.names)
    end, {})

    vim.api.nvim_create_user_command("TSstart", function()
             pcall(vim.treesitter.start)
    end, {})

    vim.api.nvim_create_user_command("TSstop", function()
             pcall(vim.treesitter.stop)
    end, {})

    vim.api.nvim_create_autocmd(
       {'FileType' },
       {
        group = vim.api.nvim_create_augroup("TS",
            { clear = true }),
        callback = function()
          pcall(vim.treesitter.start)
        end
       }
    )

    vim.api.nvim_create_autocmd(
        {'BufDelete'},
        {
        group = vim.api.nvim_create_augroup("TS",
            { clear = true }),
        callback = function()
             pcall(vim.treesitter.stop)
        end
        }
    )

   vim.api.nvim_create_autocmd(
      {
         'BufNew',
         'BufNewFile',
         'BufEnter',
         'BufReadPost'
      },
      {
      group = vim.api.nvim_create_augroup("TS",
          { clear = true }),
      callback = function(ev)
            if ev.file == "" then return end
            if vim.bo[ev.buf].buftype == "nofile" then return end
            if not vim.g.ui_entered then return end

            vim.api.nvim_exec_autocmds('User',{})
            pcall(vim.treesitter.start)
      end
      }
    )
end

return libs
