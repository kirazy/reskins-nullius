-- cspell: words electrolyzer

---@using data
---@using Reskins.SpriteUtils

local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _assets = { icons = require("__reskins-assets-api__.api.icons") }
local _sprite_utils = {
	icons = require("__reskins-sprite-utils__.icons"),
	colors = require("__reskins-sprite-utils__.colors"),
}

local IconComposition = require("__reskins-sprite-utils__.icon-composition")

local broken_tint = util.color("#CBCBCB")
local broken_symbol = {
	icon = "__nullius__/graphics/icons/broken.png",
	icon_size = 64,
}
local repair_pack_icon = {
	icon = "__base__/graphics/icons/repair-pack.png",
	icon_size = 64,
	scale = 0.25,
	shift = { -8, 8 },
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

---@param prototype ItemPrototype
---@return IconComposition composition
local function get_icon_as_composition(prototype)
	local icon_data = _sprite_utils.icons.get_icon_from_prototype(prototype)
	local without_tier_labels, tier_labels = _framework.tiers.remove_tier_labels_from_icons(icon_data)
	local without_letters, _ = _assets.icons.remove_letters_from_icons(without_tier_labels)

	local composition = IconComposition:from_icons(without_letters)
	if tier_labels then
		composition = composition:add_label(tier_labels)
	end
	return composition
end

for name, options in pairs(broken_items) do
	local target_item = data.raw.item[name]
	local source_item = data.raw.item[options.source_item]
	if not target_item or not source_item then
		goto continue
	end

	local composition = get_icon_as_composition(source_item):blend_tint(broken_tint, 0.5):add_symbol(broken_symbol)
	local icon_assignment = {
		name = name,
		type_name = "item",
		composition = composition,
	}

	_sprite_utils.icons.apply_icon_assignment(icon_assignment)

	local recipe = data.raw.recipe[name]
	if recipe then
		_sprite_utils.icons.clear_icon_from_prototype(recipe)
		recipe.icons = composition:add_overlay(repair_pack_icon):build()
	end

	::continue::
end
