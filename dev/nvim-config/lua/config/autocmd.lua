local v = require("config.vars")

local ev_buf = {'BufRead','BufNewFile'}
local files  = {
    {'.*Ansible.*','yaml.ansible','unix'},
    {[[.*\.sh]],'bash','unix'},
    {'.*[Mm]akefile.*','make','unix'},
    {[[.*\.make]],'make','unix'},
}

local libs = {
        [[c]],[[c_sharp]],[[lua]],[[vim]],
        [[vimdoc]],[[query]],[[markdown]],
        [[markdown_inline]],[[arduino]],[[asm]],
        [[bash]],[[make]],[[cpp]],[[php]],
        [[go]],[[http]],[[jinja]],[[javascript]],[[jq]],
        [[llvm]],[[python]],
        [[ssh_config]],[[tmux]],[[typescript]],[[yaml]]}

for i,val in pairs(files)
do
vim.api.nvim_create_autocmd(ev_buff, {
    pattern = val[0],
    callback = function()
        vim.api.nvim_set_option_value(
                'filetype',
                val[1],
                { buf = ev_buf })
        vim.api.nvim_set_option_value(
                'fileformat',
                val[2],
                { buf = ev_buf })
    end,
})
end
