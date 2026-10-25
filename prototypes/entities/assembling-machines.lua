---@using data

local _lib = require("_lib")
local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = {
	icons = require("__reskins-sprite-utils__.icons"),
	sprites = require("__reskins-sprite-utils__.sprites"),
}

local Applicators = require("__reskins-assets-api__.api.applicators")
local AssemblingMachine = require("__reskins-assets-api__.assets.base.entities.assembling-machine")

local small_icon_scale = 0.8
local medium_icon_scale = 0.9

local entities = {
	["nullius-small-assembler-1"] = {
		type = "assembling-machine",
		tier = 1,
		prog_tier = 1,
		machine_tier = 1, -- crafting speed: 0.5
		scale_factor = 2 / 3,
		icon_scalar = small_icon_scale,
	},
	["nullius-small-assembler-2"] = {
		type = "assembling-machine",
		tier = 2,
		prog_tier = 2,
		machine_tier = 2, -- crafting speed: 1
		scale_factor = 2 / 3,
		icon_scalar = small_icon_scale,
	},
	["nullius-small-assembler-3"] = {
		type = "assembling-machine",
		tier = 3,
		prog_tier = 3,
		machine_tier = 3, -- crafting speed: 2
		scale_factor = 2 / 3,
		icon_scalar = small_icon_scale,
	},
	["nullius-medium-assembler-1"] = {
		type = "assembling-machine",
		tier = 1,
		prog_tier = 2,
		machine_tier = 2, -- crafting speed: 1
		icon_scalar = medium_icon_scale,
	},
	["nullius-medium-assembler-2"] = {
		type = "assembling-machine",
		tier = 2,
		prog_tier = 3,
		machine_tier = 3, -- crafting speed: 2
		icon_scalar = medium_icon_scale,
	},
	["nullius-medium-assembler-3"] = {
		type = "assembling-machine",
		tier = 3,
		prog_tier = 4,
		machine_tier = 4, -- crafting speed: 4
		icon_scalar = medium_icon_scale,
	},
	["nullius-large-assembler-1"] = {
		type = "assembling-machine",
		tier = 1,
		prog_tier = 4,
		machine_tier = 5, -- crafting speed: 4
		scale_factor = 4 / 3,
	},
	["nullius-large-assembler-2"] = {
		type = "assembling-machine",
		tier = 2,
		prog_tier = 5,
		machine_tier = 6, -- crafting speed: 8
		scale_factor = 4 / 3,
	},
}

for name, options in pairs(entities) do
	local entity = data.raw[options.type][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	_lib.create_explosions_and_particles(name, {
		base_entity_name = "assembling-machine-1",
		type = "assembling-machine",
		tint = tint,
		particles = {
			["big"] = 1,
			["medium"] = 2,
		},
	})

	local corpse = _lib.create_remnant(name, {
		base_entity_name = "assembling-machine-1",
		type = "assembling-machine",
	})
	if options.scale_factor then
		_sprite_utils.sprites.rescale_prototype(corpse, options.scale_factor)
	end

	local sprite_set = AssemblingMachine.get_sprite_set({
		tint = tint,
		machine_tier = options.machine_tier,
	})

	Applicators.apply_sprite_set(entity, sprite_set)
	Applicators.apply_sprite_set(corpse, sprite_set)

	local icon_data = AssemblingMachine.get_icon({ machine_tier = options.machine_tier, tint = tint })
	local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
		tier = tier,
		name = name,
		type_name = options.type,
		icon_data = options.icon_scalar and _sprite_utils.icons.minify_icon(icon_data, options.icon_scalar) or icon_data,
	})

	_sprite_utils.icons.apply_icon_assignment(icon_assignment)

	::continue::
end
