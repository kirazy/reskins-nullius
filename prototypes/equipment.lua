local _lib = require("_lib")

local BASE_EQUIPMENT_PATH = "__reskins-assets-base__/graphics/equipment/"
local BASE_ICON_PATH = "__reskins-assets-base__/graphics/icons/"

local BOBS_EQUIPMENT_PATH = "__reskins-assets-bobs__/graphics/equipment/"
local BOBS_ICON_PATH = "__reskins-assets-bobs__/graphics/icons/"

local NULLIUS_ICON_PATH = "__nullius__/graphics/icons/"

local do_equipment = _lib.is_scope_enabled("equipment")
local do_items = _lib.is_scope_enabled("items-and-fluids")

local function assign_icons(type_name, name, icon_data)
	if not do_items then
		return
	end

	_lib.assign_icons_to_prototype(type_name, name, icon_data)
end

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

local function assign_item_and_recipe_icons(name, item_type, icon_data)
	assign_icons(item_type or "item", name, icon_data)
	assign_icons("recipe", name, icon_data)
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

for name, options in pairs(leg_augmentations) do
	local tint = _lib.get_tier_tint(options.tier)
	local icon = _lib.add_tier_labels_to_icons(
		options.tier,
		_lib.make_layered_icon(BASE_ICON_PATH .. "equipment-exoskeleton/equipment-exoskeleton-icon-", tint)
	)

	assign_item_and_recipe_icons(name, "item", icon)

	local equipment =
		data.raw["movement-bonus-equipment"]
		and data.raw["movement-bonus-equipment"][name]

	if do_equipment and equipment then
		equipment.sprite =
			make_equipment_sprite(
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

for name, options in pairs(night_vision_equipment) do
	local tint = _lib.get_tier_tint(options.tier)
	local icon = _lib.add_tier_labels_to_icons(
		options.tier,
		_lib.make_layered_icon(BASE_ICON_PATH .. "equipment-night-vision/equipment-night-vision-icon-", tint)
	)

	assign_item_and_recipe_icons(name, "item", icon)

	local equipment =
		data.raw["night-vision-equipment"]
		and data.raw["night-vision-equipment"][name]

	if do_equipment and equipment then
		equipment.sprite =
			make_equipment_sprite(
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

for name, options in pairs(generator_equipment) do
	local tint = _lib.get_tier_tint(options.tier)
	local icon = _lib.add_tier_labels_to_icons(
		options.tier,
		_lib.make_layered_icon(BOBS_ICON_PATH .. "equipment-fission-reactor/equipment-fission-reactor-icon-", tint)
	)

	assign_item_and_recipe_icons(name, "item", icon)

	local equipment =
		data.raw["generator-equipment"]
		and data.raw["generator-equipment"][name]

	if do_equipment and equipment then
		equipment.sprite =
			make_equipment_sprite(
				BOBS_EQUIPMENT_PATH .. "equipment-fission-reactor/equipment-fission-reactor-",
				256,
				256,
				options.scale,
				tint
			)
	end
end

local backup_generator_icon =
	data.raw.item
	and data.raw.item["nullius-portable-generator-backup"]
	and data.raw.item["nullius-portable-generator-backup"].icons

if do_items and backup_generator_icon then
	local reprioritization_icons =
		util.table.deepcopy(backup_generator_icon)

	-- Keep Nullius' existing up-arrow overlay for the backup generator reprioritization recipe.
	reprioritization_icons[#reprioritization_icons + 1] = {
		icon = NULLIUS_ICON_PATH .. "up.png",
		icon_size = 64,
		scale = 0.3,
		shift = { 8, -6 },
	}

	assign_icons(
		"recipe",
		"nullius-portable-generator-reprioritization",
		reprioritization_icons
	)
end


-- ============================================================================
-- Repair pack
-- ============================================================================

local self_repair_icon =
	_lib.make_layered_icon(
		BASE_ICON_PATH .. "repair-pack/repair-pack-icon-",
		_lib.get_tier_tint(4)
	)

assign_icons("capsule", "nullius-self-repair-pack", self_repair_icon)
assign_icons("recipe", "nullius-self-repair-pack", self_repair_icon)
