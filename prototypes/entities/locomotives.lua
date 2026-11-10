local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local Tints = require("__reskins-nullius__.prototypes.tints")
local TrainLocomotive = require("__reskins-assets-api__.assets.base.entities.train-locomotive")

local entities = {
	["nullius-locomotive-1"] = { tier = 1, prog_tier = 1 },
	["nullius-locomotive-2"] = { tier = 2, prog_tier = 2 },
	["nullius-locomotive-3"] = { tier = 3, prog_tier = 3 },
	["nullius-solar-locomotive"] = { tier = 0, tint = Tints.ecological_green },
}

for name, options in pairs(entities) do
	local entity = data.raw["locomotive"][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = options.tint or _framework.tiers.get_tint(tier)

	-- Update the default color selected by the runtime masks.
	entity.color = tint

	local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
		tier = tier,
		name = name,
		type_name = entity.type,
		composition = TrainLocomotive.get_icon_composition({ tint = tint }),
	})

	_sprite_utils.icons.apply_icon_assignment(icon_assignment)

	::continue::
end
