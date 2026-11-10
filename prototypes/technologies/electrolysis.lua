local TechnologyIcons = require("prototypes.technology-icons")
local Electrolyser = require("__reskins-assets-api__.assets.angels.technologies.electrolyser")

TechnologyIcons.assign_technology_icons({
	["nullius-electrolysis-1"] = {
		tier = 1,
		prog_tier = 1,
		module = Electrolyser,
	},
	["nullius-electrolysis-2"] = {
		tier = 1,
		prog_tier = 1,
		module = Electrolyser,
	},
	["nullius-electrolysis-3"] = {
		tier = 2,
		prog_tier = 2,
		module = Electrolyser,
	},
	["nullius-electrolysis-4"] = {
		tier = 3,
		prog_tier = 3,
		module = Electrolyser,
	},
})
