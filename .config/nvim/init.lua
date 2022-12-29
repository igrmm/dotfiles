-- call plugins
vim.call("plug#begin", "~/.config/nvim/plugged")
vim.call("plug#", "dracula/vim")
vim.call("plug#", "itchyny/lightline.vim")
vim.call("plug#", "junegunn/fzf.vim")
vim.call("plug#", "lukas-reineke/indent-blankline.nvim")
vim.call("plug#", "nvim-treesitter/nvim-treesitter", { ["do"] = vim.fn[":TSUpdate"] })
vim.call("plug#", "j-hui/fidget.nvim")
vim.call("plug#", "neovim/nvim-lspconfig")
vim.call("plug#", "hrsh7th/cmp-nvim-lsp")
vim.call("plug#", "hrsh7th/cmp-buffer")
vim.call("plug#", "hrsh7th/cmp-path")
vim.call("plug#", "hrsh7th/cmp-cmdline")
vim.call("plug#", "hrsh7th/nvim-cmp")
vim.call("plug#", "hrsh7th/cmp-vsnip")
vim.call("plug#", "hrsh7th/vim-vsnip")
vim.call("plug#end")

-- config plugins
vim.o.termguicolors = true
vim.cmd "colorscheme dracula"
vim.g["lightline"] = { colorscheme = "dracula" }

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

-- maps
vim.g.mapleader = " "
vim.keymap.set("n", "<C-_>", ":bd<CR>")
vim.keymap.set("v", "<C-c>", "\"+y")
vim.keymap.set("n", "<C-p>", "\"+P")
vim.keymap.set("n", "<leader>f", ":Files<CR>")
vim.keymap.set("n", "<leader>b", ":Buffers<CR>")

-- tree-sitter plugin (https://github.com/nvim-treesitter/nvim-treesitter)
require "nvim-treesitter.configs".setup {
    ensure_installed = { "c", "cpp", "lua", "rust", "go" },
    auto_install = true,
    highlight = { enable = true },
    additional_vim_regex_highlighting = false,
}

-- nvim-lspconfig plugin (https://github.com/neovim/nvim-lspconfig)
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>d", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set("n", "<space>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
    vim.keymap.set("n", "<space>f", function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- nvim-cmp plugin (https://github.com/hrsh7th/nvim-cmp/)
vim.o.completeopt = "menu,menuone,noselect"
local cmp = require "cmp"
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    window = {
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "vsnip" },
    }, {
        { name = "buffer" },
    })
})
local capabilities = require "cmp_nvim_lsp".default_capabilities()

-- call lsp servers
require "lspconfig".clangd.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

require "lspconfig".sumneko_lua.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
}

-- fidget plugin
require "fidget".setup {}
