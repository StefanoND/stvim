local M = {}

local wk = require("which-key")

M.keymaps = wk.add({
  {
    mode = { "n" },
    { "<localleader>cc", ":Neorg toggle-concealer<CR>", desc = "Neorg toggle concealer" },
    { "<localleader>im", ":Neorg inject-metadata<CR>", desc = "Neorg inject metadata" },
    { "<localleader>gs", ":Neorg generate-workspace-summary<CR>", desc = "Neorg gen ws summary" },
    { "<up>", "<Plug>(neorg.text-objects.item-up)", desc = "Neorg move items up" },
    { "<down>", "<Plug>(neorg.text-objects.item-down)", desc = "Neorg move items down" },
    { "<M-v>", "<Plug>(neorg.esupports.hop.hop-link.vsplit)", desc = "Neorg hop vsplit" },

    -- <C-Space> conflicts with treesitter
    { "<M-space>", "<Plug>(neorg.qol.todo-items.todo.task-cycle)", desc = "Neorg cycle todo tasks" },

    -- gO conflicts with mini
    { "<localleader>gO", "<cmd>Neorg toc<CR>", desc = "Neorg table of contents" },

    -- I'll leave these here in case they stop working again
    -- { "<localleader>cm", "<Plug>(neorg.looking-glass.magnify-code-block)", desc = "" }
    -- { "<localleader>id", "<Plug>(neorg.tempus.insert-date)", desc = "" }

    -- { "<localleader>li", "<Plug>(neorg.pivot.list.invert)", desc = "" }
    -- { "<localleader>lt", "<Plug>(neorg.pivot.list.toggle)", desc = "" }

    -- { "<localleader>ta", "<Plug>(neorg.qol.todo-items.todo.task-ambiguous)", desc = "" }
    -- { "<localleader>tc", "<Plug>(neorg.qol.todo-items.todo.task-cancelled)", desc = "" }
    -- { "<localleader>td", "<Plug>(neorg.qol.todo-items.todo.task-done)", desc = "" }
    -- { "<localleader>th", "<Plug>(neorg.qol.todo-items.todo.task-on-hold)", desc = "" }
    -- { "<localleader>ti", "<Plug>(neorg.qol.todo-items.todo.task-important)", desc = "" }
    -- { "<localleader>tp", "<Plug>(neorg.qol.todo-items.todo.task-pending)", desc = "" }
    -- { "<localleader>tr", "<Plug>(neorg.qol.todo-items.todo.task-recurring)", desc = "" }
    -- { "<localleader>tu", "<Plug>(neorg.qol.todo-items.todo.task-undone)", desc = "" }
  },
  {
    mode = { "o", "x" },
    { "iH", "<Plug>(neorg.text-objects.textobject.heading.inner)", desc = "Neorg inner heading" },
    { "aH", "<Plug>(neorg.text-objects.textobject.heading.outer)", desc = "Neorg outer heading" }
  }
})

return M.keymaps



