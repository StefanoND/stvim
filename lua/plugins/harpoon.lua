return { -- fast file access
  "theprimeagen/harpoon",
  branch = "harpoon2",
  requires = {
    { "nvim-lua/plenary.nvim" },
  },
  config = function()
    require("harpoon").setup({
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      },
      settings = {
        save_on_toggle = true,
      },
    })
    require("config.keymaps.harpoon")
  end,
}
