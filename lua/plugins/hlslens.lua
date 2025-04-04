return {
  "kevinhwang91/nvim-hlslens",
  config = function()
    require("hlslens").setup()
    require("config.keymaps.hlslens")
  end,
}
