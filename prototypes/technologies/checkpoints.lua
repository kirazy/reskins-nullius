local TechnologyIcons = require("prototypes.technology-icons")
local Automation = require("__reskins-assets-api__.assets.base.technologies.automation")
local ElectricEnergyAccumulators =
	require("__reskins-assets-api__.assets.base.technologies.electric-energy-accumulators")
local Electrolyser = require("__reskins-assets-api__.assets.angels.technologies.electrolyser")
local FluidHandling = require("__reskins-assets-api__.assets.base.technologies.fluid-handling")
local GasTank = require("__reskins-assets-api__.assets.angels.technologies.gas-tank")
local HeatExchangerTechnology = require("__reskins-assets-api__.assets.bobs.technologies.heat-exchanger")
local LabTechnology = require("__reskins-assets-api__.assets.base.technologies.lab")
local Logistics = require("__reskins-assets-api__.assets.base.technologies.logistics")
local MiningDrillTechnology = require("__reskins-assets-api__.assets.bobs.technologies.mining-drill")
local Pump = require("__reskins-assets-api__.assets.base.entities.pump")
local Robotics = require("__reskins-assets-api__.assets.base.technologies.robotics")
local SolarEnergy = require("__reskins-assets-api__.assets.base.technologies.solar-energy")
local SteamEngineTechnology = require("__reskins-assets-api__.assets.bobs.technologies.steam-engine")
local SubstationTechnology = require("__reskins-assets-api__.assets.base.technologies.substation")
local ThermalTank = require("__reskins-assets-api__.assets.assorted.technologies.thermal-tank")
local WaterTreatment = require("__reskins-assets-api__.assets.angels.technologies.water-treatment")

TechnologyIcons.assign_checkpoint_icons({
	{
		checkpoint_name = "nullius-checkpoint-heat-pipe",
		background_icons = {},
		module = HeatExchangerTechnology,
		params = { pipe_material = "base" },
		tier = 1,
		prog_tier = 2,
		overlay_scale = 4,
		top_icons = {
			TechnologyIcons.make_checkpoint_check_mark(),
		},
	},
	{
		checkpoint_name = "nullius-checkpoint-large-tank",
		background_icons = TechnologyIcons.make_blueprint_background(),
		module = GasTank,
		tier = 2,
		prog_tier = 3,
		overlay_scale = 3.5,
	},
	{
		checkpoint_name = "nullius-checkpoint-plumbing",
		background_icons = TechnologyIcons.make_blueprint_background(),
		module = FluidHandling,
		tier = 2,
		prog_tier = 2,
		overlay_scale = 4,
	},
	{
		checkpoint_name = "nullius-checkpoint-pumping",
		background_icons = TechnologyIcons.make_blueprint_background(),
		module = Pump,
		tier = 2,
		prog_tier = 2,
		overlay_scale = 4,
	},
	{
		checkpoint_name = "nullius-checkpoint-water",
		background_icons = TechnologyIcons.make_blueprint_background(),
		module = WaterTreatment,
		tier = 1,
		prog_tier = 1,
		overlay_scale = 4,
	},
	{
		checkpoint_name = "nullius-checkpoint-caustic-solution",
		background_icons = TechnologyIcons.make_blueprint_background(),
		module = Electrolyser,
		tier = 1,
		prog_tier = 1,
		overlay_scale = 4,
	},
	{
		checkpoint_name = "nullius-checkpoint-energy-storage",
		background_icons = TechnologyIcons.make_blueprint_background(),
		module = Electrolyser,
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
			TechnologyIcons.make_checkpoint_check_mark(),
		},
	},
	{
		checkpoint_name = "nullius-checkpoint-lab",
		background_icons = TechnologyIcons.make_blueprint_background(),
		module = LabTechnology,
		tier = 1,
		prog_tier = 1,
		overlay_scale = 4,
	},
	{
		checkpoint_name = "nullius-checkpoint-lab-2",
		background_icons = TechnologyIcons.make_blueprint_background(),
		module = LabTechnology,
		tier = 2,
		prog_tier = 2,
		overlay_scale = 4,
	},
	{
		checkpoint_name = "nullius-checkpoint-solar-panel",
		background_icons = TechnologyIcons.make_blueprint_background(),
		module = SolarEnergy,
		tier = 3,
		prog_tier = 3,
		overlay_scale = 4,
	},
	{
		checkpoint_name = "nullius-checkpoint-mass-production",
		background_icons = TechnologyIcons.make_blueprint_background(),
		module = Automation,
		tier = 1,
		prog_tier = 2,
		overlay_scale = 4,
	},
	{
		checkpoint_name = "nullius-checkpoint-automation",
		background_icons = TechnologyIcons.make_blueprint_background(),
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
			TechnologyIcons.make_checkpoint_check_mark(),
		},
	},
	{
		checkpoint_name = "nullius-checkpoint-large-miner",
		background_icons = TechnologyIcons.make_blueprint_background(),
		module = MiningDrillTechnology,
		params = { variant = "standard" },
		tier = 2,
		prog_tier = 4,
		overlay_scale = 8,
	},
	{
		checkpoint_name = "nullius-checkpoint-stirling-engine",
		background_icons = TechnologyIcons.make_blueprint_background(),
		module = SteamEngineTechnology,
		tier = 2,
		prog_tier = 2,
		overlay_scale = 8,
	},
	{
		checkpoint_name = "nullius-checkpoint-logistics",
		background_icons = TechnologyIcons.make_blueprint_background(),
		module = Logistics,
		tier = 2,
		prog_tier = 2,
		overlay_scale = 4,
		is_base = true,
	},
	{
		checkpoint_name = "nullius-checkpoint-logistics-2",
		background_icons = TechnologyIcons.make_blueprint_background(),
		module = Logistics,
		tier = 3,
		prog_tier = 3,
		overlay_scale = 4,
		is_base = true,
	},
	{
		checkpoint_name = "nullius-checkpoint-logistics-3",
		background_icons = TechnologyIcons.make_blueprint_background(),
		module = Logistics,
		tier = 4,
		prog_tier = 4,
		overlay_scale = 4,
	},
	{
		checkpoint_name = "nullius-checkpoint-large-beacon",
		background_icons = TechnologyIcons.make_blueprint_background(),
		icon = "__base__/graphics/technology/effect-transmission.png",
		overlay_scale = 4,
	},
})
