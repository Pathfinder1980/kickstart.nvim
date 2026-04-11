vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    local uproject = vim.fn.glob(vim.fn.getcwd() .. '/*.uproject')
    if uproject ~= '' then
      require('lazy').load { plugins = { 'UnrealDev.nvim' } }
      vim.defer_fn(function()
        vim.cmd 'UDEV start'
        vim.cmd 'UDEV setup'
      end, 1500)
    end
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'cpp', 'c' },
  callback = function()
    vim.keymap.set('n', 'gf', function() require('UEP.api').open_file() end, { noremap = true, silent = true, buffer = true, desc = 'UEP: Open include file' })
    vim.keymap.set(
      'n',
      'gd',
      function() require('UEP.api').goto_definition() end,
      { noremap = true, silent = true, buffer = true, desc = 'UEP: Goto Defintion' }
    )
    vim.keymap.set(
      'n',
      'gi',
      function() require('UEP.api').goto_impl() end,
      { noremap = true, silent = true, buffer = true, desc = 'UEP: Goto Implementation' }
    )
  end,
})

return {
  {
    'taku25/UnrealDev.nvim',
    lazy = true,
    keys = {
      { '<A-o>', '<cmd>UDEV switch<cr>', desc = 'Unreal: Switch Header/Source' },
    },
    dependencies = {
      {
        'taku25/UNL.nvim',
        build = 'cargo build --release --manifest-path scanner/Cargo.toml',
        lazy = false,
      },
      'taku25/UEP.nvim',
      'taku25/UEA.nvim',
      'taku25/UBT.nvim',
      'taku25/UCM.nvim',
      'taku25/ULG.nvim',
      'taku25/USH.nvim',
      {
        'taku25/UNX.nvim',
        dependencies = {
          'MunifTanjim/nui.nvim',
          'nvim-tree/nvim-web-devicons',
        },
      },
      'taku25/UDB.nvim',
      { 'taku25/USX.nvim', lazy = false },
      'nvim-telescope/telescope.nvim',
    },
    config = function(_, opts) require('UnrealDev').setup(opts) end,
    opts = {
      setup_modules = {
        UBT = true,
        UEP = true,
        ULG = true,
        USH = true,
        UCM = true,
        UEA = true,
        UNX = true,
      },
    },
  },
}
