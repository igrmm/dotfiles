vim.call("plug#begin", "~/.config/nvim/plugged")

-- simple plugins
vim.call("plug#", "lewis6991/gitsigns.nvim")
vim.call("plug#", "dracula/vim")
vim.call("plug#", "shortcuts/no-neck-pain.nvim")
vim.call("plug#", "itchyny/lightline.vim")
vim.call("plug#", "j-hui/fidget.nvim")

-- plugin used to jump between functions
vim.call("plug#", "nvim-treesitter/nvim-treesitter-textobjects", { ["branch"] = "main" })

-- telescope plugin
vim.call("plug#", "nvim-telescope/telescope-fzf-native.nvim", { ["do"] = vim.fn[":make"] })
vim.call("plug#", "nvim-lua/plenary.nvim")
vim.call("plug#", "nvim-telescope/telescope.nvim")

-- plugin for completion engine
vim.call("plug#", "saghen/blink.cmp", { ["tag"] = "v1.*" })

-- this plugin makes some basic lsp config automatically (clangd, lua_ls etc)
vim.call("plug#", "neovim/nvim-lspconfig")

-- use this plugin to download parsers for syntax highlight
-- TSInstall c or TSInstall cpp etc
-- vim.call("plug#", "nvim-treesitter/nvim-treesitter", { ["branch"] = "main" })

vim.call("plug#end")

-- config colorscheme plugin
vim.o.termguicolors = true
vim.cmd "colorscheme dracula"
vim.g["lightline"] = { colorscheme = "dracula" }

-- sets bg color in hover window because dracula theme doesnt fully support nvim
vim.cmd "highlight! link NormalFloat DraculaBgDark"

-- remove trailing whitespaces
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*" },
    command = [[%s/\s\+$//e]],
})

-- basic config
vim.o.number = true
vim.o.relativenumber = true
vim.o.clipboard = "unnamedplus"
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.breakindent = true
vim.o.hlsearch = false

-- maps
vim.g.mapleader = " "
vim.keymap.set("n", "<C-b>", ":bd<CR>")
vim.keymap.set("v", "<C-c>", "\"+y")
vim.keymap.set("n", "<C-p>", "\"+P")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<leader><leader>", ":Telescope find_files<CR>")
vim.keymap.set("n", "<leader>b", ":Telescope buffers<CR>")
vim.keymap.set("n", "<leader>g", ":Telescope live_grep<CR>")
vim.keymap.set("n", "<leader>t", ":Telescope<CR>")
vim.keymap.set("n", "<leader>n", ":NoNeckPain<CR>")

-- highlight (uses bultin treesitter + parsers by nvim-treesitter
-- check highlight with :Inspect on a symbol
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp", "python", "lua" },
    callback = function() vim.treesitter.start() end,
})

-- tree-sitter-textobjects plugin (https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
vim.keymap.set({ "n", "x", "o" }, "]f", function()
    require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
    local keys = vim.api.nvim_replace_termcodes("zz", true, false, true)
    vim.api.nvim_feedkeys(keys, "n", false)
end)
vim.keymap.set({ "n", "x", "o" }, "[f", function()
    require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
    local keys = vim.api.nvim_replace_termcodes("zz", true, false, true)
    vim.api.nvim_feedkeys(keys, "n", false)
end)
vim.keymap.set({ "x", "o" }, "if", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
end)
vim.keymap.set("n", "<Tab>", function()
    require("nvim-treesitter-textobjects.move").goto_next_start("@parameter.inner")
end)
vim.keymap.set("n", "<S-Tab>", function()
    require("nvim-treesitter-textobjects.move").goto_previous_start("@parameter.inner")
end)

-- config and call LSP servers
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local opts = { noremap = true, silent = true, buf = ev.buf }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format { async = true } end, opts)
        vim.keymap.set("n", "<leader>s", ":Telescope lsp_document_symbols<CR>")
        vim.keymap.set("n", "<leader>q", vim.diagnostic.open_float)
        vim.keymap.set("n", "<leader>d", ":Telescope diagnostics<CR>")
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        client.server_capabilities.semanticTokensProvider = nil
    end,
})

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
        },
    },
})

vim.lsp.enable({ "clangd", "pyright", "lua_ls" })

-- blink.cmp plugin (https://github.com/saghen/blink.cmp)
require("blink.cmp").setup({
    keymap = {
        ["<CR>"] = { "select_and_accept", "fallback" },
    }
})

-- fidget plugin (https://github.com/j-hui/fidget.nvim)
require("fidget").setup {}

-- gitsigns plugin (github.com/lewis6991/gitsigns.nvim)
require("gitsigns").setup {
    signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
    },
    vim.keymap.set("n", "]g", function() require("gitsigns").nav_hunk("next") end),
    vim.keymap.set("n", "[g", function() require("gitsigns").nav_hunk("prev") end)
}
