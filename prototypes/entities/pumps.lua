-- cspell: words togglable
local _lib = require("_lib")
local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local Applicators = require("__reskins-assets-api__.api.applicators")
local Pump = require("__reskins-assets-api__.assets.base.entities.pump")

local entities = {
	["nullius-pump-1"] = { tier = 1, prog_tier = 1 },
	["nullius-pump-2"] = { tier = 2, prog_tier = 2 },
	["pump"] = { tier = 3, prog_tier = 3 },
	["nullius-togglable-pump-1"] = { tier = 1, prog_tier = 1 },
	["nullius-togglable-pump-2"] = { tier = 2, prog_tier = 2 },
	["nullius-togglable-pump-3"] = { tier = 3, prog_tier = 3 },
}

for name, options in pairs(entities) do
	local entity = data.raw["pump"][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	_lib.create_explosions_and_particles(name, {
		base_entity_name = "pump",
		type = "pump",
		tint = tint,
		particles = {
			["medium"] = 2,
		},
	})

	local corpse = _lib.create_remnant(name, {
		base_entity_name = "pump",
		type = "pump",
	})

	local sprite_set = Pump.get_sprite_set({ tint = tint })

	Applicators.apply_sprite_set(entity, sprite_set)
	Applicators.apply_sprite_set(corpse, sprite_set)

	local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
		tier = tier,
		name = name,
		type_name = "pump",
		icon_data = Pump.get_icon({ tint = tint }),
	})

	_sprite_utils.icons.apply_icon_assignment(icon_assignment)

	::continue::
end
