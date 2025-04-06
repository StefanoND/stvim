local map = require("mini.map")

return {
  integrations = {
    map.gen_integration.builtin_search(),
    map.gen_integration.diff(),
    map.gen_integration.diagnostic(),
    map.gen_integration.gitsigns(),
  },
  window = {
    width = 6,
    show_integration_count = true,
  },
}
