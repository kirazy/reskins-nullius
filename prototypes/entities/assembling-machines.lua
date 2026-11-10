local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _assets = { icons = require("__reskins-assets-api__.api.icons") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local Applicators = require("__reskins-assets-api__.api.applicators")
local AssemblingMachine = require("__reskins-assets-api__.assets.base.entities.assembling-machine")

local small_icon_scale = 0.8
local medium_icon_scale = 0.9

local entities = {
	["nullius-small-assembler-1"] = {
		type = "assembling-machine",
		tier = 1,
		prog_tier = 1,
		machine_tier = 1, -- crafting speed: 0.5
		icon_scalar = small_icon_scale,
		letter = "S",
	},
	["nullius-small-assembler-2"] = {
		type = "assembling-machine",
		tier = 2,
		prog_tier = 2,
		machine_tier = 2, -- crafting speed: 1
		icon_scalar = small_icon_scale,
		letter = "S",
	},
	["nullius-small-assembler-3"] = {
		type = "assembling-machine",
		tier = 3,
		prog_tier = 3,
		machine_tier = 3, -- crafting speed: 2
		icon_scalar = small_icon_scale,
		letter = "S",
	},
	["nullius-medium-assembler-1"] = {
		type = "assembling-machine",
		tier = 1,
		prog_tier = 2,
		machine_tier = 2, -- crafting speed: 1
		icon_scalar = medium_icon_scale,
		letter = "M",
	},
	["nullius-medium-assembler-2"] = {
		type = "assembling-machine",
		tier = 2,
		prog_tier = 3,
		machine_tier = 3, -- crafting speed: 2
		icon_scalar = medium_icon_scale,
		letter = "M",
	},
	["nullius-medium-assembler-3"] = {
		type = "assembling-machine",
		tier = 3,
		prog_tier = 4,
		machine_tier = 5, -- crafting speed: 4
		icon_scalar = medium_icon_scale,
		letter = "M",
	},
	["nullius-large-assembler-1"] = {
		type = "assembling-machine",
		tier = 1,
		prog_tier = 4,
		machine_tier = 5, -- crafting speed: 4
		letter = "L",
	},
	["nullius-large-assembler-2"] = {
		type = "assembling-machine",
		tier = 2,
		prog_tier = 5,
		machine_tier = 6, -- crafting speed: 8
		letter = "L",
	},
}

for name, options in pairs(entities) do
	local entity = data.raw[options.type][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	local sprite_set = AssemblingMachine.get_sprite_set({
		tint = tint,
		machine_tier = options.machine_tier,
	})

	Applicators.apply_sprite_set(entity, sprite_set)

	local composition = AssemblingMachine.get_icon_composition({ machine_tier = options.machine_tier, tint = tint })
		:add_label(_assets.icons.get_letter(options.letter, tint))
	local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
		tier = tier,
		name = name,
		type_name = options.type,
		composition = options.icon_scalar and composition:minify(options.icon_scalar) or composition,
	})

	_sprite_utils.icons.apply_icon_assignment(icon_assignment)

	::continue::
end
