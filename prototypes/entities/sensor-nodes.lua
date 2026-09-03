local _lib = require("_lib")
local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local Applicators = require("__reskins-assets-api__.api.applicators")
local Radar = require("__reskins-assets-api__.assets.base.entities.radar")

local entities = {
	["radar"] = { type = "radar", tier = 1, prog_tier = 1 },
	["nullius-sensor-node-2"] = { type = "radar", tier = 2, prog_tier = 2 },
	["nullius-sensor-node-3"] = { type = "radar", tier = 3, prog_tier = 3 },
}

for name, options in pairs(entities) do
	local entity = data.raw[options.type][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	_lib.create_explosions_and_particles(name, {
		base_entity_name = "radar",
		type = options.type,
		tint = tint,
		particles = {
			["medium"] = 2,
		},
	})

	local corpse = _lib.create_remnant(name, {
		base_entity_name = "radar",
		type = options.type,
	})

	local sprite_set = Radar.get_sprite_set({ tint = tint })

	Applicators.apply_sprite_set(entity, sprite_set)
	Applicators.apply_sprite_set(corpse, sprite_set)

	local deferrable_icon = _framework.tiers.deferrable_icon_with_tier_labels({
		tier = tier,
		name = name,
		type_name = options.type,
		icon_data = Radar.get_icon({ tint = tint }),
	})

	_sprite_utils.icons.assign_deferrable_icon(deferrable_icon)

	::continue::
end
