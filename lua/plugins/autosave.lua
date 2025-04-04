return {
  "okuuva/auto-save.nvim",
  version = "*",
  cmd = "ASToggle", -- optional for lazy loading on command
  event = { "InsertLeave", "TextChanged" },
  opts = {
    trigger_events = { -- See :h events
      -- Disabling this, as it's autosaving when leave buffer and autoformatting stuff
      -- when in insert mode and following a tutorial
      -- immediate_save = { "BufLeave", "FocusLost", "QuitPre", "VimSuspend" },
      immediate_save = nil,
    },
    -- function that takes the buffer handle and determines whether to save the current buffer or not
    -- return true: if buffer is ok to be saved
    -- return false: if it's not ok to be saved
    -- if set to `nil` then no specific condition is applied
    condition = function(buf)
      local fn = vim.fn
      local utils = require("auto-save.utils.data")
      -- Don't save for `sql` file types.
      -- When working with dadbod a SQL query executed every time a change is made
      -- Run `:set filetype?` on a dadbod query to make sure of the filetype
      if utils.not_in(fn.getbufvar(buf, "&filetype"), { "mysql" }) then
        return true
      end
      return false
    end,
    -- delay after which a pending save is executed (default 1000)
    debounce_delay = 750,
  }
}
