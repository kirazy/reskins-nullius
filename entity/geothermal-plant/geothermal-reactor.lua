-- Set input parameters
local inputs = {
	type = "reactor",
	icon_name = "chemical-furnace",
	base_entity_name = "oil-refinery",
	mod = "angels",
	particles = { ["big-tint"] = 5, ["medium"] = 2 },
	group = "smelting",
	make_remnants = false,
}

local tier_map = {
	["nullius-geothermal-reactor-1"] = { tier = 1, prog_tier = 1 },
	["nullius-geothermal-reactor-2"] = { tier = 2, prog_tier = 2 },
	["nullius-geothermal-reactor-3"] = { tier = 3, prog_tier = 3 },
}

-- Reskin entities, create and assign extra details
for name, map in pairs(tier_map) do
	---@type data.ReactorPrototype
	local entity = data.raw[inputs.type][name]
	if not entity then
		goto continue
	end

	local tier = reskins.lib.tiers.get_tier(map)
	inputs.tint = map.tint or reskins.lib.tiers.get_tint(tier)

	reskins.lib.setup_standard_entity(name, tier, inputs)

	-- Reskin entities
	entity.working_light_picture = {
		layers = {
			-- Base
			{
				priority = "extra-high",
				width = 332,
				height = 374,
				frame_count = 36,
				stripes = {
					{
						filename = "__angelssmeltinggraphics__/graphics/entity/chemical-furnace/chemical-furnace-base_01.png",
						width_in_frames = 6,
						height_in_frames = 3,
					},
					{
						filename = "__angelssmeltinggraphics__/graphics/entity/chemical-furnace/chemical-furnace-base_02.png",
						width_in_frames = 6,
						height_in_frames = 3,
					},
				},
				animation_speed = 0.5,
				shift = util.by_pixel(-1, -11.5),
				scale = 0.5,
			},
			-- Mask
			{
				priority = "extra-high",
				width = 332,
				height = 374,
				frame_count = 36,
				stripes = {
					{
						filename = "__reskins-assets-angels__/graphics/entity/chemical-furnace/chemical-furnace-mask-1.png",
						width_in_frames = 6,
						height_in_frames = 3,
					},
					{
						filename = "__reskins-assets-angels__/graphics/entity/chemical-furnace/chemical-furnace-mask-2.png",
						width_in_frames = 6,
						height_in_frames = 3,
					},
				},
				animation_speed = 0.5,
				tint = inputs.tint,
				shift = util.by_pixel(-1, -11.5),
				scale = 0.5,
			},
			-- Highlights
			{
				priority = "extra-high",
				width = 332,
				height = 374,
				frame_count = 36,
				stripes = {
					{
						filename = "__reskins-assets-angels__/graphics/entity/chemical-furnace/chemical-furnace-highlights-1.png",
						width_in_frames = 6,
						height_in_frames = 3,
					},
					{
						filename = "__reskins-assets-angels__/graphics/entity/chemical-furnace/chemical-furnace-highlights-2.png",
						width_in_frames = 6,
						height_in_frames = 3,
					},
				},
				animation_speed = 0.5,
				blend_mode = "additive-soft",
				shift = util.by_pixel(-1, -11.5),
				scale = 0.5,
			},
			-- Shadow
			{
				priority = "extra-high",
				width = 448,
				height = 280,
				frame_count = 36,
				stripes = {
					{
						filename = "__angelssmeltinggraphics__/graphics/entity/chemical-furnace/chemical-furnace-shadow_01.png",
						width_in_frames = 4,
						height_in_frames = 7,
					},
					{
						filename = "__angelssmeltinggraphics__/graphics/entity/chemical-furnace/chemical-furnace-shadow_02.png",
						width_in_frames = 4,
						height_in_frames = 2,
					},
				},
				animation_speed = 0.5,
				draw_as_shadow = true,
				shift = util.by_pixel(28, 12.5),
				scale = 0.5,
			},
		},
	}

	::continue::
end
