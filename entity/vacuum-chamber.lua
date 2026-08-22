local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _lib = require("_lib")

local tier_map = {
	["nullius-vacuum-chamber-1"] = { tier = 1 },
	["nullius-vacuum-chamber-2"] = { tier = 2 },
	["nullius-vacuum-chamber-3"] = { tier = 3 },
}

-- Reskin entities, create and assign extra details
for name, map in pairs(tier_map) do
	local tier = _framework.tiers.get_tier(map)

	---@type LibHack.SetupStandardEntityInputs
	local inputs = {
		type = "assembling-machine",
		icon_name = "liquefier",
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
			{
				-- cspell: disable-next-line
				filename = "__angelsrefininggraphics__/graphics/entity/liquifier/liquifier.png",
				priority = "extra-high",
				width = 160,
				height = 160,
				frame_count = 30,
				line_length = 10,
				shift = { 0, 0 },
				animation_speed = 0.5,
			},
			-- Mask
			{
				filename = "__reskins-assets-angels__/graphics/entity/liquefier/liquefier-mask.png",
				priority = "extra-high",
				width = 160,
				height = 160,
				repeat_count = 30,
				shift = { 0, 0 },
				animation_speed = 0.5,
				tint = inputs.tint,
			},
			-- Highlights
			{
				filename = "__reskins-assets-angels__/graphics/entity/liquefier/liquefier-highlights.png",
				priority = "extra-high",
				width = 160,
				height = 160,
				repeat_count = 30,
				shift = { 0, 0 },
				animation_speed = 0.5,
				blend_mode = "additive-soft",
			},
		},
	}

	for _, fluid_box in pairs(entity.fluid_boxes or {}) do
		fluid_box.pipe_picture = nil
	end

	::continue::
end
