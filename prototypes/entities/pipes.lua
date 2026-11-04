local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _assets = { defines = require("__reskins-assets-api__.api.defines") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local Applicators = require("__reskins-assets-api__.api.applicators")
local Pipe = require("__reskins-assets-api__.assets.base.entities.pipe")
local PipeToGround = require("__reskins-assets-api__.assets.base.entities.pipe-to-ground")

local pipe_entities = {
	["pipe"] = {
		tier = 1,
		prog_tier = 1,
		pipe_material = _assets.defines.pipe_material.iron,
	},
	["nullius-pipe-2"] = {
		tier = 2,
		prog_tier = 2,
		pipe_material = _assets.defines.pipe_material.aluminum,
	},
	["nullius-pipe-3"] = {
		tier = 3,
		prog_tier = 3,
		pipe_material = _assets.defines.pipe_material.plastic,
	},
	["nullius-pipe-4"] = {
		tier = 4,
		prog_tier = 4,
		pipe_material = _assets.defines.pipe_material.nitinol,
	},
}

for name, options in pairs(pipe_entities) do
	local entity = data.raw["pipe"][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)

	local sprite_set = Pipe.get_sprite_set({ pipe_material = options.pipe_material })

	Applicators.apply_sprite_set(entity, sprite_set)

	local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
		tier = tier,
		name = name,
		type_name = "pipe",
		icon_data = Pipe.get_icon({ material = options.pipe_material }),
	})
	_sprite_utils.icons.apply_icon_assignment(icon_assignment)

	::continue::
end

local pipe_to_ground_entities = {
	["pipe-to-ground"] = {
		tier = 1,
		prog_tier = 1,
		pipe_material = _assets.defines.pipe_material.iron,
	},
	["nullius-underground-pipe-2"] = {
		tier = 2,
		prog_tier = 2,
		pipe_material = _assets.defines.pipe_material.aluminum,
	},
	["nullius-underground-pipe-3"] = {
		tier = 3,
		prog_tier = 3,
		pipe_material = _assets.defines.pipe_material.plastic,
	},
	["nullius-underground-pipe-4"] = {
		tier = 4,
		prog_tier = 4,
		pipe_material = _assets.defines.pipe_material.nitinol,
	},
}

for name, options in pairs(pipe_to_ground_entities) do
	local entity = data.raw["pipe-to-ground"][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)

	local sprite_set = PipeToGround.get_sprite_set({ pipe_material = options.pipe_material })

	Applicators.apply_sprite_set(entity, sprite_set)

	local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
		tier = tier,
		name = name,
		type_name = "pipe-to-ground",
		icon_data = PipeToGround.get_icon({ material = options.pipe_material }),
	})

	_sprite_utils.icons.apply_icon_assignment(icon_assignment)

	::continue::
end
