---@using data
---@using Reskins.Assets
---@using Reskins.SpriteUtils
---@using Reskins.Framework

if not mods["underground-pipe-pack"] then
	return
end

local _lib = require("_lib")
local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _assets = {
	defines = require("__reskins-assets-api__.api.defines"),
	icons = require("__reskins-assets-api__.api.icons"),
}
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local _V = require("visualizations")

local Applicators = require("__reskins-assets-api__.api.applicators")
local Pipe = require("__reskins-assets-api__.assets.base.entities.pipe")
local PipeToGround = require("__reskins-assets-api__.assets.base.entities.pipe-to-ground")

local visualization_offsets = _V.visualization_offsets()

local pipe_to_ground_entities = {
	-- 1-1
	["one-to-one-forward"] = {
		symbol = "surface-junction-1-to-1",
		type = "pipe-to-ground",
		offsets = {
			north = visualization_offsets.single.south,
			east = visualization_offsets.single.west,
			south = visualization_offsets.single.north,
			west = visualization_offsets.single.east,
		},
	},
	["one-to-one-right"] = {
		symbol = "surface-junction-1-to-1",
		type = "pipe-to-ground",
		offsets = {
			north = visualization_offsets.single.west,
			east = visualization_offsets.single.north,
			south = visualization_offsets.single.east,
			west = visualization_offsets.single.south,
		},
	},
	["one-to-one-reverse"] = {
		symbol = "surface-junction-1-to-1",
		type = "pipe-to-ground",
		offsets = {
			north = visualization_offsets.single.north,
			east = visualization_offsets.single.east,
			south = visualization_offsets.single.south,
			west = visualization_offsets.single.west,
		},
	},
	["one-to-one-left"] = {
		symbol = "surface-junction-1-to-1",
		type = "pipe-to-ground",
		offsets = {
			north = visualization_offsets.single.east,
			east = visualization_offsets.single.south,
			south = visualization_offsets.single.west,
			west = visualization_offsets.single.north,
		},
	},

	-- 1-2
	["one-to-two-perpendicular"] = {
		symbol = "surface-junction-1-to-2",
		type = "pipe-to-ground",
		offsets = visualization_offsets.straight_horizontal,
	},
	["one-to-two-perpendicular-secondary"] = {
		symbol = "surface-junction-1-to-2",
		type = "pipe-to-ground",
		offsets = visualization_offsets.straight_horizontal,
	},
	["one-to-two-parallel"] = {
		symbol = "surface-junction-1-to-2",
		type = "pipe-to-ground",
		offsets = visualization_offsets.straight_vertical,
	},
	["one-to-two-parallel-secondary"] = {
		symbol = "surface-junction-1-to-2",
		type = "pipe-to-ground",
		offsets = visualization_offsets.straight_vertical,
	},
	["one-to-two-L-RR"] = {
		symbol = "surface-junction-1-to-2",
		type = "pipe-to-ground",
		offsets = {
			north = visualization_offsets.corner.north,
			east = visualization_offsets.corner.east,
			south = visualization_offsets.corner.south,
			west = visualization_offsets.corner.west,
		},
	},
	["one-to-two-L-RL"] = {
		symbol = "surface-junction-1-to-2",
		type = "pipe-to-ground",
		offsets = {
			north = visualization_offsets.corner.east,
			east = visualization_offsets.corner.south,
			south = visualization_offsets.corner.west,
			west = visualization_offsets.corner.north,
		},
	},
	["one-to-two-L-FL"] = {
		symbol = "surface-junction-1-to-2",
		type = "pipe-to-ground",
		offsets = {
			north = visualization_offsets.corner.south,
			east = visualization_offsets.corner.west,
			south = visualization_offsets.corner.north,
			west = visualization_offsets.corner.east,
		},
	},
	["one-to-two-L-FR"] = {
		symbol = "surface-junction-1-to-2",
		type = "pipe-to-ground",
		offsets = {
			north = visualization_offsets.corner.west,
			east = visualization_offsets.corner.north,
			south = visualization_offsets.corner.east,
			west = visualization_offsets.corner.south,
		},
	},

	-- 1-3
	["one-to-three-forward"] = {
		symbol = "surface-junction-1-to-3",
		type = "pipe-to-ground",
		offsets = {
			north = visualization_offsets.t.south,
			east = visualization_offsets.t.west,
			south = visualization_offsets.t.north,
			west = visualization_offsets.t.east,
		},
	},
	["one-to-three-right"] = {
		symbol = "surface-junction-1-to-3",
		type = "pipe-to-ground",
		offsets = {
			north = visualization_offsets.t.west,
			east = visualization_offsets.t.north,
			south = visualization_offsets.t.east,
			west = visualization_offsets.t.south,
		},
	},
	["one-to-three-reverse"] = {
		symbol = "surface-junction-1-to-3",
		type = "pipe-to-ground",
		offsets = {
			north = visualization_offsets.t.north,
			east = visualization_offsets.t.east,
			south = visualization_offsets.t.south,
			west = visualization_offsets.t.west,
		},
	},
	["one-to-three-left"] = {
		symbol = "surface-junction-1-to-3",
		type = "pipe-to-ground",
		offsets = {
			north = visualization_offsets.t.east,
			east = visualization_offsets.t.south,
			south = visualization_offsets.t.west,
			west = visualization_offsets.t.north,
		},
	},

	-- 1-4
	["one-to-four"] = {
		symbol = "surface-junction-1-to-4",
		type = "pipe-to-ground",
		offsets = visualization_offsets.cross,
	},
}

local pipe_entities = {
	-- 4-4
	["4-to-4"] = {
		symbol = "surface-junction-4-to-4",
		type = "pipe",
		offsets = visualization_offsets.cross,
	},
}

local tier_suffixes = {
	["-t2-pipe"] = {
		pipe_material = _assets.defines.pipe_material.aluminum,
		reference_entity = "pipe-2",
	},
	["-t3-pipe"] = {
		pipe_material = _assets.defines.pipe_material.plastic,
		reference_entity = "pipe-3",
	},
	["-pipe"] = {
		pipe_material = _assets.defines.pipe_material.nitinol,
		reference_entity = "pipe-4",
	},
}

---@param defaults_type IconDefaultsType
---@param symbol string
---@param pipe_material PipeMaterial
---@param tier Tier
local function create_surface_junction_icon(defaults_type, symbol, pipe_material, tier)
	local tint = _framework.tiers.get_tint(tier)
	return _sprite_utils.icons.compose_icons(defaults_type, {
		icon = "__reskins-assets-assorted__/graphics/icons/pipe-to-ground-flipped/"
			.. pipe_material
			.. "-pipe-to-ground-flipped.png",
		icon_size = 64,
		scale = 0.5,
	}, _assets.icons.get_tinted_icon("__reskins-assets-assorted__/graphics/symbols/" .. symbol .. ".png", tint))
end

---@param name string
---@param type_name "pipe"|"pipe-to-ground"
---@return (PipePrototype|PipeToGroundPrototype)?
---@return Tier?
local function resolve_reference_parameters(name, type_name)
	local entity = data.raw[type_name][name]
	if not entity then
		return
	end

	local icon = _sprite_utils.icons.get_icon_from_prototype(entity)
	local tier = _framework.tiers.get_tier_from_icons(icon)
	if tier == nil then
		return
	end

	return entity, tier
end

for suffix, tier_options in pairs(tier_suffixes) do
	local reference_name = "nullius-underground-" .. tier_options.reference_entity
	local reference_entity, tier = resolve_reference_parameters(reference_name, "pipe-to-ground")
	if not reference_entity or tier == nil then
		goto next_suffix
	end

	for prefix, options in pairs(pipe_to_ground_entities) do
		local name = prefix .. suffix
		local entity = data.raw["pipe-to-ground"][name]
		if not entity then
			goto next_prefix
		end

		entity.corpse = util.copy(reference_entity.corpse)
		entity.dying_explosion = util.copy(reference_entity.dying_explosion)

		local sprite_set = PipeToGround.get_sprite_set({ pipe_material = tier_options.pipe_material })
		Applicators.apply_sprite_set(entity, sprite_set)

		entity.pictures = _V.append_in_world_visualizations(entity.pictures, options.offsets)
		entity.visualization = _V.make_pipe_to_ground_visualization(options.offsets)
		entity.disabled_visualization = _V.make_pipe_to_ground_disabled_visualization(options.offsets)

		local icon = create_surface_junction_icon(entity.type, options.symbol, tier_options.pipe_material, tier)
		local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
			tier = tier,
			name = entity.name,
			type_name = entity.type,
			icon_data = icon,
			options = {
				infer_corpse = false,
				infer_explosion = false,
				corpse_by_convention = false,
				explosion_by_convention = false,
			},
		})

		_sprite_utils.icons.apply_icon_assignment(icon_assignment)

		::next_prefix::
	end
	::next_suffix::
end

local pipe_visualizations = {
	straight_vertical_single = {
		offset = 0,
		shift = util.by_pixel_hr(0, -22),
	},
	straight_vertical = {
		offset = 5,
		shift = util.by_pixel_hr(0, -16),
	},
	straight_vertical_window = {
		offset = 5,
		shift = util.by_pixel_hr(0, -16),
	},
	straight_horizontal_window = {
		offset = 10,
		shift = util.by_pixel_hr(0, -9),
	},
	straight_horizontal = {
		offset = 10,
		shift = util.by_pixel_hr(0, -9),
	},
	corner_up_right = {
		offset = 3,
		shift = util.by_pixel_hr(4, -16),
	},
	corner_up_left = {
		offset = 9,
		shift = util.by_pixel_hr(-4, -16),
	},
	corner_down_right = {
		offset = 6,
		shift = util.by_pixel_hr(4, -4),
	},
	corner_down_left = {
		offset = 12,
		shift = util.by_pixel_hr(-4, -4),
	},
	t_up = {
		offset = 11,
		shift = util.by_pixel_hr(0, -16),
	},
	t_down = {
		offset = 14,
		shift = util.by_pixel_hr(0, -9),
	},
	t_right = {
		offset = 7,
		shift = util.by_pixel_hr(0, -16),
	},
	t_left = {
		offset = 13,
		shift = util.by_pixel_hr(0, -16),
	},
	cross = {
		offset = 15,
		shift = util.by_pixel_hr(0, -16),
	},
	ending_up = {
		offset = 1,
		shift = util.by_pixel_hr(0, -26),
	},
	ending_down = {
		offset = 4,
		shift = util.by_pixel_hr(0, -8),
	},
	ending_right = {
		offset = 2,
		shift = util.by_pixel_hr(7, -9),
	},
	ending_left = {
		offset = 8,
		shift = util.by_pixel_hr(-7, -9),
	},
}

local function insert_pipe_visualizations(pictures, arrow_offset)
	if not pictures then
		return
	end

	for prefix, params in pairs(pipe_visualizations) do
		pictures[prefix] = _V.append_in_world_visualization_layer(pictures[prefix], arrow_offset, params.shift)
		pictures[prefix .. "_visualization"] = _V.make_pipe_visualization(params.offset, arrow_offset)
		pictures[prefix .. "_disabled_visualization"] = _V.make_pipe_disabled_visualization(params.offset, arrow_offset)
	end
end

for suffix, tier_options in pairs(tier_suffixes) do
	local reference_name = "nullius-" .. tier_options.reference_entity
	local reference_entity, tier = resolve_reference_parameters(reference_name, "pipe")
	if not reference_entity or tier == nil then
		goto next_suffix
	end

	for prefix, options in pairs(pipe_entities) do
		local name = prefix .. suffix
		local entity = data.raw["pipe"][name]
		if not entity then
			goto next_prefix
		end

		entity.corpse = util.copy(reference_entity.corpse)
		entity.dying_explosion = util.copy(reference_entity.dying_explosion)

		local sprite_set = Pipe.get_sprite_set({ pipe_material = tier_options.pipe_material })
		Applicators.apply_sprite_set(entity, sprite_set)

		local cross_offset = { x = 4, y = 2 }
		insert_pipe_visualizations(entity.pictures, cross_offset)

		local icon = create_surface_junction_icon(entity.type, options.symbol, tier_options.pipe_material, tier)
		local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
			tier = tier,
			name = entity.name,
			type_name = entity.type,
			icon_data = icon,
			options = {
				infer_corpse = false,
				infer_explosion = false,
				corpse_by_convention = false,
				explosion_by_convention = false,
			},
		})

		_sprite_utils.icons.apply_icon_assignment(icon_assignment)

		::next_prefix::
	end
	::next_suffix::
end
