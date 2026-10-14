---@using data

local _lib = require("_lib")
local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local Applicators = require("__reskins-assets-api__.api.applicators")
local Pumpjack = require("__reskins-assets-api__.assets.base.entities.pumpjack")

local entities = {
	["nullius-extractor-1"] = {
		tier = 1,
		prog_tier = 2,
		base_tint = util.color("#e56d45") --[[@as Color]],
		accent_tint = util.color("#52adcc") --[[@as Color]],
	},
	["nullius-extractor-2"] = {
		tier = 2,
		prog_tier = 3,
		base_tint = util.color("#e51739") --[[@as Color]],
		accent_tint = util.color("#52ccb8") --[[@as Color]],
	},
}

for name, options in pairs(entities) do
	local entity = data.raw["mining-drill"][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	_lib.create_explosions_and_particles(entity.name, {
		base_entity_name = "pumpjack",
		type = entity.type,
		tint = tint,
		particles = {
			["small"] = 3,
		},
	})

	local corpse = _lib.create_remnant(entity.name, {
		base_entity_name = "pumpjack",
		type = entity.type,
	})

	local sprite_set = Pumpjack.get_sprite_set({
		-- tint = tint,
		base_tint = options.base_tint,
		accent_tint = tint,
	})

	Applicators.apply_sprite_set(entity, sprite_set)
	Applicators.apply_sprite_set(corpse, sprite_set)

	local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
		tier = tier,
		name = entity.name,
		type_name = entity.type,
		icon_data = Pumpjack.get_icon({ tint = tint }),
	})

	_sprite_utils.icons.apply_icon_assignment(icon_assignment)

	::continue::
end
