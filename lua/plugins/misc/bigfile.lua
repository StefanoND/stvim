return {
  "LunarVim/bigfile.nvim",
  enabled = false,
  version = false,
  lazy = false,
  opts = function()
    return {}
  end,
  config = function(_, opts)
    require("bigfile").setup(opts)
  end,
}
