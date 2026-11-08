---@using data

local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local Applicators = require("__reskins-assets-api__.api.applicators")
local TrainArtilleryWagon = require("__reskins-assets-api__.assets.base.entities.train-artillery-wagon")
local TurretArtillery = require("__reskins-assets-api__.assets.base.entities.turret-artillery")

-- A drone launcher is an artillery turret, and a drone carrier is an artillery wagon.
local launchers = {
	["nullius-drone-launcher-1"] = { tier = 1, prog_tier = 3 },
	["nullius-drone-launcher-2"] = { tier = 2, prog_tier = 4 },
}

local carriers = {
	["nullius-drone-carrier-1"] = { tier = 1, prog_tier = 3 },
	["nullius-drone-carrier-2"] = { tier = 2, prog_tier = 4 },
}

---Sets the given `tint` on every layer in the given `sprite` that is not drawn as a shadow, in place.
---@param sprite any
---@param tint Color
local function tint_sprite_tree(sprite, tint)
	if type(sprite) ~= "table" then
		return
	end

	if sprite.filename or sprite.filenames or sprite.stripes then
		if not sprite.draw_as_shadow then
			sprite.tint = tint
		end
	end

	for _, value in pairs(sprite) do
		tint_sprite_tree(value, tint)
	end
end

---Gets a copy of the pictures from the artillery wagon in the given `tint`.
---@param tint Color
---@return RollingStockRotatedSlopedGraphics?
local function make_carrier_pictures(tint)
	local pictures = util.copy(data.raw["artillery-wagon"]["artillery-wagon"].pictures)
	tint_sprite_tree(pictures, tint)
	return pictures
end

for name, options in pairs(launchers) do
	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
		tier = tier,
		name = name,
		type_name = "artillery-turret",
		composition = TurretArtillery.get_icon_composition({ tint = tint }),
	})
	_sprite_utils.icons.apply_icon_assignment(icon_assignment)

	local entity = data.raw["artillery-turret"][name]
	if entity then
		local sprite_set = TurretArtillery.get_sprite_set({ tint = tint })
		Applicators.apply_sprite_set(entity, sprite_set)
	end
end

for name, options in pairs(carriers) do
	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
		tier = tier,
		name = name,
		type_name = "artillery-wagon",
		composition = TrainArtilleryWagon.get_icon_composition({ tint = tint }),
	})
	_sprite_utils.icons.apply_icon_assignment(icon_assignment)

	local entity = data.raw["artillery-wagon"][name]
	if entity then
		entity.color = tint
		entity.pictures = make_carrier_pictures(tint)
	end
end
