local key = {
}

function key:setup(keylist)
    vim.g.mapleader = " " --','
    for _, v in pairs(keylist) do
        if #v == 2 then
        vim.keymap.set(
            "n",
            v[1],
            v[2])
        goto continue
        end
        if #v == 3 then
        vim.keymap.set(
            v[3],
            v[1],
            v[2])
        goto continue
        end
        vim.keymap.set(
            v[3],
            v[1],
            v[2],
            v[4])
        ::continue::
    end
end

return key
