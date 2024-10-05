-- vim: set foldmethod=marker :

return {
  renderers = {
    window = {
      { "indent" },
      { "icon" },
      { "name" },
    },
    tab = {
      { "indent" },
      { "icon" },
      { "name" },
    },
  },
  tabs = {
    window = {
      mappings = {
        ["<cr>"] = "select_tab",
        ["r"] = "rename_tab",
        ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = false } },
        -- Clear irrelevant mappings
        ["A"] = false,
        ["S"] = false,
        ["a"] = false,
        ["c"] = false,
        ["e"] = false,
        ["l"] = false,
        ["m"] = false,
        ["p"] = false,
        ["s"] = false,
        ["t"] = false,
        ["w"] = false,
        ["x"] = false,
        ["y"] = false,
      },
    },
  },
}
