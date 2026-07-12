local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _lib = require("_lib")

local tier_map = {
	["nullius-foundry-1"] = { tier = 1 },
	["nullius-foundry-2"] = { tier = 2 },
	["nullius-foundry-3"] = { tier = 3 },
}

---@param is_flipped boolean?
---@return data.WorkingVisualisation
local function get_color_mask_working_visualisation(is_flipped, tint)
	local flipped = is_flipped == true and "-flipped" or ""

	local working_vis = {
		always_draw = true,
		animation = {
			layers = {
				util.sprite_load(
					"__reskins-assets-angels__/graphics/entity/casting-machine/casting-machine" .. flipped .. "-mask",
					{
						priority = "high",
						frame_count = 49,
						animation_speed = 0.5,
						tint = tint,
						scale = 0.5,
					}
				),
				util.sprite_load(
					"__reskins-assets-angels__/graphics/entity/casting-machine/casting-machine" .. flipped .. "-highlights",
					{
						priority = "high",
						frame_count = 49,
						animation_speed = 0.5,
						blend_mode = "additive-soft",
						scale = 0.5,
					}
				),
			},
		},
	}

	return working_vis
end

-- Reskin entities, create and assign extra details
for name, map in pairs(tier_map) do
	local tier = _framework.tiers.get_tier(map)

	---@type LibHack.SetupStandardEntityInputs
	local inputs = {
		type = "assembling-machine",
		icon_name = "casting-machine",
		base_entity_name = "chemical-plant",
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

	entity.graphics_set.animation.layers[1].tint = nil
	entity.graphics_set_flipped.animation.layers[1].tint = nil

	if entity.graphics_set and entity.graphics_set.working_visualisations then
		local working_vis = get_color_mask_working_visualisation(false, inputs.tint)
		table.insert(entity.graphics_set.working_visualisations, working_vis)
	end

	if entity.graphics_set_flipped and entity.graphics_set_flipped.working_visualisations then
		local flipped_working_vis = get_color_mask_working_visualisation(true, inputs.tint)
		table.insert(entity.graphics_set_flipped.working_visualisations, flipped_working_vis)
	end

	::continue::
end
