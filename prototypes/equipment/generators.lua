local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local Applicators = require("__reskins-assets-api__.api.applicators")
local EquipmentFissionReactor = require("__reskins-assets-api__.assets.base.items.equipment-fission-reactor")
local EquipmentFissionReactorSprites = require("__reskins-assets-api__.assets.base.equipment.equipment-fission-reactor")

local generator_equipment = {
	["nullius-portable-generator-1"] = { tier = 1 },
	["nullius-portable-generator-2"] = { tier = 2 },
	["nullius-portable-generator-backup"] = { tier = 3 },
	["nullius-portable-reactor"] = { tier = 4 },
}

for name, options in pairs(generator_equipment) do
	local tint = _framework.tiers.get_tint(options.tier)
	local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
		tier = options.tier,
		name = name,
		type_name = "generator-equipment",
		composition = EquipmentFissionReactor.get_icon_composition({ tint = tint }),
	})

	_sprite_utils.icons.apply_icon_assignment(icon_assignment)

	local equipment = data.raw["generator-equipment"][name]
	if equipment ~= nil then
		Applicators.apply_sprite_set(equipment, EquipmentFissionReactorSprites.get_sprite_set({ tint = tint }))
	end
end
