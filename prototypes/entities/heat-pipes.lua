local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local Applicators = require("__reskins-assets-api__.api.applicators")
local HeatPipe = require("__reskins-assets-api__.assets.base.entities.heat-pipe")

local entities = {
	["nullius-heat-pipe-1"] = {
		tier = 1,
		prog_tier = 1,
		pipe_tint = util.color("#adbdcc"),
		plate_tint = util.color("#ebe3bc"),
	},
	["nullius-heat-pipe-2"] = {
		tier = 2,
		prog_tier = 2,
		pipe_tint = util.color("#6b7a99"),
		plate_tint = util.color("#995a54"),
	},
	["nullius-heat-pipe-3"] = {
		tier = 3,
		prog_tier = 3,
		pipe_tint = util.color("#626366"),
		plate_tint = util.color("#575c66"),
	},
}

for name, options in pairs(entities) do
	local entity = data.raw["heat-pipe"][name]
	if not entity then
		goto continue
	end

	local sprite_set = HeatPipe.get_sprite_set({ tint = options.pipe_tint, plate_tint = options.plate_tint })
	Applicators.apply_sprite_set(entity, sprite_set)

	local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
		tier = _framework.tiers.get_tier(options),
		name = name,
		type_name = "heat-pipe",
		composition = HeatPipe.get_tinted_icon_composition({ tint = options.pipe_tint, plate_tint = options.plate_tint }),
	})

	_sprite_utils.icons.apply_icon_assignment(icon_assignment)

	::continue::
end
