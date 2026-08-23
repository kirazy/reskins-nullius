local _lib = require("_lib")
local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

-- ============================================================================
-- Nullius large tanks
-- ============================================================================

local MOD_PATH = "__reskins-nullius__"

local LARGE_TANK_PATH = MOD_PATH .. "/graphics/entity/large-tank/"

local LARGE_TANK_ICON_PATH = MOD_PATH .. "/graphics/icons/large-tank/"

local large_tanks = {
	["nullius-large-tank-1"] = {
		type = "storage-tank",
		tier = 2,
		prog_tier = 2,
		nullius_tint = util.color("#D9E6FF"), --{0.85, 0.9, 1} --pipe_material_tints[Assets.defines.pipe_material.aluminum]
	},
	["nullius-large-tank-2"] = {
		type = "storage-tank",
		tier = 3,
		prog_tier = 3,
		nullius_tint = util.color("#B3B3D9"), --pipe_material_tints[Assets.defines.pipe_material.plastic]
	},
	["nullius-large-tank-3"] = {
		type = "storage-tank",
		tier = 4,
		prog_tier = 4,
		nullius_tint = util.color("#6D6D6D"), --pipe_material_tints[Assets.defines.pipe_material.tungsten]tint = {0.85, 0.9, 1},tint = {0.8, 0.8, 0.4}tint = {0.7, 0.7, 0.85}
	},
}

local function make_large_tank_sheets(tint, nullius_tint)
	return {
		{
			filename = "__angelspetrochemgraphics__/graphics/entity/" .. "petrochem-gas-tank/petrochem-gas-tank.png",
			priority = "extra-high",
			frames = 1,
			width = 334,
			height = 387,
			shift = util.by_pixel(-0.5, -6),
			scale = 0.5,
		},

		-- Mask 1 uses Nullius tint
		{
			filename = LARGE_TANK_PATH .. "large-tank-mask.png",
			priority = "extra-high",
			frames = 1,
			width = 334,
			height = 387,
			shift = util.by_pixel(-0.5, -6),
			tint = nullius_tint,
			scale = 0.5,
		},

		-- -- Mask 2 uses Reskins tier tint
		-- {
		-- 	filename = LARGE_TANK_PATH .. "large-tank-mask-2.png",
		-- 	priority = "extra-high",
		-- 	frames = 1,
		-- 	width = 334,
		-- 	height = 387,
		-- 	shift = util.by_pixel(-0.5, -6),
		-- 	tint = tint,
		-- 	scale = 0.5,
		-- },

		{
			filename = LARGE_TANK_PATH .. "large-tank-highlights.png",
			priority = "extra-high",
			frames = 1,
			width = 334,
			height = 387,
			shift = util.by_pixel(-0.5, -6),
			blend_mode = "additive",
			scale = 0.5,
		},

		{
			filename = "__angelspetrochemgraphics__/graphics/entity/" .. "petrochem-gas-tank/petrochem-gas-tank-shadow.png",
			priority = "extra-high",
			frames = 1,
			width = 437,
			height = 237,
			shift = util.by_pixel(26, 32),
			draw_as_shadow = true,
			scale = 0.5,
		},
	}
end

local function make_large_tank_icon(tint, nullius_tint)
	return {
		-- Neutralized icon base
		{
			icon = "__angelspetrochemgraphics__/graphics/icons/" .. "/petrochem-gas-tank.png",
			icon_size = 64,
		},

		-- Main Reskins tier-color mask
		{
			icon = LARGE_TANK_ICON_PATH .. "large-tank-mask.png",
			icon_size = 64,
			tint = tint,
		},

		-- Secondary Nullius tint mask
		-- {
		-- 	icon = LARGE_TANK_ICON_PATH .. "large-tank-mask-2.png",
		-- 	icon_size = 64,
		-- 	tint = nullius_tint,
		-- },
	}
end

for name, options in pairs(large_tanks) do
	local entity = data.raw[options.type] and data.raw[options.type][name]

	local item = data.raw.item and data.raw.item[name]

	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	_lib.create_explosions_and_particles(name, {
		base_entity_name = "storage-tank",
		type = options.type,
		tint = tint,
		particles = {
			["big"] = 1,
		},
	})

	entity.pictures.picture = {
		sheets = make_large_tank_sheets(tint, options.nullius_tint),
	}

	local icon = _framework.tiers.add_tier_labels_to_icons(tier, make_large_tank_icon(tint, options.nullius_tint))

	-- Storage-tank entity icon
	_sprite_utils.icons.assign_deferrable_icon({
		name = name,
		type_name = options.type,
		icon_data = util.copy(icon),
	})

	-- Corresponding placeable item icon
	if item then
		_sprite_utils.icons.assign_deferrable_icon({
			name = name,
			type_name = "item",
			icon_data = util.copy(icon),
		})
	end

	::continue::
end

-- ============================================================================
-- Nullius small tanks
-- ============================================================================

local SMALL_TANK_PATH = MOD_PATH .. "/graphics/entity/small-tank/"

local SMALL_TANK_ICON_PATH = MOD_PATH .. "/graphics/icons/small-tank/"

local small_tanks = {
	["nullius-small-tank-1"] = {
		type = "storage-tank",
		tier = 2,
		prog_tier = 2,
		nullius_tint = util.color("#D9E6FF"), --pipe_material_tints[Assets.defines.pipe_material.aluminum],
	},
	["nullius-small-tank-2"] = {
		type = "storage-tank",
		tier = 3,
		prog_tier = 3,
		nullius_tint = util.color("#B3B3D9"), --pipe_material_tints[Assets.defines.pipe_material.plastic],
	},
}

-- Each entry matches one visible section of the original Angel's sprite sheet.
local small_tank_geometry = {
	north = {
		{
			x = 0,
			y = 0,
			width = 142,
			height = 199,
			shift = { 0, -0.24 },
		},
		{
			x = 142,
			y = 117,
			width = 29,
			height = 62,
			shift = { -0.88, 0.52 },
		},
		{
			x = 171,
			y = 141,
			width = 11,
			height = 38,
			shift = { -0.57, 0.705 },
		},
	},

	east = {
		{
			x = 142,
			y = 0,
			width = 142,
			height = 199,
			shift = { 0, -0.24 },
		},
	},

	south = {
		{
			x = 284,
			y = 0,
			width = 142,
			height = 199,
			shift = { 0, -0.24 },
		},
		{
			x = 559,
			y = 48,
			width = 9,
			height = 62,
			shift = { 1, -0.58 },
		},
	},

	west = {
		{
			x = 426,
			y = 0,
			width = 142,
			height = 199,
			shift = { 0, -0.24 },
		},
		{
			x = 74,
			y = 136,
			width = 62,
			height = 63,
			shift = { 0.55, 0.82 },
		},
	},
}

local small_tank_shadow_geometry = {
	north = {
		x = 0,
		width = 207,
		height = 199,
		shift = { 0.52, 0.28 },
	},
	east = {
		x = 207,
		width = 207,
		height = 199,
		shift = { 0.52, 0.28 },
	},
	south = {
		x = 414,
		width = 207,
		height = 199,
		shift = { 0.52, 0.28 },
	},
	west = {
		x = 621,
		width = 207,
		height = 199,
		shift = { 0.52, 0.28 },
	},
}

local function make_small_tank_layer(filename, geometry, tint, blend_mode)
	local layer = {
		filename = filename,
		priority = "extra-high",
		x = geometry.x,
		y = geometry.y or 0,
		width = geometry.width,
		height = geometry.height,
		scale = 0.5,
		shift = geometry.shift,
	}

	if tint then
		layer.tint = tint
	end

	if blend_mode then
		layer.blend_mode = blend_mode
	end

	return layer
end

local function make_small_tank_direction(direction, tint, nullius_tint)
	local layers = {}

	for _, geometry in ipairs(small_tank_geometry[direction]) do
		-- Neutralized base
		layers[#layers + 1] = make_small_tank_layer(
			"__angelspetrochemgraphics__/graphics/entity/petrochem-inline-tank/petrochem-inline-tank.png",
			geometry
		)

		-- Main Reskins tier mask
		layers[#layers + 1] = make_small_tank_layer(SMALL_TANK_PATH .. "small-tank-mask.png", geometry, tint)
		-- layers[#layers + 1] = make_small_tank_layer(SMALL_TANK_PATH .. "small-tank-mask-2.png", geometry, nullius_tint)
	end

	local shadow = small_tank_shadow_geometry[direction]

	layers[#layers + 1] = {
		filename = "__angelspetrochemgraphics__/graphics/entity/petrochem-inline-tank/petrochem-inline-tank-shadow.png",
		priority = "extra-high",
		x = shadow.x,
		y = 0,
		width = shadow.width,
		height = shadow.height,
		shift = shadow.shift,
		draw_as_shadow = true,
		scale = 0.5,
	}

	return {
		layers = layers,
	}
end

local function make_small_tank_pictures(tint, nullius_tint)
	return {
		picture = {
			north = make_small_tank_direction("north", tint, nullius_tint),
			east = make_small_tank_direction("east", tint, nullius_tint),
			south = make_small_tank_direction("south", tint, nullius_tint),
			west = make_small_tank_direction("west", tint, nullius_tint),
		},

		fluid_background = {
			filename = "__angelspetrochemgraphics__/graphics/entity/" .. "electrolyser/blank.png",
			priority = "extra-high",
			width = 1,
			height = 1,
		},

		window_background = {
			filename = "__angelspetrochemgraphics__/graphics/entity/" .. "electrolyser/blank.png",
			priority = "extra-high",
			width = 1,
			height = 1,
		},

		flow_sprite = {
			filename = "__angelspetrochemgraphics__/graphics/entity/" .. "electrolyser/blank.png",
			priority = "extra-high",
			width = 1,
			height = 1,
		},

		gas_flow = {
			filename = "__angelspetrochemgraphics__/graphics/entity/" .. "electrolyser/blank.png",
			priority = "extra-high",
			width = 1,
			height = 1,
			frame_count = 1,
			animation_speed = 0.25,
		},
	}
end

local function make_small_tank_icon(tint, nullius_tint)
	return {
		{
			icon = "__angelspetrochemgraphics__/graphics/icons/petrochem-inline-tank.png",
			icon_size = 64,
		},
		{
			icon = SMALL_TANK_ICON_PATH .. "small-tank-mask.png",
			icon_size = 64,
			tint = tint,
		},
		-- FIXME: The highlights layer is MIA.
	}
end

for name, options in pairs(small_tanks) do
	local entity = data.raw[options.type] and data.raw[options.type][name]

	local item = data.raw.item and data.raw.item[name]

	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	_lib.create_explosions_and_particles(name, {
		base_entity_name = "storage-tank",
		type = options.type,
		tint = tint,
		particles = {
			["medium"] = 1,
		},
	})

	entity.pictures = make_small_tank_pictures(tint, options.nullius_tint)

	local icon = _framework.tiers.add_tier_labels_to_icons(tier, make_small_tank_icon(tint, options.nullius_tint))

	-- Storage-tank prototype icon
	_sprite_utils.icons.assign_deferrable_icon({
		name = name,
		type_name = options.type,
		icon_data = util.copy(icon),
	})

	-- Placeable item icon
	if item then
		_sprite_utils.icons.assign_deferrable_icon({
			name = name,
			type_name = "item",
			icon_data = util.copy(icon),
		})
	end

	-- Normal recipe icon
	if data.raw.recipe and data.raw.recipe[name] then
		_sprite_utils.icons.assign_deferrable_icon({
			name = name,
			type_name = "recipe",
			icon_data = util.copy(icon),
		})
	end

	::continue::
end
