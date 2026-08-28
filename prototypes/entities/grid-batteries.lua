local _lib = require("_lib")
local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = {
	icons = require("__reskins-sprite-utils__.icons"),
	sprites = require("__reskins-sprite-utils__.sprites"),
}

local Applicators = require("__reskins-assets-api__.api.applicators")
local Accumulator = require("__reskins-assets-api__.assets.base.entities.accumulator")

local entities = {
	["nullius-grid-battery-1"] = { type = "accumulator", tier = 1, prog_tier = 1, scale_factor = 3 / 2 },
	["nullius-grid-battery-2"] = { type = "accumulator", tier = 2, prog_tier = 3, scale_factor = 3 / 2 },
	["nullius-grid-battery-3"] = { type = "accumulator", tier = 3, prog_tier = 4, scale_factor = 3 / 2 },
}

for name, options in pairs(entities) do
	local entity = data.raw[options.type][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	_lib.create_explosions_and_particles(name, {
		base_entity_name = "accumulator",
		type = "accumulator",
		tint = tint,
		particles = {
			["medium"] = 2,
			["small"] = 3,
		},
	})

	local corpse = _lib.create_remnant(name, {
		base_entity_name = "accumulator",
		type = "accumulator",
	})
	if options.scale_factor then
		_sprite_utils.sprites.rescale_prototype(corpse, options.scale_factor)
	end

	local sprite_set = Accumulator.get_sprite_set({ tint = tint })

	Applicators.apply_sprite_set(entity, sprite_set)
	Applicators.apply_sprite_set(corpse, sprite_set)

	local deferrable_icon = _framework.tiers.deferrable_icon_with_tier_labels({
		tier = tier,
		name = name,
		type_name = options.type,
		icon_data = Accumulator.get_icon("base", tint),
	})

	_sprite_utils.icons.assign_deferrable_icon(deferrable_icon)

	::continue::
end
