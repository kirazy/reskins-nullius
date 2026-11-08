local TechnologyIcons = require("prototypes.technology-icons")
local Robotics = require("__reskins-assets-api__.assets.base.technologies.robotics")

TechnologyIcons.assign_technology_icons({
	["nullius-robotics-1"] = {
		tier = 1,
		prog_tier = 2,
		module = Robotics,
	},
	["nullius-robotics-2"] = {
		tier = 2,
		prog_tier = 3,
		module = Robotics,
	},
	["nullius-robotics-3"] = {
		tier = 3,
		prog_tier = 4,
		module = Robotics,
	},
	["nullius-robotics-4"] = {
		tier = 4,
		prog_tier = 5,
		module = Robotics,
	},
})
