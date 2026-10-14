local _lib = require("_lib")
local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local ENTITY_PATH = "__reskins-assets-bobs__/graphics/entity/robo-charge-port/"
local ICON_PATH = "__reskins-assets-bobs__/graphics/icons/roboport-charge-pad/"
local EQUIPMENT_PATH = "__reskins-assets-bobs__/graphics/equipment/equipment-part-charge-pad/"
local BASE_ROBOPORT_PATH = "__reskins-assets-base__/graphics/entity/roboport/"

local chargers = {
	["nullius-charger-1"] = { tier = 1, prog_tier = 2, image_index = 1, scale = 1, equipment_scale = 1 },
	["nullius-charger-2"] = { tier = 2, prog_tier = 3, image_index = 2, scale = 1, equipment_scale = 1 },
	["nullius-charger-3"] = { tier = 3, prog_tier = 4, image_index = 3, scale = 1, equipment_scale = 1 },
	["nullius-charger-4"] = { tier = 4, prog_tier = 5, image_index = 4, scale = 0.5, equipment_scale = 0.6 },
}

local triangle_offsets = {
	{ 0, -0.35 },
	{ -0.47, 0.35 },
	{ 0.47, 0.35 },
}

local function make_icon(image_index, tint)
	return {
		{
			icon = ICON_PATH .. "roboport-charge-pad-" .. image_index .. "-base.png",
			icon_size = 64,
			mipmap_count = 4,
		},
		{
			icon = ICON_PATH .. "roboport-charge-pad-mask.png",
			icon_size = 64,
			mipmap_count = 4,
			tint = tint,
		},
		{
			icon = ICON_PATH .. "roboport-charge-pad-highlights.png",
			icon_size = 64,
			mipmap_count = 4,
		},
	}
end

local function make_equipment_sprite(image_index, tint, scale)
	return {
		layers = {
			{
				filename = EQUIPMENT_PATH .. "equipment-part-charge-pad-" .. image_index .. "-base.png",
				size = 64,
				priority = "medium",
				flags = { "no-crop" },
				scale = scale,
			},
			{
				filename = EQUIPMENT_PATH .. "equipment-part-charge-pad-mask.png",
				size = 64,
				priority = "medium",
				flags = { "no-crop" },
				tint = tint,
				scale = scale,
			},
			{
				filename = EQUIPMENT_PATH .. "equipment-part-charge-pad-highlights.png",
				size = 64,
				priority = "medium",
				flags = { "no-crop" },
				blend_mode = "additive-soft",
				scale = scale,
			},
		},
	}
end

local function make_charge_port_layers(shift_x, shift_y, image_index, tint, scale)
	local shift = { shift_x, shift_y }
	local sprite_scale = 0.5 * scale

	return {
		{
			filename = ENTITY_PATH .. "robo-charge-port-" .. image_index .. "-base.png",
			priority = "medium",
			animation_speed = 0.2,
			width = 60,
			height = 56,
			repeat_count = 12,
			shift = shift,
			scale = sprite_scale,
		},
		{
			filename = ENTITY_PATH .. "robo-charge-port-mask.png",
			priority = "medium",
			animation_speed = 0.2,
			width = 60,
			height = 56,
			repeat_count = 12,
			shift = shift,
			tint = tint,
			scale = sprite_scale,
		},
		{
			filename = ENTITY_PATH .. "robo-charge-port-highlights.png",
			priority = "medium",
			animation_speed = 0.2,
			width = 60,
			height = 56,
			repeat_count = 12,
			shift = shift,
			blend_mode = "additive-soft",
			scale = sprite_scale,
		},
		{
			filename = ENTITY_PATH .. "robo-charge-port-shadow.png",
			priority = "medium",
			animation_speed = 0.2,
			width = 70,
			height = 58,
			repeat_count = 12,
			shift = util.by_pixel(shift_x * 32 + 2.5 * scale, shift_y * 32 + 0.5 * scale),
			draw_as_shadow = true,
			scale = sprite_scale,
		},
		{
			filename = ENTITY_PATH .. "robo-charge-port-lights-mask.png",
			priority = "medium",
			animation_speed = 0.2,
			width = 32,
			height = 32,
			frame_count = 12,
			shift = util.by_pixel(shift_x * 32, shift_y * 32 + scale),
			draw_as_glow = true,
			tint = tint,
			scale = sprite_scale,
		},
		{
			filename = ENTITY_PATH .. "robo-charge-port-lights-highlights.png",
			priority = "medium",
			animation_speed = 0.2,
			width = 32,
			height = 32,
			frame_count = 12,
			shift = util.by_pixel(shift_x * 32, shift_y * 32 + scale),
			draw_as_glow = true,
			blend_mode = "additive",
			scale = sprite_scale,
		},
	}
end

local function make_triangle_layers(image_index, tint, scale)
	local layers = {}

	for _, offset in pairs(triangle_offsets) do
		local charge_port_layers = make_charge_port_layers(offset[1] * scale, offset[2] * scale, image_index, tint, scale)

		for _, layer in pairs(charge_port_layers) do
			layers[#layers + 1] = layer
		end
	end

	return layers
end

local function make_recharging_animation(scale)
	return {
		filename = BASE_ROBOPORT_PATH .. "roboport-recharging.png",
		priority = "high",
		width = 37,
		height = 35,
		frame_count = 16,
		scale = 1.5 * scale,
		animation_speed = 0.5,
	}
end

for name, options in pairs(chargers) do
	local entity = data.raw["roboport"] and data.raw["roboport"][name]

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
		tier = tier,
		name = name,
		type_name = "roboport",
		icon_data = make_icon(options.image_index, tint),
	})

	_sprite_utils.icons.apply_icon_assignment(icon_assignment)

	local equipment = data.raw["roboport-equipment"] and data.raw["roboport-equipment"][name]
	if equipment then
		equipment.sprite = make_equipment_sprite(options.image_index, tint, options.equipment_scale)
	end

	if entity then
		entity.base_animation = {
			layers = make_triangle_layers(options.image_index, tint, options.scale),
		}

		entity.recharging_animation = make_recharging_animation(options.scale)
	end
end
