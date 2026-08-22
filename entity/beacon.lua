-- Copyright (c) 2024 Kirazy
-- Part of Artisanal Reskins: Nullius
--
-- See LICENSE in the project directory for license information.

local _lib = require("_lib")

local _framework = {
	tiers = require("__reskins-framework__.api.tiers"),
}

local asset_path = "__reskins-assets-base__/graphics/entity/beacon/"
local blend_mode = "additive-soft"

local inputs = {
	type = "beacon",
	icon_name = "beacon",
	base_entity_name = "beacon",
	graphics_mod = "assets-base",
	particles = { ["small"] = 3 },
}

local beacon_map = {
	["nullius-beacon-1"] = { tier = 1, prog_tier = 1, slot_set = "2-slots", scale = 0.4 },
	["nullius-beacon-2"] = { tier = 2, prog_tier = 2, slot_set = "4-slots", scale = 0.45 },
	["nullius-beacon-3"] = { tier = 3, prog_tier = 3, slot_set = "6-slots", scale = 0.5 },
	["nullius-large-beacon-1"] = { tier = 1, prog_tier = 2, tint_tier = 2, slot_set = "2-slots", scale = 0.6 },
	["nullius-large-beacon-2"] = { tier = 2, prog_tier = 3, tint_tier = 3, slot_set = "6-slots", scale = 0.665 },
}

local function scaled_pixel_shift(x, y, scale)
	local multiplier = scale / 0.5
	return util.by_pixel(x * multiplier, y * multiplier)
end

local function scaled_tint(tint, multiplier)
	if not multiplier then
		return tint
	end

	return {
		(tint[1] or tint.r) * multiplier,
		(tint[2] or tint.g) * multiplier,
		(tint[3] or tint.b) * multiplier,
		tint[4] or tint.a,
	}
end

local function beacon_base_animation(slot_set, tint, scale)
	return {
		render_layer = "floor-mechanics",
		always_draw = true,
		animation = {
			layers = {
				{
					filename = asset_path .. slot_set .. "/beacon-" .. slot_set .. "-bottom-base.png",
					width = 212,
					height = 192,
					scale = scale,
					shift = scaled_pixel_shift(0.5, 1, scale),
				},
				{
					filename = asset_path .. slot_set .. "/beacon-" .. slot_set .. "-bottom-mask.png",
					width = 212,
					height = 192,
					scale = scale,
					shift = scaled_pixel_shift(0.5, 1, scale),
					tint = tint,
				},
				{
					filename = asset_path .. slot_set .. "/beacon-" .. slot_set .. "-bottom-highlights.png",
					width = 212,
					height = 192,
					scale = scale,
					shift = scaled_pixel_shift(0.5, 1, scale),
					blend_mode = blend_mode,
				},
				{
					filename = "__base__/graphics/entity/beacon/beacon-shadow.png",
					width = 244,
					height = 176,
					scale = scale,
					shift = scaled_pixel_shift(12.5, 0.5, scale),
					draw_as_shadow = true,
				},
			},
		},
	}
end

local function beacon_top_animation(slot_set, scale, animation_speed)
	return {
		render_layer = "object",
		always_draw = true,
		animation = {
			filename = asset_path .. slot_set .. "/beacon-" .. slot_set .. "-top.png",
			width = 96,
			height = 140,
			scale = scale,
			repeat_count = 45,
			animation_speed = animation_speed,
			shift = scaled_pixel_shift(3, -19, scale),
		},
	}
end

local function beacon_light_animation(scale, animation_speed, apply_tint)
	return {
		render_layer = "object",
		apply_tint = apply_tint,
		always_draw = false,
		animation = {
			filename = "__base__/graphics/entity/beacon/beacon-light.png",
			line_length = 9,
			width = 110,
			height = 186,
			frame_count = 45,
			animation_speed = animation_speed,
			scale = scale,
			shift = scaled_pixel_shift(0.5, -18, scale),
			draw_as_light = true,
			blend_mode = "additive",
		},
	}
end

local function module_slot_overlay(slot_set, tint, scale)
	if slot_set == "4-slots" then
		return {
			render_layer = "transport-belt-circuit-connector",
			always_draw = true,
			animation = {
				filename = asset_path .. slot_set .. "/beacon-" .. slot_set .. "-bottom-slot-overlay.png",
				width = 212,
				height = 192,
				scale = scale,
				shift = scaled_pixel_shift(0.5, 1, scale),
			},
		}
	end

	if slot_set == "6-slots" then
		return {
			render_layer = "transport-belt-circuit-connector",
			always_draw = true,
			animation = {
				layers = {
					{
						filename = asset_path .. slot_set .. "/beacon-" .. slot_set .. "-bottom-slot-overlay-base.png",
						width = 212,
						height = 192,
						scale = scale,
						shift = scaled_pixel_shift(0.5, 1, scale),
					},
					{
						filename = asset_path .. slot_set .. "/beacon-" .. slot_set .. "-bottom-slot-overlay-mask.png",
						width = 212,
						height = 192,
						scale = scale,
						shift = scaled_pixel_shift(0.5, 1, scale),
						tint = tint,
					},
					{
						filename = asset_path .. slot_set .. "/beacon-" .. slot_set .. "-bottom-slot-overlay-highlights.png",
						width = 212,
						height = 192,
						scale = scale,
						shift = scaled_pixel_shift(0.5, 1, scale),
						blend_mode = blend_mode,
					},
				},
			},
		}
	end
end

local function remnant_animation(tint)
	return make_rotated_animation_variations_from_sheet(2, {
		layers = {
			{
				filename = "__base__/graphics/entity/beacon/remnants/beacon-remnants.png",
				direction_count = 1,
				width = 212,
				height = 206,
				shift = util.by_pixel(1, 5),
				scale = 0.5,
			},
			{
				filename = asset_path .. "remnants/beacon-remnants-mask.png",
				direction_count = 1,
				width = 212,
				height = 206,
				shift = util.by_pixel(1, 5),
				tint = tint,
				scale = 0.5,
			},
			{
				filename = asset_path .. "remnants/beacon-remnants-highlights.png",
				direction_count = 1,
				width = 212,
				height = 206,
				shift = util.by_pixel(1, 5),
				blend_mode = blend_mode,
				scale = 0.5,
			},
		},
	})
end

local function reskin_beacon(name, map, tint, make_icons)
	---@type data.BeaconPrototype
	local beacon = data.raw["beacon"][name]
	if not beacon then
		return
	end

	local animation_list = beacon.graphics_set and beacon.graphics_set.animation_list
	local top_speed = animation_list and animation_list[2] and animation_list[2].animation.animation_speed or 0.5
	local light_speed = animation_list and animation_list[3] and animation_list[3].animation.animation_speed or top_speed

	if make_icons then
		local setup_inputs = util.copy(inputs)
		setup_inputs.tint = tint
		_lib.setup_standard_entity(name, map.tier, setup_inputs)

		local remnant = data.raw["corpse"][beacon.corpse]
		if remnant then
			remnant.animation = remnant_animation(tint)
		end
	end

	beacon.graphics_set.animation_list = {
		beacon_base_animation(map.slot_set, tint, map.scale),
		beacon_top_animation(map.slot_set, map.scale, top_speed),
		beacon_light_animation(map.scale, light_speed, true),
		beacon_light_animation(map.scale, light_speed, false),
	}

	local overlay = module_slot_overlay(map.slot_set, tint, map.scale)
	if overlay then
		table.insert(beacon.graphics_set.animation_list, overlay)
	end
end

for name, map in pairs(beacon_map) do
	local tier = map.tint_tier or _framework.tiers.get_tier(map)
	local tint = _framework.tiers.get_tint(tier)
	reskin_beacon(name, map, tint, true)
end

for i = 1, 3 do
	local base_map = beacon_map["nullius-beacon-" .. i]
	local tier = base_map.tint_tier or _framework.tiers.get_tier(base_map)
	local tint = _framework.tiers.get_tint(tier)

	for j = 1, 4 do
		reskin_beacon("nullius-beacon-" .. i .. "-" .. j, base_map, scaled_tint(tint, 1 - (j * 0.1)), false)
	end
end
