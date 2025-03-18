local hipatterns = require("mini.hipatterns")

-- local censor_extmark_opts = function(_, match, _)
--   local mask = string.rep("*", vim.fn.strchars(match))
--   return {
--     virt_text = { { mask, "Comment" } },
--     virt_text_pos = "overlay",
--     priority = 200,
--     right_gravity = false,
--   }
-- end

local words = require("config.colors").words

-- Catppuccin Mocha Colors
-- local words = {
--   -- red = "#ff0000",
--   -- green = "#00ff00",
--   -- blue = "#0000ff",
--   -- black = "#000000",
--   -- white = "#ffffff",
--
--   black = "#11111b",
--   magenta = "#f5c2e7",
--   cyan = "#94e2d5",
--   white = "#cdd6f4",
--   rosewater = "#f5e0dc",
--   flamingo = "#f2cdcd",
--   pink = "#f5c2e7",
--   mauve = "#cba6f7",
--   red = "#f38ba8",
--   maroon = "#eba0ac",
--   peach = "#fab387",
--   yellow = "#f9e2af",
--   green = "#a6e3a1",
--   teal = "#94e2d5",
--   sky = "#89dceb",
--   sapphire = "#74c7ec",
--   blue = "#89b4fa",
--   lavender = "#b4befe",
--   text = "#cdd6f4",
--   subtext1 = "#bac2de",
--   subtext0 = "#a6adc8",
--   overlay2 = "#9399b2",
--   overlay1 = "#7f849c",
--   overlay0 = "#6c7086",
--   surface2 = "#585b70",
--   surface1 = "#45475a",
--   surface0 = "#313244",
--   base = "#1e1e2e",
--   mantle = "#181825",
--   crust = "#11111b",
-- }

local word_color_group = function(_, match)
  local hex = words[match]
  if hex == nil then
    return nil
  end
  return hipatterns.compute_hex_color_group(hex, "bg")
end

return {
  highlighters = {
    -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE', 'WARN', 'PERF', 'TEST', 'FIXME'
    todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
    hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
    warn = { pattern = "%f[%w]()WARN()%f[%W]", group = "MiniHipatternsWarn" },
    perf = { pattern = "%f[%w]()PERF()%f[%W]", group = "MiniHipatternsPerf" },
    note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
    test = { pattern = "%f[%w]()TEST()%f[%W]", group = "MiniHipatternsTest" },
    fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },

    -- Highlight hex color strings (`#rrggbb`) using that color
    hex_color = hipatterns.gen_highlighter.hex_color(),

    -- Highlight word color strings (`red`, `green`, `blue`, etc) using that color (Themed)
    word_color = { pattern = "%S+", group = word_color_group },

    -- -- Censors patterns
    -- censor = {
    --   pattern = {
    --     "password: ()%S+()",
    --   },
    --   group = "",
    --   extmark_opts = censor_extmark_opts,
    -- },
  },
}
