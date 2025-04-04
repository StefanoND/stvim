return { -- fast file access
  "theprimeagen/harpoon",
  branch = "harpoon2",
  requires = {
    { "nvim-lua/plenary.nvim" },
  },
  config = function()
    require("harpoon").setup()
    require("config.keymaps.harpoon")
  end,
}
