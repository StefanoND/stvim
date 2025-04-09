local vars = require("config.vars")

return {
  "ahmedkhalf/project.nvim",
  opts = {
    -- manual_mode = true,
    patterns = vars.rootPatterns,
    show_hidden = true,
  },
  event = "VeryLazy",
  config = function(_, opts)
    require("project_nvim").setup(opts)
    local history = require("project_nvim.utils.history")
    history.delete_project = function(project)
      for k, v in pairs(history.recent_projects) do
        if v == project.value then
          history.recent_projects[k] = nil
          return
        end
      end
    end
    require("config.keymaps.project")
  end,
}
