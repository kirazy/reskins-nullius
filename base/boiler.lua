---@param tint data.Color
---@return table animation # [Types/Animation4Way](https://wiki.factorio.com/Types/Animation4Way)
local function entity_animation(tint)
	return {
		north = {
			layers = {
				{
					filename = "__base__/graphics/entity/boiler/boiler-N-idle.png",
					priority = "extra-high",
					width = 269,
					height = 221,
					shift = util.by_pixel(-1.25, 5.25),
					frame_count = 1,
					scale = 0.5,
				},
				{
					filename = "__reskins-assets-base__/graphics/entity/boiler/boiler-north-idle-mask.png",
					priority = "extra-high",
					width = 269,
					height = 221,
					shift = util.by_pixel(-1.25, 5.25),
					tint = tint,
					frame_count = 1,
					scale = 0.5,
				},
				{
					filename = "__reskins-assets-base__/graphics/entity/boiler/boiler-north-idle-highlights.png",
					priority = "extra-high",
					width = 269,
					height = 221,
					shift = util.by_pixel(-1.25, 5.25),
					blend_mode = "additive-soft",
					frame_count = 1,
					scale = 0.5,
				},
				{
					filename = "__base__/graphics/entity/boiler/boiler-N-shadow.png",
					priority = "extra-high",
					width = 274,
					height = 164,
					scale = 0.5,
					shift = util.by_pixel(20.5, 9),
					frame_count = 1,
					draw_as_shadow = true,
				},
			},
		},
		east = {
			layers = {
				{
					filename = "__base__/graphics/entity/boiler/boiler-E-idle.png",
					priority = "extra-high",
					width = 216,
					height = 301,
					shift = util.by_pixel(-3, 1.25),
					frame_count = 1,
					scale = 0.5,
				},
				{
					filename = "__reskins-assets-base__/graphics/entity/boiler/boiler-east-idle-mask.png",
					priority = "extra-high",
					width = 216,
					height = 301,
					shift = util.by_pixel(-3, 1.25),
					tint = tint,
					frame_count = 1,
					scale = 0.5,
				},
				{
					filename = "__reskins-assets-base__/graphics/entity/boiler/boiler-east-idle-highlights.png",
					priority = "extra-high",
					width = 216,
					height = 301,
					shift = util.by_pixel(-3, 1.25),
					blend_mode = "additive-soft",
					frame_count = 1,
					scale = 0.5,
				},
				{
					filename = "__base__/graphics/entity/boiler/boiler-E-shadow.png",
					priority = "extra-high",
					width = 184,
					height = 194,
					scale = 0.5,
					shift = util.by_pixel(30, 9.5),
					frame_count = 1,
					draw_as_shadow = true,
				},
			},
		},
		south = {
			layers = {
				{
					filename = "__base__/graphics/entity/boiler/boiler-S-idle.png",
					priority = "extra-high",
					width = 260,
					height = 192,
					shift = util.by_pixel(4, 13),
					frame_count = 1,
					scale = 0.5,
				},
				{
					filename = "__reskins-assets-base__/graphics/entity/boiler/boiler-south-idle-mask.png",
					priority = "extra-high",
					width = 260,
					height = 192,
					shift = util.by_pixel(4, 13),
					tint = tint,
					frame_count = 1,
					scale = 0.5,
				},
				{
					filename = "__reskins-assets-base__/graphics/entity/boiler/boiler-south-idle-highlights.png",
					priority = "extra-high",
					width = 260,
					height = 192,
					shift = util.by_pixel(4, 13),
					blend_mode = "additive-soft",
					frame_count = 1,
					scale = 0.5,
				},
				{
					filename = "__base__/graphics/entity/boiler/boiler-S-shadow.png",
					priority = "extra-high",
					width = 311,
					height = 131,
					scale = 0.5,
					shift = util.by_pixel(29.75, 15.75),
					frame_count = 1,
					draw_as_shadow = true,
				},
			},
		},
		west = {
			layers = {
				{
					filename = "__base__/graphics/entity/boiler/boiler-W-idle.png",
					priority = "extra-high",
					width = 196,
					height = 273,
					shift = util.by_pixel(1.5, 7.75),
					frame_count = 1,
					scale = 0.5,
				},
				{
					filename = "__reskins-assets-base__/graphics/entity/boiler/boiler-west-idle-mask.png",
					priority = "extra-high",
					width = 196,
					height = 273,
					shift = util.by_pixel(1.5, 7.75),
					tint = tint,
					frame_count = 1,
					scale = 0.5,
				},
				{
					filename = "__reskins-assets-base__/graphics/entity/boiler/boiler-west-idle-highlights.png",
					priority = "extra-high",
					width = 196,
					height = 273,
					shift = util.by_pixel(1.5, 7.75),
					blend_mode = "additive-soft",
					frame_count = 1,
					scale = 0.5,
				},
				{
					filename = "__base__/graphics/entity/boiler/boiler-W-shadow.png",
					priority = "extra-high",
					width = 206,
					height = 218,
					scale = 0.5,
					shift = util.by_pixel(19.5, 6.5),
					frame_count = 1,
					draw_as_shadow = true,
				},
			},
		},
	}
end

---@param tint data.Color
---@return data.RotatedAnimationVariations
local function corpse_animation(tint)
	---@type data.RotatedAnimation
	local animation = {
		layers = {
			-- Base
			{
				filename = "__base__/graphics/entity/boiler/remnants/boiler-remnants.png",
				line_length = 1,
				width = 274,
				height = 220,
				direction_count = 4,
				shift = util.by_pixel(-0.5, -3),
				scale = 0.5,
			},
			-- Mask
			{
				filename = "__reskins-assets-base__/graphics/entity/boiler/remnants/boiler-remnants-mask.png",
				line_length = 1,
				width = 274,
				height = 220,
				direction_count = 4,
				shift = util.by_pixel(-0.5, -3),
				tint = tint,
				scale = 0.5,
			},
			-- Highlights
			{
				filename = "__reskins-assets-base__/graphics/entity/boiler/remnants/boiler-remnants-highlights.png",
				line_length = 1,
				width = 274,
				height = 220,
				direction_count = 4,
				shift = util.by_pixel(-0.5, -3),
				blend_mode = "additive-soft",
				scale = 0.5,
			},
		},
	}

	return make_rotated_animation_variations_from_sheet(1, animation)
end

---@param name string # [Prototype name](https://wiki.factorio.com/PrototypeBase#name)
---@param tier integer # 1-6 are supported, 0 to disable
---@param tint? data.Color
---@param make_tier_labels? boolean
return function(name, tier, tint, make_tier_labels)
	---@type SetupStandardEntityInputs
	local inputs = {
		type = "assembling-machine",
		icon_name = "boiler",
		icon_filename = "__base__/graphics/icons/boiler.png",
		base_entity_name = "boiler",
		mod = "lib",
		group = "base",
		particles = { ["big"] = 2, ["medium"] = 1 },
		tier_labels = make_tier_labels,
		tint = tint and tint or reskins.lib.tiers.get_tint(tier),
	}

	---@type data.AssemblingMachinePrototype
	local entity = data.raw[inputs.type][name]
	if not entity then
		return
	end

	reskins.lib.setup_standard_entity(name, tier, inputs)

	-- Fetch corpse
	local corpse = data.raw["corpse"][name .. "-remnants"]

	-- Reskin corpse
	corpse.animation = corpse_animation(inputs.tint)

	-- Reskin entity
	entity.graphics_set.animation = entity_animation(inputs.tint)
	-- entity.graphics_set.working_visualisations = working_visualizations(inputs.tint)
end
