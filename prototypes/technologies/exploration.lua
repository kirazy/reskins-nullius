local TechnologyIcons = require("prototypes.technology-icons")
local TurretArtilleryTechnology = require("__reskins-assets-api__.assets.base.technologies.turret-artillery")

TechnologyIcons.assign_technology_icons({
	["nullius-exploration-1"] = {
		tier = 1,
		prog_tier = 2,
		module = TurretArtilleryTechnology,
	},
	["nullius-exploration-2"] = {
		tier = 2,
		prog_tier = 3,
		module = TurretArtilleryTechnology,
	},
	["nullius-exploration-3"] = {
		tier = 3,
		prog_tier = 4,
		module = TurretArtilleryTechnology,
	},
})
