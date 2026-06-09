local _lib = require("_lib")
local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _assets = {
	defines = require("__reskins-assets-api__.api.defines"),
	icons = require("__reskins-assets-api__.api.icons"),
	create_icon = require("__reskins-assets-api__.assets.base.base-icons"),
}

local SolarPanelGraphicsPack = require("__reskins-assets-api__.graphics-packs.base.solar-panel-graphics-pack")

local entities = {
	["nullius-solar-panel-1"] = { type = "solar-panel", tier = 1, prog_tier = 1 },
	["nullius-solar-panel-2"] = { type = "solar-panel", tier = 2, prog_tier = 2 },
	["nullius-solar-panel-3"] = { type = "solar-panel", tier = 3, prog_tier = 3 },
	["nullius-solar-panel-4"] = { type = "solar-panel", tier = 4, prog_tier = 4 },
}

for name, options in pairs(entities) do
	local entity = data.raw[options.type][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	_lib.create_explosions_and_particles(name, {
		base_entity_name = "solar-panel",
		type = options.type,
		tint = tint,
		particles = {
			["small"] = 2,
		},
	})

	-- local corpse = _lib.create_remnant(name, {
	-- 	base_entity_name = "solar-panel",
	-- 	type = options.type,
	-- })

	local graphics_pack = SolarPanelGraphicsPack:configure({
		tint = tint,
		variant = "large",
	})

	graphics_pack:apply_to_entity(entity)
	-- graphics_pack:apply_to_corpse(corpse)

	local icon = _assets.create_icon.solar_panel(tint)
	---@type DeferrableIconData
	local deferrable_icon = {
		name = name,
		type_name = options.type,
		icon_data = _framework.tiers.add_tier_labels_to_icons(tier, icon),
	}

	_assets.icons.assign_deferrable_icon(deferrable_icon)

	::continue::
end
