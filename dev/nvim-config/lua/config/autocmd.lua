local v = require("config.vars")

vim.api.nvim_create_autocmd(v.events.buffers, {
    pattern = ".*Ansible.*",
    callback = function()
        vim.api.nvim_set_option_value('filetype', "yaml.ansible", { buf = buf })
        vim.api.nvim_set_option_value('fileformat', 'unix', { buf = buf })
    end,
})

vim.api.nvim_create_autocmd(v.events.buffers, {
    pattern = ".*sh",
    callback = function()
        vim.api.nvim_set_option_value('filetype', "bash", { buf = buf })
        vim.api.nvim_set_option_value('fileformat', 'unix', { buf = buf })
    end,
})

vim.api.nvim_create_autocmd(v.events.buffers, {
    pattern = ".*makefile.*",
    callback = function()
        vim.api.nvim_set_option_value('filetype', "make", { buf = buf })
        vim.api.nvim_set_option_value('fileformat', 'unix', { buf = buf })
    end,
})

vim.api.nvim_create_autocmd(v.events.buffers, {
    pattern = "*.lua.j2",
    callback = function()
        local parser = vim.treesitter.get_parser(bufnr,"jinja",{})
        local tree = parser:parse()[1]:root()
        local query = vim.treesitter.parse_query("jinja","(words) @words")

        vim.api.set_options_value('filetype',"jinja")
        vim.api.nvim_set_hl(0, "@words", { link = "lua" })
    end,
})
