local function merge_colors(foreground, background)
  local new_name = foreground .. background

  local hl_fg = vim.api.nvim_get_hl(0, { name = foreground })
  local hl_bg = vim.api.nvim_get_hl(0, { name = background })

  local fg = string.format("#%06x", hl_fg.fg and hl_fg.fg or 0)
  local bg = string.format("#%06x", hl_bg.bg and hl_bg.bg or 0)

  vim.api.nvim_set_hl(0, new_name, { fg = fg, bg = bg })
  return new_name
end

local function get_dap_repl_winbar(active)
  local get_mode = require("lualine.highlight").get_mode_suffix

  return function()
    local filetype = vim.bo.filetype
    local disabled_filetypes = { "dap-repl" }

    if not vim.tbl_contains(disabled_filetypes, filetype) then
      return ""
    end

    local background_color = string.format("lualine_b" .. "%s", active and get_mode() or "_inactive")

    local controls_string = "%#" .. background_color .. "#"
    for element in require("dapui.controls").controls():gmatch("%S+") do
      local color, action = string.match(element, "%%#(.*)#(%%.*)%%#0#")
      controls_string = controls_string
        .. " %#"
        .. merge_colors(color, background_color)
        .. "#"
        .. action
    end
    return controls_string
  end
end

local colors = require("config.colors").words

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand("%:p:h")
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
  checkFileSize = function()
    local file = vim.fn.expand("%:p")
    local size = vim.fn.getfsize(file)
    if size <= 0 then
      return false
    end
    return true
  end,
  checkLsp = function()
    local clients = vim.lsp.get_clients()
    return next(clients) ~= nil
  end,
  -- Lsp server name .
  lspInfo = function()
    local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
    local clients = vim.lsp.get_clients()
    local client_names = {}
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 and client.name ~= "null-ls" then
        -- return client.name
        table.insert(client_names, client.name)
      end
    end
    if #client_names > 0 then
      return table.concat(client_names, ", ")
    else
      return ""
    end
  end,
}

return {
  "nvim-lualine/lualine.nvim",
  -- enabled = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local lualine = require("lualine")

    local lazy_status = require("lazy.status") -- to configure lazy pending updates count
    local snacks = require("snacks")

    lualine.setup({
      options = {
        component_separators = "",
        theme = "catppuccin",
      },
      sections = {
        lualine_a = {
          "mode",
          function()
            return ""
          end,
          {
            -- filesize component
            "filesize",
            cond = conditions.checkFileSize,
          },
          {
            function()
              return ""
            end,
            cond = conditions.checkFileSize,
          },
          {
            "filename",
            cond = conditions.buffer_not_empty,
          },
        },
        lualine_b = {
          {
            "branch",
            cond = conditions.check_git_workspace,
          },
          {
            function()
              return ""
            end,
            cond = conditions.check_git_workspace,
          },
          {
            "diff",
            cond = conditions.check_git_workspace,
          },
          {
            function()
              return ""
            end,
            cond = conditions.check_git_workspace,
          },
          {
            "diagnostics",
            cond = conditions.check_git_workspace,
            sources = { "nvim_diagnostic" },
            symbols = { error = " ", warn = " ", info = " " },
            diagnostics_color = {
              error = { fg = colors.red },
              warn = { fg = colors.yellow },
              info = { fg = colors.cyan },
            },
          },
        },
        lualine_c = {
          {
            function()
              return "%="
            end,
            cond = conditions.checkLsp,
          },
          {
            function()
              return ""
            end,
            cond = conditions.checkLsp,
          },
          {
            conditions.lspInfo,
            icon = " LSP:",
            color = { fg = colors.white, gui = "bold" },
            cond = conditions.checkLsp,
          },
          {
            function()
              return ""
            end,
            cond = conditions.checkLsp,
          },
        },
        lualine_x = {
          {
            function()
              return ""
            end,
            cond = snacks.profiler.running,
          },
          {
            snacks.profiler.status,
            cond = snacks.profiler.running,
          },
          {
            function()
              return ""
            end,
            cond = lazy_status.has_updates,
          },
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
          },
          function()
            return ""
          end,
          { "encoding" },
          function()
            return ""
          end,
          { "fileformat" },
          function()
            return ""
          end,
          {
            "filetype",
          },
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {
          "mode",
          function()
            return ""
          end,
          {
            -- filesize component
            "filesize",
            cond = conditions.checkFileSize,
          },
          {
            function()
              return ""
            end,
            cond = conditions.checkFileSize,
          },
          {
            "filename",
            cond = conditions.buffer_not_empty,
          },
        },
        lualine_b = {
          {
            "branch",
            cond = conditions.check_git_workspace,
          },
          {
            function()
              return ""
            end,
            cond = conditions.check_git_workspace,
          },
          {
            "diff",
            cond = conditions.check_git_workspace,
          },
          {
            function()
              return ""
            end,
            cond = conditions.check_git_workspace,
          },
          {
            "diagnostics",
            cond = conditions.check_git_workspace,
            sources = { "nvim_diagnostic" },
            symbols = { error = " ", warn = " ", info = " " },
            diagnostics_color = {
              error = { fg = colors.red },
              warn = { fg = colors.yellow },
              info = { fg = colors.cyan },
            },
          },
        },
        lualine_c = {
          {
            function()
              return "%="
            end,
            cond = conditions.checkLsp,
          },
          {
            function()
              return ""
            end,
            cond = conditions.checkLsp,
          },
          {
            conditions.lspInfo,
            icon = " LSP:",
            color = { fg = colors.white, gui = "bold" },
            cond = conditions.checkLsp,
          },
          {
            function()
              return ""
            end,
            cond = conditions.checkLsp,
          },
        },
      },
      tabline = {},
      extensions = {},
      winbar = {
        lualine_a = {
          "navic",
        },
        lualine_b = { get_dap_repl_winbar(true) },
        lualine_z = {
          function()
            return "   "
          end,
        },
      },
      inactive_winbar = {
        lualine_a = {
          "navic",
        },
        lualine_b = { get_dap_repl_winbar(false) },
        lualine_z = {
          function()
            return "   "
          end,
        },
      },
      -- winbar = {
      --   lualine_a = { { "filename", file_status = false } },
      --   lualine_b = { get_dap_repl_winbar(true) },
      --   lualine_c = { "filename", "searchcount", "selectioncount", { "filename", path = 1 } },
      -- },
      -- inactive_winbar = {
      --   lualine_a = { { "filename", file_status = false } },
      --   lualine_b = { get_dap_repl_winbar(false) },
      --   lualine_c = { "filename", "searchcount", "selectioncount", GetFilePath },
      -- },
      ignore_focus = {
        "dapui_watches",
        "dapui_breakpoints",
        "dapui_scopes",
        "dapui_console",
        "dapui_stacks",
        "dap-repl",
      },
      disabled_filetypes = {
        "dapui_watches",
        "dapui_breakpoints",
        "dapui_scopes",
        "dapui_console",
        "dapui_stacks",
        "dap-repl",
      },
    })
  end,
}
