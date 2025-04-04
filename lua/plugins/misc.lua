return {
  {
    "mbbill/undotree",
  },
  {
    "mg979/vim-visual-multi",
  },
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      local devicons = require("nvim-web-devicons")

      devicons.set_icon({
        gql = {
          icon = " ",
          color = "#e535ab",
          cterm_color = "199",
          name = "GraphQL",
        },
      })

      devicons.setup()
    end,
  },
  {
    "2kabhishek/nerdy.nvim",
    cmd = "Nerdy",
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
  },
  {
    "ThePrimeagen/vim-be-good",
    config = function()
      require("config.keymaps.vim-be-good")
    end,
  },
  {
    "tpope/vim-repeat",
    lazy = false,
    -- use function to overwrite default event, otherwise it just merges with the default
    -- and `VeryLazy` keeps existing
    event = function()
      return { "BufReadPost", "BufNewFile" }
    end,
  },
  {
    "tpope/vim-abolish",
  },
  {
    "LunarVim/bigfile.nvim",
  },
}
