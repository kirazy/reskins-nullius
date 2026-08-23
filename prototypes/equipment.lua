local _lib = require("_lib")
local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local icon_helpers = require("__reskins-assets-api__.api.icon-helpers")

local BASE_EQUIPMENT_PATH = "__reskins-assets-base__/graphics/equipment/"
local BASE_ICON_PATH = "__reskins-assets-base__/graphics/icons/"

local BOBS_EQUIPMENT_PATH = "__reskins-assets-bobs__/graphics/equipment/"
local BOBS_ICON_PATH = "__reskins-assets-bobs__/graphics/icons/"

local NULLIUS_ICON_PATH = "__nullius__/graphics/icons/"

local function make_equipment_sprite(path, width, height, scale, tint)
	return {
		layers = {
			{
				filename = path .. "base.png",
				width = width,
				height = height,
				priority = "medium",
				scale = scale,
			},
			{
				filename = path .. "mask.png",
				width = width,
				height = height,
				priority = "medium",
				scale = scale,
				tint = tint,
			},
			{
				filename = path .. "highlights.png",
				width = width,
				height = height,
				priority = "medium",
				scale = scale,
				blend_mode = "additive",
			},
		},
	}
end

-- ============================================================================
-- Leg augmentation equipment
-- ============================================================================

local leg_augmentations = {
	["nullius-leg-augmentation-1"] = { tier = 1, scale = 0.687 },
	["nullius-leg-augmentation-2"] = { tier = 2, scale = 0.687 },
	["nullius-leg-augmentation-3"] = { tier = 3, scale = 0.687 },
	["nullius-leg-augmentation-4"] = { tier = 4, scale = 0.55 },
}

local exoskeleton_icon_creator_fn = icon_helpers.make_tinted_three_layer_icon_creator_fn({
	folder = "__reskins-assets-base__/graphics/icons",
	icon_name = "equipment-exoskeleton",
})

for name, options in pairs(leg_augmentations) do
	local tint = _framework.tiers.get_tint(options.tier)
	local deferrable_icon = _framework.tiers.deferrable_icon_with_tier_labels({
		tier = options.tier,
		name = name,
		type_name = "movement-bonus-equipment",
		icon_data = exoskeleton_icon_creator_fn(tint),
	})

	_sprite_utils.icons.assign_deferrable_icon(deferrable_icon)

	local equipment = data.raw["movement-bonus-equipment"] and data.raw["movement-bonus-equipment"][name]
	if equipment ~= nil then
		equipment.sprite = make_equipment_sprite(
			BASE_EQUIPMENT_PATH .. "equipment-exoskeleton/equipment-exoskeleton-",
			128,
			256,
			options.scale,
			tint
		)
	end
end

-- ============================================================================
-- Night vision equipment
-- ============================================================================

local night_vision_equipment = {
	["nullius-night-vision-1"] = { tier = 1, scale = 1.2 },
	["nullius-night-vision-2"] = { tier = 2, scale = 0.5 },
	["nullius-night-vision-3"] = { tier = 3, scale = 0.5 },
}

local night_vision_icon_creator_fn = icon_helpers.make_tinted_three_layer_icon_creator_fn({
	folder = "__reskins-assets-base__/graphics/icons",
	icon_name = "equipment-night-vision",
})

for name, options in pairs(night_vision_equipment) do
	local tint = _framework.tiers.get_tint(options.tier)
	local deferrable_icon = _framework.tiers.deferrable_icon_with_tier_labels({
		tier = options.tier,
		name = name,
		type_name = "night-vision-equipment",
		icon_data = night_vision_icon_creator_fn(tint),
	})

	_sprite_utils.icons.assign_deferrable_icon(deferrable_icon)

	local equipment = data.raw["night-vision-equipment"] and data.raw["night-vision-equipment"][name]
	if equipment ~= nil then
		equipment.sprite = make_equipment_sprite(
			BASE_EQUIPMENT_PATH .. "equipment-night-vision/equipment-night-vision-",
			128,
			128,
			options.scale,
			tint
		)
	end
end

-- ============================================================================
-- Generator equipment
-- ============================================================================

local generator_equipment = {
	["nullius-portable-generator-1"] = { tier = 1, scale = 0.5 },
	["nullius-portable-generator-2"] = { tier = 2, scale = 0.75 },
	["nullius-portable-generator-backup"] = { tier = 3, scale = 0.75 },
	["nullius-portable-reactor"] = { tier = 4, scale = 1 },
}

local fission_reactor_icon_creator_fn = icon_helpers.make_tinted_three_layer_icon_creator_fn({
	folder = "__reskins-assets-base__/graphics/icons",
	icon_name = "equipment-fission-reactor",
})

for name, options in pairs(generator_equipment) do
	local tint = _framework.tiers.get_tint(options.tier)
	local deferrable_icon = _framework.tiers.deferrable_icon_with_tier_labels({
		tier = options.tier,
		name = name,
		type_name = "generator-equipment",
		icon_data = fission_reactor_icon_creator_fn(tint),
	})

	_sprite_utils.icons.assign_deferrable_icon(deferrable_icon)

	local equipment = data.raw["generator-equipment"] and data.raw["generator-equipment"][name]
	if equipment ~= nil then
		equipment.sprite = make_equipment_sprite(
			BOBS_EQUIPMENT_PATH .. "equipment-fission-reactor/equipment-fission-reactor-",
			256,
			256,
			options.scale,
			tint
		)
	end
end
