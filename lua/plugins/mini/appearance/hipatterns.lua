local M = {}

local hi = require("mini.hipatterns")
local words = require("config.colors").words

local word_color_group = function(_, match)
  local hex = words[match]
  if hex == nil then
    return nil
  end
  return hi.compute_hex_color_group(hex, "bg")
end

M.opts = {
  tailwind = {
    enabled = true,
    ft = {
      "astro",
      "css",
      "heex",
      "html",
      "html-eex",
      "javascript",
      "javascriptreact",
      "rust",
      "svelte",
      "typescript",
      "typescriptreact",
      "vue",
    },
    -- full: the whole css class will be highlighted
    -- compact: only the color will be highlighted
    style = "full",
  },
  highlighters = {
    -- Highlight hex color strings (`#rrggbb`) using that color
    hex_color = hi.gen_highlighter.hex_color({ priority = 2000 }),

    shorthand = {
      pattern = "()#%x%x%x()%f[^%x%w]",
      group = function(_, _, data)
        ---@type string
        local match = data.full_match
        local r, g, b = match:sub(2, 2), match:sub(3, 3), match:sub(4, 4)
        local hex_color = "#" .. r .. r .. g .. g .. b .. b

        return hi.compute_hex_color_group(hex_color, "bg")
      end,
      extmark_opts = { priority = 2000 },
    },

    -- Highlight standalone:
    -- They're just here as a "fallback" if "todo-commends" stops working
    -- FIX FIXME BUG FIXIT ISSUE TODO HACK FAILED FAIL WARN WARNING XXX PERF OPTIM PERFORMANCE OPTIMIZE
    -- PASS PASSED NOTE INFO TRACK KEEPTRACK TEST TESTING
    fix = { pattern = "%f[%w]()FIX()%f[%W]", group = "hl_peach" },
    fixit = { pattern = "%f[%w]()FIXIT()%f[%W]", group = "hl_peach" },
    fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "hl_peach" },
    bug = { pattern = "%f[%w]()BUG()%f[%W]", group = "hl_peach" },
    issue = { pattern = "%f[%w]()ISSUE()%f[%W]", group = "hl_peach" },

    todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "hl_sky" },

    hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "hl_yellow" },

    warn = { pattern = "%f[%w]()WARN()%f[%W]", group = "hl_red" },
    warning = { pattern = "%f[%w]()WARNING()%f[%W]", group = "hl_red" },
    warnxxx = { pattern = "%f[%w]()XXX()%f[%W]", group = "hl_red" },

    perf = { pattern = "%f[%w]()PERF()%f[%W]", group = "hl_green" },
    performance = { pattern = "%f[%w]()PERFORMANCE()%f[%W]", group = "hl_green" },
    optim = { pattern = "%f[%w]()OPTIM()%f[%W]", group = "hl_green" },
    optimize = { pattern = "%f[%w]()OPTIMIZE()%f[%W]", group = "hl_green" },

    note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "hl_blue" },
    info = { pattern = "%f[%w]()INFO()%f[%W]", group = "hl_blue" },
    track = { pattern = "%f[%w]()TRACK()%f[%W]", group = "hl_blue" },
    keeptrack = { pattern = "%f[%w]()KEEPTRACK()%f[%W]", group = "hl_blue" },

    test = { pattern = "%f[%w]()TEST()%f[%W]", group = "hl_white" },
    testing = { pattern = "%f[%w]()TESTING()%f[%W]", group = "hl_white" },
    fail = { pattern = "%f[%w]()FAIL()%f[%W]", group = "hl_white" },
    failed = { pattern = "%f[%w]()FAILED()%f[%W]", group = "hl_white" },
    pass = { pattern = "%f[%w]()PASS()%f[%W]", group = "hl_white" },
    passed = { pattern = "%f[%w]()PASSED()%f[%W]", group = "hl_white" },

    -- Highlight word color strings (`red`, `green`, `blue`, etc) using that color (Themed)
    word_color = { pattern = "%S+", group = word_color_group },

    tailwind = {
      pattern = function()
        if not vim.tbl_contains(M.opts.tailwind.ft, vim.bo.filetype) then
          return
        end
        if M.opts.tailwind.style == "full" then
          return "%f[%w:-]()[%w:-]+%-[a-z%-]+%-%d+()%f[^%w:-]"
        elseif M.opts.tailwind.style == "compact" then
          return "%f[%w:-][%w:-]+%-()[a-z%-]+%-%d+()%f[^%w:-]"
        end
      end,
      group = function(_, _, m)
        ---@type string
        local match = m.full_match
        ---@type string, number
        local color, shade = match:match("[%w-]+%-([a-z%-]+)%-(%d+)")
        shade = tonumber(shade)
        local bg = vim.tbl_get(M.colors, color, shade)
        if bg then
          local hl = "MiniHipatternsTailwind" .. color .. shade
          if not M.hl[hl] then
            M.hl[hl] = true
            local bg_shade = shade == 500 and 950 or shade < 500 and 900 or 100
            local fg = vim.tbl_get(M.colors, color, bg_shade)
            vim.api.nvim_set_hl(0, hl, { bg = "#" .. bg, fg = "#" .. fg })
          end
          return hl
        end
      end,
      extmark_opts = { priority = 2000 },
    },
  },
}

return M.opts
