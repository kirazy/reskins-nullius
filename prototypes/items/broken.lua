-- cspell: words FFCBCBCB
local _colors = require("__reskins-sprite-utils__.colors")
local _assets = {
	defines = require("__reskins-assets-api__.api.defines"),
	icons = require("__reskins-assets-api__.api.icons"),
	create_icon = require("__reskins-assets-api__.assets.base.base-icons"),
}

local broken_symbol = {
	icon = "__nullius__/graphics/icons/broken.png",
	icon_size = 64,
}

local broken_items = {
	["nullius-broken-air-filter"] = { source_item = "nullius-air-filter-1" },
	["nullius-broken-assembler"] = { source_item = "nullius-medium-assembler-1" },
	["nullius-broken-chemical-plant"] = { source_item = "nullius-chemical-plant-1" },
	["nullius-broken-electrolyzer"] = { source_item = "nullius-electrolyzer-1" },
	["nullius-broken-foundry"] = { source_item = "nullius-foundry-1" },
	["nullius-broken-grid-battery"] = { source_item = "nullius-grid-battery-1" },
	["nullius-broken-hydro-plant"] = { source_item = "nullius-hydro-plant-1" },
	["nullius-broken-pylon"] = { source_item = "big-electric-pole" },
	["nullius-broken-sensor-node"] = { source_item = "radar" },
	["nullius-broken-solar-panel"] = { source_item = "nullius-solar-panel-1" },
}

for name, options in pairs(broken_items) do
	local target_item = data.raw.item[name]
	local source_item = data.raw.item[options.source_item]
	if not target_item or not source_item then
		goto continue
	end

	local source_icon = _assets.icons.get_icon_from_prototype(source_item)

	-- HACK: this is unsafe; prefer to construct clean icons with the appropriate tints.
	-- Needs additional work around icon generation in the assets-api.
	local icon = _assets.icons.compose_icons("default", source_icon, broken_symbol)
	icon[1].tint = _colors.from_argb("FFCBCBCB")
	icon[2].tint = _colors.blend(icon[2].tint, icon[1].tint, 0.25)

	---@type DeferrableIconData
	local deferrable_icon = {
		name = name,
		type_name = "item",
		icon_data = icon,
	}

	_assets.icons.assign_deferrable_icon(deferrable_icon)

	local recipe = data.raw.recipe[name]
	if recipe then
		local repair_pack_icon = {
			icon = "__base__/graphics/icons/repair-pack.png",
			icon_size = 64,
			scale = 0.25,
			shift = { -8, 8 },
		}

		_assets.icons.clear_icon_from_prototype(recipe)
		recipe.icons = _assets.icons.compose_icons("default", icon, repair_pack_icon)
	end

	::continue::
end
