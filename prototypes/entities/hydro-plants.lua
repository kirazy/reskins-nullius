---@using data
---@using Reskins.Assets

local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local Applicators = require("__reskins-assets-api__.api.applicators")
local PrototypeScaler = require("__reskins-assets-api__.api.prototype-scaler")
local HydroPlant = require("__reskins-assets-api__.assets.angels.entities.refining.hydro-plant")

-- The fluid boxes of these hydro plants are placed differently from those of Angel's hydro plant. The hydro plants keep
-- their own fluid box graphics and circuit connector, and draw none of the pipes that Angel's hydro plant draws on the
-- building.
local entities = {
	["nullius-hydro-plant-1"] = { tier = 1, prog_tier = 1 },
	["nullius-hydro-plant-2"] = { tier = 2, prog_tier = 2 },
	["nullius-hydro-plant-3"] = { tier = 3, prog_tier = 3 },
}

---Indicates whether the given `working_visualisation` draws pipes.
---@param working_visualisation WorkingVisualisation
---@return boolean # `true` when a layer of `working_visualisation` draws a file with "pipe" in its name; otherwise, `false`.
local function draws_pipes(working_visualisation)
	local found = false

	local function search(value)
		if type(value) ~= "table" or found then
			return
		end

		if type(value.filename) == "string" and value.filename:find("pipe", 1, true) then
			found = true
			return
		end

		for _, child in pairs(value) do
			search(child)
		end
	end

	search(working_visualisation)

	return found
end

---Sets the animation and the working visualisations of the given `target`, in place, to copies from the given `source`
---that are rescaled by the given `scaler` and leave out the working visualisations that draw pipes.
---@param target CraftingMachineGraphicsSet
---@param source CraftingMachineGraphicsSet
---@param scaler PrototypeScaler
local function set_graphics(target, source, scaler)
	local animation = util.copy(source.animation)
	local working_visualisations = {}

	for _, working_visualisation in pairs(source.working_visualisations or {}) do
		if not draws_pipes(working_visualisation) then
			working_visualisations[#working_visualisations + 1] = util.copy(working_visualisation)
		end
	end

	scaler:rescale(animation)
	scaler:rescale(working_visualisations)

	target.animation = animation
	target.working_visualisations = working_visualisations
end

for name, options in pairs(entities) do
	local entity = data.raw["assembling-machine"][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	local sprite_set = HydroPlant.get_sprite_set({ tint = tint })

	local scaler = PrototypeScaler.for_prototype(entity, {
		nominal_width = sprite_set.set.nominal_width,
		nominal_height = sprite_set.set.nominal_height,
	})

	entity.graphics_set = entity.graphics_set or {}
	set_graphics(entity.graphics_set, sprite_set.set.graphics_set, scaler)

	if sprite_set.set.graphics_set_flipped then
		entity.graphics_set_flipped = entity.graphics_set_flipped or {}
		set_graphics(entity.graphics_set_flipped, sprite_set.set.graphics_set_flipped, scaler)
	end

	Applicators.apply_corpse_and_explosion(entity, {
		corpse = sprite_set.set.corpse,
		dying_explosion = sprite_set.set.dying_explosion,
	})

	local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
		tier = tier,
		name = entity.name,
		type_name = entity.type,
		composition = HydroPlant.get_icon_composition({ tint = tint }),
	})
	_sprite_utils.icons.apply_icon_assignment(icon_assignment)

	::continue::
end
