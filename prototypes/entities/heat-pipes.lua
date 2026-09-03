---@using data

local _lib = require("_lib")
local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = {
	icons = require("__reskins-sprite-utils__.icons"),
	sprites = require("__reskins-sprite-utils__.sprites"),
}

---@class TileSpriteOptions
---@field name? string
---@field omit_number? boolean
---@field variations? integer

---@type table<string, TileSpriteOptions>
local TILE_DEFINITIONS = {
	single = { name = "straight-vertical-single", omit_number = true },
	straight_vertical = { variations = 6 },
	straight_horizontal = { variations = 6 },
	corner_right_up = { name = "corner-up-right", variations = 6 },
	corner_left_up = { name = "corner-up-left", variations = 6 },
	corner_right_down = { name = "corner-down-right", variations = 6 },
	corner_left_down = { name = "corner-down-left", variations = 6 },
	t_up = {},
	t_down = {},
	t_right = {},
	t_left = {},
	cross = { name = "t" },
	ending_up = {},
	ending_down = {},
	ending_right = {},
	ending_left = {},
}

local heated_pipes_tint = { 0.5, 0.4, 0.3, 0.5 }
local heat_glow_tint = { 1, 1, 1, 1 }

---@param layer Sprite
---@return Sprite
local function apply_heat_pipe_glow(layer)
	layer.tint = heated_pipes_tint
	local light_layer = util.copy(layer)
	light_layer.draw_as_light = true
	light_layer.tint = heat_glow_tint
	return {
		layers = {
			layer,
			light_layer,
		},
	}
end

---@param field_name string
---@param tile_options TileSpriteOptions
---@param variant_idx integer
---@return string
local function get_tile_name(field_name, tile_options, variant_idx)
	return (tile_options.name or string.gsub(field_name, "_", "-"))
		.. (tile_options.omit_number and "" or ("-" .. tostring(variant_idx)))
end

---@return ConnectableEntityGraphics
local function make_heat_glow_sprites()
	local BASE_PATH = "__base__/graphics/entity/heat-pipe/heated"
	local heat_glow_sprites = {}

	for key, t in pairs(TILE_DEFINITIONS) do
		if key == "single" then
			heat_glow_sprites[key] = util.empty_sprite()
		else
			---@type Sprite[]
			local variations = {}
			for i = 1, (t.variations or 1) do
				variations[#variations + 1] = apply_heat_pipe_glow({
					priority = "extra-high",
					filename = BASE_PATH .. "-" .. get_tile_name(key, t, i) .. ".png",
					width = 64,
					height = 64,
					scale = 0.5,
				})
			end

			heat_glow_sprites[key] = variations
		end
	end

	---@cast heat_glow_sprites ConnectableEntityGraphics
	return heat_glow_sprites
end

---@param name string
---@param fields Sprite
---@return Sprite
local function make_tile_connection_sprite_layer(name, fields)
	local BASE_PATH = "__reskins-assets-base__/graphics/entity/heat-pipe/heat-pipe"
	return util.merge({
		{
			priority = "extra-high",
			filename = BASE_PATH .. "-" .. name .. ".png",
			width = 64,
			height = 64,
			scale = 0.5,
		},
		fields,
	})
end

---@param pipe_tint Color
---@param plate_tint Color
---@return ConnectableEntityGraphics
local function make_connection_sprites(pipe_tint, plate_tint)
	local connection_sprites = {}
	for key, t in pairs(TILE_DEFINITIONS) do
		---@type Sprite[]
		local variations = {}
		for i = 1, (t.variations or 1) do
			local tile_name = get_tile_name(key, t, i)
			variations[#variations + 1] = {
				layers = {
					make_tile_connection_sprite_layer(tile_name, {}),
					make_tile_connection_sprite_layer("mask-" .. tile_name, { tint = pipe_tint }),
					make_tile_connection_sprite_layer("plate-mask-" .. tile_name, { tint = plate_tint }),
					make_tile_connection_sprite_layer("highlights-" .. tile_name, { blend_mode = "additive-soft" }),
				},
			}
		end
		connection_sprites[key] = variations
	end

	---@cast connection_sprites ConnectableEntityGraphics
	return connection_sprites
end

---@param name string
---@param fields RotatedAnimation
---@return RotatedAnimation
local function make_corpse_animation_layer(name, fields)
	return util.merge({
		{
			filename = "__reskins-assets-base__/graphics/entity/heat-pipe/remnants/" .. name .. ".png",
			width = 122,
			height = 100,
			direction_count = 2,
			shift = util.by_pixel(0.5, -1.5),
			scale = 0.5,
		},
		fields,
	})
end

---@param pipe_tint Color
---@param plate_tint Color
---@return RotatedAnimationVariations
local function make_corpse_animation(pipe_tint, plate_tint)
	return _sprite_utils.sprites.make_rotated_animation_variations_from_spritesheet(6, {
		layers = {
			make_corpse_animation_layer("heat-pipe-remnants", {}),
			make_corpse_animation_layer("heat-pipe-remnants-mask", { tint = pipe_tint }),
			make_corpse_animation_layer("heat-pipe-remnants-plate-mask", { tint = plate_tint }),
			make_corpse_animation_layer("heat-pipe-remnants-highlights", { blend_mode = "additive-soft" }),
		},
	})
end

---@param pipe_tint Color
---@param plate_tint Color
---@return IconData[]
local function heat_pipe_icon_creator_fn(pipe_tint, plate_tint)
	local BASE_PATH = "__reskins-assets-base__/graphics/icons/heat-pipe/"
	return {
		{ icon = BASE_PATH .. "heat-pipe-base.png" },
		{ icon = BASE_PATH .. "heat-pipe-mask.png", tint = pipe_tint },
		{ icon = BASE_PATH .. "heat-pipe-plate-mask.png", tint = plate_tint },
		{ icon = BASE_PATH .. "heat-pipe-highlights.png", tint = { 1, 1, 1, 0 } },
	}
end

local entities = {
	["nullius-heat-pipe-1"] = {
		tier = 1,
		prog_tier = 1,
		pipe_tint = util.color("#adbdcc") --[[@as Color]],
		plate_tint = util.color("#ebe3bc") --[[@as Color]],
	},
	["nullius-heat-pipe-2"] = {
		tier = 2,
		prog_tier = 2,
		pipe_tint = util.color("#6b7a99") --[[@as Color]],
		plate_tint = util.color("#995a54") --[[@as Color]],
	},
	["nullius-heat-pipe-3"] = {
		tier = 3,
		prog_tier = 3,
		pipe_tint = util.color("#626366") --[[@as Color]],
		plate_tint = util.color("#575c66") --[[@as Color]],
	},
}

local inputs = {
	type = "heat-pipe",
	base_entity_name = "heat-pipe",
}

for name, options in pairs(entities) do
	local entity = data.raw["heat-pipe"][name]
	if not entity then
		goto continue
	end

	-- Create particles and explosions
	_lib.create_explosion(name, {
		type = "heat-pipe",
		base_entity_name = "heat-pipe",
	})

	_lib.create_particle(name, "heat-pipe", _lib.particle_index["small"], 1, options.pipe_tint)
	_lib.create_particle(name, "heat-pipe", _lib.particle_index["medium"], 2, options.plate_tint)

	-- Create and skin remnants
	local corpse = _lib.create_remnant(name, inputs)
	corpse.animation = make_corpse_animation(options.pipe_tint, options.plate_tint)

	-- Reskin entities
	entity.connection_sprites = make_connection_sprites(options.pipe_tint, options.plate_tint)
	entity.heat_glow_sprites = make_heat_glow_sprites()

	local deferrable_icon = _framework.tiers.deferrable_icon_with_tier_labels({
		tier = _framework.tiers.get_tier(options),
		name = name,
		type_name = "heat-pipe",
		icon_data = heat_pipe_icon_creator_fn(options.pipe_tint, options.plate_tint),
	})

	_sprite_utils.icons.assign_deferrable_icon(deferrable_icon)

	::continue::
end
