return {
  "akinsho/bufferline.nvim",
  after = "catppuccin",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  config = function()
    local bufferline = require("bufferline")

    bufferline.setup({
      options = {
        mode = "buffers", -- set to "tabs" to only show tabpages instead
        separator_style = "slant",
        numbers = "ordinal", -- function({ ordinal, id, lower, raise }): string,
        tab_size = 15,
        color_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            text_align = "left",
          },
        },
        hover = {
          enabled = true,
          delay = 1,
          reveal = { "close" },
        },
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match("error") and "✘ " or "▲ "
          return " " .. icon .. count
        end,
        groups = {
          items = {
            require("bufferline.groups").builtin.pinned:with({ icon = "" }),
          },
        },
        -- GROUPS
        toggle_hidden_on_enter = true, -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
        items = {
          {
            name = "Tests", -- Mandatory
            highlight = { underline = true, sp = "blue" }, -- Optional
            priority = 2, -- determines where it will appear relative to other groups (Optional)
            icon = "", -- Optional
            matcher = function(buf) -- Mandatory
              return buf.filename:match("%_test") -- "_test" suffix
                or buf.filename:match("%_spec") -- "_spec" suffix
                or buf.filename:match("test_%") -- "test_" preffix
                or buf.filename:match("spec_%") -- "spec_" preffix
            end,
          },
          {
            name = "Docs",
            highlight = { undercurl = true, sp = "green" },
            auto_close = false, -- whether or not close this group if it doesn't contain the current buffer
            matcher = function(buf)
              return buf.filename:match("%.md") -- ".md" extension
                or buf.filename:match("%.txt") -- ".txt" extension
            end,
            separator = { -- Optional
              style = require("bufferline.groups").separator.tab,
            },
          },
        },
      },
      highlights = require("catppuccin.groups.integrations.bufferline").get(),
    })

    local opts = { noremap = true, silent = true }

    vim.keymap.set("n", "gt", "<cmd>BufferLineCycleNext<CR>", opts)
    vim.keymap.set("n", "gT", "<cmd>BufferLineCyclePrev<CR>", opts)
    vim.keymap.set("n", "<C-M-k>", "<cmd>BufferLineMoveNext<CR>", opts)
    vim.keymap.set("n", "<C-M-j>", "<cmd>BufferLineMovePrev<CR>", opts)
    vim.keymap.set("n", "<C-M-p>", "<cmd>BufferLineTogglePin<CR>", opts)
    vim.keymap.set("n", "<leader>1", "<cmd>BufferLineGoToBuffer 1<CR>", opts)
    vim.keymap.set("n", "<leader>2", "<cmd>BufferLineGoToBuffer 2<CR>", opts)
    vim.keymap.set("n", "<leader>3", "<cmd>BufferLineGoToBuffer 3<CR>", opts)
    vim.keymap.set("n", "<leader>4", "<cmd>BufferLineGoToBuffer 4<CR>", opts)
    vim.keymap.set("n", "<leader>5", "<cmd>BufferLineGoToBuffer 5<CR>", opts)
    vim.keymap.set("n", "<leader>6", "<cmd>BufferLineGoToBuffer 6<CR>", opts)
    vim.keymap.set("n", "<leader>7", "<cmd>BufferLineGoToBuffer 7<CR>", opts)
    vim.keymap.set("n", "<leader>8", "<cmd>BufferLineGoToBuffer 8<CR>", opts)
    vim.keymap.set("n", "<leader>9", "<cmd>BufferLineGoToBuffer 9<CR>", opts)
    vim.keymap.set("n", "<leader>$", "<cmd>BufferLineGoToBuffer -1<CR>", opts) -- Last Buffer
    vim.keymap.set("n", "<leader>0", "<cmd>BufferLineGoToBuffer +1<CR>", opts) -- First Buffer
  end,
}
