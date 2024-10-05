local highlights = require("neo-tree.ui.highlights")
local common = require("neo-tree.sources.common.components")

local M = {}

M.icon = function(config, node, state)
  local icon = config.default or " "
  local padding = config.padding or " "
  local highlight = config.highlight or highlights.FILE_ICON
  if node.type == "tab" then
    highlight = highlights.DIRECTORY_ICON
    if node:is_expanded() then
      icon = config.folder_open or "-"
    else
      icon = config.folder_closed or "+"
    end
  elseif node.type == "window" then
    local success, web_devicons = pcall(require, "nvim-web-devicons")
    if success then
      local devicon, hl = web_devicons.get_icon(node.name, node.filetype)
      icon = devicon or icon
      highlight = hl or highlight
    end
  end
  return {
    text = icon .. padding,
    highlight = highlight,
  }
end

M.name = function(config, node, state)
  local highlight = config.highlight or highlights.FILE_NAME
  if node.type == "tab" then
    highlight = highlights.DIRECTORY_NAME
  end
  if node:get_depth() == 1 then
    highlight = highlights.ROOT_NAME
  end
  return {
    text = node.name,
    highlight = highlight,
  }
end

return vim.tbl_deep_extend("force", common, M)
