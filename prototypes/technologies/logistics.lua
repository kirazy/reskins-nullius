local TechnologyIcons = require("prototypes.technology-icons")
local Logistics = require("__reskins-assets-api__.assets.base.technologies.logistics")

TechnologyIcons.assign_technology_icons({
	["nullius-logistics-1"] = {
		tier = 1,
		prog_tier = 1,
		module = Logistics,
		is_base = true,
	},
	["nullius-logistics-2"] = {
		tier = 2,
		prog_tier = 2,
		module = Logistics,
		is_base = true,
	},
	["nullius-logistics-3"] = {
		tier = 3,
		prog_tier = 3,
		module = Logistics,
		is_base = true,
	},
	["nullius-logistics-4"] = {
		tier = 4,
		prog_tier = 4,
		module = Logistics,
	},
})
