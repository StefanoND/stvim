return { -- NWScript
  "StefanoND/nwscript-ee-lsp.nvim",
  enabled = true,
  ft = "nwscript",
  version = false,
  lazy = true,
  dependencies = {
    "HiPhish/rainbow-delimiters.nvim",
    "L3MON4D3/LuaSnip",
    "akinsho/bufferline.nvim",
    "danymat/neogen",
    "folke/which-key.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "echasnovski/mini.icons",
    "stevearc/conform.nvim",
    {
      "StefanoND/vim-nwscript",
      config = function()
        -- Luascript doesn't work, let's use vim.cmd([[]]) to run Vimscript inside it
        vim.cmd([[
          " Whitelist modules
          let g:nwscript#modules#enabled = ['ctags', 'format']
          " Blacklist modules
          let g:nwscript#modules#disabled = ['fold']

          " Auto-wrap (actually auto-newline) comments at column 105
          " Pressing o/O in normal mode will continue a comment block.
          let g:nwscript#format#textwidth = 105
          let g:nwscript#format#options = 'croqwa2lj'

          " Remove trailing whitespace when saving
          let g:nwscript#format#whitespace = 1

          " Must enable 'fold' above
          " let g:nwscript#fold#method = 'syntax'
          " let g:nwscript#fold#level = &foldlevel
          " let g:nwscript#fold#column = 1

          " If you have your own custom options file for generating tags for NWScript files, set the path here
          " let g:nwscript#ctags#file = '/path/to/nwscript.ctags'

          " Extra directories outside your project that will be tagged
          " let g:nwscript#ctags#includes = ['~/.local/share/nwscript']
        ]])
      end,
    },
  },
  config = function()
    require("nwscript").setup()
  end,
}
