local MIN_IN_MS = 60000

return {
  {
    "quentingruber/pomodoro.nvim",
    lazy = false, -- needed so the pomodoro can start at launch
    config = function()
      local pomodoro = require("pomodoro")

      pomodoro.setup({
        start_at_launch = false,
        work_duration = 25,
        break_duration = 5,
        delay_duration = 1, -- The additionnal work time you get when you delay a break
        long_break_duration = 15,
        breaks_before_long = 4,
      })

      local opts = { silent = true, noremap = true }

      -- Pomodoro Stop
      vim.keymap.set("n", "<leader>pui", function()
        pomodoro.displayPomodoroUI()
      end, opts)
      vim.keymap.set("n", "<leader>pS", function()
        pomodoro.stop()
      end, opts)

      -- Pomodoro 25/5 minutes work/break
      vim.keymap.set("n", "<leader>pow", function()
        pomodoro.start(25)
      end, opts)
      vim.keymap.set("n", "<leader>pob", function()
        pomodoro.startBreak(5)
      end, opts)

      -- DeskTime's 52/17 minutes work/break
      vim.keymap.set("n", "<leader>pdw", function()
        pomodoro.start(50)
      end, opts)
      vim.keymap.set("n", "<leader>pdb", function()
        pomodoro.startBreak(10)
      end, opts)

      -- DeskTime's updated 112/26 minutes work/break
      vim.keymap.set("n", "<leader>puw", function()
        pomodoro.start(100)
      end, opts)
      vim.keymap.set("n", "<leader>pub", function()
        pomodoro.startBreak(20)
      end, opts)
    end,
  },
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   optional = true,
  --   event = "VeryLazy",
  --   opts = function(_, opts)
  --     table.insert(opts.sections.lualine_x, 3, {
  --       function()
  --         return require("pomodoro").get_pomodoro_status("🍅❌", "🍅", "☕")
  --       end,
  --     })
  --   end,
  -- },
}

-- return {
--   "epwalsh/pomo.nvim",
--   version = "*",
--   lazy = false,
--   cmd = { "TimerStart", "TimerRepeat" },
--   config = function()
--     local pomodoro = require("pomo")
--
--     local opts = { silent = true, noremap = true }
--     local snacks = require("snacks")
--
--     -- Pomodoro Hide/Show/Stop
--     vim.keymap.set("n", "<leader>ph", "<cmd>TimerHide<CR>", opts)
--     vim.keymap.set("n", "<leader>ps", "<cmd>TimerShow<CR>", opts)
--     vim.keymap.set("n", "<leader>pS", "<cmd>TimerStop<CR>", opts)
--
--     -- Pomodoro 25/5 minutes work/break
--     vim.keymap.set("n", "<leader>pow", "<cmd>TimerStart 25m work<CR>", opts)
--     vim.keymap.set("n", "<leader>pob", "<cmd>TimerStart 5m break<CR>", opts)
--
--     -- DeskTime's 52/17 minutes work/break
--     vim.keymap.set("n", "<leader>pdw", "<cmd>TimerStart 50m work<CR>", opts)
--     vim.keymap.set("n", "<leader>pdb", "<cmd>TimerStart 10m break<CR>", opts)
--
--     -- DeskTime's updated 112/26 minutes work/break
--     vim.keymap.set("n", "<leader>puw", "<cmd>TimerStart 100m work<CR>", opts)
--     vim.keymap.set("n", "<leader>pub", "<cmd>TimerStart 20m break<CR>", opts)
--
--     pomodoro.setup({
--       -- How often the notifiers are updated.
--       update_interval = 1000,
--
--       -- Configure the default notifiers to use for each timer.
--       -- You can also configure different notifiers for timers given specific names, see
--       -- the 'timers' field below.
--       notifiers = {
--         -- The "Default" notifier uses 'vim.notify' and works best when you have 'nvim-notify' installed.
--         {
--           name = "Default",
--           opts = {
--             -- With 'nvim-notify', when 'sticky = true' you'll have a live timer pop-up
--             -- continuously displayed. If you only want a pop-up notification when the timer starts
--             -- and finishes, set this to false.
--             sticky = true,
--
--             -- Configure the display icons:
--             title_icon = "󱎫",
--             text_icon = "󰄉",
--             -- Replace the above with these if you don't have a patched font:
--             -- title_icon = "⏳",
--             -- text_icon = "⏱️",
--           },
--         },
--
--         -- The "System" notifier sends a system notification when the timer is finished.
--         -- Currently this is only available on MacOS.
--         -- Tracking: https://github.com/epwalsh/pomo.nvim/issues/3
--         -- { name = "System" },
--
--         -- You can also define custom notifiers by providing an "init" function instead of a name.
--         -- See "Defining custom notifiers" below for an example 👇
--         -- { init = function(timer) ... end }
--       },
--
--       -- Override the notifiers for specific timer names.
--       timers = {
--         -- For example, use only the "System" notifier when you create a timer called "Break",
--         -- e.g. ':TimerStart 2m Break'.
--         Break = {
--           -- { name = "System" },
--           { name = "Default" },
--         },
--       },
--     })
--   end,
-- }
