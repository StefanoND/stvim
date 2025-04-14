return {
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    version = false,
    config = true,
  },
  {
    "catgoose/nvim-colorizer.lua",
    version = false,
    opts = function()
      return {
        lazy_load = true,
        user_default_options = {
          tailwind = true,
        },
      }
    end,
    config = function(_, opts)
      require("colorizer").setup(opts)
    end,
  },
}
