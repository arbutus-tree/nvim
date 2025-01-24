

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.number = true
vim.opt.relativenumber = true

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- wrapped line repeats indent
vim.opt.breakindent = true

-- save undo history
vim.opt.undofile = true

-- where to open splits
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.scrolloff = 6

-- this expands tabs to spaces. this might be immoral
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- TODO make the timeout faster
vim.keymap.set('i', 'hj', '<esc>', { desc = 'hj chord escape' })
vim.keymap.set('i', 'jh', '<esc>', { desc = 'jh chord escape' })

vim.keymap.set('n', '<leader>fs', ':w<cr>', { desc = 'Save file' })
vim.keymap.set('n', '<leader>fc', ':e ~/.config/nvim/init.lua<cr>', { desc = 'Go to config' })

vim.keymap.set('n', '<leader>wo', '<C-w>o', { desc = 'Close other windows' })
vim.keymap.set('n', '<leader>wq', ':close<cr>', { desc = 'Close current window' })
vim.keymap.set('n', '<leader>wh', '<C-w>h', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<leader>wj', '<C-w>j', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<leader>wk', '<C-w>k', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<leader>wl', '<C-w>l', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<leader>ws', ':sp<cr>', { desc = 'Split horizontal' })
vim.keymap.set('n', '<leader>wv', ':vsp<cr>', { desc = 'Split vertical' })

vim.keymap.set('n', '<leader>bp', ':bp<cr>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<leader>bn', ':bn<cr>', { desc = 'Next buffer' })

function ShowHelpUnderCursor()
  local word = vim.fn.expand("<cword>")  -- Get the word under the cursor
  vim.cmd("help " .. word)  -- Open help for that word
end

vim.keymap.set('n', '<leader>hc', ':lua ShowHelpUnderCursor()<cr>', { desc = 'Shows help for the term under cursor'})



-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { -- file tree
    "nvim-tree/nvim-tree.lua",
    dependencies = {"nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup()
      vim.keymap.set('n', '<leader>fo', ':NvimTreeToggle<cr>')
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "javascript","html", "css", "svelte" },
        highlight = { enable = true },
      })
    end
  }
})

-- idk, needed for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

