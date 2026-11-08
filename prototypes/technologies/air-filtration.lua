local TechnologyIcons = require("prototypes.technology-icons")
local AirFilter = require("__reskins-assets-api__.assets.angels.entities.petrochem.air-filter")

TechnologyIcons.assign_technology_icons({
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
})
