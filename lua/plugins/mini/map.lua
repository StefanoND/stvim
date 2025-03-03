local map = require("mini.map")

return {
  integrations = {
    map.gen_integration.builtin_search(),
    map.gen_integration.gitsigns(),
    map.gen_integration.diagnostic(),
  },
  window = {
    width = 8,
  },
}
