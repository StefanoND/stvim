return {
  "gbprod/yanky.nvim",
  desc = "Better Yank/Paste",
  lazy = false,
  opts = {
    highlight = { timer = 150 },
    textobj = { enabled = true },
  },
  -- keys = require("config.keymaps.yank"),
  keys = require("config.keymaps.yank"),
}
