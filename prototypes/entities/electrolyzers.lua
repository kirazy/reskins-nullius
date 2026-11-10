---@using data

-- cspell: words electrolyzer electrolyzers

local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local Applicators = require("__reskins-assets-api__.api.applicators")
local Electrolyser = require("__reskins-assets-api__.assets.angels.entities.petrochem.electrolyser")

local entities = {
	["nullius-priority-electrolyzer-1"] = { tier = 1, prog_tier = 1 },
	["nullius-priority-electrolyzer-2"] = { tier = 2, prog_tier = 2 },
	["nullius-priority-electrolyzer-3"] = { tier = 3, prog_tier = 3 },
	["nullius-surge-electrolyzer-1"] = { tier = 1, prog_tier = 1 },
	["nullius-surge-electrolyzer-2"] = { tier = 2, prog_tier = 2 },
	["nullius-surge-electrolyzer-3"] = { tier = 3, prog_tier = 3 },
}

for name, options in pairs(entities) do
	local entity = data.raw["assembling-machine"][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	local sprite_set = Electrolyser.get_sprite_set({ tint = tint })
	Applicators.apply_sprite_set(entity, sprite_set)

	local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
		tier = tier,
		name = entity.name,
		type_name = entity.type,
		composition = Electrolyser.get_icon_composition({ tint = tint }),
	})
	_sprite_utils.icons.apply_icon_assignment(icon_assignment)

	::continue::
end

-- The items place the priority electrolyzers, and have no entity of the same name.
local items = {
	["nullius-electrolyzer-1"] = { tier = 1, prog_tier = 1 },
	["nullius-electrolyzer-2"] = { tier = 2, prog_tier = 2 },
	["nullius-electrolyzer-3"] = { tier = 3, prog_tier = 3 },
}

for name, options in pairs(items) do
	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
		tier = tier,
		name = name,
		type_name = "assembling-machine",
		composition = Electrolyser.get_icon_composition({ tint = tint }),
	})
	_sprite_utils.icons.apply_icon_assignment(icon_assignment)
end
