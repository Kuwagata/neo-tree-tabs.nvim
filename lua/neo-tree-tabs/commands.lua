local cc = require("neo-tree.sources.common.commands")
local renderer = require("neo-tree.ui.renderer")
local log = require("neo-tree.log")
local manager = require("neo-tree.sources.manager")
local utils = require("neo-tree-tabs.utils")

local M = {}

M.refresh = function(state)
  manager.refresh("tabs", state)
end

M.select_tab = function(state)
  local node = state.tree:get_node()
  vim.api.nvim_set_current_tabpage(node.extra.tab_id)
  if node.extra.win_id then
    vim.api.nvim_set_current_win(node.extra.win_id)
  end
end

M.rename_tab = function(state)
  local node = state.tree:get_node()

  if node.type ~= "tab" then
    node = state.tree:get_node(node:get_parent_id())
  end

  utils.rename_tab(node.extra.tab_id, function(name)
    node.name = name
    renderer.redraw(state)
  end)
end

-- Just a wrapper to restrict previews to those items with a buffer
M.toggle_preview = function(state)
  local node = state.tree:get_node()

  if node.type ~= "window" then
    log.warn("The `preview` command can only be used on windows")
  end

  if not node.extra.bufnr then
    log.warn("This window does not have a valid buffer to preview")
  end

  cc.toggle_preview(state)
end

cc._add_common_commands(M)
return M
