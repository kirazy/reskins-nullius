--cspell: words minipump
---@using data

local _lib = require("_lib")
local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

if not mods["underground-pipe-pack"] then
	return
end

local arrow_tint = { 0, 0.831, 1, 0.5 }

local pump_entities = {
	["underground-mini-pump-t2"] = {
		tier = 2,
		prog_tier = 2,
	},
	["underground-mini-pump-t3"] = {
		tier = 3,
		prog_tier = 3,
	},
	["underground-mini-pump"] = {
		tier = 4,
		prog_tier = 4,
	},
}

---@param cardinal_direction "north"|"east"|"south"|"west"
---@param arrow_direction "N"|"E"|"S"|"W"
---@param frame_tint Color
local function make_underground_pump_directional_layers(cardinal_direction, arrow_direction, frame_tint)
	return {
		layers = {
			{
				filename = "__underground-pipe-pack__/graphics/entity/minipump/hr-minipump-" .. cardinal_direction .. ".png",
				priority = "extra-high",
				size = 96,
				scale = 0.5,
				line_length = 8,
				frame_count = 64,
				animation_speed = 1.0,
				shift = { 0, 0.1875 },
			},
			{
				filename = "__underground-pipe-pack__/graphics/entity/arrows/hr-ug-arrow-" .. arrow_direction .. ".png",
				priority = "extra-high",
				size = 96,
				tint = arrow_tint,
				repeat_count = 64,
				shift = { 0, 0.1875 },
				scale = 0.5,
			},
			{
				filename = "__underground-pipe-pack__/graphics/entity/underground-cap/hr-underground-metal-mask.png",
				priority = "extra-high",
				size = 96,
				---@diagnostic disable-next-line: param-type-mismatch
				tint = util.get_color_with_alpha(frame_tint, 0.4),
				repeat_count = 64,
				shift = { 0, 0.1875 },
				scale = 0.5,
			},
			{
				filename = "__underground-pipe-pack__/graphics/entity/shadows/hr-minipump-shadow.png",
				priority = "extra-high",
				size = 96,
				draw_as_shadow = true,
				repeat_count = 64,
				shift = { 0, 0.1875 },
				scale = 0.5,
			},
		},
	}
end

local function make_underground_pump_animations(frame_tint)
	return {
		north = make_underground_pump_directional_layers("north", "N", frame_tint),
		east = make_underground_pump_directional_layers("east", "E", frame_tint),
		south = make_underground_pump_directional_layers("south", "S", frame_tint),
		west = make_underground_pump_directional_layers("west", "W", frame_tint),
	}
end

local function make_underground_pump_icon(tint)
	return {
		{
			icon = "__underground-pipe-pack__/graphics/icons/underground-mini-pump.png",
			icon_size = 32,
			scale = 1,
		},
		{
			icon = "__underground-pipe-pack__/graphics/icons/hr-underground-metal-mask.png",
			icon_size = 96,
			scale = 0.5,
			---@diagnostic disable-next-line: param-type-mismatch
			tint = util.get_color_with_alpha(tint, 0.4),
			floating = true,
		},
	}
end

for name, options in pairs(pump_entities) do
	local entity = data.raw["pump"][name]
	if entity then
		local tier = _framework.tiers.get_tier(options)
		local tint = _framework.tiers.get_tint(tier)

		entity.animations = make_underground_pump_animations(tint)

		local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
			tier = tier,
			name = entity.name,
			type_name = entity.type,
			icon_data = make_underground_pump_icon(tint),
			options = {
				infer_corpse = false,
				infer_explosion = false,
				corpse_by_convention = false,
				explosion_by_convention = false,
			},
		})

		_sprite_utils.icons.apply_icon_assignment(icon_assignment)
	end
end
