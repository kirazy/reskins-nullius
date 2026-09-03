---@using data

local _lib = require("_lib")
local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local Applicators = require("__reskins-assets-api__.api.applicators")
local Boiler = require("__reskins-assets-api__.assets.base.entities.boiler")

local entities = {
	["nullius-boiler-1"] = { type = "assembling-machine", tier = 1, prog_tier = 2 },
	["nullius-boiler-2"] = { type = "assembling-machine", tier = 2, prog_tier = 3 },
}

local fire_tint = util.color("#2e7ae5") --[[@as Color]]

for name, options in pairs(entities) do
	---@type data.AssemblingMachinePrototype
	local entity = data.raw[options.type][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	_lib.create_explosions_and_particles(name, {
		base_entity_name = "boiler",
		type = options.type,
		tint = tint,
		particles = {
			["big"] = 3,
		},
	})

	local corpse = _lib.create_remnant(name, {
		base_entity_name = "boiler",
		type = options.type,
	})

	local sprite_set = Boiler.get_sprite_set({
		tint = tint,
		fire_tint = fire_tint,
		fire_flicker_enabled = false,
		fire_glow_flicker_enabled = false,
	})

	Applicators.apply_sprite_set(entity, sprite_set)
	Applicators.apply_sprite_set(corpse, sprite_set)

	local deferrable_icon = _framework.tiers.deferrable_icon_with_tier_labels({
		tier = tier,
		name = name,
		type_name = options.type,
		icon_data = Boiler.get_icon({ tint = tint, fire_tint = fire_tint }),
	})

	_sprite_utils.icons.assign_deferrable_icon(deferrable_icon)

	::continue::
end
