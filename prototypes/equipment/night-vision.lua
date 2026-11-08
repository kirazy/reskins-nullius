local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local Applicators = require("__reskins-assets-api__.api.applicators")
local EquipmentNightVision = require("__reskins-assets-api__.assets.base.items.equipment-night-vision")
local EquipmentNightVisionSprites = require("__reskins-assets-api__.assets.base.equipment.equipment-night-vision")

local night_vision_equipment = {
	["nullius-night-vision-1"] = { tier = 1 },
	["nullius-night-vision-2"] = { tier = 2 },
	["nullius-night-vision-3"] = { tier = 3 },
}

for name, options in pairs(night_vision_equipment) do
	local tint = _framework.tiers.get_tint(options.tier)
	local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
		tier = options.tier,
		name = name,
		type_name = "night-vision-equipment",
		composition = EquipmentNightVision.get_icon_composition({ tint = tint }),
	})

	_sprite_utils.icons.apply_icon_assignment(icon_assignment)

	local equipment = data.raw["night-vision-equipment"][name]
	if equipment ~= nil then
		Applicators.apply_sprite_set(equipment, EquipmentNightVisionSprites.get_sprite_set({ tint = tint }))
	end
end
