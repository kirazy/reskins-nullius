local TechnologyIcons = require("prototypes.technology-icons")
local MiningDrillTechnology = require("__reskins-assets-api__.assets.bobs.technologies.mining-drill")

TechnologyIcons.assign_technology_icons({
	["nullius-mining-1"] = {
		tier = 1,
		prog_tier = 1,
		module = MiningDrillTechnology,
		params = { variant = "standard" },
	},
	["nullius-mining-2"] = {
		tier = 2,
		prog_tier = 2,
		module = MiningDrillTechnology,
		params = { variant = "standard" },
	},
	["nullius-mining-3"] = {
		tier = 3,
		prog_tier = 3,
		module = MiningDrillTechnology,
		params = { variant = "standard" },
	},
})
