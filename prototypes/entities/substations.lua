local _lib = require("_lib")
local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _assets = { create_icon = require("__reskins-assets-api__.assets.base.base-icons") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local SubstationGraphicsPack = require("__reskins-assets-api__.graphics-packs.base.substation-graphics-pack")

local entities = {
	["substation"] = { type = "electric-pole", tier = 1, prog_tier = 1 },
	["nullius-substation-2"] = { type = "electric-pole", tier = 2, prog_tier = 2 },
	["nullius-substation-3"] = { type = "electric-pole", tier = 3, prog_tier = 3 },
}

for name, options in pairs(entities) do
	local entity = data.raw[options.type][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	_lib.create_explosions_and_particles(name, {
		base_entity_name = "substation",
		type = options.type,
		tint = tint,
		particles = {
			["big"] = 2,
		},
	})

	local corpse = _lib.create_remnant(name, {
		base_entity_name = "substation",
		type = options.type,
	})

	local graphics_pack = SubstationGraphicsPack:configure({
		tint = tint,
	})

	graphics_pack:apply_to_entity(entity)
	graphics_pack:apply_to_corpse(corpse)

	local deferrable_icon = _framework.tiers.deferrable_icon_with_tier_labels({
		tier = tier,
		name = name,
		type_name = options.type,
		icon_data = _assets.create_icon.substation(tint),
	})

	_sprite_utils.icons.assign_deferrable_icon(deferrable_icon)

	::continue::
end
