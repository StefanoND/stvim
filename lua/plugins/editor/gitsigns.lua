return {
  "lewis6991/gitsigns.nvim",
  enabled = true,
  event = { "BufReadPre", "BufNewFile" },
  version = false,
  opts = {
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "" },
    },
    signs_staged = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "" },
    },
    signcolumn = true,
    numhl = true,
    on_attach = function(bufnr)
      require("config.keymaps.gitsigns")
    end,
  },
}
