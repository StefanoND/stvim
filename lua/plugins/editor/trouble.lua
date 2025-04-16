return {
  "folke/trouble.nvim",
  enabled = true,
  version = false,
  dependencies = { "echasnovski/mini.icons" },
  cmd = "Trouble",
  keys = require("config.keymaps.trouble"),
  config = true,
}
