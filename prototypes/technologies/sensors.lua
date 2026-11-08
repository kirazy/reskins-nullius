local TechnologyIcons = require("prototypes.technology-icons")
local Radar = require("__reskins-assets-api__.assets.base.entities.radar")

TechnologyIcons.assign_technology_icons({
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
})
