local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _lib = require("_lib")

local tier_map = {
	["nullius-air-filter-1"] = { tier = 1 },
	["nullius-air-filter-2"] = { tier = 2 },
	["nullius-air-filter-3"] = { tier = 3 },
}

-- Reskin entities, create and assign extra details
for name, map in pairs(tier_map) do
	local tier = _framework.tiers.get_tier(map)

	---@type LibHack.SetupStandardEntityInputs
	local inputs = {
		type = "assembling-machine",
		icon_name = "air-filter",
		base_entity_name = "assembling-machine-1",
		graphics_mod = "assets-angels",
		particles = { ["big"] = 1, ["medium"] = 2 },
		make_remnants = false,
		tint = map.tint or _framework.tiers.get_tint(tier),
	}
	---@type data.AssemblingMachinePrototype
	local entity = data.raw[inputs.type][name]
	if not entity then
		goto continue
	end

	_lib.setup_standard_entity(name, tier, inputs)

	-- Reskin entities
	entity.graphics_set.animation = {
		layers = {
			-- Base
			{
				filename = "__reskins-assets-angels__/graphics/entity/air-filter/air-filter-base.png",
				priority = "extra-high",
				width = 256,
				height = 256,
				frame_count = 36,
				line_length = 6,
				shift = { 0.3, -0.3 },
				animation_speed = 0.5,
				scale = 0.6,
			},
			-- Mask
			{
				filename = "__reskins-assets-angels__/graphics/entity/air-filter/air-filter-mask.png",
				priority = "extra-high",
				width = 256,
				height = 256,
				frame_count = 36,
				line_length = 6,
				shift = { 0.3, -0.3 },
				animation_speed = 0.5,
				scale = 0.6,
				tint = inputs.tint,
			},
			-- Highlights
			{
				filename = "__reskins-assets-angels__/graphics/entity/air-filter/air-filter-highlights.png",
				priority = "extra-high",
				width = 256,
				height = 256,
				frame_count = 36,
				line_length = 6,
				shift = { 0.3, -0.3 },
				animation_speed = 0.5,
				scale = 0.6,
				blend_mode = "additive-soft",
			},
		},
	}

	::continue::
end
