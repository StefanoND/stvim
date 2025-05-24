return {
  "akinsho/toggleterm.nvim",
  version = false,
  opts = function()
    return {}
  end,
  config = function(_, opts)
    require("toggleterm").setup(opts)
  end,
}
