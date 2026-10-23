---@namespace Reskins.Nullius.Prototypes.Entities

local _lib = require("_lib")
local _assets = { defines = require("__reskins-assets-api__.api.defines") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local Applicators = require("__reskins-assets-api__.api.applicators")
local Pipe = require("__reskins-assets-api__.assets.base.entities.pipe")

local valves = {
	["nullius-one-way-valve"] = {
		tint = util.color("#689ed3"),
	},
}

local function make_animations_direction_layers(offset, tint)
	local x = 128 * offset
	return {
		layers = {
			{
				filename = "__reskins-assets-angels__/graphics/entity/pipe-valve/pipe-valve-base.png",
				priority = "extra-high",
				x = x,
				width = 128,
				height = 128,
				scale = 0.5,
			},
			{
				filename = "__reskins-assets-angels__/graphics/entity/pipe-valve/pipe-valve-mask.png",
				priority = "extra-high",
				x = x,
				width = 128,
				height = 128,
				tint = tint,
				scale = 0.5,
			},
		},
	}
end

local function make_animations(tint)
	return {
		north = make_animations_direction_layers(0, tint),
		east = make_animations_direction_layers(1, tint),
		south = make_animations_direction_layers(2, tint),
		west = make_animations_direction_layers(3, tint),
	}
end

local function handle_valve_variant(name, tint)
	local entity = data.raw["valve"][name]
	if not entity then
		return
	end

	_lib.create_explosions_and_particles(name, {
		base_entity_name = "pipe",
		type = "valve",
		tint = Pipe.get_material_tint({ material = _assets.defines.pipe_material.iron }),
		particles = {
			["medium"] = 1,
			["small"] = 2,
		},
	})

	local corpse = _lib.create_remnant(name, {
		base_entity_name = "pipe",
		type = "valve",
	})

	local sprite_set = Pipe.get_sprite_set({ pipe_material = _assets.defines.pipe_material.iron })

	entity.animations = make_animations(tint)
	Applicators.apply_sprite_set(corpse, sprite_set)

	_sprite_utils.icons.apply_icon_assignment({
		name = name,
		type_name = "valve",
		icon_data = {
			{
				icon = "__reskins-assets-angels__/graphics/icons/pipe-valve/pipe-valve-base.png",
				icon_size = 64,
			},
			{
				icon = "__reskins-assets-angels__/graphics/icons/pipe-valve/pipe-valve-mask.png",
				icon_size = 64,
				tint = tint,
			},
		},
	})
end

for valve, options in pairs(valves) do
	handle_valve_variant(valve, options.tint)
end
