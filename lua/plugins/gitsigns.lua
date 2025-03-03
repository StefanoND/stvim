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
      },
      current_line_blame = false,
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true })

        map("n", "[c", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true })

        -- Actions
        map({ "n", "v" }, "<leader>gss", ":Gitsigns stage_hunk<CR>")
        map({ "n", "v" }, "<leader>gsr", ":Gitsigns reset_hunk<CR>")
        map("n", "<leader>gsS", gs.stage_buffer)
        map("n", "<leader>gsa", gs.stage_hunk)
        map("n", "<leader>gsu", gs.undo_stage_hunk)
        map("n", "<leader>gsR", gs.reset_buffer)
        map("n", "<leader>gsp", gs.preview_hunk)
        map("n", "<leader>gsb", function()
          gs.blame_line({ full = true })
        end)
        map("n", "<leader>tlb", gs.toggle_current_line_blame)
        map("n", "<leader>gsd", gs.diffthis)
        map("n", "<leader>gsD", function()
          gs.diffthis("~")
        end)
        map("n", "<leader>td", gs.toggle_deleted)

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
      end,
    })

    -- require("scrollbar.handlers.gitsigns").setup()
  end,
}
