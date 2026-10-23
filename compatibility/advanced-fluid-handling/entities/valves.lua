if not mods["underground-pipe-pack"] then
	return
end

local _lib = require("_lib")
local _assets = { defines = require("__reskins-assets-api__.api.defines") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local Applicators = require("__reskins-assets-api__.api.applicators")
local Pipe = require("__reskins-assets-api__.assets.base.entities.pipe")

local valves = {
	["check-valve"] = {
		tint = util.color("#8dd24e"),
	},
	["overflow-valve"] = {
		tint = util.color("#d4933f"),
		has_increments = true,
	},
	["top-up-valve"] = {
		tint = util.color("#fcfcfc"),
		has_increments = true,
	},
}

local increments = { "10", "20", "30", "40", "50", "60", "70", "80", "90" }
local shifts = {
	util.by_pixel(0, -16.5),
	util.by_pixel(4, -11.5),
	util.by_pixel(0, -6),
	util.by_pixel(-4, -11.5),
}

local function make_animations_direction_layers(offset, tint, increment)
	local x = 128 * offset
	local animation = {
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

	if increment then
		table.insert(animation.layers, {
			filename = "__underground-pipe-pack__/graphics/entity/valves/top-up/" .. increment .. ".png",
			priority = "extra-high",
			width = 38,
			height = 28,
			tint = tint,
			scale = 0.4,
			shift = shifts[offset + 1],
		})
	end

	return animation
end

local function make_animations(tint, increment)
	return {
		north = make_animations_direction_layers(2, tint, increment),
		east = make_animations_direction_layers(3, tint, increment),
		south = make_animations_direction_layers(0, tint, increment),
		west = make_animations_direction_layers(1, tint, increment),
	}
end

local function handle_valve_variant(name, tint, increment)
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

	entity.animations = make_animations(tint, increment)
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
	if options.has_increments then
		for _, increment in pairs(increments) do
			handle_valve_variant(increment .. "-" .. valve, options.tint, increment)
		end
	else
		handle_valve_variant(valve, options.tint)
	end
end
