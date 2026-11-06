local _framework = {
	tiers = require("__reskins-framework__.api.tiers"),
}
local _lib = require("_lib")
local AirFilter = require("__reskins-assets-api__.assets.angels.entities.petrochem.air-filter")
local Automation = require("__reskins-assets-api__.assets.base.technologies.automation")
local ElectricEnergyAccumulators =
	require("__reskins-assets-api__.assets.base.technologies.electric-energy-accumulators")
local EquipmentExoskeleton = require("__reskins-assets-api__.assets.base.technologies.equipment-exoskeleton")
local EquipmentFissionReactor = require("__reskins-assets-api__.assets.bobs.technologies.equipment-fission-reactor")
local EquipmentNightVision = require("__reskins-assets-api__.assets.base.technologies.equipment-night-vision")
local FluidHandling = require("__reskins-assets-api__.assets.base.technologies.fluid-handling")
local FurnaceElectricChemical = require("__reskins-assets-api__.assets.bobs.technologies.furnace-electric-chemical")
local GasTank = require("__reskins-assets-api__.assets.angels.technologies.gas-tank")
local HeatExchangerTechnology = require("__reskins-assets-api__.assets.bobs.technologies.heat-exchanger")
local LabTechnology = require("__reskins-assets-api__.assets.base.technologies.lab")
local MiningDrillTechnology = require("__reskins-assets-api__.assets.bobs.technologies.mining-drill")
local OilGathering = require("__reskins-assets-api__.assets.base.technologies.oil-gathering")
local OreFlotation = require("__reskins-assets-api__.assets.angels.technologies.ore-flotation")
local PowerPoles = require("__reskins-assets-api__.assets.base.technologies.power-poles")
local Pump = require("__reskins-assets-api__.assets.base.entities.pump")
local Radar = require("__reskins-assets-api__.assets.base.entities.radar")
local RepairPack = require("__reskins-assets-api__.assets.bobs.technologies.repair-pack")
local Robotics = require("__reskins-assets-api__.assets.base.technologies.robotics")
local SolarCollector = require("__reskins-assets-api__.assets.assorted.technologies.solar-collector")
local SolarEnergy = require("__reskins-assets-api__.assets.base.technologies.solar-energy")
local SteamEngineTechnology = require("__reskins-assets-api__.assets.bobs.technologies.steam-engine")
local SubstationTechnology = require("__reskins-assets-api__.assets.base.technologies.substation")
local ThermalTank = require("__reskins-assets-api__.assets.assorted.technologies.thermal-tank")
local TurretArtilleryTechnology = require("__reskins-assets-api__.assets.base.technologies.turret-artillery")
local WaterTreatment = require("__reskins-assets-api__.assets.angels.technologies.water-treatment")
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local BASE_ICON_PATH = "__base__/graphics/icons/"

-- ============================================================================
-- Technology assignments
-- ============================================================================

local technologies = {
	["nullius-plumbing-1"] = {
		tier = 1,
		prog_tier = 1,
		module = FluidHandling,
	},
	["nullius-plumbing-2"] = {
		tier = 1,
		prog_tier = 1,
		module = FluidHandling,
	},
	["nullius-plumbing-3"] = {
		tier = 2,
		prog_tier = 2,
		module = FluidHandling,
	},
	["nullius-plumbing-4"] = {
		tier = 2,
		prog_tier = 2,
		module = FluidHandling,
	},
	["nullius-plumbing-5"] = {
		tier = 3,
		prog_tier = 3,
		module = FluidHandling,
	},
	["nullius-plumbing-6"] = {
		tier = 4,
		prog_tier = 4,
		module = FluidHandling,
	},
	["nullius-empiricism-1"] = {
		tier = 1,
		prog_tier = 1,
		module = LabTechnology,
	},
	["nullius-empiricism-2"] = {
		tier = 1,
		prog_tier = 1,
		module = LabTechnology,
	},
	["nullius-empiricism-3"] = {
		tier = 1,
		prog_tier = 1,
		module = LabTechnology,
	},
	["nullius-empiricism-4"] = {
		tier = 2,
		prog_tier = 2,
		module = LabTechnology,
	},
	["nullius-empiricism-5"] = {
		tier = 2,
		prog_tier = 2,
		module = LabTechnology,
	},
	["nullius-empiricism-6"] = {
		tier = 3,
		prog_tier = 3,
		module = LabTechnology,
	},
	["nullius-empiricism-7"] = {
		tier = 5,
		prog_tier = 5,
		module = LabTechnology,
	},
	["nullius-solar-power-1"] = {
		tier = 1,
		prog_tier = 1,
		module = SolarEnergy,
	},
	["nullius-solar-power-2"] = {
		tier = 2,
		prog_tier = 2,
		module = SolarEnergy,
	},
	["nullius-solar-power-3"] = {
		tier = 3,
		prog_tier = 3,
		module = SolarEnergy,
	},
	["nullius-solar-power-4"] = {
		tier = 4,
		prog_tier = 4,
		module = SolarEnergy,
	},
	["nullius-automation"] = {
		tier = 1,
		prog_tier = 1,
		module = Automation,
		scale = 0.66,
	},
	["nullius-automation-2"] = {
		tier = 2,
		prog_tier = 2,
		module = Automation,
	},
	["nullius-automation-3"] = {
		tier = 3,
		prog_tier = 3,
		module = Automation,
		scale = 1.25,
	},
	["nullius-mass-production-1"] = {
		tier = 1,
		prog_tier = 1,
		module = Automation,
	},
	["nullius-mass-production-2"] = {
		tier = 1,
		prog_tier = 1,
		module = Automation,
	},
	["nullius-mass-production-3"] = {
		tier = 2,
		prog_tier = 2,
		module = Automation,
		scale = 1.25,
	},
	["nullius-mass-production-4"] = {
		tier = 4,
		prog_tier = 4,
		module = Automation,
		scale = 1.25,
	},
	["nullius-mass-production-5"] = {
		tier = 5,
		prog_tier = 5,
		module = Automation,
		scale = 1.25,
	},
	["nullius-mass-production-6"] = {
		tier = 6,
		prog_tier = 6,
		module = Automation,
		scale = 1.25,
	},
	["nullius-mass-production-7"] = {
		tier = 6,
		prog_tier = 6,
		module = Automation,
		scale = 1.25,
	},
	["nullius-battery-storage-2"] = {
		tier = 1,
		prog_tier = 1,
		module = ElectricEnergyAccumulators,
	},
	["nullius-battery-storage-4"] = {
		tier = 2,
		prog_tier = 3,
		module = ElectricEnergyAccumulators,
	},
	["nullius-battery-storage-6"] = {
		tier = 3,
		prog_tier = 4,
		module = ElectricEnergyAccumulators,
	},
	["nullius-energy-distribution-1"] = {
		tier = 1,
		prog_tier = 1,
		module = PowerPoles,
	},
	["nullius-energy-distribution-2"] = {
		tier = 2,
		prog_tier = 2,
		module = PowerPoles,
	},
	["nullius-energy-distribution-3"] = {
		tier = 1,
		prog_tier = 1,
		module = SubstationTechnology,
	},
	["nullius-energy-distribution-4"] = {
		tier = 3,
		prog_tier = 3,
		module = PowerPoles,
	},
	["nullius-energy-distribution-5"] = {
		tier = 4,
		prog_tier = 4,
		module = SubstationTechnology,
	},
	["nullius-geothermal-power-1"] = {
		tier = 1,
		prog_tier = 1,
		module = FurnaceElectricChemical,
	},
	["nullius-geothermal-power-2"] = {
		tier = 2,
		prog_tier = 2,
		module = FurnaceElectricChemical,
	},
	["nullius-geothermal-power-3"] = {
		tier = 3,
		prog_tier = 3,
		module = FurnaceElectricChemical,
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
		tier = 1,
		prog_tier = 1,
		module = AirFilter,
	},
	["nullius-air-filtration-2"] = {
		tier = 2,
		prog_tier = 2,
		module = AirFilter,
	},
	["nullius-air-filtration-3"] = {
		tier = 3,
		prog_tier = 3,
		module = AirFilter,
	},
	["nullius-flotation-1"] = {
		tier = 1,
		prog_tier = 1,
		module = OreFlotation,
	},
	["nullius-flotation-2"] = {
		tier = 2,
		prog_tier = 2,
		module = OreFlotation,
	},
	["nullius-flotation-3"] = {
		tier = 3,
		prog_tier = 3,
		module = OreFlotation,
	},
	["nullius-pumping-1"] = {
		tier = 1,
		prog_tier = 1,
		module = Pump,
	},
	["nullius-pumping-2"] = {
		tier = 2,
		prog_tier = 2,
		module = Pump,
	},
	["nullius-pumping-3"] = {
		tier = 3,
		prog_tier = 3,
		module = Pump,
	},
	["nullius-mining-1"] = {
		tier = 1,
		prog_tier = 1,
		module = MiningDrillTechnology,
		params = { variant = "standard" },
	},
	["nullius-mining-2"] = {
		tier = 2,
		prog_tier = 2,
		module = MiningDrillTechnology,
		params = { variant = "standard" },
	},
	["nullius-mining-3"] = {
		tier = 3,
		prog_tier = 3,
		module = MiningDrillTechnology,
		params = { variant = "standard" },
	},
	["nullius-exploration-1"] = {
		tier = 1,
		prog_tier = 2,
		module = TurretArtilleryTechnology,
	},
	["nullius-exploration-2"] = {
		tier = 2,
		prog_tier = 3,
		module = TurretArtilleryTechnology,
	},
	["nullius-exploration-3"] = {
		tier = 3,
		prog_tier = 4,
		module = TurretArtilleryTechnology,
	},
	["nullius-thermal-storage-1"] = {
		tier = 1,
		prog_tier = 2,
		module = ThermalTank,
	},
	["nullius-thermal-storage-2"] = {
		tier = 2,
		prog_tier = 3,
		module = ThermalTank,
	},
	["nullius-thermal-storage-3"] = {
		tier = 3,
		prog_tier = 4,
		module = ThermalTank,
	},
	["nullius-locomotion-1"] = {
		tier = 1,
		module = EquipmentExoskeleton,
	},
	["nullius-locomotion-2"] = {
		tier = 2,
		module = EquipmentExoskeleton,
	},
	["nullius-locomotion-3"] = {
		tier = 3,
		module = EquipmentExoskeleton,
	},
	["nullius-locomotion-4"] = {
		tier = 4,
		module = EquipmentExoskeleton,
	},
	["nullius-locomotion-5"] = {
		tier = 5,
		module = EquipmentExoskeleton,
	},
	["nullius-cybernetics-2"] = {
		tier = 1,
		module = EquipmentNightVision,
	},
	["nullius-cybernetics-3"] = {
		tier = 2,
		module = EquipmentFissionReactor,
	},
	["nullius-cybernetics-4"] = {
		tier = 1,
		module = EquipmentExoskeleton,
	},
	["nullius-cybernetics-5"] = {
		tier = 3,
		module = EquipmentNightVision,
	},
	["nullius-insulation-1"] = {
		tier = 1,
		module = EquipmentFissionReactor,
	},
	["nullius-nuclear-power-1"] = {
		tier = 4,
		module = EquipmentFissionReactor,
	},
	["nullius-maintenance"] = {
		tier = 4,
		module = RepairPack,
	},
	["nullius-hydrology-1"] = {
		module = OilGathering,
		params = { variant = "water" },
	},
	["nullius-hydrology-2"] = {
		module = OilGathering,
		params = { variant = "water" },
	},
	["nullius-robotics-1"] = {
		tier = 1,
		prog_tier = 2,
		module = Robotics,
	},
	["nullius-robotics-2"] = {
		tier = 2,
		prog_tier = 3,
		module = Robotics,
	},
	["nullius-robotics-3"] = {
		tier = 3,
		prog_tier = 4,
		module = Robotics,
	},
	["nullius-robotics-4"] = {
		tier = 4,
		prog_tier = 5,
		module = Robotics,
	},
	["nullius-sensors-2"] = {
		module = Radar,
		tier = 1,
	},
	["nullius-sensors-3"] = {
		module = Radar,
		tier = 2,
	},
	["nullius-sensors-4"] = {
		module = Radar,
		tier = 3,
	},
	["nullius-solar-thermal-power-1"] = {
		module = SolarCollector,
		tint = util.color("#ff3333"),
	},
	["nullius-solar-thermal-power-2"] = {
		module = SolarCollector,
		tint = util.color("#ff9f1c"),
	},
	["nullius-solar-thermal-power-3"] = {
		module = SolarCollector,
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

---Gets the icon of the catalog module from the given technology `options`, in the tint of its tier and with its
---`params`, converted to the icon defaults of a technology.
---@param options table
---@return IconData[]
local function make_catalog_technology_icon(options)
	local params = util.copy(options.params or {})
	params.tint = get_tier_tint(options)

	return options.module.get_icon_composition(params):build({ to = "technology" })
end

local technology_icon_builders = {
	catalog = make_catalog_technology_icon,
	["electrolyzer-entity-frame"] = make_electrolyzer_entity_frame_technology_icon,
	flat = make_flat_technology_icon,
}

local function make_technology_icons(options)
	local icon_type = options.icon_type or "catalog"
	local builder = technology_icon_builders[icon_type]

	if not builder then
		error("The technology icon type '" .. icon_type .. "' is not known.")
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

	local icon_data = _sprite_utils.icons.transform_icons(make_technology_icons(options), {
		scale = options.scale,
	}, "technology")

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
		module = HeatExchangerTechnology,
		params = { pipe_material = "base" },
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
		module = GasTank,
		tier = 2,
		prog_tier = 3,
		overlay_scale = 3.5,
	},
	{
		checkpoint_name = "nullius-checkpoint-plumbing",
		background_icons = make_blueprint_background(),
		module = FluidHandling,
		tier = 2,
		prog_tier = 2,
		overlay_scale = 4,
	},
	{
		checkpoint_name = "nullius-checkpoint-pumping",
		background_icons = make_blueprint_background(),
		module = Pump,
		tier = 2,
		prog_tier = 2,
		overlay_scale = 4,
	},
	{
		checkpoint_name = "nullius-checkpoint-water",
		background_icons = make_blueprint_background(),
		module = WaterTreatment,
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
		module = Robotics,
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
		module = LabTechnology,
		tier = 1,
		prog_tier = 1,
		overlay_scale = 4,
	},
	{
		checkpoint_name = "nullius-checkpoint-lab-2",
		background_icons = make_blueprint_background(),
		module = LabTechnology,
		tier = 2,
		prog_tier = 2,
		overlay_scale = 4,
	},
	{
		checkpoint_name = "nullius-checkpoint-solar-panel",
		background_icons = make_blueprint_background(),
		module = SolarEnergy,
		tier = 3,
		prog_tier = 3,
		overlay_scale = 4,
	},
	{
		checkpoint_name = "nullius-checkpoint-mass-production",
		background_icons = make_blueprint_background(),
		module = Automation,
		tier = 1,
		prog_tier = 2,
		overlay_scale = 4,
	},
	{
		checkpoint_name = "nullius-checkpoint-automation",
		background_icons = make_blueprint_background(),
		module = Automation,
		tier = 3,
		prog_tier = 5,
		overlay_scale = 4,
	},
	{
		checkpoint_name = "nullius-checkpoint-grid-battery",
		module = ElectricEnergyAccumulators,
		tier = 3,
		prog_tier = 4,
	},
	{
		checkpoint_name = "nullius-checkpoint-substation",
		module = SubstationTechnology,
		tier = 2,
		prog_tier = 2,
	},
	{
		checkpoint_name = "nullius-checkpoint-thermal-tank",
		background_icons = {},
		module = ThermalTank,
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
		module = MiningDrillTechnology,
		params = { variant = "standard" },
		tier = 2,
		prog_tier = 4,
		overlay_scale = 8,
	},
	{
		checkpoint_name = "nullius-checkpoint-stirling-engine",
		background_icons = make_blueprint_background(),
		module = SteamEngineTechnology,
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
			_sprite_utils.icons.create_technology_icon(checkpoint.icon, checkpoint.icon_size),
		}
	end

	return {}
end

local function apply_checkpoint_overlay(options)
	local checkpoint = data.raw.technology and data.raw.technology[options.checkpoint_name]

	if not checkpoint then
		return
	end

	local overlay_icons = _sprite_utils.icons.transform_icons(make_technology_icons(options), {
		scale = options.overlay_scale,
		shift = options.overlay_shift,
	}, "technology")

	if not overlay_icons then
		return
	end

	local combined_icons = get_checkpoint_background_icons(checkpoint, options)

	-- Append the generated overlay after the blueprint background.
	for _, icon_layer in pairs(overlay_icons) do
		combined_icons[#combined_icons + 1] = util.copy(icon_layer)
	end

	if options.top_icons then
		for _, icon_layer in pairs(options.top_icons) do
			combined_icons[#combined_icons + 1] = util.copy(icon_layer)
		end
	end

	_sprite_utils.icons.assign_icons_to_prototype_and_related_prototypes(
		options.checkpoint_name,
		"technology",
		combined_icons
	)
end

for _, options in pairs(checkpoint_overlays) do
	apply_checkpoint_overlay(options)
end
