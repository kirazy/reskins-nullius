local _sprites = require("__reskins-sprite-utils__.sprites")
local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _lib = require("_lib")

---
---Gets the standard working visualisations for a chemical plant. This is the Factorio default.
---
---### Returns
---@return data.WorkingVisualisation # The complete set of working visualisations.
---@nodiscard
local function get_chemical_plant_standard_working_visualisations()
	---@type data.WorkingVisualisation
	local working_visualisation = {
		{
			apply_recipe_tint = "primary",
			north_animation = {
				filename = "__base__/graphics/entity/chemical-plant/chemical-plant-liquid-north.png",
				frame_count = 24,
				line_length = 6,
				width = 66,
				height = 44,
				shift = util.by_pixel(23, 15),
				scale = 0.5,
			},
			east_animation = {
				filename = "__base__/graphics/entity/chemical-plant/chemical-plant-liquid-east.png",
				frame_count = 24,
				line_length = 6,
				width = 70,
				height = 36,
				shift = util.by_pixel(0, 22),
				scale = 0.5,
			},
			south_animation = {
				filename = "__base__/graphics/entity/chemical-plant/chemical-plant-liquid-south.png",
				frame_count = 24,
				line_length = 6,
				width = 66,
				height = 42,
				shift = util.by_pixel(0, 17),
				scale = 0.5,
			},
			west_animation = {
				filename = "__base__/graphics/entity/chemical-plant/chemical-plant-liquid-west.png",
				frame_count = 24,
				line_length = 6,
				width = 74,
				height = 36,
				shift = util.by_pixel(-10, 13),
				scale = 0.5,
			},
		},
		{
			apply_recipe_tint = "secondary",
			north_animation = {
				filename = "__base__/graphics/entity/chemical-plant/chemical-plant-foam-north.png",
				frame_count = 24,
				line_length = 6,
				width = 62,
				height = 42,
				shift = util.by_pixel(24, 15),
				scale = 0.5,
			},
			east_animation = {
				filename = "__base__/graphics/entity/chemical-plant/chemical-plant-foam-east.png",
				frame_count = 24,
				line_length = 6,
				width = 68,
				height = 36,
				shift = util.by_pixel(0, 22),
				scale = 0.5,
			},
			south_animation = {
				filename = "__base__/graphics/entity/chemical-plant/chemical-plant-foam-south.png",
				frame_count = 24,
				line_length = 6,
				width = 60,
				height = 40,
				shift = util.by_pixel(1, 17),
				scale = 0.5,
			},
			west_animation = {
				filename = "__base__/graphics/entity/chemical-plant/chemical-plant-foam-west.png",
				frame_count = 24,
				line_length = 6,
				width = 68,
				height = 28,
				shift = util.by_pixel(-9, 15),
				scale = 0.5,
			},
		},
		{
			apply_recipe_tint = "tertiary",
			fadeout = true,
			constant_speed = true,
			north_position = util.by_pixel_hr(-30, -161),
			east_position = util.by_pixel_hr(29, -150),
			south_position = util.by_pixel_hr(12, -134),
			west_position = util.by_pixel_hr(-32, -130),
			render_layer = "wires",
			animation = {
				filename = "__base__/graphics/entity/chemical-plant/chemical-plant-smoke-outer.png",
				frame_count = 47,
				line_length = 16,
				width = 90,
				height = 188,
				animation_speed = 0.5,
				shift = util.by_pixel(-2, -40),
				scale = 0.5,
			},
		},
		{
			apply_recipe_tint = "quaternary",
			fadeout = true,
			constant_speed = true,
			north_position = util.by_pixel_hr(-30, -161),
			east_position = util.by_pixel_hr(29, -150),
			south_position = util.by_pixel_hr(12, -134),
			west_position = util.by_pixel_hr(-32, -130),
			render_layer = "wires",
			animation = {
				filename = "__base__/graphics/entity/chemical-plant/chemical-plant-smoke-inner.png",
				frame_count = 47,
				line_length = 16,
				width = 40,
				height = 84,
				animation_speed = 0.5,
				shift = util.by_pixel(0, -14),
				scale = 0.5,
			},
		},
	}

	return working_visualisation
end

---
---Gets an `Animation4Way` object containing vanilla-type (standard) chemical plant sprites colored
---using the given `tint`.
---
---### Returns
---@return data.Animation4Way # The complete set of tinted sprites.
---
---### Examples
---```lua
----- Get the sprites colored for a tier 3 chemical plant.
---local tint = reskins.lib.tiers.get_tint(3)
---local chemical_plant = data.raw["assembling-machine"]["chemical-plant-3"]
---
---chemical_plant.animation = _chemical_plants.get_standard_animation(tint)
---```
---
---### Parameters
---@param tint data.Color
---@nodiscard
local function get_chemical_plant_standard_animation(tint)
	return _sprites.make_4way_animation_from_spritesheet({
		layers = {
			-- Base
			{
				filename = "__reskins-assets-base__/graphics/entity/chemical-plant/chemical-plant-base.png",
				width = 220,
				height = 292,
				frame_count = 24,
				line_length = 12,
				shift = util.by_pixel(0.5, -9),
				scale = 0.5,
			},
			-- Mask
			{
				filename = "__reskins-assets-base__/graphics/entity/chemical-plant/chemical-plant-mask.png",
				width = 220,
				height = 292,
				frame_count = 24,
				line_length = 12,
				shift = util.by_pixel(0.5, -9),
				tint = tint,
				scale = 0.5,
			},
			-- Highlights
			{
				filename = "__reskins-assets-base__/graphics/entity/chemical-plant/chemical-plant-highlights.png",
				width = 220,
				height = 292,
				frame_count = 24,
				line_length = 12,
				shift = util.by_pixel(0.5, -9),
				blend_mode = "additive-soft",
				scale = 0.5,
			},
			-- Shadow
			{
				filename = "__base__/graphics/entity/chemical-plant/chemical-plant-shadow.png",
				width = 312,
				height = 222,
				repeat_count = 24,
				shift = util.by_pixel(27, 6),
				draw_as_shadow = true,
				scale = 0.5,
			},
		},
	})
end

---
---Gets a `RotatedAnimationVariations` object containing vanilla-type (standard) chemical plant
---remnant sprites colored using the given `tint`.
---
---### Returns
---@return data.RotatedAnimationVariations # The complete set of tinted remnant sprites.
---
---### Examples
---```lua
----- Get the remnant sprites colored for a tier 3 chemical plant.
---local tint = reskins.lib.tiers.get_tint(3)
---local chemical_plant_remnants = data.raw["corpse"]["chemical-plant-3-remnants"]
---
---chemical_plant_remnants.animation = _chemical_plants.get_standard_remnants(tint)
---```
---
---### Parameters
---@param tint data.Color # The color of the remnant sprites.
---@nodiscard
local function get_chemical_plant_standard_remnants(tint)
	---@type data.RotatedAnimationVariations
	local animation = {
		layers = {
			-- Base
			{
				filename = "__reskins-assets-base__/graphics/entity/chemical-plant/remnants/chemical-plant-remnants-base.png",
				width = 446,
				height = 342,
				direction_count = 1,
				shift = util.by_pixel(16, -5.5),
				scale = 0.5,
			},
			-- Mask
			{
				filename = "__reskins-assets-base__/graphics/entity/chemical-plant/remnants/chemical-plant-remnants-mask.png",
				width = 446,
				height = 342,
				direction_count = 1,
				shift = util.by_pixel(16, -5.5),
				tint = tint,
				scale = 0.5,
			},
			-- Highlights
			{
				filename = "__reskins-assets-base__/graphics/entity/chemical-plant/remnants/chemical-plant-remnants-highlights.png",
				width = 446,
				height = 342,
				direction_count = 1,
				shift = util.by_pixel(16, -5.5),
				blend_mode = "additive-soft",
				scale = 0.5,
			},
		},
	}

	return animation
end

local function chemical_plant(name, tier, tint, make_tier_labels)
	---@type SetupStandardEntityInputs
	local inputs = {
		type = "assembling-machine",
		icon_name = "chemical-plant",
		base_entity_name = "chemical-plant",
		graphics_mod = "assets-base",
		particles = { ["big"] = 1, ["medium"] = 2 },
		tier_labels = make_tier_labels,
		tint = tint and tint or _framework.tiers.get_tint(tier),
	}

	---@type data.AssemblingMachinePrototype
	local entity = data.raw[inputs.type][name]
	if not entity then
		return
	end

	_lib.setup_standard_entity(name, tier, inputs)

	-- Fetch corpse
	local corpse = data.raw["corpse"][entity.corpse]

	-- Reskin corpse
	corpse.animation = get_chemical_plant_standard_remnants(inputs.tint)

	-- Reskin entity
	entity.graphics_set.animation = get_chemical_plant_standard_animation(inputs.tint)
	entity.graphics_set.working_visualisations = get_chemical_plant_standard_working_visualisations()
end

return chemical_plant
