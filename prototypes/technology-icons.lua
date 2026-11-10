---@using data
---@using Reskins.Framework
---@using Reskins.SpriteUtils

---@namespace Reskins.Nullius

local _framework = {
	settings = require("__reskins-framework__.api.settings"),
	tiers = require("__reskins-framework__.api.tiers"),
}
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local BASE_ICON_PATH = "__base__/graphics/icons/"

-- The technologies marked `is_base` show the belts of the base game, and are reskinned only when the tier colors are
-- customized, as are those belts.
local reskin_base_entities = _framework.settings.get_value("reskins-framework-use-custom-tier-colors") == true

---Defines a catalog module of the Assets API for a technology icon, such as `assets.base.technologies.radar`.
---@alias CatalogModule { get_icon_composition: fun(params?: any): IconComposition }

---Defines the icon of a technology from the `get_icon_composition` function of a catalog module, in the tint of a tier,
---and the options with which it is assigned.
---@class CatalogTechnologyIconDefinition
---The source of the icon. Default `"catalog"`.
---@field icon_type? "catalog"
---The module from which the icon is read.
---@field module CatalogModule
---The parameters given to `get_icon_composition` of `module` in addition to `tint`.
---@field params? table<string, string|integer>
---The traditional tier of the technology.
---@field tier? Tier
---The progression tier of the technology.
---@field prog_tier? Tier
---The tint of the icon. When `nil`, the color of the tier for the current tier mapping is used, if `tier` is given.
---@field tint? Color
---The scale applied to the icon. When `nil`, the icon is not scaled.
---@field scale? double
---When `true`, indicates that the icon is assigned only when the tier colors are customized. Default `false`.
---@field is_base? boolean

---Defines the icon of a technology from one image file, and the options with which it is assigned.
---@class FlatTechnologyIconDefinition
---The source of the icon.
---@field icon_type "flat"
---The file name of the image.
---@field icon FileName
---The size of the image, in pixels. Default `256`.
---@field icon_size? SpriteSizeType
---The scale applied to the icon. When `nil`, the icon is not scaled.
---@field scale? double
---When `true`, indicates that the icon is assigned only when the tier colors are customized. Default `false`.
---@field is_base? boolean

---Defines the icon of a technology and the options with which it is assigned.
---@alias TechnologyIconDefinition CatalogTechnologyIconDefinition|FlatTechnologyIconDefinition

---Defines the icon of a checkpoint from the `get_icon_composition` function of a catalog module, in the tint of a tier,
---and the checkpoint to which it is assigned.
---@class CatalogCheckpointIconDefinition
---The source of the icon. Default `"catalog"`.
---@field icon_type? "catalog"
---The module from which the icon is read.
---@field module CatalogModule
---The parameters given to `get_icon_composition` of `module` in addition to `tint`.
---@field params? table<string, string|integer>
---The traditional tier of the technology.
---@field tier? Tier
---The progression tier of the technology.
---@field prog_tier? Tier
---The tint of the icon. When `nil`, the color of the tier for the current tier mapping is used, if `tier` is given.
---@field tint? Color
---The name of the checkpoint technology to which the icon is assigned.
---@field checkpoint_name string
---The layers drawn beneath the icon. When `nil`, the first layer in the current icon of the checkpoint is used.
---@field background_icons? IconData[]
---The layers drawn over the icon. Default `nil`.
---@field top_icons? IconData[]
---The scale applied to the icon. When `nil`, the icon is not scaled.
---@field overlay_scale? double
---The shift applied to the icon. When `nil`, the icon is not shifted.
---@field overlay_shift? Vector
---When `true`, indicates that the icon is assigned only when the tier colors are customized. Default `false`.
---@field is_base? boolean

---Defines the icon of a checkpoint from one image file, and the checkpoint to which it is assigned.
---@class FlatCheckpointIconDefinition
---The source of the icon.
---@field icon_type "flat"
---The file name of the image.
---@field icon FileName
---The size of the image, in pixels. Default `256`.
---@field icon_size? SpriteSizeType
---The name of the checkpoint technology to which the icon is assigned.
---@field checkpoint_name string
---The layers drawn beneath the icon. When `nil`, the first layer in the current icon of the checkpoint is used.
---@field background_icons? IconData[]
---The layers drawn over the icon. Default `nil`.
---@field top_icons? IconData[]
---The scale applied to the icon. When `nil`, the icon is not scaled.
---@field overlay_scale? double
---The shift applied to the icon. When `nil`, the icon is not shifted.
---@field overlay_shift? Vector
---When `true`, indicates that the icon is assigned only when the tier colors are customized. Default `false`.
---@field is_base? boolean

---Defines the icon of a checkpoint and the checkpoint to which it is assigned.
---@alias CheckpointIconDefinition CatalogCheckpointIconDefinition|FlatCheckpointIconDefinition

---Defines the icon of a technology or a checkpoint from a catalog module.
---@alias CatalogIconDefinition CatalogTechnologyIconDefinition|CatalogCheckpointIconDefinition

---Defines the icon of a technology or a checkpoint from one image file.
---@alias FlatIconDefinition FlatTechnologyIconDefinition|FlatCheckpointIconDefinition

---Provides methods for assigning icons to the technologies and checkpoints of Nullius.
local M = {}

---Gets the tint of the icon that the given `options` describe, from its `tint` or from the color of its tier.
---@param options CatalogIconDefinition
---@return Color? # The tint, or `nil` when `options` gives neither a tint nor a tier.
---@nodiscard
local function get_tier_tint(options)
	if options.tint then
		return options.tint
	end

	local tier = options.tier
	if not tier then
		return nil
	end

	return _framework.tiers.get_tint(_framework.tiers.get_tier(tier, options.prog_tier))
end

---Gets the icon of the image file that the given `options` name.
---@param options FlatIconDefinition
---@return IconData[]
---@nodiscard
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
---@param options CatalogIconDefinition
---@return IconData[]
local function make_catalog_technology_icon(options)
	---@type table<string, any>
	local params = util.copy(options.params or {})
	params.tint = get_tier_tint(options)

	local icon_data = options.module.get_icon_composition(params):build({ to = "technology" })
	return icon_data
end

---Gets the icon that the given `options` describe, from the source that its `icon_type` selects.
---@param options TechnologyIconDefinition|CheckpointIconDefinition
---@return IconData[]
---@nodiscard
local function make_technology_icons(options)
	local icon_type = options.icon_type or "catalog"

	if icon_type == "catalog" then
		return make_catalog_technology_icon(options --[[@as CatalogIconDefinition]])
	elseif icon_type == "flat" then
		return make_flat_technology_icon(options --[[@as FlatIconDefinition]])
	end

	error("The technology icon type '" .. icon_type .. "' is not known.")
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
---@param technologies table<string, TechnologyIconDefinition> The options for the icon of each technology, by the name of the technology.
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

---Gets the layers drawn beneath the icon of the given `checkpoint`, from the `background_icons` of the given `options`
---or from the current icon of the checkpoint.
---@param checkpoint TechnologyPrototype
---@param options CheckpointIconDefinition
---@return IconData[] # A copy of the layers, or an empty array when neither gives any.
---@nodiscard
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
			_sprite_utils.icons.get_icon_from_prototype(checkpoint)[1],
		}
	end

	return {}
end

---Assigns the icon that the given `options` describe to the checkpoint technology it names, if it exists.
---@param options CheckpointIconDefinition
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
---@param checkpoints CheckpointIconDefinition[] The options for the icon of each checkpoint.
function M.assign_checkpoint_icons(checkpoints)
	for _, options in pairs(checkpoints) do
		apply_checkpoint_overlay(options)
	end
end

return M
