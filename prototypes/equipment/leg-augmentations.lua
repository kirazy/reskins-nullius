local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local Applicators = require("__reskins-assets-api__.api.applicators")
local EquipmentExoskeleton = require("__reskins-assets-api__.assets.base.items.equipment-exoskeleton")
local EquipmentExoskeletonSprites = require("__reskins-assets-api__.assets.base.equipment.equipment-exoskeleton")

local leg_augmentations = {
	["nullius-leg-augmentation-1"] = { tier = 1 },
	["nullius-leg-augmentation-2"] = { tier = 2 },
	["nullius-leg-augmentation-3"] = { tier = 3 },
	["nullius-leg-augmentation-4"] = { tier = 4 },
}

for name, options in pairs(leg_augmentations) do
	local tint = _framework.tiers.get_tint(options.tier)
	local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
		tier = options.tier,
		name = name,
		type_name = "movement-bonus-equipment",
		composition = EquipmentExoskeleton.get_icon_composition({ tint = tint }),
	})

	_sprite_utils.icons.apply_icon_assignment(icon_assignment)

	local equipment = data.raw["movement-bonus-equipment"][name]
	if equipment ~= nil then
		Applicators.apply_sprite_set(equipment, EquipmentExoskeletonSprites.get_sprite_set({ tint = tint }))
	end
end
