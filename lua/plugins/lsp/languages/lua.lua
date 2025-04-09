return { -- LUA
  "folke/lazydev.nvim",
  dependencies = {
    "Bilal2453/luvit-meta", -- optional `vim.uv` typings
  },
  ft = "lua", -- only load on lua files
  cmd = "LazyDev",
  opts = {
    library = {
      -- See the configuration section for more details
      -- Load luvit types when the `vim.uv` word is found
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      -- { path = "luvit-meta/library", words = { "vim%.uv" } },
      -- { path = "LazyVim", words = { "LazyVim" } },
      "LazyVim",
      { path = "snacks.nvim", words = { "Snacks" } },
    },
  },
}
