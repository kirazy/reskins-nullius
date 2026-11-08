local TechnologyIcons = require("prototypes.technology-icons")
local EquipmentExoskeleton = require("__reskins-assets-api__.assets.base.technologies.equipment-exoskeleton")
local EquipmentFissionReactor = require("__reskins-assets-api__.assets.bobs.technologies.equipment-fission-reactor")
local EquipmentNightVision = require("__reskins-assets-api__.assets.base.technologies.equipment-night-vision")

TechnologyIcons.assign_technology_icons({
	["nullius-cybernetics-2"] = {
		tier = 1,
		module = EquipmentNightVision,
	},
	["nullius-cybernetics-3"] = {
		tier = 2,
		module = EquipmentFissionReactor,
	},
	["nullius-cybernetics-4"] = {
		tier = 1,
		module = EquipmentExoskeleton,
	},
	["nullius-cybernetics-5"] = {
		tier = 3,
		module = EquipmentNightVision,
	},
})
