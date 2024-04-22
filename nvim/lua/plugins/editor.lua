return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      opts.window.mappings = {
        ["o"] = { "open", nowait = true },
        ["oc"] = "none",
        ["od"] = "none",
        ["og"] = "none",
        ["om"] = "none",
        ["on"] = "none",
        ["os"] = "none",
        ["ot"] = "none",
      }
      opts.filesystem.group_empty_dirs = true -- when true, empty folders will be grouped together
      opts.sort_case_insensitive = true
    end,
  },
}
