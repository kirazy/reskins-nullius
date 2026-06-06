-- Set input parameters
local inputs = {
	type = "assembling-machine",
	icon_name = "ore-crusher",
	base_entity_name = "assembling-machine-1",
	mod = "angels",
	particles = { ["big"] = 1, ["medium"] = 2 },
	group = "refining",
	make_remnants = false,
}

local tier_map = {
	["nullius-crusher-1"] = { tier = 1 },
	["nullius-crusher-2"] = { tier = 2 },
	["nullius-crusher-3"] = { tier = 3 },
}

-- Reskin entities, create and assign extra details
for name, map in pairs(tier_map) do
	---@type data.AssemblingMachinePrototype
	local entity = data.raw[inputs.type][name]
	if not entity then
		goto continue
	end

	local tier = reskins.lib.tiers.get_tier(map)
	inputs.defer_to_data_updates = map.defer_to_data_updates
	inputs.tint = map.tint or reskins.lib.tiers.get_tint(tier)

	reskins.lib.setup_standard_entity(name, tier, inputs)

	-- Reskin entities
	entity.graphics_set.animation = {
		layers = {
			-- Base
			{
				filename = "__angelsrefininggraphics__/graphics/entity/ore-crusher/ore-crusher-base.png",
				priority = "extra-high",
				width = 189,
				height = 214,
				frame_count = 16,
				line_length = 4,
				shift = util.by_pixel(-0.5, -5),
				animation_speed = 0.5,
				scale = 0.5,
			},
			-- Mask
			{
				filename = "__reskins-assets-angels__/graphics/entity/ore-crusher/ore-crusher-mask.png",
				priority = "extra-high",
				width = 189,
				height = 214,
				repeat_count = 16,
				shift = util.by_pixel(-0.5, -5),
				tint = inputs.tint,
				animation_speed = 0.5,
				scale = 0.5,
			},
			-- Highlights
			{
				filename = "__reskins-assets-angels__/graphics/entity/ore-crusher/ore-crusher-highlights.png",
				priority = "extra-high",
				width = 189,
				height = 214,
				repeat_count = 16,
				shift = util.by_pixel(-0.5, -5),
				blend_mode = "additive-soft",
				animation_speed = 0.5,
				scale = 0.5,
			},
			-- Shadow
			{
				filename = "__angelsrefininggraphics__/graphics/entity/ore-crusher/ore-crusher-shadow.png",
				priority = "extra-high",
				width = 282,
				height = 140,
				repeat_count = 16,
				shift = util.by_pixel(24, 17.5),
				draw_as_shadow = true,
				animation_speed = 0.5,
				scale = 0.5,
			},
		},
	}

	::continue::
end
