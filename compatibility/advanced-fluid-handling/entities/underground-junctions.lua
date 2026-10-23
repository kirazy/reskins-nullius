---@using data
---@using Reskins.Assets
---@using Reskins.SpriteUtils
---@using Reskins.Framework

local _lib = require("_lib")
local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _assets = {
	defines = require("__reskins-assets-api__.api.defines"),
	icons = require("__reskins-assets-api__.api.icons"),
}
local _sprite_utils = {
	icons = require("__reskins-sprite-utils__.icons"),
	colors = require("__reskins-sprite-utils__.colors"),
}

local _V = require("visualizations")

if not mods["underground-pipe-pack"] then
	return
end

local visualization_offsets = _V.visualization_offsets()

local pipe_to_ground_entities = {
	-- 1-1
	["underground-i"] = {
		symbol = "underground-straight-junction",
		type = "pipe-to-ground",
		offsets = visualization_offsets.straight_vertical,
		picture_variants = {
			north = "NS",
			east = "EW",
			south = "NS",
			west = "EW",
		},
	},
	["underground-L"] = {
		symbol = "underground-elbow-junction",
		type = "pipe-to-ground",
		offsets = {
			north = visualization_offsets.corner.south,
			east = visualization_offsets.corner.west,
			south = visualization_offsets.corner.north,
			west = visualization_offsets.corner.east,
		},
		picture_variants = {
			north = "ES",
			south = "NW",
			east = "SW",
			west = "NE",
		},
	},
	["underground-t"] = {
		symbol = "underground-three-way-junction",
		type = "pipe-to-ground",
		offsets = {
			north = visualization_offsets.t.south,
			east = visualization_offsets.t.west,
			south = visualization_offsets.t.north,
			west = visualization_offsets.t.east,
		},
		picture_variants = {
			north = "ESW",
			east = "NSW",
			south = "NEW",
			west = "NES",
		},
	},
	["underground-cross"] = {
		symbol = "underground-four-way-junction",
		type = "pipe-to-ground",
		offsets = visualization_offsets.cross,
		picture_variants = {
			north = "NESW",
			south = "NESW",
			west = "NESW",
			east = "NESW",
		},
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
		icon = "__reskins-assets-assorted__/graphics/icons/underground-junction/"
			.. pipe_material
			.. "-underground-junction.png",
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

local function make_underground_junction_directional_layers(variant, tint)
	return {
		layers = {
			{
				filename = "__underground-pipe-pack__/graphics/entity/underground-cap/hr-ug-" .. variant .. ".png",
				priority = "extra-high",
				size = 96,
				shift = { 0, 0.1875 },
				scale = 0.5,
			},
			{
				filename = "__underground-pipe-pack__/graphics/entity/arrows/hr-ug-arrow-" .. variant .. ".png",
				priority = "extra-high",
				size = 96,
				tint = tint,
				shift = { 0, 0.1875 },
				scale = 0.5,
			},
			{
				filename = "__underground-pipe-pack__/graphics/entity/underground-cap/hr-underground-metal-mask.png",
				priority = "extra-high",
				size = 96,
				tint = util.get_color_with_alpha(tint, 0.4),
				shift = { 0, 0.1875 },
				scale = 0.5,
			},
			{
				filename = "__underground-pipe-pack__/graphics/entity/shadows/hr-minipump-shadow.png",
				priority = "extra-high",
				size = 96,
				draw_as_shadow = true,
				shift = { 0, 0.1875 },
				scale = 0.5,
			},
		},
	}
end

local function make_underground_junction_pictures(picture_variants, tint)
	return {
		north = make_underground_junction_directional_layers(picture_variants.north, tint),
		east = make_underground_junction_directional_layers(picture_variants.east, tint),
		south = make_underground_junction_directional_layers(picture_variants.south, tint),
		west = make_underground_junction_directional_layers(picture_variants.west, tint),
	}
end

for suffix, tier_options in pairs(tier_suffixes) do
	local reference_name = "nullius-" .. tier_options.reference_entity
	local reference_entity, tier = resolve_reference_parameters(reference_name, "pipe")
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

		local tint = _framework.tiers.get_tint(tier)
		entity.pictures = make_underground_junction_pictures(options.picture_variants, tint)
		entity.visualization = {
			north = {
				layers = {
					_V.arrow_visualization_layer(options.offsets.north),
					_V.pipe_to_ground_visualization_layer(0),
				},
			},
			east = {
				layers = {
					_V.arrow_visualization_layer(options.offsets.east),
					_V.pipe_to_ground_visualization_layer(0),
				},
			},
			south = {
				layers = {
					_V.arrow_visualization_layer(options.offsets.south),
					_V.pipe_to_ground_visualization_layer(0),
				},
			},
			west = {
				layers = {
					_V.arrow_visualization_layer(options.offsets.west),
					_V.pipe_to_ground_visualization_layer(0),
				},
			},
		}
		entity.disabled_visualization = {
			north = {
				layers = {
					_V.arrow_visualization_layer(options.offsets.north),
					_V.pipe_to_ground_disabled_visualization_layer(0),
				},
			},
			east = {
				layers = {
					_V.arrow_visualization_layer(options.offsets.east),
					_V.pipe_to_ground_disabled_visualization_layer(0),
				},
			},
			south = {
				layers = {
					_V.arrow_visualization_layer(options.offsets.south),
					_V.pipe_to_ground_disabled_visualization_layer(0),
				},
			},
			west = {
				layers = {
					_V.arrow_visualization_layer(options.offsets.west),
					_V.pipe_to_ground_disabled_visualization_layer(0),
				},
			},
		}

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
