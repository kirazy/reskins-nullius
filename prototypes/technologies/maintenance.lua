local TechnologyIcons = require("prototypes.technology-icons")
local RepairPack = require("__reskins-assets-api__.assets.bobs.technologies.repair-pack")

TechnologyIcons.assign_technology_icons({
	["nullius-maintenance"] = {
		tier = 4,
		module = RepairPack,
	},
})
