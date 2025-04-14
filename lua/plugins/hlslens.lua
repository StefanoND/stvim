return {
  "kevinhwang91/nvim-hlslens",
  version = false,
  opts = function()
    return {}
  end,
  config = function(_, opts)
    require("hlslens").setup(opts)
    require("config.keymaps.hlslens")
  end,
}
