local _lib = require("_lib")
local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _assets = {
	icons = require("__reskins-assets-api__.api.icons"),
}

local LAB_BASE = "__base__/graphics/entity/lab/"
local LAB_RESKINS = "__reskins-nullius__/graphics/entity/lab/"

local lab_tiers = {
	["nullius-lab-1"] = { type = "lab", tier = 1, prog_tier = 1 },
	["nullius-lab-2"] = { type = "lab", tier = 2, prog_tier = 2 },
	["nullius-lab-3"] = { type = "lab", tier = 3, prog_tier = 3 },
	["nullius-biology-lab"] = { type = "lab", tier = 4, prog_tier = 4, scale_factor = 4 / 3 },
}

local function lab_layers(tint, frame_count, line_length, repeat_count, animation_speed, scale_factor)
	local animated = frame_count > 1
	scale_factor = scale_factor or 1

	return {
		layers = {
			{
				filename = LAB_BASE .. "lab.png",
				width = 194,
				height = 174,
				frame_count = frame_count,
				line_length = line_length,
				repeat_count = repeat_count,
				animation_speed = animation_speed,
				shift = util.by_pixel(0, 1.5 * scale_factor),
				scale = 0.5 * scale_factor,
			},
			{
				filename = LAB_RESKINS .. "lab-mask.png",
				width = 194,
				height = 174,
				frame_count = frame_count,
				line_length = line_length,
				repeat_count = repeat_count,
				animation_speed = animation_speed,
				shift = util.by_pixel(0, 1.5 * scale_factor),
				tint = tint,
				scale = 0.5 * scale_factor,
			},
			{
				filename = LAB_RESKINS .. "lab-highlights.png",
				width = 194,
				height = 174,
				frame_count = frame_count,
				line_length = line_length,
				repeat_count = repeat_count,
				animation_speed = animation_speed,
				shift = util.by_pixel(0, 1.5 * scale_factor),
				blend_mode = "additive-soft",
				scale = 0.5 * scale_factor,
			},
			{
				filename = LAB_BASE .. "lab-integration.png",
				width = 242,
				height = 162,
				frame_count = 1,
				line_length = 1,
				repeat_count = animated and frame_count or nil,
				animation_speed = animation_speed,
				shift = util.by_pixel(0, 15.5 * scale_factor),
				scale = 0.5 * scale_factor,
			},
			{
				filename = LAB_BASE .. "lab-shadow.png",
				width = 242,
				height = 136,
				frame_count = 1,
				line_length = 1,
				repeat_count = animated and frame_count or nil,
				animation_speed = animation_speed,
				shift = util.by_pixel(13 * scale_factor, 11 * scale_factor),
				draw_as_shadow = true,
				scale = 0.5 * scale_factor,
			},
		},
	}
end

for name, options in pairs(lab_tiers) do
	local entity = data.raw[options.type][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)
	local animation_speed = entity.on_animation.layers[1].animation_speed or 0.25

	_lib.create_explosions_and_particles(name, {
		base_entity_name = "lab",
		type = "lab",
		tint = tint,
		particles = {
			["big"] = 1,
			["medium"] = 2,
		},
	})

	local corpse = _lib.create_remnant(name, {
		base_entity_name = "lab",
		type = "lab",
	})
	corpse.animation = make_rotated_animation_variations_from_sheet(1, {
		filename = LAB_RESKINS .. "lab-remnants.png",
		width = 266,
		height = 196,
		direction_count = 2,
		shift = util.by_pixel(4, 9.5),
		scale = 0.5,
	})

	entity.on_animation = lab_layers(tint, 33, 11, nil, animation_speed, options.scale_factor)
	entity.off_animation = lab_layers(tint, 1, 1, nil, animation_speed, options.scale_factor)

	local icon_data = util.table.deepcopy(data.raw.item[name].icons or entity.icons)

	---@type DeferrableIconData
	local deferrable_icon = {
		name = name,
		type_name = options.type,
		icon_data = _lib.add_tier_labels_to_icons(tier, icon_data),
	}

	_assets.icons.assign_deferrable_icon(deferrable_icon)

	::continue::
end
