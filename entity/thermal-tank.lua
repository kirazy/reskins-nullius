local _lib = require("_lib")
local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local THERMAL_TANK_PATH = "__reskins-nullius__/graphics/entity/thermal-tank/thermal-tank-"
local THERMAL_TANK_ICON_PATH = "__reskins-nullius__/graphics/icons/thermal-tank/thermal-tank-"
local NULLIUS_THERMAL_TANK_PATH = "__nullius__/graphics/entity/thermaltank/"

local thermal_tanks = {}

local function add_thermal_tank(name, type_name, tier)
	thermal_tanks[name] = {
		type = type_name,
		tier = tier,
		prog_tier = tier + 1,
	}
end

for tier = 1, 3 do
	add_thermal_tank("nullius-thermal-tank-" .. tier, "reactor", tier)

	-- Actual placeable reactor variants.
	add_thermal_tank("nullius-thermal-tank-horizontal-" .. tier, "reactor", tier)

	add_thermal_tank("nullius-thermal-tank-vertical-" .. tier, "reactor", tier)

	add_thermal_tank("nullius-thermal-tank-build-" .. tier, "storage-tank", tier)
end

local function make_thermal_tank_layer(filename, overrides)
	local layer = util.copy({
		priority = "extra-high",
		width = 180,
		height = 180,
		scale = 0.73,
		shift = { 0.3, -0.3 },
	})
	layer.filename = filename

	for key, value in pairs(overrides or {}) do
		layer[key] = value
	end

	return layer
end

local function make_thermal_tank_layers(tint)
	return {
		make_thermal_tank_layer(THERMAL_TANK_PATH .. "base.png"),
		make_thermal_tank_layer(THERMAL_TANK_PATH .. "mask.png", { tint = tint }),
		make_thermal_tank_layer(THERMAL_TANK_PATH .. "highlights.png", {
			blend_mode = "additive",
		}),
		{
			filename = NULLIUS_THERMAL_TANK_PATH .. "thermaltank-shadow.png",
			priority = "extra-high",
			width = 230,
			height = 180,
			scale = 0.73,
			shift = { 0.3, -0.3 },
			draw_as_shadow = true,
		},
	}
end

local function make_thermal_tank_picture(tint)
	return {
		layers = make_thermal_tank_layers(tint),
	}
end

local function make_thermal_tank_pictures(tint)
	return {
		picture = {
			north = make_thermal_tank_picture(tint),
			east = make_thermal_tank_picture(tint),
			south = make_thermal_tank_picture(tint),
			west = make_thermal_tank_picture(tint),
		},
		fluid_background = data.raw["storage-tank"]["storage-tank"].pictures.fluid_background,
		window_background = data.raw["storage-tank"]["storage-tank"].pictures.window_background,
		flow_sprite = data.raw["storage-tank"]["storage-tank"].pictures.flow_sprite,
		gas_flow = data.raw["storage-tank"]["storage-tank"].pictures.gas_flow,
	}
end

local function make_thermal_tank_icon_layer(filename, tint)
	return {
		icon = filename,
		icon_size = 64,
		mipmap_count = 4,
		tint = tint,
	}
end

local function make_thermal_tank_icon(tint)
	return {
		make_thermal_tank_icon_layer(THERMAL_TANK_ICON_PATH .. "base.png"),
		make_thermal_tank_icon_layer(THERMAL_TANK_ICON_PATH .. "mask.png", tint),
		make_thermal_tank_icon_layer(THERMAL_TANK_ICON_PATH .. "highlights.png"),
	}
end

local function assign_thermal_tank_icons(building_tier, label_tier, icon_data)
	local function assign_to(prefix, type_name)
		local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
			tier = label_tier,
			name = prefix .. "-" .. building_tier,
			type_name = type_name,
			icon_data = icon_data,
		})

		_sprite_utils.icons.apply_icon_assignment(icon_assignment)
	end

	assign_to("nullius-thermal-tank", "reactor")
	assign_to("nullius-thermal-tank-horizontal", "reactor")
	assign_to("nullius-thermal-tank-vertical", "reactor")
	assign_to("nullius-thermal-tank-build", "storage-tank")
end

for tier = 1, 3 do
	local icon_tier = _framework.tiers.get_tier({
		tier = tier,
		prog_tier = tier + 1,
	})
	local tint = _framework.tiers.get_tint(icon_tier)

	assign_thermal_tank_icons(tier, icon_tier, make_thermal_tank_icon(tint))
end

for name, options in pairs(thermal_tanks) do
	local entity = data.raw[options.type] and data.raw[options.type][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	if options.type == "reactor" then
		entity.picture = make_thermal_tank_picture(tint)
	else
		entity.pictures = make_thermal_tank_pictures(tint)
	end

	::continue::
end
