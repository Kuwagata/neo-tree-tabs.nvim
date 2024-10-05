local TAB_VAR_PREFIX = "neo-tree-tabs_"

local M = {}

M.get_tab_var = function(tab_id, name, default)
  local status, value = pcall(function()
    return vim.api.nvim_tabpage_get_var(tab_id, TAB_VAR_PREFIX .. name)
  end)

  return status and value or (default and default or nil)
end

M.set_tab_var = function(tab_id, name, value)
  vim.api.nvim_tabpage_set_var(tab_id, TAB_VAR_PREFIX .. name, value)
end

M.new_tab = function(tab_name)
  -- TODO: Implement later
end

local _rename_tab = function(tab_id, new_name)
  M.set_tab_var(tab_id, "name", new_name)
end

M.rename_tab = function(id, callback)
  local tab_id = id or 0
  vim.ui.input({ prompt = "New Tab Name" }, function(name)
    if name and #name == 0 then
      return
    end
    _rename_tab(tab_id, name)
    if callback then
      callback(name)
    end
  end)
end

M.delete_tab = function(tab_id)
  -- TODO: Implement later
end

return M
