local M = {}

local wk = require("which-key")
local harpoon = require("harpoon")

M.keymaps = wk.add({
  mode = { "n" },

  -- { "<leader>m", ":lua require('harpoon.mark').add_file()<CR>", desc = "" },
  {
    "<leader>ha",
    function()
      -- harpoon:list():append()
      harpoon:list():add()
    end,
    desc = "Harpoon add"
  },
  -- { "<leader>ht", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", desc = "" },
  {
    "<leader>ht",
    function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end,
    desc = "Harpoon toggle list"
  },

  {
    "<leader>h1",
    function()
      harpoon:list():select(1)
    end,
    desc = "Harpoon select 1"
  },
  {
    "<leader>h2",
    function()
      harpoon:list():select(2)
    end,
    desc = "Harpoon select 2"
  },
  {
    "<leader>h3",
    function()
      harpoon:list():select(3)
    end,
    desc = "Harpoon select 3"
  },
  {
    "<leader>h4",
    function()
      harpoon:list():select(4)
    end,
    desc = "Harpoon select 4"
  },
  {
    "<leader>h5",
    function()
      harpoon:list():select(5)
    end,
    desc = "Harpoon select 5"
  },
  {
    "<leader>h6",
    function()
      harpoon:list():select(6)
    end,
    desc = "Harpoon select 6"
  },
  {
    "<leader>h7",
    function()
      harpoon:list():select(7)
    end,
    desc = "Harpoon select 7"
  },
  {
    "<leader>h8",
    function()
      harpoon:list():select(8)
    end,
    desc = "Harpoon select 8"
  },
  {
    "<leader>h9",
    function()
      harpoon:list():select(9)
    end,
    desc = "Harpoon select 9"
  },

  -- Toggle previous & next buffers stored within Harpoon list
  {
    "<C-S-P>",
    function()
      harpoon:list():prev()
    end,
    desc = "Harpoon select next"
  },
  {
    "<C-S-N>",
    function()
      harpoon:list():next()
    end,
    desc = "Harpoon select previous"
  },
})

return M.keymaps

