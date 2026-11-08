local TechnologyIcons = require("prototypes.technology-icons")
local ThermalTank = require("__reskins-assets-api__.assets.assorted.technologies.thermal-tank")

TechnologyIcons.assign_technology_icons({
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
})
