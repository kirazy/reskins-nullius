local _framework = {
	tiers = require("__reskins-framework__.api.tiers"),
}
local _lib = require("_lib")
local _assets = { create_icon = require("__reskins-assets-api__.assets.base.base-icons") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local BASE_ICON_PATH = "__base__/graphics/icons/"

local RESKINS_TECH_PATH = "__reskins-assets-base__/graphics/technology/"
local BASE_RESKINS_ICON_PATH = "__reskins-assets-base__/graphics/icons/"
local ANGELS_TECH_PATH = "__reskins-assets-angels__/graphics/technology/"
local ANGELS_ICON_PATH = "__reskins-assets-angels__/graphics/icons/"
local BOBS_TECH_PATH = "__reskins-assets-bobs__/graphics/technology/"
local FLUID_TECH_PATH = RESKINS_TECH_PATH .. "fluid-handling/fluid-handling-technology-"
local LAB_TECH_PATH = "__reskins-nullius__/graphics/technology/lab/lab-"
local THERMAL_TANK_TECH_PATH = "__reskins-nullius__/graphics/technology/thermal-tank/thermal-tank-"
local ELECTRIC_CHEMICAL_FURNACE_TECH_PATH =
	"__reskins-assets-bobs__/graphics/technology/furnace-electric-chemical/furnace-electric-chemical-technology-"
local STEAM_ENGINE_TECH_PATH = "__reskins-assets-bobs__/graphics/technology/steam-engine/steam-engine-technology-"
local HEAT_EXCHANGER_TECH_PATH = "__reskins-assets-bobs__/graphics/technology/heat-exchanger/"

local LARGE_TANK_TECH_PATH = "__reskins-nullius__/graphics/technology/large-tank/large-tank-"

-- ============================================================================
-- Technology assignments
-- ============================================================================

local technologies = {
	["nullius-plumbing-1"] = {
		tier = 1,
		prog_tier = 1,
		path = FLUID_TECH_PATH,
	},
	["nullius-plumbing-2"] = {
		tier = 1,
		prog_tier = 1,
		path = FLUID_TECH_PATH,
	},
	["nullius-plumbing-3"] = {
		tier = 2,
		prog_tier = 2,
		path = FLUID_TECH_PATH,
	},
	["nullius-plumbing-4"] = {
		tier = 2,
		prog_tier = 2,
		path = FLUID_TECH_PATH,
	},
	["nullius-plumbing-5"] = {
		tier = 3,
		prog_tier = 3,
		path = FLUID_TECH_PATH,
	},
	["nullius-plumbing-6"] = {
		tier = 4,
		prog_tier = 4,
		path = FLUID_TECH_PATH,
	},
	["nullius-empiricism-1"] = {
		tier = 1,
		prog_tier = 1,
		path = LAB_TECH_PATH,
	},
	["nullius-empiricism-2"] = {
		tier = 1,
		prog_tier = 1,
		path = LAB_TECH_PATH,
	},
	["nullius-empiricism-3"] = {
		tier = 1,
		prog_tier = 1,
		path = LAB_TECH_PATH,
	},
	["nullius-empiricism-4"] = {
		tier = 2,
		prog_tier = 2,
		path = LAB_TECH_PATH,
	},
	["nullius-empiricism-5"] = {
		tier = 2,
		prog_tier = 2,
		path = LAB_TECH_PATH,
	},
	["nullius-empiricism-6"] = {
		tier = 3,
		prog_tier = 3,
		path = LAB_TECH_PATH,
	},
	["nullius-empiricism-7"] = {
		tier = 5,
		prog_tier = 5,
		path = LAB_TECH_PATH,
	},
	["nullius-solar-power-1"] = {
		tier = 1,
		prog_tier = 1,
		path = RESKINS_TECH_PATH .. "solar-energy/solar-energy-technology-",
	},
	["nullius-solar-power-2"] = {
		tier = 2,
		prog_tier = 2,
		path = RESKINS_TECH_PATH .. "solar-energy/solar-energy-technology-",
	},
	["nullius-solar-power-3"] = {
		tier = 3,
		prog_tier = 3,
		path = RESKINS_TECH_PATH .. "solar-energy/solar-energy-technology-",
	},
	["nullius-solar-power-4"] = {
		tier = 4,
		prog_tier = 4,
		path = RESKINS_TECH_PATH .. "solar-energy/solar-energy-technology-",
	},
	["nullius-automation"] = {
		tier = 1,
		prog_tier = 1,
		path = RESKINS_TECH_PATH .. "automation/automation-technology-",
		scale = 0.66,
	},
	["nullius-automation-2"] = {
		tier = 2,
		prog_tier = 2,
		path = RESKINS_TECH_PATH .. "automation/automation-technology-",
	},
	["nullius-automation-3"] = {
		tier = 3,
		prog_tier = 3,
		path = RESKINS_TECH_PATH .. "automation/automation-technology-",
		scale = 1.25,
	},
	["nullius-mass-production-1"] = {
		tier = 1,
		prog_tier = 1,
		path = RESKINS_TECH_PATH .. "automation/automation-technology-",
	},
	["nullius-mass-production-2"] = {
		tier = 1,
		prog_tier = 1,
		path = RESKINS_TECH_PATH .. "automation/automation-technology-",
	},
	["nullius-mass-production-3"] = {
		tier = 2,
		prog_tier = 2,
		path = RESKINS_TECH_PATH .. "automation/automation-technology-",
		scale = 1.25,
	},
	["nullius-mass-production-4"] = {
		tier = 4,
		prog_tier = 4,
		path = RESKINS_TECH_PATH .. "automation/automation-technology-",
		scale = 1.25,
	},
	["nullius-mass-production-5"] = {
		tier = 5,
		prog_tier = 5,
		path = RESKINS_TECH_PATH .. "automation/automation-technology-",
		scale = 1.25,
	},
	["nullius-mass-production-6"] = {
		tier = 6,
		prog_tier = 6,
		path = RESKINS_TECH_PATH .. "automation/automation-technology-",
		scale = 1.25,
	},
	["nullius-mass-production-7"] = {
		tier = 6,
		prog_tier = 6,
		path = RESKINS_TECH_PATH .. "automation/automation-technology-",
		scale = 1.25,
	},
	["nullius-battery-storage-2"] = {
		tier = 1,
		prog_tier = 1,
		path = RESKINS_TECH_PATH .. "electric-energy-accumulators/electric-energy-accumulators-technology-",
	},
	["nullius-battery-storage-4"] = {
		tier = 2,
		prog_tier = 3,
		path = RESKINS_TECH_PATH .. "electric-energy-accumulators/electric-energy-accumulators-technology-",
	},
	["nullius-battery-storage-6"] = {
		tier = 3,
		prog_tier = 4,
		path = RESKINS_TECH_PATH .. "electric-energy-accumulators/electric-energy-accumulators-technology-",
	},
	["nullius-energy-distribution-1"] = {
		tier = 1,
		prog_tier = 1,
		path = RESKINS_TECH_PATH .. "power-poles/power-poles-technology-",
	},
	["nullius-energy-distribution-2"] = {
		tier = 2,
		prog_tier = 2,
		path = RESKINS_TECH_PATH .. "power-poles/power-poles-technology-",
	},
	["nullius-energy-distribution-3"] = {
		tier = 1,
		prog_tier = 1,
		path = RESKINS_TECH_PATH .. "substation/substation-technology-",
	},
	["nullius-energy-distribution-4"] = {
		tier = 3,
		prog_tier = 3,
		path = RESKINS_TECH_PATH .. "power-poles/power-poles-technology-",
	},
	["nullius-energy-distribution-5"] = {
		tier = 4,
		prog_tier = 4,
		path = RESKINS_TECH_PATH .. "substation/substation-technology-",
	},
	["nullius-geothermal-power-1"] = {
		tier = 1,
		prog_tier = 1,
		path = ELECTRIC_CHEMICAL_FURNACE_TECH_PATH,
	},
	["nullius-geothermal-power-2"] = {
		tier = 2,
		prog_tier = 2,
		path = ELECTRIC_CHEMICAL_FURNACE_TECH_PATH,
	},
	["nullius-geothermal-power-3"] = {
		tier = 3,
		prog_tier = 3,
		path = ELECTRIC_CHEMICAL_FURNACE_TECH_PATH,
	},
	["nullius-electrolysis-1"] = {
		icon_type = "electrolyzer-entity-frame",
		tier = 1,
		prog_tier = 1,
	},
	["nullius-electrolysis-2"] = {
		icon_type = "electrolyzer-entity-frame",
		tier = 1,
		prog_tier = 1,
	},
	["nullius-electrolysis-3"] = {
		icon_type = "electrolyzer-entity-frame",
		tier = 2,
		prog_tier = 2,
	},
	["nullius-electrolysis-4"] = {
		icon_type = "electrolyzer-entity-frame",
		tier = 3,
		prog_tier = 3,
	},
	["nullius-air-filtration-1"] = {
		icon_type = "tinted-icon",
		tier = 1,
		prog_tier = 1,
		path = ANGELS_ICON_PATH .. "air-filter/air-filter-icon-",
	},
	["nullius-air-filtration-2"] = {
		icon_type = "tinted-icon",
		tier = 2,
		prog_tier = 2,
		path = ANGELS_ICON_PATH .. "air-filter/air-filter-icon-",
	},
	["nullius-air-filtration-3"] = {
		icon_type = "tinted-icon",
		tier = 3,
		prog_tier = 3,
		path = ANGELS_ICON_PATH .. "air-filter/air-filter-icon-",
	},
	["nullius-flotation-1"] = {
		tier = 1,
		prog_tier = 1,
		path = ANGELS_TECH_PATH .. "ore-flotation/ore-flotation-technology-",
	},
	["nullius-flotation-2"] = {
		tier = 2,
		prog_tier = 2,
		path = ANGELS_TECH_PATH .. "ore-flotation/ore-flotation-technology-",
	},
	["nullius-flotation-3"] = {
		tier = 3,
		prog_tier = 3,
		path = ANGELS_TECH_PATH .. "ore-flotation/ore-flotation-technology-",
	},
	["nullius-pumping-1"] = {
		icon_type = "tinted-icon",
		tier = 1,
		prog_tier = 1,
		path = BASE_RESKINS_ICON_PATH .. "pump/pump-icon-",
	},
	["nullius-pumping-2"] = {
		icon_type = "tinted-icon",
		tier = 2,
		prog_tier = 2,
		path = BASE_RESKINS_ICON_PATH .. "pump/pump-icon-",
	},
	["nullius-pumping-3"] = {
		icon_type = "tinted-icon",
		tier = 3,
		prog_tier = 3,
		path = BASE_RESKINS_ICON_PATH .. "pump/pump-icon-",
	},
	["nullius-mining-1"] = {
		tier = 1,
		prog_tier = 1,
		path = "__reskins-assets-bobs__/graphics/technology/mining-drill/mining-drill-technology-",
		icon_size = 128,
	},
	["nullius-mining-2"] = {
		tier = 2,
		prog_tier = 2,
		path = "__reskins-assets-bobs__/graphics/technology/mining-drill/mining-drill-technology-",
		icon_size = 128,
	},
	["nullius-mining-3"] = {
		tier = 3,
		prog_tier = 3,
		path = "__reskins-assets-bobs__/graphics/technology/mining-drill/mining-drill-technology-",
		icon_size = 128,
	},
	["nullius-exploration-1"] = {
		tier = 1,
		prog_tier = 2,
		path = RESKINS_TECH_PATH .. "turret-artillery/turret-artillery-technology-",
	},
	["nullius-exploration-2"] = {
		tier = 2,
		prog_tier = 3,
		path = RESKINS_TECH_PATH .. "turret-artillery/turret-artillery-technology-",
	},
	["nullius-exploration-3"] = {
		tier = 3,
		prog_tier = 4,
		path = RESKINS_TECH_PATH .. "turret-artillery/turret-artillery-technology-",
	},
	["nullius-thermal-storage-1"] = {
		tier = 1,
		prog_tier = 2,
		path = THERMAL_TANK_TECH_PATH,
	},
	["nullius-thermal-storage-2"] = {
		tier = 2,
		prog_tier = 3,
		path = THERMAL_TANK_TECH_PATH,
	},
	["nullius-thermal-storage-3"] = {
		tier = 3,
		prog_tier = 4,
		path = THERMAL_TANK_TECH_PATH,
	},
	["nullius-locomotion-1"] = {
		tier = 1,
		path = RESKINS_TECH_PATH .. "equipment-exoskeleton/equipment-exoskeleton-technology-",
	},
	["nullius-locomotion-2"] = {
		tier = 2,
		path = RESKINS_TECH_PATH .. "equipment-exoskeleton/equipment-exoskeleton-technology-",
	},
	["nullius-locomotion-3"] = {
		tier = 3,
		path = RESKINS_TECH_PATH .. "equipment-exoskeleton/equipment-exoskeleton-technology-",
	},
	["nullius-locomotion-4"] = {
		tier = 4,
		path = RESKINS_TECH_PATH .. "equipment-exoskeleton/equipment-exoskeleton-technology-",
	},
	["nullius-locomotion-5"] = {
		tier = 5,
		path = RESKINS_TECH_PATH .. "equipment-exoskeleton/equipment-exoskeleton-technology-",
	},
	["nullius-cybernetics-2"] = {
		tier = 1,
		path = RESKINS_TECH_PATH .. "equipment-night-vision/equipment-night-vision-technology-",
	},
	["nullius-cybernetics-3"] = {
		tier = 2,
		path = BOBS_TECH_PATH .. "equipment-fission-reactor/equipment-fission-reactor-technology-",
	},
	["nullius-cybernetics-4"] = {
		tier = 1,
		path = RESKINS_TECH_PATH .. "equipment-exoskeleton/equipment-exoskeleton-technology-",
	},
	["nullius-cybernetics-5"] = {
		tier = 3,
		path = RESKINS_TECH_PATH .. "equipment-night-vision/equipment-night-vision-technology-",
	},
	["nullius-insulation-1"] = {
		tier = 1,
		path = BOBS_TECH_PATH .. "equipment-fission-reactor/equipment-fission-reactor-technology-",
	},
	["nullius-nuclear-power-1"] = {
		tier = 4,
		path = BOBS_TECH_PATH .. "equipment-fission-reactor/equipment-fission-reactor-technology-",
	},
	["nullius-maintenance"] = {
		tier = 4,
		path = BOBS_TECH_PATH .. "repair-pack/repair-pack-technology-",
		icon_size = 128,
	},
	["nullius-hydrology-1"] = {
		icon_type = "flat",
		icon = BOBS_TECH_PATH .. "oil-gathering/water-pumpjack-technology-base.png",
		icon_size = 256,
	},
	["nullius-hydrology-2"] = {
		icon_type = "flat",
		icon = BOBS_TECH_PATH .. "oil-gathering/water-pumpjack-technology-base.png",
		icon_size = 256,
	},
	["nullius-robotics-1"] = {
		tier = 1,
		prog_tier = 2,
		path = RESKINS_TECH_PATH .. "robotics/robotics-technology-",
	},
	["nullius-robotics-2"] = {
		tier = 2,
		prog_tier = 3,
		path = RESKINS_TECH_PATH .. "robotics/robotics-technology-",
	},
	["nullius-robotics-3"] = {
		tier = 3,
		prog_tier = 4,
		path = RESKINS_TECH_PATH .. "robotics/robotics-technology-",
	},
	["nullius-robotics-4"] = {
		tier = 4,
		prog_tier = 5,
		path = RESKINS_TECH_PATH .. "robotics/robotics-technology-",
	},
	["nullius-sensors-2"] = {
		icon_type = "radar",
		tier = 1,
	},
	["nullius-sensors-3"] = {
		icon_type = "radar",
		tier = 2,
	},
	["nullius-sensors-4"] = {
		icon_type = "radar",
		tier = 3,
	},
	["nullius-solar-thermal-power-1"] = {
		path = "__reskins-nullius__/graphics/technology/collector/collector-technology-",
		tint = util.color("#ff3333"),
	},
	["nullius-solar-thermal-power-2"] = {
		path = "__reskins-nullius__/graphics/technology/collector/collector-technology-",
		tint = util.color("#ff9f1c"),
	},
	["nullius-solar-thermal-power-3"] = {
		path = "__reskins-nullius__/graphics/technology/collector/collector-technology-",
		tint = util.color("#ffe55c"),
	},
}

-- ============================================================================
-- Helpers
-- ============================================================================

local function get_tier_tint(options)
	if options.tint then
		return options.tint
	end

	if not options.tier then
		return nil
	end

	local tier = _framework.tiers.get_tier(options)
	return _framework.tiers.get_tint(tier)
end

local function make_tinted_technology_icon(options)
	local size = options.icon_size or 256

	return {
		{
			icon = options.path .. "base.png",
			icon_size = size,
		},
		{
			icon = options.path .. "mask.png",
			icon_size = size,
			tint = get_tier_tint(options),
		},
		{
			icon = options.path .. "highlights.png",
			icon_size = size,
			tint = { 1, 1, 1, 0 },
		},
	}
end

local function make_tinted_icon_technology_icon(options)
	local size = options.icon_size or 64

	return {
		{
			icon = options.path .. "base.png",
			icon_size = size,
		},
		{
			icon = options.path .. "mask.png",
			icon_size = size,
			tint = get_tier_tint(options),
		},
		{
			icon = options.path .. "highlights.png",
			icon_size = size,
			tint = { 1, 1, 1, 0 },
		},
	}
end

local function make_electrolyzer_entity_frame_technology_icon(options)
	return {
		{
			icon = "__angelspetrochemgraphics__/graphics/entity/electrolyser/electrolyser-north.png",
			icon_size = 224,
		},
		{
			icon = "__reskins-assets-angels__/graphics/entity/electrolyser/electrolyser-mask.png",
			icon_size = 224,
			tint = get_tier_tint(options),
		},
		{
			icon = "__reskins-assets-angels__/graphics/entity/electrolyser/electrolyser-highlights.png",
			icon_size = 224,
			tint = { 1, 1, 1, 0 },
		},
	}
end

local function make_flat_technology_icon(options)
	return {
		{
			icon = options.icon,
			icon_size = options.icon_size or 256,
		},
	}
end

local function make_radar_technology_icon(options)
	return _assets.create_icon.radar(get_tier_tint(options))
end

local function make_heat_exchanger_technology_icon(options)
	local size = options.icon_size or 128
	local icon_base = options.icon_base or "heat-exchanger-base"

	return {
		{
			icon = options.path .. icon_base .. "-technology-base.png",
			icon_size = size,
		},
		{
			icon = options.path .. "heat-exchanger-technology-mask.png",
			icon_size = size,
			tint = get_tier_tint(options),
		},
		{
			icon = options.path .. "heat-exchanger-technology-highlights.png",
			icon_size = size,
		},
	}
end

local technology_icon_builders = {
	["electrolyzer-entity-frame"] = make_electrolyzer_entity_frame_technology_icon,
	flat = make_flat_technology_icon,
	["heat-exchanger"] = make_heat_exchanger_technology_icon,
	radar = make_radar_technology_icon,
	["tinted-icon"] = make_tinted_icon_technology_icon,
	tinted = make_tinted_technology_icon,
}

local function make_technology_icons(options)
	local icon_type = options.icon_type or "tinted"
	local builder = technology_icon_builders[icon_type]

	if not builder then
		error("Unknown technology icon type: " .. icon_type)
	end

	return builder(options)
end

local function make_checkpoint_checkmark()
	return {
		icon = "__nullius__/graphics/icons/checkpoint.png",
		icon_size = 64,
		tint = { 0.6, 0.6, 0.6, 0.6 },
		scale = 8,
	}
end

local function make_blueprint_background()
	return {
		{
			icon = BASE_ICON_PATH .. "blueprint.png",
			icon_size = 64,
			scale = 8,
		},
	}
end

-- ============================================================================
-- Apply regular technology icons
-- ============================================================================

for name, options in pairs(technologies) do
	local technology = data.raw.technology and data.raw.technology[name]

	if not technology then
		goto continue
	end

	local icon_data =
		_sprite_utils.icons.transform_icons(make_technology_icons(options), options.scale, options.shift, nil, "technology")

	_sprite_utils.icons.assign_icons_to_prototype_and_related_prototypes(name, "technology", icon_data)

	::continue::
end

-- ============================================================================
-- Apply checkpoint graphics
-- ============================================================================

local checkpoint_overlays = {
	{
		checkpoint_name = "nullius-checkpoint-heat-pipe",
		background_icons = {},
		icon_type = "heat-exchanger",
		path = HEAT_EXCHANGER_TECH_PATH,
		icon_base = "heat-exchanger-base",
		tier = 1,
		prog_tier = 2,
		overlay_scale = 4,
		top_icons = {
			make_checkpoint_checkmark(),
		},
	},
	{
		checkpoint_name = "nullius-checkpoint-large-tank",
		background_icons = make_blueprint_background(),
		path = LARGE_TANK_TECH_PATH,
		tier = 2,
		prog_tier = 3,
		overlay_scale = 3.5,
	},
	{
		checkpoint_name = "nullius-checkpoint-plumbing",
		background_icons = make_blueprint_background(),
		path = FLUID_TECH_PATH,
		tier = 2,
		prog_tier = 2,
		overlay_scale = 4,
	},
	{
		checkpoint_name = "nullius-checkpoint-pumping",
		background_icons = make_blueprint_background(),
		icon_type = "tinted-icon",
		path = BASE_RESKINS_ICON_PATH .. "pump/pump-icon-",
		tier = 2,
		prog_tier = 2,
		overlay_scale = 4,
	},
	{
		checkpoint_name = "nullius-checkpoint-water",
		background_icons = make_blueprint_background(),
		path = ANGELS_TECH_PATH .. "water-treatment/water-treatment-technology-",
		tier = 1,
		prog_tier = 1,
		overlay_scale = 4,
	},
	{
		checkpoint_name = "nullius-checkpoint-caustic-solution",
		background_icons = make_blueprint_background(),
		icon_type = "electrolyzer-entity-frame",
		tier = 1,
		prog_tier = 1,
		overlay_scale = 4,
	},
	{
		checkpoint_name = "nullius-checkpoint-energy-storage",
		background_icons = make_blueprint_background(),
		icon_type = "electrolyzer-entity-frame",
		tier = 1,
		prog_tier = 1,
		overlay_scale = 4,
	},
	{
		checkpoint_name = "nullius-checkpoint-robotics",
		background_icons = {},
		path = RESKINS_TECH_PATH .. "robotics/robotics-technology-",
		tier = 1,
		prog_tier = 2,
		overlay_scale = 4,
		top_icons = {
			make_checkpoint_checkmark(),
		},
	},
	{
		checkpoint_name = "nullius-checkpoint-lab",
		background_icons = make_blueprint_background(),
		path = LAB_TECH_PATH,
		tier = 1,
		prog_tier = 1,
		overlay_scale = 4,
	},
	{
		checkpoint_name = "nullius-checkpoint-lab-2",
		background_icons = make_blueprint_background(),
		path = LAB_TECH_PATH,
		tier = 2,
		prog_tier = 2,
		overlay_scale = 4,
	},
	{
		checkpoint_name = "nullius-checkpoint-solar-panel",
		background_icons = make_blueprint_background(),
		path = RESKINS_TECH_PATH .. "solar-energy/solar-energy-technology-",
		tier = 3,
		prog_tier = 3,
		overlay_scale = 4,
	},
	{
		checkpoint_name = "nullius-checkpoint-mass-production",
		background_icons = make_blueprint_background(),
		path = RESKINS_TECH_PATH .. "automation/automation-technology-",
		tier = 1,
		prog_tier = 2,
		overlay_scale = 4,
	},
	{
		checkpoint_name = "nullius-checkpoint-automation",
		background_icons = make_blueprint_background(),
		path = RESKINS_TECH_PATH .. "automation/automation-technology-",
		tier = 3,
		prog_tier = 5,
		overlay_scale = 4,
	},
	{
		checkpoint_name = "nullius-checkpoint-grid-battery",
		path = RESKINS_TECH_PATH .. "electric-energy-accumulators/electric-energy-accumulators-technology-",
		tier = 3,
		prog_tier = 4,
	},
	{
		checkpoint_name = "nullius-checkpoint-substation",
		path = RESKINS_TECH_PATH .. "substation/substation-technology-",
		tier = 2,
		prog_tier = 2,
	},
	{
		checkpoint_name = "nullius-checkpoint-thermal-tank",
		background_icons = {},
		path = THERMAL_TANK_TECH_PATH,
		tier = 3,
		prog_tier = 4,
		overlay_scale = 4,
		top_icons = {
			make_checkpoint_checkmark(),
		},
	},
	{
		checkpoint_name = "nullius-checkpoint-large-miner",
		background_icons = make_blueprint_background(),
		path = "__reskins-assets-bobs__/graphics/technology/mining-drill/mining-drill-technology-",
		icon_size = 128,
		tier = 2,
		prog_tier = 4,
		overlay_scale = 8,
	},
	{
		checkpoint_name = "nullius-checkpoint-stirling-engine",
		background_icons = make_blueprint_background(),
		path = STEAM_ENGINE_TECH_PATH,
		icon_size = 128,
		tier = 2,
		prog_tier = 2,
		overlay_scale = 8,
	},
	{
		checkpoint_name = "nullius-checkpoint-large-beacon",
		background_icons = make_blueprint_background(),
		icon_type = "flat",
		icon = "__base__/graphics/technology/effect-transmission.png",
		overlay_scale = 4,
	},
}

local function get_checkpoint_background_icons(checkpoint, options)
	if options.background_icons then
		return util.copy(options.background_icons)
	end

	if checkpoint.icons and checkpoint.icons[1] then
		return {
			util.copy(checkpoint.icons[1]),
		}
	end

	if checkpoint.icon then
		return {
			_assets.icons.create_technology_icon(checkpoint.icon, checkpoint.icon_size),
		}
	end

	return {}
end

local function apply_checkpoint_overlay(options)
	local checkpoint = data.raw.technology and data.raw.technology[options.checkpoint_name]

	if not checkpoint then
		return
	end

	local overlay_icons = _sprite_utils.icons.transform_icons(
		make_technology_icons(options),
		options.overlay_scale,
		options.overlay_shift,
		nil,
		"technology"
	)

	if not overlay_icons then
		return
	end

	local combined_icons = get_checkpoint_background_icons(checkpoint, options)

	-- Append the generated overlay after the blueprint background.
	for _, icon_layer in ipairs(overlay_icons) do
		combined_icons[#combined_icons + 1] = util.copy(icon_layer)
	end

	if options.top_icons then
		for _, icon_layer in ipairs(options.top_icons) do
			combined_icons[#combined_icons + 1] = util.copy(icon_layer)
		end
	end

	_sprite_utils.icons.assign_icons_to_prototype_and_related_prototypes(
		options.checkpoint_name,
		"technology",
		combined_icons
	)
end

for _, options in ipairs(checkpoint_overlays) do
	apply_checkpoint_overlay(options)
end
