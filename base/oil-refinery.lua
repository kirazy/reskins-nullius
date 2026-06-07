local _sprites = require("__reskins-sprite-utils__.sprites")
local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _lib = require("_lib")

---Provides vanilla-style sprite definition for oil refinery `animation` field. See [Prototype/AssemblingMachine](https://wiki.factorio.com/Prototype/AssemblingMachine).
---@param tint data.Color
---@return data.Animation4Way
local function entity_animation(tint)
	return _sprites.make_4way_animation_from_spritesheet({
		layers = {
			-- Base
			{
				filename = "__base__/graphics/entity/oil-refinery/oil-refinery.png",
				width = 386,
				height = 430,
				shift = util.by_pixel(0, -7.5),
				scale = 0.5,
			},
			-- Mask
			{
				filename = "__reskins-assets-base__/graphics/entity/oil-refinery/oil-refinery-mask.png",
				width = 386,
				height = 430,
				shift = util.by_pixel(0, -7.5),
				tint = tint,
				scale = 0.5,
			},
			-- Highlights
			{
				filename = "__reskins-assets-base__/graphics/entity/oil-refinery/oil-refinery-highlights.png",
				width = 386,
				height = 430,
				shift = util.by_pixel(0, -7.5),
				blend_mode = "additive-soft",
				scale = 0.5,
			},
			-- Shadow
			{
				filename = "__base__/graphics/entity/oil-refinery/oil-refinery-shadow.png",
				width = 674,
				height = 426,
				shift = util.by_pixel(82.5, 26.5),
				draw_as_shadow = true,
				scale = 0.5,
			},
		},
	})
end

---Provides vanilla-style sprite definition for oil refinery corpse `animation` field. See [Prototype/Corpse](https://wiki.factorio.com/Prototype/Corpse).
---@param tint data.Color
---@return data.RotatedAnimationVariations
local function corpse_animation(tint)
	---@type data.RotatedAnimation
	local animation = {
		layers = {
			-- Base
			{
				filename = "__base__/graphics/entity/oil-refinery/remnants/refinery-remnants.png",
				width = 467,
				height = 415,
				direction_count = 1,
				shift = util.by_pixel(-0.25, -0.25), --moved from -8.5 to -4.5
				scale = 0.5,
			},
			-- Mask
			{
				filename = "__reskins-assets-base__/graphics/entity/oil-refinery/remnants/oil-refinery-remnants-mask.png",
				width = 467,
				height = 415,
				direction_count = 1,
				shift = util.by_pixel(-0.25, -0.25),
				tint = tint,
				scale = 0.5,
			},
			-- Highlights
			{
				filename = "__reskins-assets-base__/graphics/entity/oil-refinery/remnants/oil-refinery-remnants-highlights.png",
				width = 467,
				height = 415,
				direction_count = 1,
				shift = util.by_pixel(-0.25, -0.25),
				blend_mode = "additive-soft",
				scale = 0.5,
			},
		},
	}

	return _sprites.make_rotated_animation_variations_from_spritesheet(1, animation)
end

---Reskins the named assembling machine with vanilla-style oil refinery sprites and color masking, and sets up appropriate corpse, explosion, and particle prototypes
---@param name string # [Prototype name](https://wiki.factorio.com/PrototypeBase#name)
---@param tier integer # 1-6 are supported, 0 to disable
---@param tint? data.Color
---@param make_tier_labels? boolean
local function oil_refinery(name, tier, tint, make_tier_labels)
	---@type SetupStandardEntityInputs
	local inputs = {
		type = "assembling-machine",
		icon_name = "oil-refinery",
		base_entity_name = "oil-refinery",
		graphics_mod = "assets-base",
		particles = { ["big-tint"] = 5, ["medium"] = 2 },
		tier_labels = make_tier_labels,
		tint = tint and tint or _framework.tiers.get_tint(tier),
	}

	---@type data.AssemblingMachinePrototype
	local entity = data.raw[inputs.type][name]
	if not entity then
		return
	end

	_lib.setup_standard_entity(name, tier, inputs)

	-- Fetch corpse
	local corpse = data.raw["corpse"][entity.corpse]

	-- Reskin corpse
	corpse.animation = corpse_animation(inputs.tint)

	-- Reskin entity
	entity.graphics_set.animation = entity_animation(inputs.tint)
end

return oil_refinery
