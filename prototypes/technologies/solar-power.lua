local TechnologyIcons = require("prototypes.technology-icons")
local SolarEnergy = require("__reskins-assets-api__.assets.base.technologies.solar-energy")

TechnologyIcons.assign_technology_icons({
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
})
