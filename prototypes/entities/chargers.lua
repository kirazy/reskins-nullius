---@using data

local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local Applicators = require("__reskins-assets-api__.api.applicators")
local PrototypeScaler = require("__reskins-assets-api__.api.prototype-scaler")
local RoboChargePort = require("__reskins-assets-api__.assets.bobs.entities.robo-charge-port")
local RoboportChargePad = require("__reskins-assets-api__.assets.bobs.items.roboport-charge-pad")
local EquipmentPartChargePad = require("__reskins-assets-api__.assets.bobs.equipment.equipment-part-charge-pad")

local chargers = {
	["nullius-charger-1"] = { tier = 1, prog_tier = 2, image_index = 1, scale = 1 },
	["nullius-charger-2"] = { tier = 2, prog_tier = 3, image_index = 2, scale = 1 },
	["nullius-charger-3"] = { tier = 3, prog_tier = 4, image_index = 3, scale = 1 },
	["nullius-charger-4"] = { tier = 4, prog_tier = 5, image_index = 4, scale = 0.5 },
}

local triangle_offsets = {
	{ 0, -0.35 },
	{ -0.47, 0.35 },
	{ 0.47, 0.35 },
}

---Gets the positions of the charging pads for the given `scale`.
---@param scale number
---@return Vector[]
local function get_pad_positions(scale)
	local positions = {}

	for _, offset in pairs(triangle_offsets) do
		positions[#positions + 1] = { offset[1] * scale, offset[2] * scale }
	end

	return positions
end

for name, options in pairs(chargers) do
	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
		tier = tier,
		name = name,
		type_name = "roboport",
		composition = RoboportChargePad.get_icon_composition({ tint = tint, tier = options.image_index }),
	})
	_sprite_utils.icons.apply_icon_assignment(icon_assignment)

	local equipment = data.raw["roboport-equipment"][name]
	if equipment then
		local equipment_set = EquipmentPartChargePad.get_sprite_set({ tint = tint, tier = options.image_index })
		Applicators.apply_sprite_set(equipment, equipment_set)
	end

	local entity = data.raw["roboport"][name]
	if entity then
		local sprite_set = RoboChargePort.get_sprite_set({
			tint = tint,
			tier = options.image_index,
			pad_positions = get_pad_positions(options.scale),
			pad_scale = options.scale,
		})
		local graphics_set = util.copy(sprite_set.set.graphics_set)

		local scaler = PrototypeScaler.for_prototype(entity, {
			nominal_width = sprite_set.set.nominal_width,
			nominal_height = sprite_set.set.nominal_height,
		})
		scaler:rescale(graphics_set)

		entity.base_animation = graphics_set.base_animation
		entity.recharging_animation = graphics_set.recharging_animation
	end
end
