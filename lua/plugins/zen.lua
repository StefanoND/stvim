return {
  "mrcapivaro/true-zen.nvim", -- pocco81/true-zen.nvim seems to be unmaintained
  opts = {
    integrations = {
      tmux = true, -- hide tmux status bar in (minimalist, ataraxis)
      kitty = { -- increment font size in Kitty. Note: you must set `allow_remote_control socket-only` and `listen_on unix:/tmp/kitty` in your personal config (ataraxis)
        enabled = true,
        font = "+3", -- Not working
      },
      twilight = false, -- enable twilight (ataraxis)
      lualine = true, -- hide nvim-lualine (ataraxis)
    },
  },
  config = function(_, opts)
    require("true-zen").setup(opts)

    local keymap = vim.keymap.set

    keymap("n", "<leader>zn", ":TZNarrow<CR>", { noremap = true, desc = "Zen Narrow" })
    keymap("v", "<leader>zn", ":'<,'>TZNarrow<CR>", { noremap = true, desc = "Zen Narrow Visual" })
    keymap("n", "<leader>zf", ":TZFocus<CR>", { noremap = true, desc = "Zen Focus" })
    keymap("n", "<leader>zm", ":TZMinimalist<CR>", { noremap = true, desc = "Zen Minimalist" })
    keymap("n", "<leader>za", ":TZAtaraxis<CR>", { noremap = true, desc = "Zen Ataraxis" })
  end,
}
