local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local Applicators = require("__reskins-assets-api__.api.applicators")
local PipeValve = require("__reskins-assets-api__.assets.angels.entities.petrochem.pipe-valve")

local valves = {
	["nullius-one-way-valve"] = {
		tint = util.color("#689ed3"),
	},
}

for name, options in pairs(valves) do
	local entity = data.raw["valve"][name]
	if not entity then
		goto continue
	end

	local sprite_set = PipeValve.get_sprite_set({ tint = options.tint })
	Applicators.apply_sprite_set(entity, sprite_set)

	local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
		tier = 0,
		name = entity.name,
		type_name = entity.type,
		composition = PipeValve.get_icon_composition({ tint = options.tint }),
	})
	_sprite_utils.icons.apply_icon_assignment(icon_assignment)

	::continue::
end
