return {
  {
    "nvim-tree/nvim-web-devicons",
    -- dependencies = { "nvim-tree/nvim-web-devicons" },
    enabled = true,
    lazy = true,
    opts = function()
      local devicons = require("nvim-web-devicons")
      devicons.set_icon_by_filetype({
        nwscript = "nwscript",
      })

      devicons.set_icon({
        nwscript = {
          default = true,
          icon = " ",
          color = "#b4befe",
          cterm_color = "153",
          name = "nwscript",
        },
      })

      return {}
    end,
    config = function(_, opts)
      require("nvim-web-devicons").setup(opts)
    end,
  },
  {
    "echasnovski/mini.icons",
    enabled = true,
    version = false,
    lazy = false,
    priority = 1000,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
    opts = function()
      return {
        file = {
          [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
          ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
          [".eslintrc.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
          [".node-version"] = { glyph = "", hl = "MiniIconsGreen" },
          [".prettierrc"] = { glyph = "", hl = "MiniIconsPurple" },
          [".yarnrc.yml"] = { glyph = "", hl = "MiniIconsBlue" },
          ["eslint.config.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
          ["package.json"] = { glyph = "", hl = "MiniIconsGreen" },
          ["tsconfig.json"] = { glyph = "", hl = "MiniIconsAzure" },
          ["tsconfig.build.json"] = { glyph = "", hl = "MiniIconsAzure" },
          ["yarn.lock"] = { glyph = "", hl = "MiniIconsBlue" },
        },
        filetype = {
          dotenv = { glyph = "", hl = "MiniIconsYellow" },
          nwscript = { glyph = "", hl = "MiniIconsBlue" },
        },
      }
    end,
    config = function(_, opts)
      require("mini.icons").setup(opts)
    end,
  },
}
