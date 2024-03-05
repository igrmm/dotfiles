-- call plugins
vim.call("plug#begin", "~/.config/nvim/plugged")
vim.call("plug#", "lewis6991/gitsigns.nvim")
vim.call("plug#", "dracula/vim")
vim.call("plug#", "shortcuts/no-neck-pain.nvim")
vim.call("plug#", "itchyny/lightline.vim")
vim.call("plug#", "lukas-reineke/indent-blankline.nvim")
vim.call("plug#", "nvim-treesitter/nvim-treesitter", { ["do"] = vim.fn[":TSUpdate"] })
vim.call("plug#", "nvim-treesitter/nvim-treesitter-textobjects")
vim.call("plug#", "j-hui/fidget.nvim")
vim.call("plug#", "vifm/vifm.vim")
vim.call("plug#", "nvim-telescope/telescope-fzf-native.nvim", { ["do"] = vim.fn[":make"] })
vim.call("plug#", "nvim-lua/plenary.nvim")
vim.call("plug#", "nvim-telescope/telescope.nvim")
vim.call("plug#", "neovim/nvim-lspconfig")
vim.call("plug#", "saadparwaiz1/cmp_luasnip")
vim.call("plug#", "L3MON4D3/LuaSnip")
vim.call("plug#", "hrsh7th/cmp-nvim-lsp")
vim.call("plug#", "hrsh7th/nvim-cmp")
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

-- commands
vim.api.nvim_create_user_command("XY", "s/\\.x/\\.y/g | s/>x/>y/g", {})
vim.api.nvim_create_user_command("YX", "s/\\.y/\\.x/g | s/>y/>x/g", {})

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
vim.keymap.set("n", "<leader>e", ":Vifm<CR>")
vim.keymap.set("n", "<leader><leader>", ":Telescope find_files<CR>")
vim.keymap.set("n", "<leader>b", ":Telescope buffers<CR>")
vim.keymap.set("n", "<leader>g", ":Telescope live_grep<CR>")
vim.keymap.set("n", "<leader>t", ":Telescope<CR>")
vim.keymap.set("n", "<leader>n", ":NoNeckPain<CR>")

-- tree-sitter plugin (https://github.com/nvim-treesitter/nvim-treesitter)
require "nvim-treesitter.configs".setup {
    ensure_installed = { "c", "cpp", "lua", "rust", "go", "python" },
    auto_install = true,
    highlight = { enable = true },
    additional_vim_regex_highlighting = false,
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ['aa'] = '@parameter.outer',
                ['ia'] = '@parameter.inner',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
            },
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
                [']p'] = '@parameter.outer',
            },
            goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
            },
            goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer',
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer',
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
                ['<leader>A'] = '@parameter.inner',
            },
        },
    },
}

-- nvim-lspconfig plugin (https://github.com/neovim/nvim-lspconfig)
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>q", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>d", ":Telescope diagnostics<CR>", opts)

local on_attach = function(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
    vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format { async = true } end, bufopts)
    vim.keymap.set("n", "<leader>s", ":Telescope lsp_document_symbols<CR>")
    client.server_capabilities.semanticTokensProvider = nil
end

-- nvim-cmp plugin (https://github.com/hrsh7th/nvim-cmp/)
vim.o.completeopt = "menu,menuone,noselect"
local cmp = require "cmp"
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
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
        { name = "luasnip" },
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

require "lspconfig".pyright.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

require "lspconfig".ruff_lsp.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

-- fidget plugin
require "fidget".setup {}

-- gitsigns plugin
require('gitsigns').setup {
    signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
    },
}
