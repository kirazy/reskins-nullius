local TechnologyIcons = require("prototypes.technology-icons")
local EquipmentFissionReactor = require("__reskins-assets-api__.assets.bobs.technologies.equipment-fission-reactor")

TechnologyIcons.assign_technology_icons({
	["nullius-insulation-1"] = {
		tier = 1,
		module = EquipmentFissionReactor,
	},
})
