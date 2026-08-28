local _lib = require("_lib")
local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local Applicators = require("__reskins-assets-api__.api.applicators")
local LogisticRobot = require("__reskins-assets-api__.assets.base.entities.robot-logistic")

local entities = {
	["nullius-logistic-bot-1"] = { type = "logistic-robot", tier = 1, prog_tier = 2 },
	["nullius-logistic-bot-2"] = { type = "logistic-robot", tier = 2, prog_tier = 3 },
	["nullius-logistic-bot-3"] = { type = "logistic-robot", tier = 3, prog_tier = 4 },
	["nullius-logistic-bot-4"] = { type = "logistic-robot", tier = 4, prog_tier = 5 },
}

for name, options in pairs(entities) do
	local entity = data.raw[options.type][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	_lib.create_explosions_and_particles(name, {
		base_entity_name = "logistic-robot",
		type = "logistic-robot",
		tint = tint,
		particles = {
			["medium"] = 2,
		},
	})

	local corpse = _lib.create_remnant(name, {
		base_entity_name = "logistic-robot",
		type = "logistic-robot",
	})

	local sprite_set = LogisticRobot.get_sprite_set({ tint = tint })

	Applicators.apply_sprite_set(entity, sprite_set)
	Applicators.apply_sprite_set(corpse, sprite_set)

	_lib.configure_robot_death_animation(entity, corpse.name)

	local deferrable_icon = _framework.tiers.deferrable_icon_with_tier_labels({
		tier = tier,
		name = name,
		type_name = options.type,
		icon_data = LogisticRobot.get_icon(tint),
	})

	_sprite_utils.icons.assign_deferrable_icon(deferrable_icon)

	::continue::
end
