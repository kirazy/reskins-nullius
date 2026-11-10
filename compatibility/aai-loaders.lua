---@using data

local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

if not mods["aai-loaders"] then
	return
end

local loaders = {
	["aai-basic-loader"] = {
		tier = 0,
		prog_tier = 0,
		technology = "nullius-loader-1",
	},
	["aai-loader"] = {
		tier = 1,
		prog_tier = 1,
		technology = "nullius-loader-2",
	},
	["aai-fast-loader"] = {
		tier = 2,
		prog_tier = 2,
		technology = "nullius-loader-3",
	},
	["aai-express-loader"] = {
		tier = 3,
		prog_tier = 3,
		technology = "nullius-loader-4",
	},
	["aai-ultimate-loader"] = {
		tier = 4,
		prog_tier = 4,
		technology = "nullius-loader-5",
	},
}

---Gets the tint of the highlight layer that is added over a tinted layer.
---@return Color
local function aai_blend_tint()
	local blend = 0.25
	return { blend, blend, blend, 0 }
end

---Sets the given `tint` on the tint sheet of the given `structure_direction`, if any, and adds a highlight sheet if
---there is none, in place.
---@param structure_direction? Sprite4Way
---@param tint Color
local function patch_sheet_tint(structure_direction, tint)
	if not structure_direction or not structure_direction.sheets then
		return
	end

	-- The first tint sheet is the sheet of the loader, and a later tint sheet is a highlight sheet.
	-- reskins-compatibility adds the highlight sheet when it is active.
	local tint_sheet = nil
	local has_highlight_sheet = false
	for _, sheet in pairs(structure_direction.sheets) do
		if sheet.filename and sheet.filename:find("_tint.png") then
			if tint_sheet then
				has_highlight_sheet = true
			else
				tint_sheet = sheet
			end
		end
	end

	if not tint_sheet then
		return
	end

	tint_sheet.tint = tint

	-- Add an analogue of the highlights layer to help soften the saturation
	-- and better align with Artisanal Reskins color handling.
	if not has_highlight_sheet then
		local highlight_patch_sheet = util.copy(tint_sheet)
		highlight_patch_sheet.tint = aai_blend_tint()
		highlight_patch_sheet.blend_mode = "additive-soft"
		table.insert(structure_direction.sheets, highlight_patch_sheet)
	end
end

---Sets the given `tint` on the mask layer of the given `icons`, and adds a highlight layer if there is none, in place.
---@param icons IconData[]
---@param tint Color
local function patch_icons_tint(icons, tint)
	-- The first mask layer is the mask of the loader, and a later mask layer is a highlight layer.
	-- reskins-compatibility adds the highlight layer when it is active.
	local mask_layer = nil
	local has_highlight_layer = false
	for _, layer in pairs(icons) do
		if layer.icon and layer.icon:find("_mask") then
			if mask_layer then
				has_highlight_layer = true
			else
				mask_layer = layer
			end
		end
	end

	if not mask_layer then
		return
	end

	mask_layer.tint = tint

	-- Add an analogue of the highlights layer to help soften the saturation
	-- and better align with Artisanal Reskins color handling.
	if not has_highlight_layer then
		local highlight_patch_layer = util.copy(mask_layer)
		highlight_patch_layer.tint = aai_blend_tint()
		table.insert(icons, highlight_patch_layer)
	end
end

for name, options in pairs(loaders) do
	local loader = data.raw["loader-1x1"][name]
	if not loader then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	if loader.structure then
		patch_sheet_tint(loader.structure.direction_in, tint)
		patch_sheet_tint(loader.structure.direction_out, tint)
	end

	if loader.icons then
		local icon_data = _sprite_utils.icons.get_icon_from_prototype(loader)
		patch_icons_tint(icon_data, tint)

		local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
			tier = tier,
			name = loader.name,
			type_name = loader.type,
			icon_data = icon_data,
		})
		_sprite_utils.icons.apply_icon_assignment(icon_assignment)
	end

	local technology = data.raw["technology"][options.technology]
	if technology and technology.icons then
		local icon_data = _sprite_utils.icons.get_icon_from_prototype(technology)
		patch_icons_tint(icon_data, tint)

		_sprite_utils.icons.apply_icon_assignment({
			name = technology.name,
			type_name = technology.type,
			icon_data = icon_data,
		})
	end

	::continue::
end
