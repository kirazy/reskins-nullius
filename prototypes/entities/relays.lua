local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local Applicators = require("__reskins-assets-api__.api.applicators")
local RoboZoneExpander = require("__reskins-assets-api__.assets.bobs.entities.robo-zone-expander")

-- The relays draw the logistic zone expander at 0.6 times its size.
local SCALE_FACTOR = 0.6

local entities = {
	["nullius-relay-1"] = { tier = 1, prog_tier = 2, variant = 1 },
	["nullius-relay-2"] = { tier = 2, prog_tier = 3, variant = 1 },
	["nullius-relay-3"] = { tier = 3, prog_tier = 4, variant = 1 },
	["nullius-relay-4"] = { tier = 4, prog_tier = 5, variant = 1 },
	["nullius-relay-construction-1"] = { tier = 1, prog_tier = 2, variant = 4 },
	["nullius-relay-construction-2"] = { tier = 2, prog_tier = 3, variant = 4 },
	["nullius-relay-construction-3"] = { tier = 3, prog_tier = 4, variant = 4 },
	["nullius-relay-construction-4"] = { tier = 4, prog_tier = 5, variant = 4 },
}

for name, options in pairs(entities) do
	local entity = data.raw["roboport"][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	local sprite_set = RoboZoneExpander.get_sprite_set({ tint = tint, tier = options.variant })
	Applicators.apply_sprite_set(entity, sprite_set, { scale_factor = SCALE_FACTOR })

	local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
		tier = tier,
		name = entity.name,
		type_name = entity.type,
		composition = RoboZoneExpander.get_icon_composition({ tint = tint, tier = options.variant }),
	})
	_sprite_utils.icons.apply_icon_assignment(icon_assignment)

	::continue::
end
