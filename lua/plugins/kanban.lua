return {
  -- "arakkkkk/kanban.nvim" -- Original Author
  "yugapanda/kanban.nvim", -- I prefer his changes
  config = function()
    require("kanban").setup({
      markdown = {
        description_folder = "./tasks/", -- Path to save the file corresponding to the task.
        list_head = "## ",
      },
    })
  end,
}
