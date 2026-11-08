local TechnologyIcons = require("prototypes.technology-icons")
local FurnaceElectricChemical = require("__reskins-assets-api__.assets.bobs.technologies.furnace-electric-chemical")

TechnologyIcons.assign_technology_icons({
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
})
