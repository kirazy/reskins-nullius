local TechnologyIcons = require("prototypes.technology-icons")
local Automation = require("__reskins-assets-api__.assets.base.technologies.automation")

TechnologyIcons.assign_technology_icons({
	["nullius-automation"] = {
		tier = 1,
		prog_tier = 1,
		module = Automation,
		scale = 0.66,
	},
	["nullius-automation-2"] = {
		tier = 2,
		prog_tier = 2,
		module = Automation,
	},
	["nullius-automation-3"] = {
		tier = 3,
		prog_tier = 3,
		module = Automation,
		scale = 1.25,
	},
})
