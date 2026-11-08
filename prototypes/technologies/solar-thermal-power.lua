local TechnologyIcons = require("prototypes.technology-icons")
local SolarCollector = require("__reskins-assets-api__.assets.assorted.technologies.solar-collector")

TechnologyIcons.assign_technology_icons({
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
})
