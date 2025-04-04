local wk = require("which-key")

wk.add({
    { -- Visual mode only
      mode = { "v" },
      -- { keymap, function, desc = "" },
    },
    { -- Normal mode only
      mode = { "n" },

      -- Tmux
      { "<M-Left>", "<cmd>TmuxNavigateLeft<CR>", desc = "Move to left window" },
      { "<M-Down>", "<cmd>TmuxNavigateDown<CR>", desc =  "Move to Down window" },
      { "<M-Up>", "<cmd>TmuxNavigateUp<CR>", desc =  "Move to Up window" },
      { "<M-Right>", "<cmd>TmuxNavigateRight<CR>", desc =  "Move to right window" }
    },
})

