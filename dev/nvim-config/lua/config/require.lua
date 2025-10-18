local req = {
    dap = {
        dap=	require("dap"),
        ui=	require("dapui"),
        go=	require("dap-go"),
        mason=	require("mason-nvim-dap"),
    },
    tls = {
        tls=		require("telescope"),
        builtin=	require("telescope.builtin"),
    },
    sess=	require("sessions"),
    ws=		require("workspaces"),
    lsp ={
        zero=	require('lsp-zero'),
        conf=	vim.lsp.config,
        mason={
            mason=	require("mason"),
            lsp=	require("mason-lspconfig")
        },
    },
    cmp = {
        cmp=	require('cmp'),
        lsp=	require('cmp_nvim_lsp'),
    },
}

return req
