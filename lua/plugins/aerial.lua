return {
  "stevearc/aerial.nvim",
  opts = function()
    local opts = {
      attach_mode = "global",
      backends = { "lsp", "treesitter", "markdown", "man" },
      show_guides = true,
      layout = {
        resize_to_content = true,
        max_width = { 60, 0.3 },
        default_direction = "left",
        min_width = 30,
        win_opts = {
          winhl = "Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB",
          signcolumn = "yes",
          statuscolumn = " ",
        },
      },
      icons = require("blink.cmp").kind_icons,
      filter_kind = false,
      -- stylua: ignore
      guides = {
        mid_item   = "├╴",
        last_item  = "╰╴",
        nested_top = "│ ",
        whitespace = "  ",
      },
    }
    return opts
  end,
  keys = require("config.keymaps.aerial"),
}
