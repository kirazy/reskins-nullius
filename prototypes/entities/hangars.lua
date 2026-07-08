-- Copyright (c) 2024 Kirazy
-- Part of Artisanal Reskins: Nullius
--
-- See LICENSE in the project directory for license information.

local _lib = require("_lib")
local _framework = {
	tiers = require("__reskins-framework__.api.tiers"),
}

local base_path = "__reskins-assets-base__/graphics/entity/roboport/"
local bobs_path = "__reskins-assets-bobs__/graphics/entity/roboport/"

local inputs = {
	type = "roboport",
	icon_name = "roboport",
	base_entity_name = "roboport",
	graphics_mod = "assets-bobs",
	particles = { ["medium"] = 2 },
}

local tier_map = {
	["nullius-hangar-1"] = { tier = 1, prog_tier = 2, image_index = 1, scale = 0.75 },
	["nullius-hangar-2"] = { tier = 2, prog_tier = 3, image_index = 2, scale = 0.75 },
	["nullius-hangar-3"] = { tier = 3, prog_tier = 4, image_index = 3, scale = 0.75 },
	["nullius-hangar-4"] = { tier = 4, prog_tier = 5, image_index = 4, scale = 0.5 },
	["nullius-hangar-construction-1"] = { tier = 1, prog_tier = 2, image_index = 1, scale = 0.75, antenna_image_index = 4, antenna_tint = { 0.9, 0.8, 0.7 } },
	["nullius-hangar-construction-2"] = { tier = 2, prog_tier = 3, image_index = 2, scale = 0.75, antenna_image_index = 3, antenna_tint = { 0.85, 1, 0.9 } },
	["nullius-hangar-construction-3"] = { tier = 3, prog_tier = 4, image_index = 3, scale = 0.75, antenna_image_index = 3, antenna_tint = { 1, 1, 0.75 } },
	["nullius-hangar-construction-4"] = { tier = 4, prog_tier = 5, image_index = 4, scale = 0.5, antenna_image_index = 3, antenna_tint = { 0.7, 0.7, 0.7 } },
}

for name, map in pairs(tier_map) do
	---@type data.RoboportPrototype
	local entity = data.raw[inputs.type][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(map)
	inputs.icon_base = "roboport-" .. map.image_index
	inputs.tint = _framework.tiers.get_tint(tier)

	_lib.setup_standard_entity(name, tier, inputs)

	local remnant = data.raw["corpse"][entity.corpse]
	if remnant then
		remnant.animation = make_rotated_animation_variations_from_sheet(2, {
			layers = {
				{
					filename = base_path .. "remnants/roboport-remnants.png",
					width = 364,
					height = 358,
					direction_count = 1,
					shift = util.by_pixel(2, 8),
					scale = 0.5,
				},
				{
					filename = base_path .. "remnants/roboport-remnants-mask.png",
					width = 364,
					height = 358,
					direction_count = 1,
					shift = util.by_pixel(2, 8),
					tint = inputs.tint,
					scale = 0.5,
				},
				{
					filename = base_path .. "remnants/roboport-remnants-highlights.png",
					width = 364,
					height = 358,
					direction_count = 1,
					shift = util.by_pixel(2, 8),
					blend_mode = "additive-soft",
					scale = 0.5,
				},
			},
		})
	end

	entity.spawn_and_station_height = -0.1
	entity.base = {
		layers = {
			{
				filename = base_path .. "roboport-base.png",
				width = 228,
				height = 277,
				shift = _lib.scaled_pixel(2, 7.75, map.scale),
				scale = 0.5 * map.scale,
			},
			{
				filename = base_path .. "roboport-base-mask.png",
				width = 228,
				height = 277,
				shift = _lib.scaled_pixel(2, 7.75, map.scale),
				tint = inputs.tint,
				scale = 0.5 * map.scale,
			},
			{
				filename = base_path .. "roboport-base-highlights.png",
				width = 228,
				height = 277,
				shift = _lib.scaled_pixel(2, 7.75, map.scale),
				blend_mode = "additive-soft",
				scale = 0.5 * map.scale,
			},
			{
				filename = base_path .. "roboport-shadow.png",
				width = 294,
				height = 201,
				draw_as_shadow = true,
				shift = _lib.scaled_pixel(28.5, 19.25, map.scale),
				scale = 0.5 * map.scale,
			},
		},
	}

	entity.base_patch = {
		layers = {
			{
				filename = base_path .. "roboport-base-patch.png",
				priority = "medium",
				width = 138,
				height = 100,
				shift = _lib.scaled_pixel(1.5, 5, map.scale),
				scale = 0.5 * map.scale,
			},
			{
				filename = base_path .. "roboport-base-patch-mask.png",
				priority = "medium",
				width = 138,
				height = 100,
				shift = _lib.scaled_pixel(1.5, 5, map.scale),
				tint = inputs.tint,
				scale = 0.5 * map.scale,
			},
			{
				filename = base_path .. "roboport-base-patch-highlights.png",
				priority = "medium",
				width = 138,
				height = 100,
				shift = _lib.scaled_pixel(1.5, 5, map.scale),
				blend_mode = "additive-soft",
				scale = 0.5 * map.scale,
			},
		},
	}

	entity.base_animation = {
		filename = bobs_path .. "antennas/roboport-" .. (map.antenna_image_index or map.image_index) .. "-base-animation.png",
		priority = "medium",
		width = 83,
		height = 59,
		frame_count = 8,
		animation_speed = 0.5,
		shift = _lib.scaled_pixel(-17.75, -61.25, map.scale),
		tint = map.antenna_tint,
		scale = 0.5 * map.scale,
	}

	entity.door_animation_up = {
		filename = bobs_path .. "doors/roboport-" .. map.image_index .. "-door-up.png",
		priority = "medium",
		width = 97,
		height = 38,
		frame_count = 16,
		shift = _lib.scaled_pixel(-0.25, -29.5, map.scale),
		scale = 0.5 * map.scale,
	}

	entity.door_animation_down = {
		filename = bobs_path .. "doors/roboport-" .. map.image_index .. "-door-down.png",
		priority = "medium",
		width = 97,
		height = 41,
		frame_count = 16,
		shift = _lib.scaled_pixel(-0.25, -9.75, map.scale),
		scale = 0.5 * map.scale,
	}

	entity.recharging_animation = {
		filename = base_path .. "roboport-recharging.png",
		priority = "high",
		width = 37,
		height = 35,
		frame_count = 16,
		scale = 1.5 * map.scale,
		animation_speed = 0.5,
	}

	::continue::
end
