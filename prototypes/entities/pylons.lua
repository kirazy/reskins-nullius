local _lib = require("_lib")
local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _assets = {
	defines = require("__reskins-assets-api__.api.defines"),
	icons = require("__reskins-assets-api__.api.icons"),
	create_icon = require("__reskins-assets-api__.assets.base.base-icons"),
}

local ElectricPoleBigGraphicsPack =
	require("__reskins-assets-api__.graphics-packs.base.electric-pole-big-graphics-pack")

local entities = {
	["big-electric-pole"] = { type = "electric-pole", tier = 1, prog_tier = 1 },
	["nullius-pylon-2"] = { type = "electric-pole", tier = 2, prog_tier = 2 },
	["nullius-pylon-3"] = { type = "electric-pole", tier = 3, prog_tier = 3 },
}

for name, options in pairs(entities) do
	local entity = data.raw[options.type][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	_lib.create_explosions_and_particles(name, {
		base_entity_name = "big-electric-pole",
		type = options.type,
		tint = tint,
		particles = {
			["medium-long"] = 1,
		},
	})

	local corpse = _lib.create_remnant(name, {
		base_entity_name = "big-electric-pole",
		type = options.type,
	})

	local graphics_pack = ElectricPoleBigGraphicsPack:configure({
		tint = tint,
	})

	graphics_pack:apply_to_entity(entity)
	graphics_pack:apply_to_corpse(corpse)

	local icon = _assets.create_icon.electric_pole_big(tint)
	---@type DeferrableIconData
	local deferrable_icon = {
		name = name,
		type_name = options.type,
		icon_data = _framework.tiers.add_tier_labels_to_icons(tier, icon),
	}

	_assets.icons.assign_deferrable_icon(deferrable_icon)

	::continue::
end
