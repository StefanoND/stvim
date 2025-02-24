local Snacks = require("snacks")
local opts = { noremap = true, silent = true }
local extend = function(desc)
  vim.tbl_deep_extend("force", opts, { desc = desc })
end

local areThereOpennedBuffers = function()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if bufname == "" then
      return true -- There's no opened buffers
    end
  end
  return false -- There's a buffer open
end

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  dependencies = {
    "echasnovski/mini.icons",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    animate = { enabled = false },
    bigfile = {
      enabled = true,
      notify = true, -- show notification when big file detected
      size = 2.5 * 1024 * 1024, -- 2.5MB
    },
    bufdelete = { enabled = false },
    dashboard = { enabled = false },
    debug = { enabled = false },
    dim = { enabled = false },
    explorer = {
      enabled = true,
      replace_netrw = true, -- Replace netrw with the snacks explorer
    },
    git = {
      enabled = true,
    },
    gitbrowse = {
      enabled = true,
      notify = true,
    },
    image = { enabled = true },
    indent = {
      enabled = true,
      chunk = {
        enabled = true,
      },
    },
    input = { enabled = false },
    layout = { enabled = false },
    lazygit = { enabled = true },
    notifier = { enabled = false }, -- Doesn't work well with pomodoro
    notify = { enabled = true },
    picker = {
      enabled = true,
      sources = {
        explorer = {
          auto_close = true,
        },
      },
    },
    profiler = { enabled = true },
    quickfile = { enabled = true },
    rename = { enabled = true },
    scope = { enabled = false },
    scratch = { enabled = true },
    scroll = { enabled = false },
    statuscolumn = {
      enabled = true,
      left = { "fold", "git" }, -- priority of signs on the left (high to low)
      right = { "mark", "sign" }, -- priority of signs on the right (high to low)
      folds = {
        open = true, -- show open fold icons
        git_hl = true, -- use Git Signs hl for fold icons
      },
    },
    terminal = { enabled = false },
    toggle = { enabled = false },
    util = { enabled = true },
    win = { enabled = false },
    words = { enabled = true },
    zen = { enabled = false },
  },
  keys = {
    {
      "<leader>op",
      function()
        Snacks.explorer.open(opts)
      end,
      extend("Open File Explorer"),
    },
    {
      "<leader>gS",
      function()
        Snacks.gitbrowse.open(opts)
      end,
      extend("Open the repository of active file in the browser"),
    },
    {
      "<leader>gl",
      function()
        Snacks.lazygit(opts)
      end,
      extend("Opens lazygit"),
    },
    {
      "<leader>gll",
      function()
        Snacks.lazygit.log(opts)
      end,
      extend("Opens lazygit with the log view"),
    },
    {
      "<leader>glf",
      function()
        Snacks.lazygit.log_file(opts)
      end,
      extend("Opens lazygit with the log of the current file"),
    },
    {
      "<leader>.",
      function()
        Snacks.scratch()
      end,
      extend("Toggle Scratch Buffer"),
    },
    {
      "<leader>S",
      function()
        Snacks.scratch.select()
      end,
      extend("Select Scratch Buffer"),
    },
    {
      "<leader>pps",
      function()
        Snacks.profiler.scratch()
      end,
      extend("Profiler scratch buffer"),
    },
    {
      "<leader>wj",
      function()
        Snacks.words.jump(1, true)
      end,
      extend("Jumps to next reference"),
    },
    {
      "<leader>sp",
      function()
        Snacks.picker()
      end,
      extend("Show all pickers"),
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Disable animations globally
        vim.g.snacks_animate = false

        -- -- Setup some globals for debugging (lazy-loaded)
        -- _G.dd = function(...)
        --   Snacks.debug.inspect(...)
        -- end
        -- _G.bt = function()
        --   Snacks.debug.backtrace()
        -- end
        -- vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        local toggleConceal = { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }
        local toggleBackground = { off = "light", on = "dark", name = "Dark Background" }

        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle.option("conceallevel", toggleConceal):map("<leader>uc")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle.option("background", toggleBackground):map("<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        -- Snacks.toggle.indent():map("<leader>ug")
        -- Snacks.toggle.dim():map("<leader>uD")

        Snacks.toggle.profiler():map("<leader>ppp") -- Toggle the profiler
        Snacks.toggle.profiler_highlights():map("<leader>pph") -- Toggle the profiler highlights

        -- Will open explorer if there's no opened buffers
        if areThereOpennedBuffers() then
          Snacks.explorer.open()
        end
      end,
    })
  end,
}
