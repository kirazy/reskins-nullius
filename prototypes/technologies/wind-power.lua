local TechnologyIcons = require("prototypes.technology-icons")
local WindTurbine = require("__reskins-assets-api__.assets.assorted.technologies.wind-turbine")

TechnologyIcons.assign_technology_icons({
	["nullius-wind-power-1"] = {
		tier = 1,
		prog_tier = 1,
		module = WindTurbine,
	},
	["nullius-wind-power-2"] = {
		tier = 2,
		prog_tier = 2,
		module = WindTurbine,
	},
	["nullius-wind-power-3"] = {
		tier = 3,
		prog_tier = 3,
		module = WindTurbine,
	},
})
