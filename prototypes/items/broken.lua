-- cspell: words electrolyzer

---@using data
---@using Reskins.SpriteUtils

local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = {
	icons = require("__reskins-sprite-utils__.icons"),
	colors = require("__reskins-sprite-utils__.colors"),
}

local broken_tint = util.color("#CBCBCB") --[[@as Color]]
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

---@param icon_datum IconData
---@param tint Color
---@param weight? float
local function apply_blended_tint(icon_datum, tint, weight)
	-- Skip empty layers.
	if icon_datum.icon:find("empty.png") then
		return
	end

	local base_tint = icon_datum.tint
	if not base_tint then
		-- Apply new tint directly.
		icon_datum.tint = tint
	elseif not _sprite_utils.colors.are_equal(base_tint, { 1, 1, 1, 0 }) then
		-- Blend non-highlights layers.
		icon_datum.tint = _sprite_utils.colors.blend(base_tint, tint, weight) --[[@as Color]]
	end
end

local function blend_in_color(icon_data, tint, weight, defaults_type)
	local icon_data_copy, labels = _framework.tiers.remove_tier_labels_from_icons(icon_data)
	for _, icon_layer in pairs(icon_data_copy) do
		apply_blended_tint(icon_layer, tint, weight)
	end

	return labels and _sprite_utils.icons.compose_icons(defaults_type, icon_data_copy, labels) or icon_data_copy
end

for name, options in pairs(broken_items) do
	local target_item = data.raw.item[name]
	local source_item = data.raw.item[options.source_item]
	if not target_item or not source_item then
		goto continue
	end

	local source_icon = _sprite_utils.icons.get_icon_from_prototype(source_item)
	local broken_icon =
		_sprite_utils.icons.compose_icons("item", blend_in_color(source_icon, broken_tint, 0.5, "item"), broken_symbol)

	---@type IconDataAssignment
	local icon_assignment = {
		name = name,
		type_name = "item",
		icon_data = broken_icon,
	}

	_sprite_utils.icons.apply_icon_assignment(icon_assignment)

	local recipe = data.raw.recipe[name]
	if recipe then
		_sprite_utils.icons.clear_icon_from_prototype(recipe)
		recipe.icons = _sprite_utils.icons.compose_icons("item", broken_icon, repair_pack_icon)
	end

	::continue::
end
