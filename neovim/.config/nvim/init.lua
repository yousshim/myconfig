-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        {
            dir = os.getenv("HOME") .. "/git/99",
            config = function()
                local _99 = require("99")

                local cwd = vim.uv.cwd()
                local basename = vim.fs.basename(cwd)
                _99.setup({
                    model = "opencode/claude-haiku-4-5",
                    logger = {
                        level = _99.DEBUG,
                        path = "/tmp/" .. basename .. ".99.debug",
                        print_on_error = true,
                        type = "file",
                    },
                    md_files = {
                        "AGENT.md",
                    },
                })

                vim.keymap.set("n", "<leader>9f", function()
                    _99.fill_in_function()
                end)

                vim.keymap.set("v", "<leader>9v", function()
                    _99.visual()
                end)

                vim.keymap.set("v", "<leader>9s", function()
                    _99.stop_all_requests()
                end)
            end,
        },
        {
            'saghen/blink.cmp',
            version = '1.*',
            opts = {
                keymap = { preset = 'default' },
                completion = { documentation = { auto_show = false } },
                sources = {
                    default = { 'lsp', 'path', 'snippets', 'buffer' },
                },
                fuzzy = { implementation = "prefer_rust_with_warning" }
            },
            opts_extend = { "sources.default" }
        },
        {
            'stevearc/oil.nvim',
            ---@module 'oil'
            ---@type oil.SetupOpts
            opts = {},
            dependencies = {
                {
                    "nvim-mini/mini.icons",
                    opts = {}
                }
            },
            lazy = false,
            keys = {
                { "-", "<CMD>Oil<CR>", desc = "Open oil directory editor" },
            },
        },
        {
            "ibhagwan/fzf-lua",
            dependencies = {
                {
                    "nvim-mini/mini.icons",
                    opts = {}
                }
            },
            ---@module "fzf-lua"
            ---@type fzf-lua.Config|{}
            ---@diagnostic disable: missing-fields
            opts = {},
            keys = {
                { "<leader>ff", "<CMD>FzfLua files<CR>", desc = "Fuzzy find files" },
                { "<leader>fc", function() require("fzf-lua").files({ cwd = vim.fn.stdpath("config") }) end, desc = "Fuzzy find config files" },
                { "<leader>fg", "<CMD>FzfLua grep<CR>", desc = "Fuzzy find grep" },
                { "<leader>fh", "<CMD>FzfLua helptags<CR>", desc = "Fuzzy find help tags" },
            },

        },
        {
            "supermaven-inc/supermaven-nvim",
            event = "InsertEnter",
            cmd = {
                "SupermavenUseFree",
            },
            opts = {},
        },
        {
            "catppuccin/nvim",
            name = "catppuccin",
            priority = 1000,
            config = function()
                vim.cmd.colorscheme('catppuccin')
            end
        },
    },
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'typescript', 'zig' },
    callback = function()
        vim.treesitter.start()
    end,
})


vim.opt.shiftwidth=4
vim.opt.tabstop=4
vim.opt.expandtab=true
vim.opt.softtabstop = 4
vim.opt.number=true
vim.opt.signcolumn="yes"
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
vim.opt.undofile = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.termguicolors = true



vim.lsp.enable("tsserver")
vim.lsp.enable("zls")
vim.lsp.enable("pyrefly")
vim.lsp.enable("luals")
