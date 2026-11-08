local TechnologyIcons = require("prototypes.technology-icons")
local PowerPoles = require("__reskins-assets-api__.assets.base.technologies.power-poles")
local SubstationTechnology = require("__reskins-assets-api__.assets.base.technologies.substation")

TechnologyIcons.assign_technology_icons({
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
})
