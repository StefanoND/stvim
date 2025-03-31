local Snacks = require("snacks")
local opts = { noremap = true, silent = true }
local extend = function(desc)
  vim.tbl_deep_extend("force", opts, { desc = desc })
end

local shouldOpenExplorer = function()
  local bufname = vim.api.nvim_buf_get_name(0)
  if bufname:match("^%a+://") or bufname == "" then
    return true -- There's no opened buffers, open explorer
  end
  return false -- There's a buffer open, don't open explorer
end

local openExplorer = function()
  vim.cmd([[lua require("snacks").explorer.open()]])
end

local checkOpenExplorer = function()
  if shouldOpenExplorer() then
    openExplorer()
  end
end

local winNumbers = {
  list = {
    wo = {
      number = true,
      relativenumber = true,
    },
  },
}

local vars = require("config.vars")

local hls = {
  "RainbowDelimiterRed",
  "RainbowDelimiterYellow",
  "RainbowDelimiterBlue",
  "RainbowDelimiterOrange",
  "RainbowDelimiterGreen",
  "RainbowDelimiterViolet",
  "RainbowDelimiterCyan",
}

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
      size = vars.maxFileSize,
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
      enabled = false,
    },
    gitbrowse = {
      enabled = false,
      notify = true,
    },
    image = { enabled = true },
    indent = {
      enabled = true,
      hl = hls,
      scope = {
        hl = hls,
      },
      chunk = {
        enabled = true,
        char = {
          corner_top = "╭",
          corner_bottom = "╰",
        },
        hl = hls,
      },
    },
    input = {
      enabled = true,
      icon = " ",
      icon_hl = "SnacksInputIcon",
      icon_pos = "left",
      prompt_pos = "title",
      win = { style = "input" },
      expand = true,
    },
    layout = { enabled = false },
    lazygit = { enabled = true },
    notifier = {
      enabled = true,
      margin = { top = 1, right = 1, bottom = 1 },
      top_down = false, -- place notifications from top to bottom
    }, -- Doesn't work well with pomodoro
    notify = { enabled = true },
    picker = {
      enabled = true,
      formatters = {
        file = {
          truncate = 80,
        },
      },
      sources = {
        explorer = {
          auto_close = true,
          hidden = true,
          ignored = true,
          follow = true,
          show_empty = true,
          -- exclude = {
          --   "node_modules",
          --   "Utilities/omnisharp*",
          --   ".git",
          --   "dist",
          --   "lazy-lock.json",
          --   ".nasher",
          -- },
          win = winNumbers,
        },
        files = {
          cmd = "rg",
          hidden = true,
          ignored = true,
          follow = true,
          show_empty = true,
          exclude = {
            "node_modules",
            "Utilities/omnisharp*",
            ".git",
            "dist",
            "lazy-lock.json",
            ".nasher",
          },
          win = winNumbers,
        },
        grep = {
          hidden = true,
          ignored = true,
          follow = true,
          show_empty = true,
          exclude = {
            "node_modules",
            "Utilities/omnisharp*",
            ".git",
            "dist",
            "lazy-lock.json",
            ".nasher",
          },
          win = winNumbers,
        },
        register = {
          finder = "vim_registers",
          format = "register",
          preview = "preview",
          confirm = { "copy", "close" },
        },
      },
    },
    profiler = { enabled = true },
    quickfile = { enabled = true },
    rename = { enabled = true },
    scope = { enabled = true },
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
      git = {
        patterns = { "GitSign", "GitSigns", "MiniDiffSign" },
      },
    },
    terminal = { enabled = true },
    toggle = { enabled = true },
    util = { enabled = true },
    win = { enabled = false },
    words = { enabled = true },
    zen = { enabled = false },
  },
  keys = {
    -- Registers
    {
      '<leader>s"',
      function()
        Snacks.picker.registers()
      end,
      desc = "Registers",
    },
    -- Terminal
    {
      "<leader>tt",
      function()
        Snacks.terminal.toggle()
      end,
      desc = "Toggle terminal",
    },
    -- Explorer
    {
      "<leader>op",
      function()
        Snacks.explorer.open(opts)
      end,
      extend("Open File Explorer"),
    },
    -- Find
    {
      "<leader>ff",
      function()
        Snacks.picker.files()
      end,
      desc = "Find Files",
    },
    {
      "<leader>fs",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep",
    },
    {
      "<leader>fd",
      function()
        Snacks.picker.diagnostics()
      end,
      desc = "Diagnostics",
    },
    {
      "<leader>fD",
      function()
        Snacks.picker.diagnostics_buffer()
      end,
      desc = "Buffer Diagnostics",
    },
    {
      "<leader>fb",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Buffers",
    },
    {
      "<leader>fh",
      function()
        Snacks.picker.help()
      end,
      desc = "Help Pages",
    },
    {
      "<leader>fgf",
      function()
        Snacks.picker.git_files()
      end,
      desc = "Find Git Files",
    },
    {
      "<leader>fm",
      function()
        Snacks.picker.marks()
      end,
      desc = "Marks",
    },
    {
      "<leader>fps",
      function()
        Snacks.picker.lsp_symbols()
      end,
      desc = "LSP Symbols",
    },
    {
      "<leader>fws",
      function()
        Snacks.picker.lsp_workspace_symbols()
      end,
      desc = "LSP Workspace Symbols",
    },
    { "<leader>fn", ":Nerdy<CR>", desc = "Open Nerdfonts Glyphs" },

    -- Git
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

    -- Scratch
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

    -- Profiler
    {
      "<leader>pps",
      function()
        Snacks.profiler.scratch()
      end,
      extend("Profiler scratch buffer"),
    },

    -- Words
    {
      "<leader>wj",
      function()
        Snacks.words.jump(1, true)
      end,
      extend("Jumps to next reference"),
    },

    -- Picker
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

        -- Create some toggle mappings
        local toggleConceal = { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }
        local toggleBackground = { off = "light", on = "dark", name = "Dark Background" }

        Snacks.toggle.line_number():map("<leader>ul")

        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        -- Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        -- Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.option("conceallevel", toggleConceal):map("<leader>uc")
        -- Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle.option("background", toggleBackground):map("<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>th")
        -- Snacks.toggle.indent():map("<leader>ug")
        -- Snacks.toggle.dim():map("<leader>uD")

        Snacks.toggle.profiler():map("<leader>ppp") -- Toggle the profiler
        Snacks.toggle.profiler_highlights():map("<leader>pph") -- Toggle the profiler highlights

        vim.cmd([[silent !tmux set status off]])
        checkOpenExplorer()
      end,
    })

    ---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
    local progress = vim.defaulttable()
    vim.api.nvim_create_autocmd("LspProgress", {
      ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
        if not client or type(value) ~= "table" then
          return
        end
        local p = progress[client.id]

        for i = 1, #p + 1 do
          if i == #p + 1 or p[i].token == ev.data.params.token then
            p[i] = {
              token = ev.data.params.token,
              msg = ("[%3d%%] %s%s"):format(
                value.kind == "end" and 100 or value.percentage or 100,
                value.title or "",
                value.message and (" **%s**"):format(value.message) or ""
              ),
              done = value.kind == "end",
            }
            break
          end
        end

        local msg = {} ---@type string[]
        progress[client.id] = vim.tbl_filter(function(v)
          return table.insert(msg, v.msg) or not v.done
        end, p)

        local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
        vim.notify(table.concat(msg, "\n"), "info", {
          id = "lsp_progress",
          title = client.name,
          opts = function(notif)
            notif.icon = #progress[client.id] == 0 and " "
              or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
          end,
        })
      end,
    })
  end,
}
