local M = {
    'echasnovski/mini.bufremove',
    event = "VeryLazy",
    opts = {},
    keys = {
        {"<leader>br", "<cmd>MiniBufremove.unshow()", "Remove current buffer"},
    }
},