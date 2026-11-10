---@using data
---@using Reskins.Assets
---@using Reskins.Assets.Applicators

local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _assets = { defines = require("__reskins-assets-api__.api.defines") }
local _sprite_utils = {
	icons = require("__reskins-sprite-utils__.icons"),
	sprites = require("__reskins-sprite-utils__.sprites"),
}

local Applicators = require("__reskins-assets-api__.api.applicators")
local OffshorePump = require("__reskins-assets-api__.assets.base.entities.offshore-pump")

---The direction from the center of a seawater intake to its fluid output, for each direction of the intake.
---@type table<"north"|"east"|"south"|"west", Vector>
local output_directions = {
	north = { 0, 1 },
	east = { -1, 0 },
	south = { 0, -1 },
	west = { 1, 0 },
}

---Gets a copy of the given `sprite` with its shift, or the shift of each layer, moved by the given `offset`.
---@generic T : Sprite|Animation
---@param sprite T
---@param offset Vector
---@return T
local function get_moved_sprite(sprite, offset)
	local moved = util.copy(sprite)

	for _, layer in pairs(moved.layers or { moved }) do
		layer.shift = util.add_shift(layer.shift or { 0, 0 }, offset)
	end

	return moved
end

---The directions of a seawater intake, in the order of the variations in a water reflection with
---`orientation_to_variation`.
local variation_directions = { "north", "east", "south", "west" }

---Gets a copy of the given `water_reflection` with each variation of its sheet as a picture of its own, moved toward
---the fluid output of the intake by the given `offset` divided by the given `scale_factor`.
---
---Applying the sprite set multiplies each shift by `scale_factor`, which moves each picture `offset` tiles toward the
---fluid output.
---@param water_reflection WaterReflectionDefinition
---@param scale_factor double
---@param offset double
---@return WaterReflectionDefinition
local function get_moved_water_reflection(water_reflection, scale_factor, offset)
	local sheet = water_reflection.pictures --[[@as SpriteSheet]]
	local line_length = (sheet.line_length or sheet.variation_count) --[[@as integer]]
	local width = sheet.width --[[@as integer]]
	local height = sheet.height --[[@as integer]]

	---@type Sprite[]
	local pictures = {}

	for index, direction in pairs(variation_directions) do
		local shift = util.mul_shift(output_directions[direction], offset / scale_factor) --[[@as Vector]]

		pictures[index] = {
			filename = sheet.filename --[[@as FileName]],
			priority = sheet.priority,
			x = ((index - 1) % line_length) * width,
			y = math.floor((index - 1) / line_length) * height,
			width = width,
			height = height,
			shift = util.add_shift(sheet.shift or { 0, 0 }, shift),
			scale = sheet.scale,
		}
	end

	return {
		pictures = pictures,
		rotate = water_reflection.rotate,
		orientation_to_variation = water_reflection.orientation_to_variation,
	}
end

---Gets the converter from the offshore pump sprite set to the crafting machine sprite set of a seawater intake, which
---draws the offshore pump moved by the given `offset` toward the fluid output of the intake.
---
---The underwater pictures are the faded underwater pictures of the offshore pump, resized by the given `scale_factor`
---and drawn at half opacity above the water. The legs, the glass, and the fluid are drawn as working visualisations at
---the render layers of the offshore pump, and the fluid uses the primary tint of the recipe.
---@param scale_factor double The factor by which the sprite set is resized when it is applied.
---@param offset double The distance in tiles from the center of the intake to the center of the offshore pump.
---@return SpriteSetTransformer<OffshorePumpSpriteSet, CraftingMachineSpriteSet>
local function get_crafting_machine_converter(scale_factor, offset)
	return function(sprite_set)
		local graphics_set = sprite_set.graphics_set
		local faded_underwater_pictures =
			_sprite_utils.sprites.get_rescaled_prototype(OffshorePump.get_faded_underwater_pictures(), scale_factor)

		local animation = {}

		---@type WorkingVisualisation
		local underwater = { always_draw = true, render_layer = "decorative" }
		---@type WorkingVisualisation
		local legs = { always_draw = true, render_layer = "ground-patch" }
		---@type WorkingVisualisation
		local glass = { always_draw = true, render_layer = "object", secondary_draw_order = 40 }
		---@type WorkingVisualisation
		local fluid = {
			always_draw = true,
			render_layer = "object",
			secondary_draw_order = 20,
			apply_recipe_tint = "primary",
		}

		for direction, output_direction in pairs(output_directions) do
			local shift = util.mul_shift(output_direction, offset) --[[@as Vector]]
			local field = direction .. "_animation"

			local underwater_picture = get_moved_sprite(faded_underwater_pictures[direction] --[[@as Sprite]], shift)
			underwater_picture.tint = { 1, 1, 1, 0.5 }

			animation[direction] = get_moved_sprite(graphics_set.animation[direction], shift)
			underwater[field] = underwater_picture
			legs[field] = get_moved_sprite(graphics_set.base_pictures[direction], shift)
			glass[field] = get_moved_sprite(graphics_set.glass_pictures[direction], shift)
			fluid[field] = get_moved_sprite(graphics_set.fluid_animation[direction], shift)
		end

		-- The seawater intakes have no circuit connection.
		---@type CraftingMachineSpriteSet
		local crafting_machine_sprite_set = {
			graphics_set = {
				animation = animation,
				working_visualisations = { underwater, legs, glass, fluid },
			},
			fluid_boxes = sprite_set.fluid_boxes,
			heat_buffers = sprite_set.heat_buffers,
			pipe_material = sprite_set.pipe_material,
			light_flicker = sprite_set.light_flicker,
			integration_patch = sprite_set.integration_patch,
			integration_patch_render_layer = sprite_set.integration_patch_render_layer,
			dying_explosion = sprite_set.dying_explosion,
			corpse = sprite_set.corpse,
			water_reflection = sprite_set.water_reflection,
			drawing_box_vertical_extension = sprite_set.drawing_box_vertical_extension,
			nominal_width = sprite_set.nominal_width,
			nominal_height = sprite_set.nominal_height,
		}

		return crafting_machine_sprite_set
	end
end

-- Each seawater intake draws the offshore pump at `scale_factor` times its size, moved `offset` tiles from the center
-- of the intake toward its fluid output.
local entities = {
	["nullius-seawater-intake-1"] = {
		tier = 1,
		prog_tier = 1,
		icon_scale_factor = 0.8,
		scale_factor = 0.9,
		offset = 1.055,
	},
	["nullius-seawater-intake-2"] = {
		tier = 2,
		prog_tier = 2,
		scale_factor = 1.2,
		offset = 0.9,
	},
}

for name, options in pairs(entities) do
	local entity = data.raw["assembling-machine"][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	local sprite_set = OffshorePump.get_sprite_set({ tint = tint })

	-- `apply_sprite_set` applies the water reflection from this sprite set and ignores the water reflection that the
	-- converter returns, so the water reflection is moved here.
	sprite_set.set.water_reflection = get_moved_water_reflection(
		sprite_set.set.water_reflection --[[@as WaterReflectionDefinition]],
		options.scale_factor,
		options.offset
	)

	sprite_set.converters = {
		[_assets.defines.sprite_set_type.crafting_machine_sprite_set] = get_crafting_machine_converter(
			options.scale_factor,
			options.offset
		),
	}

	Applicators.apply_sprite_set(entity, sprite_set, { scale_factor = options.scale_factor })

	local composition = OffshorePump.get_icon_composition({ tint = tint })
	local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
		tier = tier,
		name = name,
		type_name = entity.type,
		composition = options.icon_scale_factor and composition:minify(options.icon_scale_factor) or composition,
	})

	_sprite_utils.icons.apply_icon_assignment(icon_assignment)

	::continue::
end
