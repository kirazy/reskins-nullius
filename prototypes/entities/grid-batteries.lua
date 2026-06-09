local _lib = require("_lib")
local _sprites = require("__reskins-sprite-utils__.sprites")
local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _assets = {
	defines = require("__reskins-assets-api__.api.defines"),
	icons = require("__reskins-assets-api__.api.icons"),
	create_icon = require("__reskins-assets-api__.assets.base.base-icons"),
}

local AccumulatorGraphicsPack = require("__reskins-assets-api__.graphics-packs.base.accumulator-graphics-pack")

local entities = {
	["nullius-grid-battery-1"] = { type = "accumulator", tier = 1, prog_tier = 1, scale_factor = 3 / 2 },
	["nullius-grid-battery-2"] = { type = "accumulator", tier = 2, prog_tier = 2, scale_factor = 3 / 2 },
	["nullius-grid-battery-3"] = { type = "accumulator", tier = 3, prog_tier = 3, scale_factor = 3 / 2 },
}

for name, options in pairs(entities) do
	local entity = data.raw[options.type][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	_lib.create_explosions_and_particles(name, {
		base_entity_name = "accumulator",
		type = "accumulator",
		tint = tint,
		particles = {
			["medium"] = 2,
			["small"] = 3,
		},
	})

	local corpse = _lib.create_remnant(name, {
		base_entity_name = "accumulator",
		type = "accumulator",
	})

	local graphics_pack = AccumulatorGraphicsPack:configure({
		tint = tint,
	})

	graphics_pack:apply_to_entity(entity)
	graphics_pack:apply_to_corpse(corpse)
	if options.scale_factor then
		_sprites.rescale_prototype(corpse, options.scale_factor)
	end

	local icon = _assets.create_icon.accumulator(tint)
	---@type DeferrableIconData
	local deferrable_icon = {
		name = name,
		type_name = options.type,
		icon_data = _framework.tiers.add_tier_labels_to_icons(tier, icon),
	}

	_assets.icons.assign_deferrable_icon(deferrable_icon)

	::continue::
end
