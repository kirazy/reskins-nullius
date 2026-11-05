---@using data
---@using Reskins.Framework
---@using Reskins.SpriteUtils

local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { defines = require("__reskins-sprite-utils__.defines") }

local corners = _sprite_utils.defines.icon_transforms.corners

---@type table<string, TieredIconDefinition>
local recipes = {
	["nullius-copper-heat-pipe"] = {
		sources = {
			{ name = "nullius-heat-pipe-2", type_name = "item" },
			{ name = "nullius-copper-sheet", type_name = "item", transform = corners.northeast },
		},
	},
	["nullius-one-way-valve-2"] = {
		sources = {
			{ name = "nullius-one-way-valve", type_name = "item" },
			{ name = "nullius-rubber", type_name = "item", transform = corners.northeast },
		},
	},
}

_framework.tiers.assign_icons_with_tier_labels("recipe", recipes)
