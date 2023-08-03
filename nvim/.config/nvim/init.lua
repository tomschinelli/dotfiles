-- ========================================================================== --
-- ==                           EDITOR SETTINGS                            == --
-- ========================================================================== --
vim.opt.number = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 0
vim.opt.expandtab = true

vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
--vim.opt.hlsearch = true
vim.opt.breakindent = true


-- ========================================================================== --
-- ==                             KEYBINDINGS                              == --
-- ========================================================================== --

-- Space as leader key
vim.g.mapleader = ' '

-- Shortcuts
vim.keymap.set({'n', 'x', 'o'}, '<leader>h', '^') -- jump begin line
vim.keymap.set({'n', 'x', 'o'}, '<leader>l', 'g_') -- jump end line
vim.keymap.set('n', '<leader>a', ':keepjumps normal! ggVG<cr>') -- mark all

-- Basic clipboard interaction
vim.keymap.set({'n', 'x'}, 'cp', '"+y') -- copy
vim.keymap.set({'n', 'x'}, 'cv', '"+ip') -- paste

-- Delete text
vim.keymap.set({'n', 'x'}, 'x', '"_x')


-- Commands
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>')
vim.keymap.set('n', '<leader>bq', '<cmd>bdelete<cr>')
vim.keymap.set('n', '<leader>bl', '<cmd>buffer #<cr>')

-- ========================================================================== --
-- ==                               COMMANDS                               == --
-- ========================================================================== --
--
vim.api.nvim_create_user_command('ReloadConfig', 'source $MYVIMRC', {})

--- File explorer
vim.keymap.set('n', '<F2>', '<cmd>Lexplore<cr>')
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 30

-- ========================================================================== --
-- ==                               PLUGINS                                == --
-- ========================================================================== --

local lazy = {}

function lazy.install(path)
  if not vim.loop.fs_stat(path) then
    print('Installing lazy.nvim....')
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      path,
    })
  end
end

function lazy.setup(plugins)
  -- You can "comment out" the line below after lazy.nvim is installed
  lazy.install(lazy.path)

  vim.opt.rtp:prepend(lazy.path)
  require('lazy').setup(plugins, lazy.opts)
end


lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
lazy.opts = {}

lazy.setup({
  {'folke/tokyonight.nvim'},
  {'nvim-lualine/lualine.nvim'},
})


-- ========================================================================== --
-- ==                         PLUGIN CONFIGURATION                         == --
-- ========================================================================== --

---
-- Colorscheme
---
require("tokyonight").setup({
  transparent = true,
  styles = {
    sidebars = "transparent",
    floats = "transparent",
  }
})

vim.opt.termguicolors = true
vim.cmd.colorscheme('tokyonight-night')

---
-- lualine.nvim (statusline)
---
require('lualine').setup({
  options = {
    icons_enabled = true,
    theme = 'tokyonight'
  }
  

})
