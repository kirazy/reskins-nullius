---@param tint data.Color
---@return table animation # [Types/Animation4Way](https://wiki.factorio.com/Types/Animation4Way)
local function entity_animation(tint)
    return {
        north = {
            layers = {
                {
                    filename = "__base__/graphics/entity/steam-engine/steam-engine-V.png",
                    width = 225,
                    height = 391,
                    shift = util.by_pixel(4.75, -6.25),
                    scale = 0.475,
                },
                {
                    filename = "__reskins-assets-base__/graphics/entity/steam-engine/steam-engine-vertical-mask.png",
                    width = 225,
                    height = 391,
                    shift = util.by_pixel(4.75, -6.25),
                    tint = tint,
                    scale = 0.475,
                },
                {
                    filename = "__reskins-assets-base__/graphics/entity/steam-engine/steam-engine-vertical-highlights.png",
                    width = 225,
                    height = 391,
                    shift = util.by_pixel(4.75, -6.25),
                    "additive-soft",
                    scale = 0.475,
                },
            },
        },
        east = {
            layers = {
                {
                    filename = "__base__/graphics/entity/steam-engine/steam-engine-H.png",
                    width = 352,
                    height = 257,
                    shift = util.by_pixel(1, -4.75),
                    scale = 0.475,
                },
                {
                    filename = "__reskins-assets-base__/graphics/entity/steam-engine/steam-engine-horizontal-mask.png",
                    width = 352,
                    height = 257,
                    shift = util.by_pixel(1, -4.75),
                    tint = tint,
                    scale = 0.475,
                },
                {
                    filename = "__reskins-assets-base__/graphics/entity/steam-engine/steam-engine-horizontal-highlights.png",
                    width = 352,
                    height = 257,
                    shift = util.by_pixel(1, -4.75),
                    "additive-soft",
                    scale = 0.475,
                },
            },
        },
        south = {
            layers = {
                {
                    filename = "__base__/graphics/entity/steam-engine/steam-engine-V.png",
                    width = 225,
                    height = 391,
                    shift = util.by_pixel(4.75, -6.25),
                    scale = 0.475,
                },
                {
                    filename = "__reskins-assets-base__/graphics/entity/steam-engine/steam-engine-vertical-mask.png",
                    width = 225,
                    height = 391,
                    shift = util.by_pixel(4.75, -6.25),
                    tint = tint,
                    scale = 0.475,
                },
                {
                    filename = "__reskins-assets-base__/graphics/entity/steam-engine/steam-engine-vertical-highlights.png",
                    width = 225,
                    height = 391,
                    shift = util.by_pixel(4.75, -6.25),
                    "additive-soft",
                    scale = 0.475,
                },
            },
        },
        west = {
            layers = {
                {
                    filename = "__base__/graphics/entity/steam-engine/steam-engine-H.png",
                    width = 352,
                    height = 257,
                    shift = util.by_pixel(1, -4.75),
                    scale = 0.475,
                },
                {
                    filename = "__reskins-assets-base__/graphics/entity/steam-engine/steam-engine-horizontal-mask.png",
                    width = 352,
                    height = 257,
                    shift = util.by_pixel(1, -4.75),
                    tint = tint,
                    scale = 0.475,
                },
                {
                    filename = "__reskins-assets-base__/graphics/entity/steam-engine/steam-engine-horizontal-highlights.png",
                    width = 352,
                    height = 257,
                    shift = util.by_pixel(1, -4.75),
                    "additive-soft",
                    scale = 0.475,
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
                filename = "__base__/graphics/entity/steam-engine/remnants/steam-engine-remnants.png",
                line_length = 1,
                width = 462,
                height = 386,
                direction_count = 4,
                shift = util.by_pixel(17, 6.5),
                scale = 0.5
			},
			-- Mask
			{
				filename = "__reskins-assets-base__/graphics/entity/steam-engine/remnants/steam-engine-remnants-mask.png",
                line_length = 1,
                width = 462,
                height = 386,
                direction_count = 4,
                shift = util.by_pixel(17, 6.5),
				tint = tint,
				scale = 0.5,
			},
			-- Highlights
			{
				filename = "__reskins-assets-base__/graphics/entity/steam-engine/remnants/steam-engine-remnants-highlights.png",
                line_length = 1,
                width = 462,
                height = 386,
                direction_count = 4,
                shift = util.by_pixel(17, 6.5),
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
		type = "electric-energy-interface",
		icon_name = "steam-engine",
        icon_filename = "__base__/graphics/icons/steam-engine.png",
		base_entity_name = "steam-engine",
		mod = "lib",
		group = "base",
		particles = { ["big"] = 2, ["medium"] = 1 },
		tier_labels = make_tier_labels,
		tint = tint and tint or reskins.lib.tiers.get_tint(tier),
	}

	---@type data.ElectricEnergyInterface
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
	entity.pictures = entity_animation(inputs.tint)
end