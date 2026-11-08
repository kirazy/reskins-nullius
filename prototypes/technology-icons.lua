---@using data

local _framework = {
	settings = require("__reskins-framework__.api.settings"),
	tiers = require("__reskins-framework__.api.tiers"),
}
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local BASE_ICON_PATH = "__base__/graphics/icons/"

-- The technologies marked `is_base` show the belts of the base game, and are reskinned only when the tier colors are
-- customized, as are those belts.
local reskin_base_entities = _framework.settings.get_value("reskins-framework-use-custom-tier-colors") == true

---Provides methods for assigning icons to the technologies and checkpoints of Nullius.
local M = {}

local function get_tier_tint(options)
	if options.tint then
		return options.tint
	end

	if not options.tier then
		return nil
	end

	local tier = _framework.tiers.get_tier(options)
	return _framework.tiers.get_tint(tier)
end

local function make_electrolyzer_entity_frame_technology_icon(options)
	return {
		{
			icon = "__angelspetrochemgraphics__/graphics/entity/electrolyser/electrolyser-north.png",
			icon_size = 224,
		},
		{
			icon = "__reskins-assets-angels__/graphics/entity/electrolyser/electrolyser-mask.png",
			icon_size = 224,
			tint = get_tier_tint(options),
		},
		{
			icon = "__reskins-assets-angels__/graphics/entity/electrolyser/electrolyser-highlights.png",
			icon_size = 224,
			tint = { 1, 1, 1, 0 },
		},
	}
end

local function make_flat_technology_icon(options)
	return {
		{
			icon = options.icon,
			icon_size = options.icon_size or 256,
		},
	}
end

---Gets the icon of the catalog module from the given technology `options`, in the tint of its tier and with its
---`params`, converted to the icon defaults of a technology.
---@param options table
---@return IconData[]
local function make_catalog_technology_icon(options)
	local params = util.copy(options.params or {})
	params.tint = get_tier_tint(options)

	return options.module.get_icon_composition(params):build({ to = "technology" })
end

local technology_icon_builders = {
	catalog = make_catalog_technology_icon,
	["electrolyzer-entity-frame"] = make_electrolyzer_entity_frame_technology_icon,
	flat = make_flat_technology_icon,
}

local function make_technology_icons(options)
	local icon_type = options.icon_type or "catalog"
	local builder = technology_icon_builders[icon_type]

	if not builder then
		error("The technology icon type '" .. icon_type .. "' is not known.")
	end

	return builder(options)
end

---Gets the check mark that is drawn over the icon of a checkpoint.
---@return IconData
---@nodiscard
function M.make_checkpoint_check_mark()
	return {
		icon = "__nullius__/graphics/icons/checkpoint.png",
		icon_size = 64,
		tint = { 0.6, 0.6, 0.6, 0.6 },
		scale = 8,
	}
end

---Gets the blueprint that is drawn behind the icon of a checkpoint.
---@return IconData[]
---@nodiscard
function M.make_blueprint_background()
	return {
		{
			icon = BASE_ICON_PATH .. "blueprint.png",
			icon_size = 64,
			scale = 8,
		},
	}
end

---Assigns the icon that each of the given `technologies` describes to the technology of the same name, if it exists.
---
---An entry with `is_base` set is skipped unless the setting `reskins-framework-use-custom-tier-colors` is enabled.
---@param technologies table<string, table> The options for the icon of each technology, by the name of the technology.
function M.assign_technology_icons(technologies)
	for name, options in pairs(technologies) do
		local technology = data.raw.technology[name]

		if not technology or (options.is_base and not reskin_base_entities) then
			goto continue
		end

		local icon_data = _sprite_utils.icons.transform_icons(make_technology_icons(options), {
			scale = options.scale,
		}, "technology")

		_sprite_utils.icons.assign_icons_to_prototype_and_related_prototypes(name, "technology", icon_data)

		::continue::
	end
end

local function get_checkpoint_background_icons(checkpoint, options)
	if options.background_icons then
		return util.copy(options.background_icons)
	end

	if checkpoint.icons and checkpoint.icons[1] then
		return {
			util.copy(checkpoint.icons[1]),
		}
	end

	if checkpoint.icon then
		return {
			_sprite_utils.icons.create_technology_icon(checkpoint.icon, checkpoint.icon_size),
		}
	end

	return {}
end

local function apply_checkpoint_overlay(options)
	local checkpoint = data.raw.technology[options.checkpoint_name]

	if not checkpoint or (options.is_base and not reskin_base_entities) then
		return
	end

	local overlay_icons = _sprite_utils.icons.transform_icons(make_technology_icons(options), {
		scale = options.overlay_scale,
		shift = options.overlay_shift,
	}, "technology")

	if not overlay_icons then
		return
	end

	local combined_icons = get_checkpoint_background_icons(checkpoint, options)

	-- Append the generated overlay after the blueprint background.
	for _, icon_layer in pairs(overlay_icons) do
		combined_icons[#combined_icons + 1] = util.copy(icon_layer)
	end

	if options.top_icons then
		for _, icon_layer in pairs(options.top_icons) do
			combined_icons[#combined_icons + 1] = util.copy(icon_layer)
		end
	end

	_sprite_utils.icons.assign_icons_to_prototype_and_related_prototypes(
		options.checkpoint_name,
		"technology",
		combined_icons
	)
end

---Assigns the icon that each of the given `checkpoints` describes to the checkpoint technology it names, if it exists.
---
---An entry with `is_base` set is skipped unless the setting `reskins-framework-use-custom-tier-colors` is enabled.
---@param checkpoints table[] The options for the icon of each checkpoint.
function M.assign_checkpoint_icons(checkpoints)
	for _, options in pairs(checkpoints) do
		apply_checkpoint_overlay(options)
	end
end

return M
