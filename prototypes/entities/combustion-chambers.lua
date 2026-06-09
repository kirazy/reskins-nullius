local _lib = require("_lib")
local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _assets = {
	defines = require("__reskins-assets-api__.api.defines"),
	icons = require("__reskins-assets-api__.api.icons"),
	create_icon = require("__reskins-assets-api__.assets.base.base-icons"),
}

local icon_helper = require("__reskins-assets-api__.api.icon-helpers")

local oil_boiler_icon = icon_helper.make_tinted_three_layer_icon_creator_fn({
	folder = "__reskins-assets-bobs__/graphics/icons",
	icon_name = "boiler-oil",
})

local BoilerGraphicsPack = require("__reskins-assets-api__.graphics-packs.base.boiler-graphics-pack")

local entities = {
	["nullius-combustion-chamber-1"] = { type = "assembling-machine", tier = 1, prog_tier = 1 },
	["nullius-combustion-chamber-2"] = { type = "assembling-machine", tier = 2, prog_tier = 2 },
	["nullius-combustion-chamber-3"] = { type = "assembling-machine", tier = 3, prog_tier = 3 },
}

for name, options in pairs(entities) do
	---@type data.AssemblingMachinePrototype
	local entity = data.raw[options.type][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	_lib.create_explosions_and_particles(name, {
		base_entity_name = "boiler",
		type = options.type,
		tint = tint,
		particles = {
			["big"] = 3,
		},
	})

	local corpse = _lib.create_remnant(name, {
		base_entity_name = "boiler",
		type = options.type,
	})

	local graphics_pack = BoilerGraphicsPack:configure({
		tint = tint,
	})

	local picture_set = graphics_pack.get_picture_set(tint)
	entity.graphics_set = {
		animation = {
			north = picture_set.north.structure,
			east = picture_set.east.structure,
			south = picture_set.south.structure,
			west = picture_set.west.structure,
		},
		working_visualisations = {
			-- Structure patch.
			{
				always_draw = true,
				east_animation = {
					filename = "__base__/graphics/entity/boiler/boiler-E-patch.png",
					width = 6,
					height = 36,
					shift = util.by_pixel(33.5, -13.5),
					scale = 0.5,
				},
				render_layer = "higher-object-under",
			},
			-- Fire
			{
				fadeout = true,
				effect = "uranium-glow",
				north_animation = picture_set.north.fire,
				east_animation = picture_set.east.fire,
				south_animation = picture_set.south.fire,
				west_animation = picture_set.west.fire,
				secondary_draw_order = 2,
			},
			-- Fire Glow
			{
				fadeout = true,
				effect = "uranium-glow",
				north_animation = picture_set.north.fire_glow,
				east_animation = picture_set.east.fire_glow,
				south_animation = picture_set.south.fire_glow,
				west_animation = picture_set.west.fire_glow,
			},
		},
	}
	graphics_pack:apply_to_corpse(corpse)

	local icon = oil_boiler_icon(tint)
	---@type DeferrableIconData
	local deferrable_icon = {
		name = name,
		type_name = options.type,
		icon_data = _framework.tiers.add_tier_labels_to_icons(tier, icon),
	}

	_assets.icons.assign_deferrable_icon(deferrable_icon)

	::continue::
end
