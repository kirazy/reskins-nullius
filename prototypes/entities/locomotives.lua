local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _assets = { create_icon = require("__reskins-assets-api__.assets.base.items.icons") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local entities = {
	["nullius-locomotive-1"] = { type = "locomotive", tier = 1, prog_tier = 1 },
	["nullius-locomotive-2"] = { type = "locomotive", tier = 2, prog_tier = 2 },
	["nullius-locomotive-3"] = { type = "locomotive", tier = 3, prog_tier = 3 },
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
		icon_data = _assets.create_icon.train_locomotive({ tint = tint }),
	})

	_sprite_utils.icons.apply_icon_assignment(icon_assignment)

	::continue::
end

-- Solar locomotive is outside the tier system.
