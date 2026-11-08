local TechnologyIcons = require("prototypes.technology-icons")
local Pump = require("__reskins-assets-api__.assets.base.entities.pump")

TechnologyIcons.assign_technology_icons({
	["nullius-pumping-1"] = {
		tier = 1,
		prog_tier = 1,
		module = Pump,
	},
	["nullius-pumping-2"] = {
		tier = 2,
		prog_tier = 2,
		module = Pump,
	},
	["nullius-pumping-3"] = {
		tier = 3,
		prog_tier = 3,
		module = Pump,
	},
})
