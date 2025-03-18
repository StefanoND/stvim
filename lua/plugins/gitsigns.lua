return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("gitsigns").setup({
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "" },
      },
      signcolumn = true,
      numhl = true,
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end)

        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end)

        -- Actions
        map("n", "<leader>gss", gitsigns.stage_hunk)
        map("n", "<leader>gsr", gitsigns.reset_hunk)
        map("n", "<leader>gsu", gitsigns.undo_stage_hunk)

        map("v", "<leader>gss", function()
          gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)

        map("v", "<leader>gsr", function()
          gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)

        map("n", "<leader>gsS", gitsigns.stage_buffer)
        map("n", "<leader>gsR", gitsigns.reset_buffer)
        map("n", "<leader>gsp", gitsigns.preview_hunk)
        map("n", "<leader>gsi", gitsigns.preview_hunk_inline)

        map("n", "<leader>gsb", function()
          gitsigns.blame_line({ full = true })
        end)

        map("n", "<leader>gsd", gitsigns.diffthis)

        map("n", "<leader>gsD", function()
          gitsigns.diffthis("~")
        end)

        map("n", "<leader>gsb", gitsigns.toggle_current_line_blame)
        map("n", "<leader>gst", gitsigns.toggle_deleted)
        map("n", "<leader>gsw", gitsigns.toggle_word_diff)
        map("n", "<leader>gsl", gitsigns.toggle_linehl)
        map("n", "<leader>gso", function()
          gitsigns.toggle_linehl()
          gitsigns.toggle_deleted()
        end)

        -- Text object
        map({ "o", "x" }, "ih", gitsigns.select_hunk)
      end,
    })
  end,
}
