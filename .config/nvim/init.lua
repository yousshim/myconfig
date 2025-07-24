-- Basic settings
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.number = true  -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers

vim.opt.tabstop = 4    -- Number of spaces a tab equals
vim.opt.softtabstop = 4 -- Number of spaces in one tab when editing
vim.opt.shiftwidth = 4  -- Number of spaces to use for autoindenting
vim.opt.expandtab = true   -- Tabs are space

vim.opt.autoindent = true    -- Auto indent new lines
vim.opt.smartindent = true   -- Enable smart indent

vim.opt.wrap = false       -- Disable line wrapping
vim.opt.linebreak = true   -- Break lines at word boundaries

vim.opt.swapfile = false   -- Disable swap file
vim.opt.backup = false     -- Disable backups
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
vim.opt.undofile = true    -- Enable persistent undo

vim.opt.hlsearch = true    -- Highlight search results
vim.opt.incsearch = true   -- Do incremental searching

vim.opt.termguicolors = true -- Enable 24-bit colors

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

-- Setup lazy.nvim
require("lazy").setup({
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme "catppuccin"
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        branch = 'master',
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require'nvim-treesitter.configs'.setup {
                ensure_installed = { "lua", "java", "go", "typescript", "bash" },
                highlight = {
                    enable = true,
                }
            }
        end
    },
    {
      'saghen/blink.cmp',
      -- use a release tag to download pre-built binaries
      version = '1.*',
      opts = {
        sources = {
          default = { 'lsp' },
        },
      },
      opts_extend = { "sources.default" }
    },
    {
      "supermaven-inc/supermaven-nvim",
      config = function()
        require("supermaven-nvim").setup({})
      end,
    },
    {
        'echasnovski/mini.pairs',
        version = '*',
        opts = {}
    },
})


vim.lsp.config['gopls'] = {
    cmd = { 'gopls' },
    filetypes = { 'go' },
    root_markers = { 'go.mod', '.git' }
}
vim.lsp.enable('gopls')

vim.lsp.config['tsserver'] = {
    cmd = { 'typescript-language-server', '--stdio' },
    filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
    root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },
}
vim.lsp.enable('tsserver')

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        vim.api.nvim_create_autocmd('BufWritePre', {
            callback = function(ev)
                vim.lsp.buf.format()
            end
        })
    end
})
