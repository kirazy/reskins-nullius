local _sprites = require("__reskins-sprite-utils__.sprites")
local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _lib = require("_lib")

---@param tint data.Color
---@return data.Sprite4Way
local function entity_picture(tint)
	return {
		north = {
			layers = {
				{
					filename = "__base__/graphics/entity/steam-engine/steam-engine-V.png",
					width = 225,
					height = 391,
					shift = util.by_pixel(4.75, -6.25),
					scale = 0.475,
				},
				{
					filename = "__reskins-assets-base__/graphics/entity/steam-engine/steam-engine-vertical-mask.png",
					width = 225,
					height = 391,
					shift = util.by_pixel(4.75, -6.25),
					tint = tint,
					scale = 0.475,
				},
				{
					filename = "__reskins-assets-base__/graphics/entity/steam-engine/steam-engine-vertical-highlights.png",
					width = 225,
					height = 391,
					shift = util.by_pixel(4.75, -6.25),
					blend_mode = "additive-soft",
					scale = 0.475,
				},
			},
		},
		east = {
			layers = {
				{
					filename = "__base__/graphics/entity/steam-engine/steam-engine-H.png",
					width = 352,
					height = 257,
					shift = util.by_pixel(1, -4.75),
					scale = 0.475,
				},
				{
					filename = "__reskins-assets-base__/graphics/entity/steam-engine/steam-engine-horizontal-mask.png",
					width = 352,
					height = 257,
					shift = util.by_pixel(1, -4.75),
					tint = tint,
					scale = 0.475,
				},
				{
					filename = "__reskins-assets-base__/graphics/entity/steam-engine/steam-engine-horizontal-highlights.png",
					width = 352,
					height = 257,
					shift = util.by_pixel(1, -4.75),
					blend_mode = "additive-soft",
					scale = 0.475,
				},
			},
		},
		south = {
			layers = {
				{
					filename = "__base__/graphics/entity/steam-engine/steam-engine-V.png",
					width = 225,
					height = 391,
					shift = util.by_pixel(4.75, -6.25),
					scale = 0.475,
				},
				{
					filename = "__reskins-assets-base__/graphics/entity/steam-engine/steam-engine-vertical-mask.png",
					width = 225,
					height = 391,
					shift = util.by_pixel(4.75, -6.25),
					tint = tint,
					scale = 0.475,
				},
				{
					filename = "__reskins-assets-base__/graphics/entity/steam-engine/steam-engine-vertical-highlights.png",
					width = 225,
					height = 391,
					shift = util.by_pixel(4.75, -6.25),
					blend_mode = "additive-soft",
					scale = 0.475,
				},
			},
		},
		west = {
			layers = {
				{
					filename = "__base__/graphics/entity/steam-engine/steam-engine-H.png",
					width = 352,
					height = 257,
					shift = util.by_pixel(1, -4.75),
					scale = 0.475,
				},
				{
					filename = "__reskins-assets-base__/graphics/entity/steam-engine/steam-engine-horizontal-mask.png",
					width = 352,
					height = 257,
					shift = util.by_pixel(1, -4.75),
					tint = tint,
					scale = 0.475,
				},
				{
					filename = "__reskins-assets-base__/graphics/entity/steam-engine/steam-engine-horizontal-highlights.png",
					width = 352,
					height = 257,
					shift = util.by_pixel(1, -4.75),
					blend_mode = "additive-soft",
					scale = 0.475,
				},
			},
		},
	}
end

local function get_horizontal_animation_layers(tint)
	---@type data.Animation[]
	local layers = {
		{
			filename = "__base__/graphics/entity/steam-engine/steam-engine-H.png",
			width = 352,
			height = 257,
			frame_count = 32,
			line_length = 8,
			shift = util.by_pixel(1, -4.75),
			scale = 0.475,
		},
		{
			filename = "__reskins-assets-base__/graphics/entity/steam-engine/steam-engine-horizontal-mask.png",
			width = 352,
			height = 257,
			frame_count = 32,
			line_length = 8,
			shift = util.by_pixel(1, -4.75),
			tint = tint,
			scale = 0.475,
		},
		{
			filename = "__reskins-assets-base__/graphics/entity/steam-engine/steam-engine-horizontal-highlights.png",
			width = 352,
			height = 257,
			frame_count = 32,
			line_length = 8,
			shift = util.by_pixel(1, -4.75),
			blend_mode = "additive-soft",
			scale = 0.475,
		},
		{
			filename = "__base__/graphics/entity/steam-engine/steam-engine-H-shadow.png",
			width = 508,
			height = 160,
			frame_count = 32,
			line_length = 8,
			shift = util.by_pixel(48, 24),
			draw_as_shadow = true,
			scale = 0.475,
		},
	}

	return layers
end

---@param tint data.Color
---@return data.Animation[]
local function get_vertical_animation_layers(tint)
	local base_path = "__base__/graphics/entity/steam-engine/"
	local assets_path = "__reskins-assets-base__/graphics/entity/steam-engine/"

	---@type data.Animation[]
	local layers = {
		{
			filename = base_path .. "steam-engine-V.png",
			width = 225,
			height = 391,
			frame_count = 32,
			line_length = 8,
			shift = util.by_pixel(4.75, -6.25),
			scale = 0.475,
		},
		{
			filename = assets_path .. "steam-engine-vertical-mask.png",
			width = 225,
			height = 391,
			frame_count = 32,
			line_length = 8,
			shift = util.by_pixel(4.75, -6.25),
			tint = tint,
			scale = 0.475,
		},
		{
			filename = assets_path .. "steam-engine-vertical-highlights.png",
			width = 225,
			height = 391,
			frame_count = 32,
			line_length = 8,
			shift = util.by_pixel(4.75, -6.25),
			blend_mode = "additive-soft",
			scale = 0.475,
		},
		{
			filename = base_path .. "steam-engine-V-shadow.png",
			width = 330,
			height = 307,
			frame_count = 32,
			line_length = 8,
			shift = util.by_pixel(40.5, 9.25),
			draw_as_shadow = true,
			scale = 0.475,
		},
		{
			filename = "__base__/graphics/entity/pipe-covers/pipe-cover-south.png",
			width = 128,
			height = 128,
			scale = 0.475,
			frame_count = 1,
			repeat_count = 32,
			shift = { 0, 2.96 },
		},
		{
			filename = "__base__/graphics/entity/heat-pipe/heat-pipe-ending-down-1.png",
			width = 64,
			height = 27,
			scale = 0.475,
			frame_count = 1,
			repeat_count = 32,
			shift = { 0, 2.56 },
		},
	}

	return layers
end

---@param tint data.Color
---@return data.RotatedAnimationVariations
local function corpse_animation(tint)
	---@type data.RotatedAnimation
	local animation = {
		layers = {
			-- Base
			{
				filename = "__base__/graphics/entity/steam-engine/remnants/steam-engine-remnants.png",
				line_length = 1,
				width = 462,
				height = 386,
				direction_count = 4,
				shift = util.by_pixel(17, 6.5),
				scale = 0.475,
			},
			-- Mask
			{
				filename = "__reskins-assets-base__/graphics/entity/steam-engine/remnants/steam-engine-remnants-mask.png",
				line_length = 1,
				width = 462,
				height = 386,
				direction_count = 4,
				shift = util.by_pixel(17, 6.5),
				tint = tint,
				scale = 0.475,
			},
			-- Highlights
			{
				filename = "__reskins-assets-base__/graphics/entity/steam-engine/remnants/steam-engine-remnants-highlights.png",
				line_length = 1,
				width = 462,
				height = 386,
				direction_count = 4,
				shift = util.by_pixel(17, 6.5),
				blend_mode = "additive-soft",
				scale = 0.475,
			},
		},
	}

	return _sprites.make_rotated_animation_variations_from_spritesheet(1, animation)
end

local tier_map = {
	["nullius-stirling-engine-1"] = { tier = 1, prog_tier = 1 },
	["nullius-stirling-engine-2"] = { tier = 2, prog_tier = 2 },
	["nullius-stirling-engine-3"] = { tier = 3, prog_tier = 3 },
}

for name, map in pairs(tier_map) do
	local tier = _framework.tiers.get_tier(map)

	---@type SetupStandardEntityInputs
	local inputs = {
		type = "electric-energy-interface",
		icon_name = "steam-engine",
		base_entity_name = "steam-engine",
		graphics_mod = "assets-base",
		particles = { ["big"] = 2, ["medium"] = 1 },
		tint = _framework.tiers.get_tint(tier),
	}

	---@type data.ElectricEnergyInterfacePrototype
	local entity = data.raw[inputs.type][name]
	if not entity then
		goto continue
	end

	_lib.setup_standard_entity(name, tier, inputs)

	-- Fetch corpse
	local corpse = data.raw["corpse"][entity.corpse]

	-- Reskin corpse
	corpse.animation = corpse_animation(inputs.tint)

	-- Reskin entity
	entity.pictures = entity_picture(inputs.tint)

	local vertical_animation = data.raw["animation"]["nullius-stirling-vertical-turbine-" .. map.tier]
	vertical_animation.layers = get_vertical_animation_layers(inputs.tint)

	local horizontal_animation = data.raw["animation"]["nullius-stirling-horizontal-turbine-" .. map.tier]
	horizontal_animation.layers = get_horizontal_animation_layers(inputs.tint)

	::continue::
end
