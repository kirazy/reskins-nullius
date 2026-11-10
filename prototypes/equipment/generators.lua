-- cspell: words reprioritization
---@using data
---@using Reskins.SpriteUtils

local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = {
	defines = require("__reskins-sprite-utils__.defines"),
	icons = require("__reskins-sprite-utils__.icons"),
}

local Applicators = require("__reskins-assets-api__.api.applicators")
local EquipmentFissionReactor = require("__reskins-assets-api__.assets.base.items.equipment-fission-reactor")
local EquipmentFissionReactorSprites = require("__reskins-assets-api__.assets.base.equipment.equipment-fission-reactor")

local battery_low_symbol = _sprite_utils.icons.create_icon("__base__/graphics/icons/signal/signal-battery-low.png", 64)
local battery_full_symbol =
	_sprite_utils.icons.create_icon("__base__/graphics/icons/signal/signal-battery-full.png", 64)

-- Draw the symbol at half size in the lower-left corner, 8 pixels from the left edge to clear the tier label.
local southwest = _sprite_utils.defines.icon_transforms.corners.southwest
local symbol_placement = { scale = southwest.scale, shift = { southwest.shift[1] + 2, southwest.shift[2] } }

local generator_equipment = {
	["nullius-portable-generator-1"] = { tier = 1, prog_tier = 1 },
	["nullius-portable-generator-2"] = { tier = 2, prog_tier = 2 },
	["nullius-portable-generator-backup"] = { tier = 2, prog_tier = 2, symbol = battery_low_symbol },
	["nullius-portable-reactor"] = { tier = 3, prog_tier = 3 },
}

---Gets the icon composition of a portable generator in the given `tint`, with the given `symbol`, if any.
---@param tint Color
---@param symbol? IconData
---@return IconComposition
local function get_icon_composition(tint, symbol)
	local composition = EquipmentFissionReactor.get_icon_composition({ tint = tint })
	if symbol then
		composition = composition:add_symbol(symbol, symbol_placement)
	end

	return composition
end

for name, options in pairs(generator_equipment) do
	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)
	local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
		tier = tier,
		name = name,
		type_name = "generator-equipment",
		composition = get_icon_composition(tint, options.symbol),
	})

	_sprite_utils.icons.apply_icon_assignment(icon_assignment)

	local equipment = data.raw["generator-equipment"][name]
	if equipment ~= nil then
		Applicators.apply_sprite_set(equipment, EquipmentFissionReactorSprites.get_sprite_set({ tint = tint }))
	end
end

-- The reprioritization recipe converts the backup generator into the portable generator 2.
local reprioritization = data.raw["recipe"]["nullius-portable-generator-reprioritization"]
if reprioritization then
	local tier = _framework.tiers.get_tier(generator_equipment["nullius-portable-generator-2"])
	local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
		tier = tier,
		name = reprioritization.name,
		type_name = "recipe",
		composition = get_icon_composition(_framework.tiers.get_tint(tier), battery_full_symbol),
	})

	_sprite_utils.icons.apply_icon_assignment(icon_assignment)
end
