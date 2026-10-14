local _lib = require("_lib")
local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local Applicators = require("__reskins-assets-api__.api.applicators")
local Substation = require("__reskins-assets-api__.assets.base.entities.substation")

local entities = {
	["substation"] = { type = "electric-pole", tier = 1, prog_tier = 1 },
	["nullius-substation-2"] = { type = "electric-pole", tier = 2, prog_tier = 2 },
	["nullius-substation-3"] = { type = "electric-pole", tier = 3, prog_tier = 3 },
}

for name, options in pairs(entities) do
	local entity = data.raw[options.type][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	_lib.create_explosions_and_particles(name, {
		base_entity_name = "substation",
		type = options.type,
		tint = tint,
		particles = {
			["big"] = 2,
		},
	})

	local corpse = _lib.create_remnant(name, {
		base_entity_name = "substation",
		type = options.type,
	})

	local sprite_set = Substation.get_sprite_set({ tint = tint })

	Applicators.apply_sprite_set(entity, sprite_set)
	Applicators.apply_sprite_set(corpse, sprite_set)

	local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
		tier = tier,
		name = name,
		type_name = options.type,
		icon_data = Substation.get_icon({ tint = tint }),
	})

	_sprite_utils.icons.apply_icon_assignment(icon_assignment)

	::continue::
end
