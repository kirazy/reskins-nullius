local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local TrainCargoWagon = require("__reskins-assets-api__.assets.base.entities.train-cargo-wagon")

local entities = {
	["nullius-cargo-wagon-1"] = { type = "cargo-wagon", tier = 1, prog_tier = 1 },
	["nullius-cargo-wagon-2"] = { type = "cargo-wagon", tier = 2, prog_tier = 2 },
	["nullius-cargo-wagon-3"] = { type = "cargo-wagon", tier = 3, prog_tier = 3 },
}

for name, options in pairs(entities) do
	local entity = data.raw[options.type][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
		tier = tier,
		name = name,
		type_name = entity.type,
		composition = TrainCargoWagon.get_icon_composition({ tint = tint }),
	})

	_sprite_utils.icons.apply_icon_assignment(icon_assignment)

	::continue::
end
