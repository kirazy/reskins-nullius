-- HACK: To avoid pulling in the Artisanal Reskins: Library sprite overrides and until Artisanal
-- Reskins: Framework and Artisanal Reskins: Assets API are both ready for use.

local sprite_utils = {
	icons = require("__reskins-sprite-utils__.icons"),
	colors = require("__reskins-sprite-utils__.colors"),
	defines = require("__reskins-sprite-utils__.defines"),
	sprites = require("__reskins-sprite-utils__.sprites"),
}

local _framework = {
	tiers = require("__reskins-framework__.api.tiers"),
}

-- This is expected by the functions but AR: Nullius does not use icon deferral.
---@type Reskins.SpriteUtils.DeferredIconStore
local _deferred_icon_store = {}

---@class LibHack
local lib = {}

local asset_mod_names = {
	["assets-angels"] = { directory = "__reskins-assets-angels__" },
	["assets-base"] = { directory = "__reskins-assets-base__" },
	["assets-bobs"] = { directory = "__reskins-assets-bobs__" },
}

---------------------------------------------------------------------------------------------------
-- functions.lua
---------------------------------------------------------------------------------------------------

---@class SetupStandardEntityInputs : ParseInputsInputs, CreateExplosionsAndParticlesInputs, CreateRemnantInputs, ConstructIconInputsOld

---Most entities have a common process for reskinning, so consolidate the other functions under one super-function for
---ease of use
---@param name string # The name of the entity prototype to be reskinned.
---@param tier integer # The tier of the entity. An integer value from 0 to 6. Default `0`.
---@param inputs SetupStandardEntityInputs
function lib.setup_standard_entity(name, tier, inputs)
	-- Parse inputs
	lib.set_inputs_defaults(inputs)

	-- Create particles and explosions
	if inputs.make_explosions then
		lib.create_explosions_and_particles(name, inputs)
	end

	-- Create remnants
	if inputs.make_remnants then
		lib.create_remnant(name, inputs)
	end

	-- Create icons
	if inputs.make_icons then
		lib.construct_icon(name, tier, inputs)
	end
end

---@class ParseInputsInputs
---@field icon_size? data.SpriteSizeType # Default `64`.
---@field technology_icon_size? data.SpriteSizeType # Default `128`.
---@field make_explosions? boolean # Default `true`, creates explosions in `standard_setup_entity`.
---@field make_remnants? boolean # Default `true`, creates corpses in `standard_setup_entity`.
---@field make_icons? boolean # Default `true`, create icons in `standard_setup_entity`.
---@field tier_labels? boolean # Default `true`, displays tier labels on icons.
---@field make_icon_pictures? boolean # Default `true`, creates pictures for item-on-ground icons.

---Adds missing default values to the given `inputs` table.
---@param inputs ParseInputsInputs
---@return ParseInputsInputs inputs
function lib.set_inputs_defaults(inputs)
	inputs.icon_size = inputs.icon_size or 64
	inputs.technology_icon_size = inputs.technology_icon_size or 128
	inputs.make_explosions = (inputs.make_explosions ~= false)
	inputs.make_remnants = (inputs.make_remnants ~= false)
	inputs.make_icons = (inputs.make_icons ~= false)
	inputs.tier_labels = (inputs.tier_labels ~= false)
	inputs.make_icon_pictures = (inputs.make_icon_pictures ~= false)

	return inputs
end

---@class CreateRemnantInputs
---@field base_entity_name string # The type name of the entity to copy an existing `CorpsePrototype` from.
---@field type string # The type name of the entity to be assigned the new `CorpsePrototype`.

---@class remnant # See [Prototype/Corpse](https://wiki.factorio.com/Prototype/Corpse)

---Copies the Factorio corpse specified by `inputs.base_entity_name`, extends `data` with a new
---corpse with the name `ar-[name]-remnants`, and assigns it to the named entity
---@param name string
---@param inputs CreateRemnantInputs
---```
--- inputs = {
---     base_entity_name = string -- Name of Factorio reference entity to copy from, e.g. `stone-furnace`
---     type = string -- See https://wiki.factorio.com/Prototype_definitions
--- }
---```
---@return data.CorpsePrototype
function lib.create_remnant(name, inputs)
	---@type data.CorpsePrototype
	local remnant = util.copy(data.raw["corpse"][inputs.base_entity_name .. "-remnants"])
	remnant.name = "ar-" .. name .. "-remnants"
	data:extend({ remnant })

	-- Assign corpse to originating entity
	data.raw[inputs.type][name]["corpse"] = remnant.name

	return remnant
end

---@class CreateExplosionInputs : CreateRemnantInputs

---Copies the Factorio explosion specified by `inputs.base_entity_name`, extends `data` with a new
---explosion with the name `ar-[name]-explosion`, and assigns it to the named entity
---@param name string
---@param inputs CreateExplosionInputs
---```
--- inputs = {
---     base_entity_name = string -- Name of Factorio reference entity to copy from, e.g. `stone-furnace`
---     type = string -- See https://wiki.factorio.com/Prototype_definitions
--- }
---```
function lib.create_explosion(name, inputs)
	local explosion_copy = util.copy(data.raw["explosion"][inputs.base_entity_name .. "-explosion"])
	explosion_copy.name = "ar-" .. name .. "-explosion"
	data:extend({ explosion_copy })

	-- Assign explosion to originating entity
	data.raw[inputs.type][name]["dying_explosion"] = explosion_copy.name
end

--- @param root table The table from which to begin the search.
--- @param ... string|integer A list of keys defining the path to traverse within the root table.
--- @return any #The value at the end of the key sequence if it exists; otherwise, `nil`.
local function try_get_value(root, ...)
	for i = 1, select("#", ...) do
		if type(root) ~= "table" then
			return nil
		end
		local key = select(i, ...)
		root = root[key]
		if root == nil then
			return nil
		end
	end

	return root
end

---Gets the preferred explosion for a given `explosion`, preferring the indirect base explosion, if it exists.
---@param explosion data.ExplosionPrototype The explosion to check for a base explosion.
---@return data.ExplosionPrototype
local function get_preferred_explosion(explosion)
	-- Several entities have a redirection to a base explosion entity, so we need to check for that and use it
	-- preferentially.

	---@type data.TriggerEffect[]|nil
	local target_effects = try_get_value(explosion, "created_effect", "action_delivery", "target_effects")

	if not target_effects or #target_effects == 0 then
		return explosion
	end

	if target_effects[1].type == "create-explosion" then
		-- Copy the explosion reference and update our explosion, if it doesn't already exist, as we may visit the same
		-- explosion multiple times.
		local explosion_base_name = target_effects[1].entity_name

		local base_explosion = data.raw["explosion"][explosion_base_name]
		if base_explosion.name:find("ar-", 1, true) then
			return base_explosion
		end

		base_explosion = util.copy(data.raw["explosion"][explosion_base_name])
		base_explosion.name = "ar-" .. explosion.name .. "-base"
		data:extend({ base_explosion })

		-- Update the explosion reference name.
		target_effects[1].entity_name = base_explosion.name
		return base_explosion
	end

	return explosion
end

---A map of particle names to particle exclusions to prevent false positives.
local particle_exclusions_map = {
	["metal-particle-medium"] = {
		"long-metal-particle-medium",
	},
}

---Checks if the given `particle_name` is a match for the `base_particle_name`, excepting any exclusions.
---@param particle_name data.ParticleID The particle name to check.
---@param base_particle_name string The base particle name to check against.
---@return boolean # `true` if the particle name is a match for the base particle name, otherwise `false`.
local function is_particle_name_intended_match(particle_name, base_particle_name)
	if particle_name:find(base_particle_name, 1, true) then
		local exclusions = particle_exclusions_map[base_particle_name]
		if exclusions then
			for _, exclusion in pairs(exclusions) do
				if particle_name:find(exclusion, 1, true) then
					return false
				end
			end
		end

		return true
	end

	return false
end

---Gets the preferred particle by checking for a particle name in `particle_effects` that contains the given
---`base_particle_name`. The method will preferentially select the particle at the index matching `key`, if it exists.
---Otherwise, the method will select the first particle that matches the `base_particle_name`.
---@param particle_effects data.CreateParticleTriggerEffectItem[] The particle effects to search through.
---@param base_particle_name string The base particle name to search for.
---@param key integer The key to preferentially select, if it exists.
---@return data.CreateParticleTriggerEffectItem|nil # The preferred particle effect, or `nil` if none are found.
local function get_preferred_particle(particle_effects, base_particle_name, key)
	local preferred_particle
	local fallback_particle
	for index, effect in pairs(particle_effects) do
		if is_particle_name_intended_match(effect.particle_name, base_particle_name) then
			if index == key then
				preferred_particle = effect
				break
			elseif not fallback_particle then
				fallback_particle = effect
			end
		end
	end

	return preferred_particle or fallback_particle
end

---Links a given `explosion` to the given `particle` by checking for particle effects in the explosion's target effects
---that match the `base_particle_name`. The method will preferentially select the particle at the index matching `key`,
---if it exists. Otherwise, the method will select the first particle that matches the `base_particle_name` to establish
---the link.
---@param explosion data.ExplosionPrototype The explosion to link the particle to.
---@param particle data.ParticlePrototype The particle to link to the explosion.
---@param base_particle_name string The base particle name to search for.
---@param key integer The key to preferentially select, if it exists.
local function link_particle_to_explosion(explosion, particle, base_particle_name, key)
	local target_effects = try_get_value(explosion, "created_effect", "action_delivery", "target_effects")
	if not target_effects or #target_effects == 0 then
		return
	end

	-- Filter target_effects for all particle effects.
	local particle_effects = {}
	for _, effect in pairs(target_effects) do
		if effect.type == "create-particle" then
			table.insert(particle_effects, effect)
		end
	end

	if #particle_effects > 0 then
		local particle_effect = get_preferred_particle(particle_effects, base_particle_name, key)

		if particle_effect then
			particle_effect.particle_name = particle.name
		end
	end
end

---Copies the Factorio particle specified by `base_entity_name`, applies tints, extends `data`
---with a new particle with the name `ar-[name]-[base-particle-name]-tinted`, and links it to the named explosion
---@param name data.EntityID The name of the entity prototype for which an AR explosion exists.
---@param base_entity_name data.EntityID Name of Factorio reference entity to copy from, e.g. `stone-furnace`
---@param base_particle_name string A value from `lib.particle_index` used to find the particle to copy.
---@param key integer Index corresponding to the particle within the explosion target_effects table.
---@param tint data.Color The tint to apply to the particle.
function lib.create_particle(name, base_entity_name, base_particle_name, key, tint)
	local particle = util.copy(data.raw["optimized-particle"][base_entity_name .. "-" .. base_particle_name])

	particle.name = "ar-" .. name .. "-" .. base_particle_name .. "-tinted"
	particle.pictures.sheet.tint = tint

	data:extend({ particle })

	local explosion = data.raw["explosion"]["ar-" .. name .. "-explosion"]
	if not explosion then
		return
	else
		local preferred_explosion = get_preferred_explosion(explosion)
		link_particle_to_explosion(preferred_explosion, particle, base_particle_name, key)
	end
end

---@class CreateExplosionsAndParticlesInputs : CreateExplosionInputs
---@field particles? table # Table of keys for `_lib.particle_index` and the target index within the explosion particle table to copy
---@field tint table # [Types/Color](https://wiki.factorio.com/Types/Color)

---Batches the `create_explosion` and `create_particle` function together for ease of use
---@param name string # [Prototype name](https://wiki.factorio.com/PrototypeBase#name)
---@param inputs CreateExplosionsAndParticlesInputs @
---```
--- inputs = {
---     base_entity_name = string -- Name of Factorio reference entity to copy from, e.g. `stone-furnace`
---     type = string -- See https://wiki.factorio.com/Prototype_definitions
---     tint = table -- See https://wiki.factorio.com/Types/Color
---     particles? = {
---         [string] = integer, -- _lib.particle_index key, and associated target particle index
---         ...
---     }
--- }
---```
function lib.create_explosions_and_particles(name, inputs)
	lib.create_explosion(name, inputs)

	if inputs.particles then
		for particle, key in pairs(inputs.particles) do
			-- Create and assign the particle
			lib.create_particle(name, inputs.base_entity_name, lib.particle_index[particle], key, inputs.tint)
		end
	end
end

lib.particle_index = {
	["tiny-stone"] = "stone-particle-tiny",
	["small"] = "metal-particle-small",
	["small-stone"] = "stone-particle-small",
	["medium"] = "metal-particle-medium",
	["medium-long"] = "long-metal-particle-medium",
	["medium-stone"] = "stone-particle-medium",
	["big"] = "metal-particle-big",
	["big-stone"] = "stone-particle-big",
	["big-tint"] = "metal-particle-big-tint",
}

---------------------------------------------------------------------------------------------------
-- icon-handling.lua
---------------------------------------------------------------------------------------------------

---@class ConstructTechnologyIconInputsOld
---@field mod "assets-angels"|"assets-base"|"assets-bobs"|"assets-assorted
---@field group? string # Folder under the `graphics/technology` folder. Default `nil`.
---@field subgroup? string # Folder under the `group` folder, e.g. `group/subgroup`. Default `nil`.
---@field untinted_icon_mask? boolean # Overrides default tinting behavior; when `true`, will not apply `tint` to the mask layer.
---@field tint? data.Color # Expected if `untinted_icon_mask` is not `true`. If not provided, defaults to white ({1, 1, 1, 1}).
---@field technology_icon_filename? data.FileName # Required if `icon_name` is not defined.
---@field technology_icon_size? data.SpriteSizeType # Default `128`.
---@field icon_name? string # Required if `technology_icon_filename` is not defined. Specifies the folder/filenames to prepare the layered icon.
---@field icon_base? string # Override of `icon_name` for filename variants within the folder specified by `icon_name`, for the base layer
---@field icon_mask? string # Override of `icon_name` for filename variants within the folder specified by `icon_name`, for the mask layer
---@field icon_highlights? string # Override of `icon_name` for filename variants within the folder specified by `icon_name`, for the highlights layer
---@field technology_icon_extras? data.IconData[] # An array of `IconData` objects to append to the main icon.
---@field technology_icon_layers? 1|2|3 # Default 3 if used with `technology_icon_name`, 1 if used with `technology_icon_filename`, corresponds to the number of standard-form files to prepare
---@field defer_to_data_updates? boolean # When `true`, stores the icon for assignment at the end of data-updates. Expected if `defer_to_data_final_fixes` is not set.
---@field defer_to_data_final_fixes? boolean # When `true`, stores the icon for assignment at the end of data-final-fixes. Supersedes `defer_to_data_updates`. Expected if `defer_to_data_updates` is not set.

---@param name string # The name of the technology prototype.
---@param inputs ConstructTechnologyIconInputsOld
function lib.construct_technology_icon(name, inputs)
	---@type ConstructTechnologyIconInputsOld
	local inputs_copy = util.copy(inputs)

	--Set defaults
	inputs_copy.technology_icon_size = inputs_copy.technology_icon_size or 128

	-- Handle compatibility defaults
	local subfolder_path = ""
	if inputs_copy.group then
		subfolder_path = inputs_copy.group .. "/"
	end
	if inputs_copy.subgroup then
		subfolder_path = subfolder_path .. inputs_copy.subgroup .. "/"
	end

	-- Handle mask tinting defaults
	local icon_tint = inputs_copy.tint
	if inputs_copy.untinted_icon_mask then
		icon_tint = nil
	end

	-- Handle icon_layers defaults
	local icon_layers
	if inputs_copy.technology_icon_filename then
		icon_layers = inputs_copy.technology_icon_layers or 1
	else
		icon_layers = inputs_copy.technology_icon_layers or 3
	end

	-- Some entities have variable bases and masks
	local icon_base = inputs_copy.icon_base or inputs_copy.icon_name
	local icon_mask = inputs_copy.icon_mask or inputs_copy.icon_name
	local icon_highlights = inputs_copy.icon_highlights or inputs_copy.icon_name

	-- Setup icon layers
	---@type data.IconData
	local icon_base_layer = {
		icon = inputs_copy.technology_icon_filename
			or asset_mod_names[inputs_copy.mod].directory
				.. "/graphics/technology/"
				.. subfolder_path
				.. inputs_copy.icon_name
				.. "/"
				.. icon_base
				.. "-technology-base.png",
		icon_size = inputs_copy.technology_icon_size,
	}

	---@type data.IconData, data.IconData
	local icon_mask_layer, icon_highlights_layer
	if icon_layers > 1 then
		icon_mask_layer = {
			icon = asset_mod_names[inputs_copy.mod].directory
				.. "/graphics/technology/"
				.. subfolder_path
				.. inputs_copy.icon_name
				.. "/"
				.. icon_mask
				.. "-technology-mask.png",
			icon_size = inputs_copy.technology_icon_size,
			tint = icon_tint,
		}

		icon_highlights_layer = {
			icon = asset_mod_names[inputs_copy.mod].directory
				.. "/graphics/technology/"
				.. subfolder_path
				.. inputs_copy.icon_name
				.. "/"
				.. icon_highlights
				.. "-technology-highlights.png",
			icon_size = inputs_copy.technology_icon_size,
			tint = { 1, 1, 1, 0 },
		}
	end

	---@type data.IconData[]
	local icon_data = { icon_base_layer }

	if icon_layers > 1 then
		table.insert(icon_data, icon_mask_layer)
	end

	if icon_layers > 2 then
		table.insert(icon_data, icon_highlights_layer)
	end

	-- Append icon extras as needed
	if inputs_copy.technology_icon_extras then
		-- Append icon_extras
		for n = 1, #inputs_copy.technology_icon_extras do
			table.insert(icon_data, inputs_copy.technology_icon_extras[n])
		end
	end

	---@type DeferrableIconData
	local deferrable_icon = {
		name = name,
		type_name = "technology",
		icon_data = icon_data,
	}

	-- It may be necessary to put icons back in final fixes, allow for that
	local stage
	if inputs_copy.defer_to_data_final_fixes then
		stage = sprite_utils.defines.stage.data_final_fixes
	elseif inputs_copy.defer_to_data_updates then
		stage = sprite_utils.defines.stage.data_updates
	end

	if stage then
		sprite_utils.icons.store_icon_for_deferred_assignment_in_stage(_deferred_icon_store, stage, deferrable_icon)
	else
		sprite_utils.icons.assign_deferrable_icon(deferrable_icon)
	end
end

---@alias TechnologyConstant
---| "battery"
---| "braking-force"
---| "capacity"
---| "count"
---| "damage"
---| "follower-count"
---| "ghost"
---| "health"
---| "logistic-slot"
---| "map-zoom"
---| "mining"
---| "mining-productivity"
---| "movement-speed"
---| "range"
---| "speed"

local technology_constants = {
	["battery"] = { icon = "__core__/graphics/icons/technology/constants/constant-battery.png" },
	["braking-force"] = { icon = "__core__/graphics/icons/technology/constants/constant-braking-force.png" },
	["capacity"] = { icon = "__core__/graphics/icons/technology/constants/constant-capacity.png" },
	["count"] = { icon = "__core__/graphics/icons/technology/constants/constant-count.png" },
	["damage"] = { icon = "__core__/graphics/icons/technology/constants/constant-damage.png" },
	["follower-count"] = { icon = "__core__/graphics/icons/technology/constants/constant-follower-count.png" },
	["ghost"] = { icon = "__core__/graphics/icons/technology/constants/constant-time-to-live-ghosts.png" },
	["health"] = { icon = "__core__/graphics/icons/technology/constants/constant-health.png" },
	["logistic-slot"] = { icon = "__core__/graphics/icons/technology/constants/constant-logistic-slot.png" },
	["map-zoom"] = { icon = "__core__/graphics/icons/technology/constants/constant-map-zoom.png" },
	["mining"] = { icon = "__core__/graphics/icons/technology/constants/constant-mining.png" },
	["mining-productivity"] = { icon = "__core__/graphics/icons/technology/constants/constant-mining-productivity.png" },
	["movement-speed"] = { icon = "__core__/graphics/icons/technology/constants/constant-movement-speed.png" },
	["range"] = { icon = "__core__/graphics/icons/technology/constants/constant-range.png" },
	["speed"] = { icon = "__core__/graphics/icons/technology/constants/constant-speed.png" },
}

---@param constant TechnologyConstant
---@param scale double?
---@return data.IconData
function lib.return_technology_effect_icon(constant, scale)
	---@type data.IconData
	local icon_data = {
		icon = technology_constants[constant].icon,
		icon_size = 128,
		shift = util.mul_shift({ 100, 100 }, scale or 1),
		scale = scale,
	}

	return icon_data
end

---The common base class for all creatable icons.
---@class CreatableIconBase
---The path to the folder containing the icon files, relative to the mod's `graphics` folder.
---@field subfolder string
---The size of the square icon, in pixels, e.g. `32` for a 32px by 32px icon.
---
---Mandatory if `icon_size` is not specified outside of `icons`.
---
---[View Documentation](https://lua-api.factorio.com/latest/types/IconData.html#icon_size)
---@field icon_size data.SpriteSizeType
---
---Defaults to `32/icon_size` for items and recipes, and `256/icon_size` for technologies.
---
---Specifies the scale of the icon on the GUI scale. A scale of `2` means that the icon will be two
---times bigger on screen (and thus more pixelated).
---
---[View Documentation](https://lua-api.factorio.com/latest/types/IconData.html#scale)
---@field scale? double
---
---Used to offset the icon "layer" from the overall icon. The shift is applied from the center (so
---negative shifts are left and up, respectively). Shift values are based on final size (`icon_size
---* scale`) of the first icon.
---
---[View Documentation](https://lua-api.factorio.com/latest/types/IconData.html#shift)
---@field shift? data.Vector
---
---The tint to apply to the icon.
---
---[View Documentation](https://lua-api.factorio.com/latest/types/IconData.html#tint)
---@field tint? data.Color

---A creatable multi-layer icon that uses the standard form of a base layer, mask layer, and a
---highlights layer.
---
---The number of layers used to create the icon is determined by the `num_layers` field.
---@class TintedCreatableIcon : CreatableIconBase
---
---The prefix of the base icon file named `{icon_base}-icon-base.png`. Used in place of `mask_name`
---and `highlights_name` if neither is provided.
---@field icon_base string
---
---The prefix of the mask icon file named `{icon_mask}-icon-mask.png` Optional; uses `icon_base` if
---not provided.
---@field icon_mask? string
---
---The prefix of the highlights icon file named `{icon_highlights}-icon-highlights.png` Optional;
---uses `icon_base` if not provided.
---@field icon_highlights? string
---
---The tint to apply to the mask layer.
---@field tint data.Color
---
---The number of layers in the icon. Default `3`.
---@field num_layers? 1|2|3

---A creatable single-layer icon.
---@class FlatCreatableIcon : CreatableIconBase
---The name of the icon file named `{icon}.png`.
---@field icon string
---
---An optional tint to apply to the icon.
---@field tint? data.Color

---@class ConstructIconInputsOld
---@field type string # The type name of the prototype.
---@field graphics_mod "assets-angels"|"assets-base"|"assets-bobs"|"assets-assorted"
---@field group? string # Folder under the `graphics/icons` folder. Default `nil`.
---@field subgroup? string # Folder under the `group` folder, e.g. `group/subgroup`. Default `nil`.
---@field untinted_icon_mask? boolean # Overrides default tinting behavior; when `true`, will not apply `tint` to the mask layer.
---@field tint? data.Color # Expected if `untinted_icon_mask` is not `true`. If not provided, defaults to white ({1, 1, 1, 1}).
---@field tier_labels? boolean # Default `true`, displays tier labels on icons.
---@field icon_filename? data.FileName # Required if `icon_name` is not defined.
---@field icon_size? data.SpriteSizeType # Default `64`.
---@field icon_name? string # Required if `icon_filename` is not defined. Specifies the folder/filenames to prepare the layered icon.
---@field icon_base? string # Override of `icon_name` for filename variants within the folder specified by `icon_name`, for the base layer
---@field icon_mask? string # Override of `icon_name` for filename variants within the folder specified by `icon_name`, for the mask layer
---@field icon_highlights? string # Override of `icon_name` for filename variants within the folder specified by `icon_name`, for the highlights layer
---@field icon_extras? data.IconData[] # An array of `IconData` objects to append to the main icon.
---@field icon_picture_extras? data.SpriteVariations[] # An array of `SpriteVariations` objects to append to the main sprite for the item-on-ground.
---@field icon_layers? 1|2|3 # Default 3 if used with `icon_name`, 1 if used with `icon_filename`, corresponds to the number of standard-form files to prepare
---@field defer_to_data_updates? boolean # When `true`, stores the icon for assignment at the end of data-updates. Expected if `defer_to_data_final_fixes` is not set.
---@field defer_to_data_final_fixes? boolean # When `true`, stores the icon for assignment at the end of data-final-fixes. Supersedes `defer_to_data_updates`. Expected if `defer_to_data_updates` is not set.

---Constructs and assigns an icon to the prototype with the given `name` from the given `inputs`,
---and appends tier labels of the given `tier`.
---
---@param name string # The name of the prototype.
---@param tier integer # The tier of the added labels. An integer value from 0 to 6.
---@param inputs ConstructIconInputsOld
function lib.construct_icon(name, tier, inputs)
	---@type ConstructIconInputsOld
	local inputs_copy = util.copy(inputs)

	--Set defaults
	inputs_copy.icon_size = inputs.icon_size or 64
	inputs_copy.tier_labels = (inputs.tier_labels ~= false)

	-- Handle compatibility defaults
	local subfolder_path = ""
	if inputs_copy.group then
		subfolder_path = inputs_copy.group .. "/"
	end
	if inputs_copy.subgroup then
		subfolder_path = subfolder_path .. inputs_copy.subgroup .. "/"
	end

	-- Handle mask tinting defaults
	---@type data.Color|nil
	local icon_tint = inputs_copy.tint
	if inputs_copy.untinted_icon_mask then
		icon_tint = nil
	elseif not inputs_copy.tint then
		inputs_copy.untinted_icon_mask = true
	end

	-- Handle icon_layers defaults
	---@type integer
	local icon_layers
	if inputs_copy.icon_filename then
		icon_layers = inputs_copy.icon_layers or 1
	else
		icon_layers = inputs_copy.icon_layers or 3
	end

	-- Some entities have variable bases and masks
	local icon_base = inputs_copy.icon_base or inputs_copy.icon_name
	local icon_mask = inputs_copy.icon_mask or inputs_copy.icon_name
	local icon_highlights = inputs_copy.icon_highlights or inputs_copy.icon_name

	-- Setup icon layers
	---@type data.IconData
	local icon_base_layer = {
		icon = inputs_copy.icon_filename
			or asset_mod_names[inputs_copy.graphics_mod].directory
				.. "/graphics/icons/"
				.. subfolder_path
				.. inputs_copy.icon_name
				.. "/"
				.. icon_base
				.. "-icon-base.png",
		icon_size = inputs_copy.icon_size,
	}

	---@type data.IconData, data.IconData
	local icon_mask_layer, icon_highlights_layer
	if icon_layers > 1 then
		icon_mask_layer = {
			icon = asset_mod_names[inputs_copy.graphics_mod].directory
				.. "/graphics/icons/"
				.. subfolder_path
				.. inputs_copy.icon_name
				.. "/"
				.. icon_mask
				.. "-icon-mask.png",
			icon_size = inputs_copy.icon_size,
			tint = icon_tint,
		}

		icon_highlights_layer = {
			icon = asset_mod_names[inputs_copy.graphics_mod].directory
				.. "/graphics/icons/"
				.. subfolder_path
				.. inputs_copy.icon_name
				.. "/"
				.. icon_highlights
				.. "-icon-highlights.png",
			icon_size = inputs_copy.icon_size,
			tint = { 1, 1, 1, 0 },
		}
	end

	---@type data.IconData[]
	local icon_data = { icon_base_layer }

	if icon_layers > 1 then
		table.insert(icon_data, icon_mask_layer)
	end

	if icon_layers > 2 then
		table.insert(icon_data, icon_highlights_layer)
	end

	---@type data.SpriteVariations
	local pictures = sprite_utils.sprites.create_sprite_from_icons(icon_data, 1.0)

	-- Append icon extras as needed
	if inputs_copy.icon_extras then
		-- Append icon_extras
		for n = 1, #inputs_copy.icon_extras do
			table.insert(icon_data, inputs_copy.icon_extras[n])
		end
	end

	if inputs_copy.icon_picture_extras then
		-- If we have one layer, we need to convert to an layered sprite.
		if not pictures.layers then
			pictures = {
				layers = { pictures },
			}
		end

		for n = 1, #inputs_copy.icon_picture_extras do
			table.insert(pictures.layers, inputs_copy.icon_picture_extras[n])
		end
	end

	---@type DeferrableIconData
	local deferrable_icon = {
		name = name,
		type_name = inputs_copy.type or "item",
		icon_data = inputs_copy.tier_labels and _framework.tiers.add_tier_labels_to_icons(tier, icon_data) or icon_data,
		pictures = pictures,
	}

	-- It may be necessary to put icons back in final fixes, allow for that
	local stage
	if inputs_copy.defer_to_data_final_fixes then
		stage = sprite_utils.defines.stage.data_final_fixes
	elseif inputs_copy.defer_to_data_updates then
		stage = sprite_utils.defines.stage.data_updates
	end

	if stage then
		sprite_utils.icons.store_icon_for_deferred_assignment_in_stage(_deferred_icon_store, stage, deferrable_icon)
	else
		sprite_utils.icons.assign_deferrable_icon(deferrable_icon)
	end
end

---Converts the directional sprite sheet to a non-directional, animated sprite sheet, for use with robot death animations.
---@param animation data.RotatedAnimation
---@param shift data.Vector
---@return data.Animation
local function convert_rotated_animation_to_animation(animation, shift)
	---@type data.RotatedAnimation
	local animation_copy = util.copy(animation)
	local layers = animation_copy.layers or { animation_copy }

	for _, layer in pairs(layers) do
		--- Extract the direction count, use it as frames.
		layer.frame_count = layer.direction_count

		--- Remove it from the returned prototype.
		layer.direction_count = nil
		layer.animation_speed = 1
		layer.shift = util.add_shift(layer.shift, shift)
	end

	return animation_copy --[[@as data.Animation]]
end

---Sets the `run_mode` field of a given animation to `"backward"` everywhere it is required.
---@param animation data.Animation
---@return data.Animation
local function get_reversed_animation(animation)
	---@type data.Animation
	local animation_copy = util.copy(animation)

	--- Ensure working with an array of layers if animation was a single layer.
	local layers = animation_copy.layers or { animation_copy }

	for _, layer in pairs(layers) do
		layer.run_mode = "backward"
	end

	return animation_copy
end

---Creates the necessary particles and animations for a flying robot's death spiral, and links it to the prototype.
---@param prototype data.CombatRobotPrototype|data.RobotWithLogisticInterfacePrototype
---@param corpse_name data.EntityID
function lib.configure_robot_death_animation(prototype, corpse_name)
	local shadow_shift = { -0.75, -0.40 }
	local animation_shift = { 0, 0 }

	local particle_name = "ar-" .. prototype.name .. "-dying-particle"

	local animation = convert_rotated_animation_to_animation(prototype.in_motion, animation_shift)
	local shadow_animation = convert_rotated_animation_to_animation(prototype.shadow_in_motion, shadow_shift)

	---@type data.ParticlePrototype
	local particle = {
		type = "optimized-particle",
		name = particle_name,
		pictures = { animation, get_reversed_animation(animation) },
		shadows = { shadow_animation, get_reversed_animation(shadow_animation) },
		movement_modifier = 0.95,
		life_time = 1000,
		regular_trigger_effect_frequency = 2,
		regular_trigger_effect = {
			{
				type = "create-trivial-smoke",
				smoke_name = "smoke-fast",
				starting_frame_deviation = 5,
				probability = 0.5,
			},
			{
				type = "create-particle",
				particle_name = "spark-particle",
				tail_length = 10,
				tail_length_deviation = 5,
				tail_width = 5,
				probability = 0.2,
				initial_height = 0.2,
				initial_vertical_speed = 0.15,
				initial_vertical_speed_deviation = 0.05,
				speed_from_center = 0.1,
				speed_from_center_deviation = 0.05,
				offset_deviation = { { -0.25, -0.25 }, { 0.25, 0.25 } },
			},
		},
		ended_on_ground_trigger_effect = {
			type = "create-entity",
			entity_name = corpse_name,
			offsets = { { 0, 0 } },
		},
	}

	data:extend({ particle })

	prototype.dying_trigger_effect = {
		{
			type = "create-particle",
			particle_name = particle_name,
			initial_height = 1.8,
			initial_vertical_speed = 0,
			frame_speed = 1,
			frame_speed_deviation = 0.5,
			speed_from_center = 0,
			speed_from_center_deviation = 0.2,
			offset_deviation = { { -0.01, -0.01 }, { 0.01, 0.01 } },
			offsets = { { 0, 0.5 } },
		},
	}

	if prototype.type == "construction-robot" or prototype.type == "logistic-robot" then
		return
	end

	prototype.destroy_action = {
		type = "direct",
		action_delivery = {
			type = "instant",
			source_effects = {
				type = "create-particle",
				particle_name = particle_name,
				initial_height = 1.8,
				initial_vertical_speed = 0,
				frame_speed = 0.5,
				frame_speed_deviation = 0.5,
				speed_from_center = 0,
				speed_from_center_deviation = 0.1,
				offset_deviation = { { -0.01, -0.01 }, { 0.01, 0.01 } },
				offsets = { { 0, 0.5 } },
			},
		},
	}
end

---Initializes the library with the specified `icon_store` for use with deferrable
---icon assignment, and returns the LibHack instance.
---@param icon_store Reskins.SpriteUtils.DeferredIconStore
---@return LibHack
function lib.with_icon_store(icon_store)
	_deferred_icon_store = icon_store
	return lib -- chainable
end

return lib
