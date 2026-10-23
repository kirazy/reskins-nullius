---@using data
---@using Reskins.SpriteUtils

local _sprite_utils = {
	defines = require("__reskins-sprite-utils__.defines"),
	icons = require("__reskins-sprite-utils__.icons"),
}

local corners = _sprite_utils.defines.icon_transforms.corners

---@type table<string, IconSources>
local recipe_icon_sources_map = {
	["nullius-copper-heat-pipe"] = {
		{ name = "nullius-heat-pipe-2", type_name = "item" },
		{ name = "nullius-copper-sheet", type_name = "item", transform = corners.northeast },
	},
	["nullius-one-way-valve-2"] = {
		{ name = "nullius-one-way-valve", type_name = "item" },
		{ name = "nullius-rubber", type_name = "item", transform = corners.northeast },
	},
}

_sprite_utils.icons.create_and_assign_composed_icons_from_sources_to_recipe(recipe_icon_sources_map)
