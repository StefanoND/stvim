return {
  "gbprod/yanky.nvim",
  version = false,
  desc = "Better Yank/Paste",
  lazy = false,
  opts = {
    highlight = { timer = 150 },
    textobj = { enabled = true },
    system_clipboard = { clipboard_register = true },
  },
  keys = require("config.keymaps.yank"),
}
