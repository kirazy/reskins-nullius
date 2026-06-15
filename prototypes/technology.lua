local _framework = {
	tiers = require("__reskins-framework__.api.tiers"),
}

local MEDIUM_TECH_PATH =
	"__reskins-assets-base__/graphics/technology/fluid-handling/"
	.. "fluid-handling-technology-"


-- ============================================================================
-- Medium tank technology assignments
-- ============================================================================

local technologies = {
	["nullius-plumbing-1"] = {
		tier = 1,
		prog_tier = 1,
	},
	["nullius-plumbing-2"] = {
		tier = 1,
		prog_tier = 1,
	},
	["nullius-plumbing-3"] = {
		tier = 2,
		prog_tier = 2,
	},
	["nullius-plumbing-4"] = {
		tier = 2,
		prog_tier = 2,
	},
	["nullius-plumbing-5"] = {
		tier = 3,
		prog_tier = 3,
	},
	["nullius-plumbing-6"] = {
		tier = 4,
		prog_tier = 4,
	},
}


-- ============================================================================
-- Helpers
-- ============================================================================

local function make_medium_technology_icon(tint)
	return {
		{
			icon = MEDIUM_TECH_PATH .. "base.png",
			icon_size = 256,
		},
		{
			icon = MEDIUM_TECH_PATH .. "mask.png",
			icon_size = 256,
			tint = tint,
		},
		{
			icon = MEDIUM_TECH_PATH .. "highlights.png",
			icon_size = 256,
		},
	}
end

local function get_icon_layers(prototype)
	if not prototype then
		return nil
	end

	if prototype.icons then
		return table.deepcopy(prototype.icons)
	end

	if prototype.icon then
		return {
			{
				icon = prototype.icon,
				icon_size = prototype.icon_size,
				icon_mipmaps = prototype.icon_mipmaps,
			},
		}
	end

	return nil
end

local function clear_single_icon_fields(prototype)
	prototype.icon = nil
	prototype.icon_size = nil
	prototype.icon_mipmaps = nil
end


-- ============================================================================
-- Apply medium tank technology icons
-- ============================================================================

for name, options in pairs(technologies) do
	local technology = data.raw.technology[name]
	if not technology then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	technology.icons = make_medium_technology_icon(tint)

	clear_single_icon_fields(technology)

	::continue::
end


-- ============================================================================
-- Apply the large-tank item icon to the checkpoint technology
-- ============================================================================

local checkpoint =
	data.raw.technology["nullius-checkpoint-large-tank"]

local large_tank_item =
	data.raw.item["nullius-large-tank-2"]

if checkpoint and large_tank_item then
	local tank_icons = get_icon_layers(large_tank_item)

	if tank_icons then
		local combined_icons = {}

		-- Preserve the existing checkpoint blueprint background.
		if checkpoint.icons and checkpoint.icons[1] then
			combined_icons[#combined_icons + 1] =
				table.deepcopy(checkpoint.icons[1])
		elseif checkpoint.icon then
			combined_icons[#combined_icons + 1] = {
				icon = checkpoint.icon,
				icon_size = checkpoint.icon_size,
				icon_mipmaps = checkpoint.icon_mipmaps,
			}
		end

		-- Add every layer from the reskinned large-tank-2 item icon.
		for _, icon_layer in ipairs(tank_icons) do
			combined_icons[#combined_icons + 1] =
				table.deepcopy(icon_layer)
		end

		checkpoint.icons = combined_icons

		clear_single_icon_fields(checkpoint)
	end
end