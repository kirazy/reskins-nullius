local TechnologyIcons = require("prototypes.technology-icons")
local EquipmentFissionReactor = require("__reskins-assets-api__.assets.bobs.technologies.equipment-fission-reactor")

TechnologyIcons.assign_technology_icons({
	["nullius-nuclear-power-1"] = {
		tier = 4,
		module = EquipmentFissionReactor,
	},
})
