---@using data
---@using Reskins.Framework
---@using Reskins.SpriteUtils

local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { defines = require("__reskins-sprite-utils__.defines") }

local corners = _sprite_utils.defines.icon_transforms.corners

---@type table<string, TieredIconDefinition>
local recipes = {
	["nullius-plastic-pipe"] = {
		sources = {
			{ name = "nullius-pipe-2", type_name = "item" },
			{ name = "nullius-plastic", type_name = "item", transform = corners.northeast },
		},
	},
	["nullius-stone-pipe"] = {
		sources = {
			{ name = "pipe", type_name = "item" },
			{ name = "stone-brick", type_name = "item", transform = corners.northeast },
		},
	},
	["pipe"] = {
		sources = {
			{ name = "pipe", type_name = "item" },
			{ name = "nullius-iron-ingot", type_name = "item", transform = corners.northeast },
		},
	},
	["nullius-pipe-2"] = {
		sources = {
			{ name = "nullius-pipe-2", type_name = "item" },
			{ name = "nullius-steel-ingot", type_name = "item", transform = corners.northeast },
		},
	},
}

_framework.tiers.assign_icons_with_tier_labels("recipe", recipes)
