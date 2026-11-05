local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local Applicators = require("__reskins-assets-api__.api.applicators")
local Accumulator = require("__reskins-assets-api__.assets.base.entities.accumulator")

local entities = {
	["nullius-grid-battery-1"] = { type = "accumulator", tier = 1, prog_tier = 1 },
	["nullius-grid-battery-2"] = { type = "accumulator", tier = 2, prog_tier = 3 },
	["nullius-grid-battery-3"] = { type = "accumulator", tier = 3, prog_tier = 4 },
}

for name, options in pairs(entities) do
	local entity = data.raw[options.type][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	local sprite_set = Accumulator.get_sprite_set({ tint = tint })

	Applicators.apply_sprite_set(entity, sprite_set)

	local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
		tier = tier,
		name = name,
		type_name = options.type,
		composition = Accumulator.get_icon_composition({ tint = tint }),
	})

	_sprite_utils.icons.apply_icon_assignment(icon_assignment)

	::continue::
end
