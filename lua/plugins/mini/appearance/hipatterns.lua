local hipatterns = require("mini.hipatterns")
local words = require("config.colors").words

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
  },
}
