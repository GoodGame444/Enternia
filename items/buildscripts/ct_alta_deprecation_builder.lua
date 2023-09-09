require "/scripts/util.lua"
require "/scripts/vec2.lua"
require "/scripts/versioningutils.lua"
require "/items/buildscripts/abilities.lua"
require "/items/buildscripts/ct_alta_item_builder.lua"

local ct_alta_item_builder = build

function build(directory, config, parameters, level, seed)
  local configParameter = function(keyName, defaultValue)
    if parameters[keyName] ~= nil then return parameters[keyName]
    elseif config[keyName] ~= nil then return config[keyName]
    else return defaultValue end
  end
  local item = configParameter("newItemChange")
  if item then
    local itemConfig = root.itemConfig(item)
    config = itemConfig.config or config
    parameters = itemConfig.parameters or parameters
  else
    parameters.newItemChange = configParameter("newItem", "ct_combat_mask_mk2")
    config.itemName = parameters.newItemChange
    parameters.itemName = parameters.newItemChange
  end
  config, parameters = ct_alta_item_builder(directory, config, parameters, level, seed)
  return config, parameters
end
