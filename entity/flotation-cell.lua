local Framework = { tiers = require("__reskins-framework__.api.tiers") }
local _lib = require("_lib")
local _sprites = require("__reskins-sprite-utils__.sprites")

local tier_map = {
	["nullius-flotation-cell-1"] = { tier = 1, prog_tier = 1 },
	["nullius-flotation-cell-2"] = { tier = 2, prog_tier = 2 },
	["nullius-flotation-cell-3"] = { tier = 3, prog_tier = 3 },
}

-- Reskin entities, create and assign extra details.
for name, map in pairs(tier_map) do
	local tier = Framework.tiers.get_tier(map)

	---@type LibHack.SetupStandardEntityInputs
	local inputs = {
		type = "assembling-machine",
		icon_name = "ore-flotation-cell",
		base_entity_name = "assembling-machine-1",
		graphics_mod = "assets-angels",
		particles = { ["big"] = 1, ["medium"] = 2 },
		make_remnants = false,
		tint = Framework.tiers.get_tint(tier),
	}

	---@type data.AssemblingMachinePrototype
	local entity = data.raw[inputs.type][name]
	if not entity then
		goto continue
	end

	_lib.setup_standard_entity(name, tier, inputs)

	entity.graphics_set = entity.graphics_set or {}
	if
		entity.graphics_set.animation
		and entity.graphics_set.animation.layers
		and entity.graphics_set.animation.layers[1]
	then
		entity.graphics_set.animation.layers[1].tint = nil
	end

	entity.graphics_set.working_visualisations = {
		_sprites.get_rescaled_prototype({
			always_draw = true,
			animation = {
				filename = "__angelsrefininggraphics__/graphics/entity/ore-floatation-cell/ore-flotation-cell-animation-idle.png",
				priority = "extra-high",
				width = 166,
				height = 117,
				frame_count = 32,
				line_length = 8,
				shift = util.by_pixel_hr(62, 5),
				scale = 0.5,
			},
		}, 0.81),

		_sprites.get_rescaled_prototype({
			fadeout = true,
			animation = {
				filename = "__angelsrefininggraphics__/graphics/entity/ore-floatation-cell/ore-flotation-cell-animation-base.png",
				priority = "extra-high",
				width = 166,
				height = 117,
				frame_count = 64,
				line_length = 8,
				shift = util.by_pixel_hr(62, 5),
				scale = 0.5,
			},
		}, 0.81),

		_sprites.get_rescaled_prototype({
			fadeout = true,
			apply_recipe_tint = "primary",
			animation = {
				filename = "__angelsrefininggraphics__/graphics/entity/ore-floatation-cell/ore-flotation-cell-animation-water-tintable.png",
				priority = "extra-high",
				width = 166,
				height = 117,
				frame_count = 64,
				line_length = 8,
				shift = util.by_pixel_hr(62, 5),
				scale = 0.5,
			},
		}, 0.81),

		_sprites.get_rescaled_prototype({
			fadeout = true,
			apply_recipe_tint = "secondary",
			animation = {
				filename = "__angelsrefininggraphics__/graphics/entity/ore-floatation-cell/ore-flotation-cell-animation-froth-tintable.png",
				priority = "extra-high",
				width = 166,
				height = 117,
				frame_count = 64,
				line_length = 8,
				shift = util.by_pixel_hr(62, 5),
				scale = 0.5,
			},
		}, 0.81),

		{
			always_draw = true,
			animation = {
				layers = {
					_sprites.get_rescaled_prototype({
						filename = "__reskins-assets-angels__/graphics/entity/ore-flotation-cell/ore-flotation-cell-mask.png",
						priority = "extra-high",
						width = 333,
						height = 363,
						shift = util.by_pixel_hr(-1, -1),
						tint = inputs.tint,
						scale = 0.5,
					}, 0.81),
					_sprites.get_rescaled_prototype({
						filename = "__reskins-assets-angels__/graphics/entity/ore-flotation-cell/ore-flotation-cell-highlights.png",
						priority = "extra-high",
						width = 333,
						height = 363,
						shift = util.by_pixel_hr(-1, -1),
						blend_mode = "additive-soft",
						scale = 0.5,
					}, 0.81),
				},
			},
		},
	}

	-- Maybe fix animation speed shenanigans?
	entity.match_animation_speed_to_activity = false

	::continue::
end
