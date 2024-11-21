local pickers = require 'core.plugins.fzf.pickers'

local M = {
  'ibhagwan/fzf-lua',
  -- optional for icon support
  cmd = 'FzfLua',
  lazy = false,
  keys = {
    { '<leader>ff', '<cmd>FzfLua files formatter="path.filename_first"<cr>', desc = 'Fzf files' },
    { '<leader>fF', pickers.folders, desc = 'Fzf files' },
    { '<leader>fc', pickers.command_history, desc = 'Fzf command history' },
    { '<leader>fb', pickers.git_branches, desc = 'Fzf git branches' },
    { '<leader>qf', '<cmd>FzfLua quickfix_stack<cr>', desc = 'Fzf last quickfix lists' },
    { '<leader>fq', '<cmd>FzfLua quickfix<cr>', desc = 'Fzf quickfix' },
    { '<leader>fq', pickers.zoxide, desc = 'Fzf zoxide' },
    { '<leader>fw', pickers.switch_worktree, desc = 'Switch Worktree' },
    { '<leader>fW', pickers.add_worktree, desc = 'Switch Worktree' },
    { '<leader>f<space>', '<cmd>FzfLua resume<cr>', desc = 'Fzf resume search' },

    {
      '<leader>fg',
      function()
        pickers.grep({}, true, false)
      end,
      desc = 'Fzf live grep',
    },
    { '<leader><space>', pickers.buffers_or_recent, desc = 'Fzf open buffers' },
    { '<leader>fF', '<cmd>FzfLua<cr>', desc = 'FzfLua' },
  },
  config = function()
    -- calling `setup` is optional for customization
    require('fzf-lua').setup {
      'fzf-tmux',
      fzf_opts = {
        ['--margin'] = '0,0',
        -- ['--select-1'] = '',
        ['--padding'] = '0',
      },
      git = {
        status = {
          winopts = {
            preview = { vertical = 'down:70%', horizontal = 'right:70%' },
          },
        },
        commits = { winopts = { preview = { vertical = 'down:60%' } } },
        bcommits = { winopts = { preview = { vertical = 'down:60%' } } },
        branches = {
          -- cmd_add = { "git", "checkout", "-b" },
          cmd_del = { 'git', 'branch', '--delete', '--force' },
          -- winopts = {
          --   preview = { vertical = 'down:75%', horizontal = 'right:75%' },
          -- },
        },
      },
    }

    require('fzf-lua').register_ui_select(function(_, items)
      local min_h, max_h = 0.15, 0.70
      local h = (#items + 4) / vim.o.lines
      if h < min_h then
        h = min_h
      elseif h > max_h then
        h = max_h
      end
      return { winopts = { height = h, width = 0.60, row = 0.40 } }
    end)
  end,
}

return M
