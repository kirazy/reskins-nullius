local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _lib = require("_lib")
local _sprite_utils = { sprites = require("__reskins-sprite-utils__.sprites") }

local tier_map = {
	["nullius-hydro-plant-1"] = { tier = 1 },
	["nullius-hydro-plant-2"] = { tier = 2 },
	["nullius-hydro-plant-3"] = { tier = 3 },
}

-- Reskin entities, create and assign extra details
for name, map in pairs(tier_map) do
	local tier = _framework.tiers.get_tier(map)

	---@type LibHack.SetupStandardEntityInputs
	local inputs = {
		type = "assembling-machine",
		icon_name = "hydro-plant",
		base_entity_name = "assembling-machine-1",
		graphics_mod = "assets-angels",
		particles = { ["big"] = 1, ["medium"] = 2 },
		make_remnants = false,
		tint = _framework.tiers.get_tint(tier),
	}

	---@type data.AssemblingMachinePrototype
	local entity = data.raw[inputs.type][name]
	if not entity then
		goto continue
	end

	_lib.setup_standard_entity(name, tier, inputs)

	-- Reskin entities
	entity.graphics_set = entity.graphics_set or {}
	entity.graphics_set.animation = {
		layers = {
			-- Base
			_sprite_utils.sprites.get_rescaled_prototype({
				filename = "__angelsrefininggraphics__/graphics/entity/hydro-plant/hydro-plant-base.png",
				priority = "extra-high",
				width = 459,
				height = 491,
				shift = util.by_pixel(0, 0),
				scale = 0.5,
			}, 0.725),
			-- Mask
			_sprite_utils.sprites.get_rescaled_prototype({
				filename = "__reskins-assets-angels__/graphics/entity/hydro-plant/hydro-plant-mask.png",
				priority = "extra-high",
				width = 459,
				height = 491,
				shift = util.by_pixel(0, 0),
				tint = inputs.tint,
				scale = 0.5,
			}, 0.725),
			-- Highlights
			_sprite_utils.sprites.get_rescaled_prototype({
				filename = "__reskins-assets-angels__/graphics/entity/hydro-plant/hydro-plant-highlights.png",
				priority = "extra-high",
				width = 459,
				height = 491,
				shift = util.by_pixel(0, 0),
				blend_mode = "additive-soft",
				scale = 0.5,
			}, 0.725),
		},
	}

	::continue::
end
