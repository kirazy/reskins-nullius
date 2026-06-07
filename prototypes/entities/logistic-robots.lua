local _lib = require("_lib")
local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _assets = {
	defines = require("__reskins-assets-api__.api.defines"),
	icons = require("__reskins-assets-api__.api.icons"),
	create_icon = require("__reskins-assets-api__.assets.base.base-icons"),
}

local RobotLogisticGraphicsPack = require("__reskins-assets-api__.graphics-packs.base.robot-logistic-graphics-pack")

local entities = {
	["nullius-logistic-bot-1"] = { type = "logistic-robot", tier = 1, prog_tier = 1 },
	["nullius-logistic-bot-2"] = { type = "logistic-robot", tier = 2, prog_tier = 2 },
	["nullius-logistic-bot-3"] = { type = "logistic-robot", tier = 3, prog_tier = 3 },
	["nullius-logistic-bot-4"] = { type = "logistic-robot", tier = 4, prog_tier = 4 },
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

	local graphics_pack = RobotLogisticGraphicsPack:configure({
		tint = tint,
	})

	graphics_pack:apply_to_entity(entity)
	graphics_pack:apply_to_corpse(corpse)

	_lib.configure_robot_death_animation(entity, corpse.name)

	local icon = _assets.create_icon.robot_logistic(tint)
	---@type DeferrableIconData
	local deferrable_icon = {
		name = name,
		type_name = options.type,
		icon_data = _framework.tiers.add_tier_labels_to_icons(tier, icon),
	}

	_assets.icons.assign_deferrable_icon(deferrable_icon)

	::continue::
end
