local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local Applicators = require("__reskins-assets-api__.api.applicators")
local Radar = require("__reskins-assets-api__.assets.base.entities.radar")

local entities = {
	["radar"] = { tier = 1, prog_tier = 1 },
	["nullius-sensor-node-2"] = { tier = 2, prog_tier = 2 },
	["nullius-sensor-node-3"] = { tier = 3, prog_tier = 3 },
}

for name, options in pairs(entities) do
	local entity = data.raw["radar"][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	local sprite_set = Radar.get_sprite_set({ tint = tint })

	Applicators.apply_sprite_set(entity, sprite_set)

	local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
		tier = tier,
		name = name,
		type_name = entity.type,
		composition = Radar.get_icon_composition({ tint = tint }),
	})

	_sprite_utils.icons.apply_icon_assignment(icon_assignment)

	::continue::
end
