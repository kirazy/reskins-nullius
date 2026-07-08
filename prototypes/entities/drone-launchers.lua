local _lib = require("_lib")
local _framework = {
	tiers = require("__reskins-framework__.api.tiers"),
}

local TURRET_ENTITY_PATH = "__reskins-assets-base__/graphics/entity/turret-artillery/"
local TURRET_ICON_PATH = "__reskins-assets-base__/graphics/icons/turret-artillery/turret-artillery-icon-"
local CARRIER_ICON_PATH = "__reskins-assets-base__/graphics/icons/train-artillery-wagon/train-artillery-wagon-icon-"
local blend_mode = _lib.get_setting("reskins-lib-blend-mode") or "additive"

local do_entities = _lib.is_scope_enabled("entities")
local do_items = _lib.is_scope_enabled("items-and-fluids")

if not (do_entities or do_items) then
	return
end

local launchers = {
	["nullius-drone-launcher-1"] = { tier = 1, prog_tier = 3 },
	["nullius-drone-launcher-2"] = { tier = 2, prog_tier = 4 },
}

local carriers = {
	["nullius-drone-carrier-1"] = { tier = 1, prog_tier = 3 },
	["nullius-drone-carrier-2"] = { tier = 2, prog_tier = 4 },
}

local function make_base_picture(tint)
	return {
		layers = {
			{
				filename = TURRET_ENTITY_PATH .. "turret-artillery-base.png",
				priority = "high",
				width = 207,
				height = 199,
				shift = util.by_pixel(0, 22),
				scale = 0.5,
			},
			{
				filename = TURRET_ENTITY_PATH .. "turret-artillery-mask.png",
				priority = "high",
				width = 207,
				height = 199,
				shift = util.by_pixel(0, 22),
				tint = tint,
				scale = 0.5,
			},
			{
				filename = TURRET_ENTITY_PATH .. "turret-artillery-highlights.png",
				priority = "high",
				width = 207,
				height = 199,
				shift = util.by_pixel(0, 22),
				blend_mode = blend_mode,
				scale = 0.5,
			},
			{
				filename = "__base__/graphics/entity/artillery-turret/artillery-turret-base-shadow.png",
				priority = "high",
				width = 277,
				height = 149,
				shift = util.by_pixel(20, 38),
				draw_as_shadow = true,
				scale = 0.5,
			},
		},
	}
end

local function make_remnant_animation(tint)
	return make_rotated_animation_variations_from_sheet(1, {
		layers = {
			{
				filename = TURRET_ENTITY_PATH .. "remnants/turret-artillery-remnants-base.png",
				width = 326,
				height = 290,
				direction_count = 1,
				shift = util.by_pixel(9.5, 1.5),
				scale = 0.5,
			},
			{
				filename = TURRET_ENTITY_PATH .. "remnants/turret-artillery-remnants-mask.png",
				width = 326,
				height = 290,
				direction_count = 1,
				shift = util.by_pixel(9.5, 1.5),
				tint = tint,
				scale = 0.5,
			},
			{
				filename = TURRET_ENTITY_PATH .. "remnants/turret-artillery-remnants-highlights.png",
				width = 326,
				height = 290,
				direction_count = 1,
				shift = util.by_pixel(9.5, 1.5),
				blend_mode = blend_mode,
				scale = 0.5,
			},
		},
	})
end

local function assign_remnant(name, tint)
	local remnant_name = "ar-" .. name .. "-remnants"
	local remnant = data.raw["corpse"] and data.raw["corpse"][remnant_name]

	if not remnant then
		remnant = util.copy(data.raw["corpse"]["artillery-turret-remnants"])
		remnant.name = remnant_name
		data:extend({ remnant })
		remnant = data.raw["corpse"][remnant_name]
	end

	remnant.animation = make_remnant_animation(tint)
	return remnant.name
end

local function tint_sprite_tree(sprite, tint)
	if type(sprite) ~= "table" then
		return
	end

	if sprite.filename or sprite.filenames or sprite.stripes then
		if not sprite.draw_as_shadow then
			sprite.tint = tint
		end
	end

	for _, value in pairs(sprite) do
		tint_sprite_tree(value, tint)
	end
end

local function make_carrier_pictures(tint)
	local pictures =
		util.table.deepcopy(data.raw["artillery-wagon"]["artillery-wagon"].pictures)

	tint_sprite_tree(pictures, tint)
	return pictures
end

for name, options in pairs(launchers) do
	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)
	local icon = _lib.add_tier_labels_to_icons(
		tier,
		_lib.make_layered_icon(TURRET_ICON_PATH, tint, nil, 64, 4)
	)

	if do_items then
		_lib.assign_icons_to_prototype("item", name, icon)
		_lib.assign_icons_to_prototype("recipe", name, icon)
	end

	if do_entities then
		local entity = data.raw["artillery-turret"] and data.raw["artillery-turret"][name]

		if entity then
			_lib.assign_icons_to_prototype("artillery-turret", name, icon)
			entity.corpse = assign_remnant(name, tint)
			entity.base_picture = make_base_picture(tint)
		end
	end
end

for name, options in pairs(carriers) do
	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)
	local icon = _lib.add_tier_labels_to_icons(
		tier,
		_lib.make_layered_icon(CARRIER_ICON_PATH, tint, nil, 64, 4)
	)

	if do_items then
		_lib.assign_icons_to_prototype("item-with-entity-data", name, icon)
		_lib.assign_icons_to_prototype("recipe", name, icon)
	end

	if do_entities then
		local entity = data.raw["artillery-wagon"] and data.raw["artillery-wagon"][name]

		if entity then
			_lib.assign_icons_to_prototype("artillery-wagon", name, icon)
			entity.color = tint
			entity.pictures = make_carrier_pictures(tint)
		end
	end
end
