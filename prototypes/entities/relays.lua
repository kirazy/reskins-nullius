-- Copyright (c) 2024 Kirazy
-- Part of Artisanal Reskins: Nullius
--
-- See LICENSE in the project directory for license information.

local _lib = require("_lib")
local _framework = {
	tiers = require("__reskins-framework__.api.tiers"),
}

local expander_path = "__reskins-assets-bobs__/graphics/entity/robo-zone-expander/"
local roboport_path = "__reskins-assets-bobs__/graphics/entity/roboport/"

local empty_sprite = {
	filename = "__core__/graphics/empty.png",
	priority = "medium",
	width = 1,
	height = 1,
	frame_count = 1,
}

local empty_animation = {
	filename = "__core__/graphics/empty.png",
	priority = "medium",
	width = 1,
	height = 1,
	frame_count = 1,
}

local inputs = {
	type = "roboport",
	icon_name = "robo-zone-expander",
	icon_mask = "zone-expander",
	icon_highlights = "zone-expander",
	base_entity_name = "roboport",
	graphics_mod = "assets-bobs",
	particles = { ["medium"] = 2 },
	make_remnants = false,
}

local tier_map = {
	["nullius-relay-1"] = { tier = 1, prog_tier = 2, image_index = 1, scale = 0.6 },
	["nullius-relay-2"] = { tier = 2, prog_tier = 3, image_index = 2, scale = 0.6 },
	["nullius-relay-3"] = { tier = 3, prog_tier = 4, image_index = 3, scale = 0.6 },
	["nullius-relay-4"] = { tier = 4, prog_tier = 5, image_index = 4, scale = 0.6 },
	["nullius-relay-construction-1"] = { tier = 1, prog_tier = 2, image_index = 1, scale = 0.6, antenna_image_index = 4, antenna_tint = { 0.9, 0.8, 0.7 } },
	["nullius-relay-construction-2"] = { tier = 2, prog_tier = 3, image_index = 2, scale = 0.6, antenna_image_index = 3, antenna_tint = { 0.85, 1, 0.9 } },
	["nullius-relay-construction-3"] = { tier = 3, prog_tier = 4, image_index = 3, scale = 0.6, antenna_image_index = 3, antenna_tint = { 1, 1, 0.75 } },
	["nullius-relay-construction-4"] = { tier = 4, prog_tier = 5, image_index = 4, scale = 0.6, antenna_image_index = 1, antenna_tint = { 0.7, 0.7, 0.7 } },
}

for name, map in pairs(tier_map) do
	---@type data.RoboportPrototype
	local entity = data.raw[inputs.type][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(map)
	inputs.icon_base = "zone-expander-" .. map.image_index
	inputs.tint = _framework.tiers.get_tint(tier)

	_lib.setup_standard_entity(name, tier, inputs)

	entity.base = {
		layers = {
			{
				filename = expander_path .. "robo-zone-expander-" .. map.image_index .. "-base.png",
				width = 56,
				height = 156,
				shift = _lib.scaled_pixel(0.5, -29.5, map.scale),
				scale = 0.5 * map.scale,
			},
			{
				filename = expander_path .. "robo-zone-expander-mask.png",
				width = 38,
				height = 30,
				shift = _lib.scaled_pixel(0.5, 0, map.scale),
				tint = inputs.tint,
				scale = 0.5 * map.scale,
			},
			{
				filename = expander_path .. "robo-zone-expander-highlights.png",
				width = 38,
				height = 30,
				shift = _lib.scaled_pixel(0.5, 0, map.scale),
				blend_mode = "additive-soft",
				scale = 0.5 * map.scale,
			},
		},
	}

	entity.base_animation = {
		layers = {
			{
				filename = roboport_path .. "antennas/roboport-" .. (map.antenna_image_index or map.image_index) .. "-base-animation.png",
				priority = "medium",
				width = 83,
				height = 59,
				frame_count = 8,
				animation_speed = 0.5,
				shift = _lib.scaled_pixel(0.25, -66, map.scale),
				tint = map.antenna_tint,
				scale = 0.5 * map.scale,
			},
			{
				filename = expander_path .. "robo-zone-expander-shadow.png",
				width = 228,
				height = 60,
				frame_count = 8,
				shift = _lib.scaled_pixel(44.5, -1.5, map.scale),
				draw_as_shadow = true,
				scale = 0.5 * map.scale,
			},
		},
	}

	entity.base_patch = util.copy(empty_sprite)
	entity.door_animation_up = util.copy(empty_animation)
	entity.door_animation_down = util.copy(empty_animation)

	entity.water_reflection = {
		pictures = {
			filename = expander_path .. "robo-zone-expander-reflection.png",
			priority = "extra-high",
			width = 12,
			height = 23,
			shift = _lib.scaled_pixel(0, 45, map.scale),
			variation_count = 1,
			scale = 5 * map.scale,
		},
		rotate = false,
		orientation_to_variation = false,
	}

	::continue::
end
