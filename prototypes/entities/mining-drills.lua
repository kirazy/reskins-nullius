local _lib = require("_lib")
local _sprites = require("__reskins-sprite-utils__.sprites")
local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _assets = {
	icons = require("__reskins-assets-api__.api.icons"),
}

local do_entities =
	_lib.is_scope_enabled("entities")
local do_items =
	_lib.is_scope_enabled("items-and-fluids")

local BASE_ENTITY_PATH =
	"__reskins-assets-base__/graphics/entity/mining-drill-electric/"
local BASE_ICON_PATH =
	"__reskins-assets-base__/graphics/icons/mining-drill-electric/"
local BOBS_ENTITY_PATH =
	"__reskins-assets-bobs__/graphics/entity/mining-drill-electric/frame-blue/"
local ASSORTED_TALL_ENTITY_PATH =
	"__reskins-assets-assorted__/graphics/entity/mining-drill-electric-tall/"
local ASSORTED_TALL_FRAME_BLUE_PATH =
	ASSORTED_TALL_ENTITY_PATH .. "frame-blue/"
local ASSORTED_TALL_ICON_PATH =
	"__reskins-assets-assorted__/graphics/icons/mining-drill-electric-tall/"

local drill_animation_sequence = {
	1, 1, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
	11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
	21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
	21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
	21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
	21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
	21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
	21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
	21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
	21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
	21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
	21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
	21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
	21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
	21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
	21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
	21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
	21, 20, 19, 18, 17, 16, 15, 14, 13, 12,
	11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 1, 1,
}

local drill_animation_shadow_sequence = {
	1, 1, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
	11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
	21, 21, 21, 21, 21, 21, 21, 21, 21, 21,
	21, 21, 21, 21, 21, 21, 21, 21, 21, 21,
	21, 21, 21, 21, 21, 21, 21, 21, 21, 21,
	21, 21, 21, 21, 21, 21, 21, 21, 21, 21,
	21, 21, 21, 21, 21, 21, 21, 21, 21, 21,
	21, 21, 21, 21, 21, 21, 21, 21, 21, 21,
	21, 21, 21, 21, 21, 21, 21, 21, 21, 21,
	21, 21, 21, 21, 21, 21, 21, 21, 21, 21,
	21, 21, 21, 21, 21, 21, 21, 21, 21, 21,
	21, 21, 21, 21, 21, 21, 21, 21, 21, 21,
	21, 21, 21, 21, 21, 21, 21, 21, 21, 21,
	21, 21, 21, 21, 21, 21, 21, 21, 21, 21,
	21, 21, 21, 21, 21, 21, 21, 21, 21, 21,
	21, 21, 21, 21, 21, 21, 21, 21, 21, 21,
	21, 21, 21, 21, 21, 21, 21, 21, 21, 21,
	21, 20, 19, 18, 17, 16, 15, 14, 13, 12,
	11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 1, 1,
}

local size_map = {
	small = {
		scale_factor = 2 / 3,
		source = "nullius-small-miner-3",
	},
	medium = {
		scale_factor = 1,
		source = "nullius-medium-miner-3",
	},
	large = {
		scale_factor = 4 / 3,
		source = "nullius-large-miner-2",
		icon_path = ASSORTED_TALL_ICON_PATH,
		icon_name = "mining-drill-electric-tall",
		drill = "tall",
	},
}

local entities = {
	["nullius-small-miner-1"] = {
		type = "mining-drill",
		tier = 1,
		prog_tier = 1,
		size = "small",
		preserve_burner_sprites = true,
	},
	["nullius-small-miner-2"] = {
		type = "mining-drill",
		tier = 2,
		prog_tier = 2,
		size = "small",
	},
	["nullius-small-miner-3"] = {
		type = "mining-drill",
		tier = 3,
		prog_tier = 3,
		size = "small",
	},
	["nullius-medium-miner-1"] = {
		type = "mining-drill",
		tier = 1,
		prog_tier = 2,
		size = "medium",
		preserve_burner_sprites = true,
	},
	["nullius-medium-miner-2"] = {
		type = "mining-drill",
		tier = 2,
		prog_tier = 3,
		size = "medium",
	},
	["nullius-medium-miner-3"] = {
		type = "mining-drill",
		tier = 3,
		prog_tier = 4,
		size = "medium",
	},
	["nullius-large-miner-1"] = {
		type = "mining-drill",
		tier = 2,
		prog_tier = 4,
		size = "large",
		frame = "blue",
	},
	["nullius-large-miner-2"] = {
		type = "mining-drill",
		tier = 3,
		prog_tier = 5,
		size = "large",
		frame = "blue",
	},
}

local function make_icon(path, name, tint)
	return {
		{
			icon = path .. name .. "-icon-base.png",
			icon_size = 64,
		},
		{
			icon = path .. name .. "-icon-mask.png",
			icon_size = 64,
			tint = tint,
		},
		{
			icon = path .. name .. "-icon-highlights.png",
			icon_size = 64,
		},
	}
end

local function make_drill_layer(path, filename, width, height, shift, scale, tint)
	return {
		priority = "high",
		filename = path .. filename,
		line_length = 6,
		width = width,
		height = height,
		frame_count = 30,
		animation_speed = 0.4,
		frame_sequence = drill_animation_sequence,
		shift = shift,
		tint = tint,
		scale = scale,
	}
end

local function make_drill_shadow_layer(filename, width, height, shift, scale)
	return {
		priority = "high",
		filename = ASSORTED_TALL_ENTITY_PATH .. filename,
		line_length = 7,
		width = width,
		height = height,
		frame_count = 21,
		animation_speed = 0.4,
		frame_sequence = drill_animation_shadow_sequence,
		draw_as_shadow = true,
		shift = shift,
		scale = scale,
	}
end

local function make_highlight_layer(filename, width, height, shift, scale)
	local layer =
		make_drill_layer(BASE_ENTITY_PATH, filename, width, height, shift, scale)

	layer.blend_mode = "additive"

	return layer
end

local function make_tall_highlight_layer(filename, width, height, shift, scale)
	local layer =
		make_drill_layer(ASSORTED_TALL_ENTITY_PATH, filename, width, height, shift, scale)

	layer.blend_mode = "additive"

	return layer
end

local function replace_drill_layers(graphics_set, tint, scale_factor, drill)
	local drill_scale =
		0.5 * scale_factor
	local is_tall =
		drill == "tall"
	local drill_path =
		is_tall and ASSORTED_TALL_ENTITY_PATH or BASE_ENTITY_PATH
	local vertical_name =
		is_tall and "mining-drill-electric-tall-mask.png" or "mining-drill-electric-mask.png"
	local vertical_base =
		"mining-drill-electric-tall.png"
	local vertical_highlights =
		is_tall and "mining-drill-electric-tall-highlights.png" or "mining-drill-electric-highlights.png"
	local vertical_shadow =
		"mining-drill-electric-tall-shadow.png"
	local vertical_width =
		is_tall and 194 or 162
	local vertical_height =
		is_tall and 154 or 156
	local horizontal_name =
		is_tall and "mining-drill-electric-tall-horizontal-mask.png" or "mining-drill-electric-horizontal-mask.png"
	local horizontal_base =
		"mining-drill-electric-tall-horizontal.png"
	local horizontal_highlights =
		is_tall and "mining-drill-electric-tall-horizontal-highlights.png" or "mining-drill-electric-horizontal-highlights.png"
	local horizontal_shadow =
		"mining-drill-electric-tall-horizontal-shadow.png"
	local horizontal_width =
		is_tall and 104 or 80
	local horizontal_height =
		is_tall and 178 or 160
	local front_name =
		is_tall and "mining-drill-electric-tall-horizontal-front-mask.png" or "mining-drill-electric-horizontal-front-mask.png"
	local front_base =
		"mining-drill-electric-tall-horizontal-front.png"
	local front_highlights =
		is_tall and "mining-drill-electric-tall-horizontal-front-highlights.png" or "mining-drill-electric-horizontal-front-highlights.png"
	local front_width =
		is_tall and 54 or 66
	local front_height =
		is_tall and 136 or 154

	local north_shift =
		util.by_pixel(1 * scale_factor, -11 * scale_factor)
	local east_shift =
		util.by_pixel(2 * scale_factor, -12 * scale_factor)
	local front_shift =
		util.by_pixel(-3 * scale_factor, 3 * scale_factor)
	local north_shadow_shift =
		util.by_pixel(21 * scale_factor, 5 * scale_factor)
	local east_shadow_shift =
		util.by_pixel(48 * scale_factor, 5 * scale_factor)

	local visuals =
		graphics_set.working_visualisations

	if not visuals then
		return
	end

	if visuals[3] and visuals[3].north_animation and visuals[3].north_animation.layers then
		local base_layer =
			visuals[3].north_animation.layers[1]
		local shadow_layer =
			visuals[3].north_animation.layers[2]

		if is_tall then
			base_layer =
				make_drill_layer(
					ASSORTED_TALL_ENTITY_PATH,
					vertical_base,
					vertical_width,
					vertical_height,
					north_shift,
					drill_scale
				)
			shadow_layer =
				make_drill_shadow_layer(
					vertical_shadow,
					232,
					50,
					north_shadow_shift,
					drill_scale
				)
		end

		visuals[3].north_animation.layers = {
			base_layer,
			make_drill_layer(
				drill_path,
				vertical_name,
				vertical_width,
				vertical_height,
				north_shift,
				drill_scale,
				tint
			),
			(is_tall and make_tall_highlight_layer or make_highlight_layer)(
				vertical_highlights,
				vertical_width,
				vertical_height,
				north_shift,
				drill_scale
			),
			shadow_layer,
		}

		visuals[3].south_animation =
			visuals[3].north_animation
	end

	if visuals[3] and visuals[3].east_animation and visuals[3].east_animation.layers then
		local base_layer =
			visuals[3].east_animation.layers[1]
		local shadow_layer =
			visuals[3].east_animation.layers[2]

		if is_tall then
			base_layer =
				make_drill_layer(
					ASSORTED_TALL_ENTITY_PATH,
					horizontal_base,
					horizontal_width,
					horizontal_height,
					east_shift,
					drill_scale
				)
			shadow_layer =
				make_drill_shadow_layer(
					horizontal_shadow,
					236,
					138,
					east_shadow_shift,
					drill_scale
				)
		end

		visuals[3].east_animation.layers = {
			base_layer,
			make_drill_layer(
				drill_path,
				horizontal_name,
				horizontal_width,
				horizontal_height,
				east_shift,
				drill_scale,
				tint
			),
			(is_tall and make_tall_highlight_layer or make_highlight_layer)(
				horizontal_highlights,
				horizontal_width,
				horizontal_height,
				east_shift,
				drill_scale
			),
			shadow_layer,
		}

		visuals[3].west_animation =
			visuals[3].east_animation
	end

	if visuals[6] and visuals[6].east_animation then
		local base_layer =
			visuals[6].east_animation

		if is_tall then
			base_layer =
				make_drill_layer(
					ASSORTED_TALL_ENTITY_PATH,
					front_base,
					front_width,
					front_height,
					front_shift,
					drill_scale
				)
		end

		visuals[6].east_animation = {
			layers = {
				base_layer,
				make_drill_layer(
					drill_path,
					front_name,
					front_width,
					front_height,
					front_shift,
					drill_scale,
					tint
				),
				(is_tall and make_tall_highlight_layer or make_highlight_layer)(
					front_highlights,
					front_width,
					front_height,
					front_shift,
					drill_scale
				),
			},
		}

		visuals[6].west_animation =
			visuals[6].east_animation
	end
end

local function replace_area_frame(graphics_set, drill, scale_factor)
	local animation =
		graphics_set.animation
	local visuals =
		graphics_set.working_visualisations
	local is_tall =
		drill == "tall"
	local frame_path =
		is_tall and ASSORTED_TALL_FRAME_BLUE_PATH or BOBS_ENTITY_PATH
	local frame_prefix =
		is_tall and "mining-drill-electric-tall" or "mining-drill-electric"

	if animation and animation.north and animation.north.layers and animation.north.layers[1] then
		local layer = animation.north.layers[1]
		layer.filename = frame_path .. frame_prefix .. "-north.png"
		if is_tall then
			layer.width = 194
			layer.height = 242
		end
	end

	if animation and animation.east and animation.east.layers and animation.east.layers[1] then
		local layer = animation.east.layers[1]
		layer.filename = frame_path .. frame_prefix .. "-east.png"
		if is_tall then
			layer.width = 194
			layer.height = 94
		end
	end

	if animation and animation.west and animation.west.layers and animation.west.layers[1] then
		local layer = animation.west.layers[1]
		layer.filename = frame_path .. frame_prefix .. "-west.png"
		if is_tall then
			layer.width = 194
			layer.height = 94
		end
	end

	if is_tall and animation and animation.south and animation.south.layers and animation.south.layers[1] then
		local layer = animation.south.layers[1]
		layer.filename = frame_path .. frame_prefix .. "-south.png"
		layer.width = 194
		layer.height = 240
	end

	if not visuals or not visuals[7] then
		return
	end

	if visuals[7].east_animation then
		visuals[7].east_animation.filename =
			frame_path .. frame_prefix .. "-east-front.png"
		if is_tall then
			visuals[7].east_animation.width = 208
			visuals[7].east_animation.height = 186
			visuals[7].east_animation.shift =
				util.by_pixel(21 * scale_factor + 2, 10 * scale_factor + 1)
		end
	end

	if visuals[7].south_animation and visuals[7].south_animation.layers then
		if visuals[7].south_animation.layers[1] then
			local layer = visuals[7].south_animation.layers[1]
			layer.filename =
				frame_path .. frame_prefix .. "-south-output.png"
			if is_tall then
				layer.line_length = 5
				layer.frame_count = 5
				layer.width = 82
				layer.height = 56
			end
		end

		if visuals[7].south_animation.layers[2] then
			local layer = visuals[7].south_animation.layers[2]
			layer.filename =
				frame_path .. frame_prefix .. "-south-front.png"
			if is_tall then
				layer.width = 172
				layer.height = 42
			end
		end
	end

	if visuals[7].west_animation then
		visuals[7].west_animation.filename =
			frame_path .. frame_prefix .. "-west-front.png"
		if is_tall then
			visuals[7].west_animation.width = 210
			visuals[7].west_animation.height = 190
			visuals[7].west_animation.shift =
				util.by_pixel(-22 * scale_factor - 2, 12 * scale_factor - 3)
		end
	end
end

local function apply_graphics(entity, options, tint, source_graphics_set)
	if not source_graphics_set then
		return
	end

	local graphics_set =
		util.table.deepcopy(source_graphics_set)
	local size =
		size_map[options.size]

	replace_drill_layers(
		graphics_set,
		tint,
		size.scale_factor,
		size.drill
	)

	if options.frame == "blue" then
		replace_area_frame(graphics_set, size.drill, size.scale_factor)
	end

	entity.graphics_set = graphics_set
end

local source_graphics_sets = {}

if do_entities then
	for size_name, size in pairs(size_map) do
		local source =
			data.raw["mining-drill"]
			and data.raw["mining-drill"][size.source]

		if source and source.graphics_set then
			source_graphics_sets[size_name] =
				util.table.deepcopy(source.graphics_set)
		end
	end
end

for name, options in pairs(entities) do
	local entity =
		data.raw[options.type]
		and data.raw[options.type][name]

	if entity and not options.preserve_burner_sprites and (do_entities or do_items) then
		local size =
			size_map[options.size]

		local tier =
			_framework.tiers.get_tier(options)
		local tint =
			_framework.tiers.get_tint(tier)

		if do_entities then
			_lib.create_explosions_and_particles(name, {
				base_entity_name = "electric-mining-drill",
				type = options.type,
				tint = tint,
			})

			local corpse =
				_lib.create_remnant(name, {
					base_entity_name = "electric-mining-drill",
					type = options.type,
				})

			if size and size.scale_factor then
				_sprites.rescale_prototype(corpse, size.scale_factor)
			end

			apply_graphics(
				entity,
				options,
				tint,
				source_graphics_sets[options.size]
			)
		end

		if do_items then
			local icon_path =
				(size and size.icon_path)
				or BASE_ICON_PATH
			local icon_name =
				(size and size.icon_name)
				or "mining-drill-electric"

			local icon =
				make_icon(
					icon_path,
					icon_name,
					tint
				)

			---@type DeferrableIconData
			local deferrable_icon = {
				name = name,
				type_name = options.type,
				icon_data = _lib.add_tier_labels_to_icons(tier, icon),
			}

			_assets.icons.assign_deferrable_icon(deferrable_icon)
		end
	end
end
