local TechnologyIcons = require("prototypes.technology-icons")
local OilGathering = require("__reskins-assets-api__.assets.base.technologies.oil-gathering")

TechnologyIcons.assign_technology_icons({
	["nullius-hydrology-1"] = {
		module = OilGathering,
		params = { variant = "water" },
	},
	["nullius-hydrology-2"] = {
		module = OilGathering,
		params = { variant = "water" },
	},
})
