local renderer = require("neo-tree.ui.renderer")
local utils = require("neo-tree-tabs.utils")
local config = require("neo-tree-tabs.config")

local M = {
  name = "tabs",
  display_name = "Tabs",
}

M.config = config

M.navigate = function(state)
  local tabs = {}
  local tab_count = 0
  for i, tab_id in ipairs(vim.api.nvim_list_tabpages()) do
    local win_count = 0
    local windows = {}
    for j, win_id in ipairs(vim.api.nvim_tabpage_list_wins(tab_id)) do
      local buf_id = vim.api.nvim_win_get_buf(win_id)

      if vim.api.nvim_get_option_value("buflisted", { buf = buf_id }) then
        win_count = win_count + 1
        table.insert(windows, {
          id = "T" .. i .. "W" .. j,
          name = vim.api.nvim_buf_get_name(buf_id),
          type = "window",
          filetype = vim.api.nvim_get_option_value("filetype", { buf = buf_id }),
          extra = {
            win_id = win_id,
            tab_id = tab_id,
            bufnr = buf_id,
          },
        })
      end
    end

    tab_count = tab_count + 1
    table.insert(tabs, {
      id = i,
      name = utils.get_tab_var(tab_id, "name", "Default Tab #" .. tab_id),
      type = "tab",
      children = windows,
      extra = {
        num_windows = win_count,
        tab_id = tab_id,
      },
    })
  end

  local root = {
    id = "root",
    name = "Tabs",
    type = "root",
    skip_node = true,
    children = tabs,
    extra = {
      num_tabs = tab_count,
    },
  }

  local current = "T" .. vim.api.nvim_win_get_tabpage(0) .. "W" .. vim.api.nvim_win_get_number(0)
  renderer.show_nodes({ root }, state)
  renderer.focus_node(state, current, false)
end

---@param opts table Configuration table.
M.setup = function(opts)
  -- TODO: Add configuration if needed
end

return M
