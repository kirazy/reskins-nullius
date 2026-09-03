local _lib = require("_lib")
local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _assets = { applicators = require("__reskins-assets-api__.api.applicators") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local ConstructionRobot = require("__reskins-assets-api__.assets.base.entities.robot-construction")

local entities = {
	["nullius-construction-bot-1"] = { type = "construction-robot", tier = 1, prog_tier = 2 },
	["nullius-construction-bot-2"] = { type = "construction-robot", tier = 2, prog_tier = 3 },
	["nullius-construction-bot-3"] = { type = "construction-robot", tier = 3, prog_tier = 4 },
	["nullius-construction-bot-4"] = { type = "construction-robot", tier = 4, prog_tier = 5 },
}

for name, options in pairs(entities) do
	local entity = data.raw[options.type][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	_lib.create_explosions_and_particles(name, {
		base_entity_name = "construction-robot",
		type = "construction-robot",
		tint = tint,
		particles = {
			["medium"] = 2,
		},
	})

	local corpse = _lib.create_remnant(name, {
		base_entity_name = "construction-robot",
		type = "construction-robot",
	})

	local sprite_set = ConstructionRobot.get_sprite_set({ tint = tint })
	_assets.applicators.apply_sprite_set(entity, sprite_set)
	_assets.applicators.apply_sprite_set(corpse, sprite_set)

	_lib.configure_robot_death_animation(entity, corpse.name)

	local deferrable_icon = _framework.tiers.deferrable_icon_with_tier_labels({
		tier = tier,
		name = name,
		type_name = options.type,
		icon_data = ConstructionRobot.get_icon({ tint = tint }),
	})

	_sprite_utils.icons.assign_deferrable_icon(deferrable_icon)

	::continue::
end
