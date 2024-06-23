local themes = {
  nightfox = {
    'EdenEast/nightfox.nvim',
    config = function()
      require 'core.plugins.themes.nightfox'
    end,
  },
  tundra = {
    'sam4llis/nvim-tundra',
    config = function()
      require 'core.plugins.themes.tundra'
    end,
  },
  tokyonight = {
    'folke/tokyonight.nvim',
    branch = 'main',
    config = function()
      require 'core.plugins.themes.tokyonight'
    end,
  },
  kanagawa = {
    'rebelot/kanagawa.nvim',
    config = function()
      require 'core.plugins.themes.kanagawa'
    end,
  },
  oxocarbon = {
    'nyoom-engineering/oxocarbon.nvim',
    config = function()
      require 'core.plugins.themes.oxocarbon'
    end,
  },
  catppuccin = {
    'catppuccin/nvim',
    name = 'catppuccin',
    config = function()
      require 'core.plugins.themes.catppuccin'
    end,
  },
}

local selectedTheme = themes[vim.g.config.theme.name]
vim.api.nvim_set_hl(0, 'Comment', { italic=true })

return selectedTheme
