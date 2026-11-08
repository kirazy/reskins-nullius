local TechnologyIcons = require("prototypes.technology-icons")
local ElectricEnergyAccumulators =
	require("__reskins-assets-api__.assets.base.technologies.electric-energy-accumulators")

TechnologyIcons.assign_technology_icons({
	["nullius-battery-storage-2"] = {
		tier = 1,
		prog_tier = 1,
		module = ElectricEnergyAccumulators,
	},
	["nullius-battery-storage-4"] = {
		tier = 2,
		prog_tier = 3,
		module = ElectricEnergyAccumulators,
	},
	["nullius-battery-storage-6"] = {
		tier = 3,
		prog_tier = 4,
		module = ElectricEnergyAccumulators,
	},
})
