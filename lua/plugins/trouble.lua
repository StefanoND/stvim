return {
  "folke/trouble.nvim",
  version = false,
  dependencies = { "echasnovski/mini.nvim" },
  cmd = "Trouble",
  keys = require("config.keymaps.trouble"),
  config = true,
}
