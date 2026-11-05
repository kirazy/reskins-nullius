---@using data

local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local Applicators = require("__reskins-assets-api__.api.applicators")
local Roboport = require("__reskins-assets-api__.assets.base.entities.roboport")

local entities = {
	["nullius-hangar-1"] = { tier = 1, prog_tier = 2 },
	["nullius-hangar-2"] = { tier = 2, prog_tier = 3 },
	["nullius-hangar-3"] = { tier = 3, prog_tier = 4 },
	["nullius-hangar-4"] = { tier = 4, prog_tier = 5 },
	["nullius-hangar-construction-1"] = { tier = 1, prog_tier = 2, antenna_variant = 4 },
	["nullius-hangar-construction-2"] = { tier = 2, prog_tier = 3, antenna_variant = 4 },
	["nullius-hangar-construction-3"] = { tier = 3, prog_tier = 4, antenna_variant = 4 },
	["nullius-hangar-construction-4"] = { tier = 4, prog_tier = 5, antenna_variant = 4 },
}

for name, options in pairs(entities) do
	local entity = data.raw["roboport"][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	local sprite_set = Roboport.get_sprite_set({
		tint = tint,
		antenna_variant = options.antenna_variant,
	})

	Applicators.apply_sprite_set(entity, sprite_set)

	local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
		tier = tier,
		name = entity.name,
		type_name = entity.type,
		composition = Roboport.get_icon_composition({ tint = tint }),
	})

	_sprite_utils.icons.apply_icon_assignment(icon_assignment)

	::continue::
end
