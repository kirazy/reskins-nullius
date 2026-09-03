local _lib = require("_lib")
local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _assets = { defines = require("__reskins-assets-api__.api.defines") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local Applicators = require("__reskins-assets-api__.api.applicators")
local Pipe = require("__reskins-assets-api__.assets.base.entities.pipe")
local PipeToGround = require("__reskins-assets-api__.assets.base.entities.pipe-to-ground")

local pipe_material_tints = {
	[_assets.defines.pipe_material.aluminum] = util.color("#ffffff"),
	[_assets.defines.pipe_material.copper] = util.color("#d45539"),
	[_assets.defines.pipe_material.stone] = util.color("#cfcfcf"),
	[_assets.defines.pipe_material.bronze] = util.color("#b09954"),
	[_assets.defines.pipe_material.steel] = util.color("#877c76"),
	[_assets.defines.pipe_material.plastic] = util.color("#0078ff"),
	[_assets.defines.pipe_material.brass] = util.color("#f9c854"),
	[_assets.defines.pipe_material.titanium] = util.color("#adadb2"),
	[_assets.defines.pipe_material.ceramic] = util.color("#8f7967"),
	[_assets.defines.pipe_material.tungsten] = util.color("#3b3b3b"),
	[_assets.defines.pipe_material.nitinol] = util.color("#706f6b"),
	[_assets.defines.pipe_material.copper_tungsten] = util.color("#99593d"),
	[_assets.defines.pipe_material.titanium_angels] = util.color("#995f92"),
	[_assets.defines.pipe_material.ceramic_angels] = util.color("#ffffff"),
	[_assets.defines.pipe_material.tungsten_angels] = util.color("#7e5f45"),
	[_assets.defines.pipe_material.nitinol_angels] = util.color("#7664a9"),
}

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
		pipe_material = _assets.defines.pipe_material.tungsten,
	},
}

for name, options in pairs(pipe_entities) do
	local entity = data.raw["pipe"][name]
	if not entity then
		goto continue
	end

	_lib.create_explosions_and_particles(name, {
		base_entity_name = "pipe",
		type = "pipe",
		tint = pipe_material_tints[options.pipe_material],
		particles = {
			["medium"] = 1,
			["small"] = 2,
		},
	})

	local corpse = _lib.create_remnant(name, {
		base_entity_name = "pipe",
		type = "pipe",
	})

	local tier = _framework.tiers.get_tier(options)

	local sprite_set = Pipe.get_sprite_set({ pipe_material = options.pipe_material })

	Applicators.apply_sprite_set(entity, sprite_set)
	Applicators.apply_sprite_set(corpse, sprite_set)

	local deferrable_icon = _framework.tiers.deferrable_icon_with_tier_labels({
		tier = tier,
		name = name,
		type_name = "pipe",
		icon_data = Pipe.get_icon({ material = options.pipe_material }),
	})
	_sprite_utils.icons.assign_deferrable_icon(deferrable_icon)

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

	_lib.create_explosions_and_particles(name, {
		base_entity_name = "pipe-to-ground",
		type = "pipe-to-ground",
		tint = pipe_material_tints[options.pipe_material],
		particles = {
			["medium"] = 1,
			["small"] = 2,
		},
	})

	local corpse = _lib.create_remnant(name, {
		base_entity_name = "pipe-to-ground",
		type = "pipe-to-ground",
	})

	local tier = _framework.tiers.get_tier(options)

	local sprite_set = PipeToGround.get_sprite_set({ pipe_material = options.pipe_material })

	Applicators.apply_sprite_set(entity, sprite_set)
	Applicators.apply_sprite_set(corpse, sprite_set)

	local deferrable_icon = _framework.tiers.deferrable_icon_with_tier_labels({
		tier = tier,
		name = name,
		type_name = "pipe-to-ground",
		icon_data = PipeToGround.get_icon({ material = options.pipe_material }),
	})

	_sprite_utils.icons.assign_deferrable_icon(deferrable_icon)

	::continue::
end
