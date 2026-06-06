-- Set input parameters
local inputs = {
	type = "assembling-machine",
	icon_name = "powder-mixer",
	base_entity_name = "assembling-machine-1",
	mod = "angels",
	particles = { ["big"] = 1, ["medium"] = 2 },
	group = "smelting",
	make_remnants = false,
}

local tier_map = {
	["nullius-boxer"] = { tier = 1, prog_tier = 1 },
}

-- Reskin entities, create and assign extra details
for name, map in pairs(tier_map) do
	---@type data.AssemblingMachinePrototype
	local entity = data.raw[inputs.type][name]
	if not entity then
		goto continue
	end

	local tier = reskins.lib.tiers.get_tier(map)
	inputs.tint = map.tint or reskins.lib.tiers.get_tint(tier)

	reskins.lib.setup_standard_entity(name, tier, inputs)

	-- Reskin entities
	entity.graphics_set.animation = {
		layers = {
			-- Base
			{
				filename = "__angelssmeltinggraphics__/graphics/entity/powder-mixer/powder-mixer-base.png",
				priority = "extra-high",
				width = 138,
				height = 170,
				line_length = 4,
				frame_count = 4,
				animation_speed = 0.5,
				shift = util.by_pixel(0.5, -9.5),
				scale = 0.5,
			},
			-- Mask
			{
				filename = "__reskins-assets-angels__/graphics/entity/powder-mixer/powder-mixer-mask.png",
				priority = "extra-high",
				width = 138,
				height = 170,
				line_length = 4,
				frame_count = 4,
				animation_speed = 0.5,
				shift = util.by_pixel(0.5, -9.5),
				tint = inputs.tint,
				scale = 0.5,
			},
			-- Highlights
			{
				filename = "__reskins-assets-angels__/graphics/entity/powder-mixer/powder-mixer-highlights.png",
				priority = "extra-high",
				width = 138,
				height = 170,
				line_length = 4,
				frame_count = 4,
				animation_speed = 0.5,
				shift = util.by_pixel(0.5, -9.5),
				blend_mode = "additive-soft",
				scale = 0.5,
			},
			-- Shadow
			{
				filename = "__angelssmeltinggraphics__/graphics/entity/powder-mixer/powder-mixer-shadow.png",
				priority = "extra-high",
				width = 183,
				height = 99,
				repeat_count = 4,
				animation_speed = 0.5,
				draw_as_shadow = true,
				shift = util.by_pixel(13, 9),
				scale = 0.5,
			},
		},
	}

	::continue::
end
