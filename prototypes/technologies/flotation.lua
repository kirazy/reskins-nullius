local TechnologyIcons = require("prototypes.technology-icons")
local OreFlotation = require("__reskins-assets-api__.assets.angels.technologies.ore-flotation")

TechnologyIcons.assign_technology_icons({
	["nullius-flotation-1"] = {
		tier = 1,
		prog_tier = 1,
		module = OreFlotation,
	},
	["nullius-flotation-2"] = {
		tier = 2,
		prog_tier = 2,
		module = OreFlotation,
	},
	["nullius-flotation-3"] = {
		tier = 3,
		prog_tier = 3,
		module = OreFlotation,
	},
})
