--cspell: words aneutronic

local _assets = {
	defines = require("__reskins-assets-api__.api.defines"),
	sprites = require("__reskins-assets-api__.api.sprites"),
}
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local IconComposition = require("__reskins-sprite-utils__.icon-composition")

local lit_items = {
	["nullius-aneutronic-cell"] = _assets.sprites.get_sprite_light_layer(_assets.defines.light.fuel_cell),
	["nullius-fusion-cell"] = _assets.sprites.get_sprite_light_layer(_assets.defines.light.fuel_cell),
	["nullius-breeder-cell"] = _assets.sprites.get_sprite_light_layer(_assets.defines.light.fuel_cell),
	["nullius-fission-cell"] = _assets.sprites.get_sprite_light_layer(_assets.defines.light.fuel_cell),

	["nullius-antimatter"] = _assets.sprites.get_sprite_light_layer(_assets.defines.light.fuel),
	["nullius-magazine"] = _assets.sprites.get_sprite_light_layer(_assets.defines.light.rounds_magazine),
}

for name, light in pairs(lit_items) do
	local item = data.raw.item[name]
	if item then
		_sprite_utils.icons.apply_icon_assignment({
			name = item.name,
			type_name = item.type,
			composition = IconComposition:from_prototype(item):add_light(light),
			options = {
				strict = true,
			},
		})
	end
end

local glowing_items = {
	"nullius-enriched-uranium",
}

for _, name in pairs(glowing_items) do
	local item = data.raw.item[name]
	if item then
		_sprite_utils.icons.apply_icon_assignment({
			name = item.name,
			type_name = item.type,
			composition = IconComposition:from_prototype(item):add_glow(item),
			options = {
				strict = true,
			},
		})
	end
end
