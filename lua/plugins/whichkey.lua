return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    require('which-key').setup()

    -- Document existing key chains
    require('which-key').register {
      ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
      ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
      ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
      ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore', b = { name = '[B]uffer' } },
      ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
      ['<leader>h'] = { name = '[H]arpoon', _ = 'which_key_ignore' },
      ['<leader>l'] = { name = '[L]SP', _ = 'which_key_ignore', d = { name = '[D]ocument' }, w = { name = '[W]orksapce' }, c = { name = '[C]ode' } },
      ['<leader>D'] = { name = '[D]ebug', _ = 'which_key_ignore', g = { name = '[G]o' }, u = { name = '[U]I' } },
      ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore', s = { name = '[G]it[S]igns' } },
    }
  end,
}
