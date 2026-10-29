---@using data
---@using Reskins.Assets.Assorted.Entities

local _lib = require("_lib")
local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = {
	icons = require("__reskins-sprite-utils__.icons"),
	sprites = require("__reskins-sprite-utils__.sprites"),
}

local Applicators = require("__reskins-assets-api__.api.applicators")
local HeatExchanger = require("__reskins-assets-api__.assets.base.entities.heat-exchanger")

local entities = {
	["nullius-heat-exchanger-1"] = {
		tier = 1,
		prog_tier = 1,
	},
	["nullius-heat-exchanger-2"] = {
		tier = 2,
		prog_tier = 2,
	},
	["nullius-heat-exchanger-3"] = {
		tier = 3,
		prog_tier = 3,
	},
}

for name, options in pairs(entities) do
	local entity = data.raw["assembling-machine"][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	_lib.create_explosions_and_particles(name, {
		base_entity_name = "heat-exchanger",
		type = "assembling-machine",
		tint = tint,
		particles = {
			["big"] = 2,
			["medium"] = 1,
		},
	})

	local corpse = _lib.create_remnant(name, {
		base_entity_name = "heat-exchanger",
		type = "assembling-machine",
	})

	local sprite_set = HeatExchanger.get_sprite_set({
		tint = tint,
		pipe_material = "base",
	})

	Applicators.apply_sprite_set(entity, sprite_set)
	Applicators.apply_sprite_set(corpse, sprite_set)

	local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
		tier = tier,
		name = entity.name,
		type_name = entity.type,
		icon_data = HeatExchanger.get_icon({ tint = tint, pipe_material = "base" }),
	})

	_sprite_utils.icons.apply_icon_assignment(icon_assignment)

	::continue::
end
