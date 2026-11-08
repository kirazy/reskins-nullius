---@using data
---@using Reskins.Assets
---@using Reskins.Assets.Applicators

local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local PrototypeScaler = require("__reskins-assets-api__.api.prototype-scaler")
local StorageTank = require("__reskins-assets-api__.assets.base.entities.storage-tank")
local ThermalTank = require("__reskins-assets-api__.assets.assorted.entities.thermal-tank")

-- A thermal tank is placed as a storage tank that then builds the tank.
-- The horizontal and vertical reactors are the built tanks.
local reactor_prefixes = {
	"nullius-thermal-tank-",
	"nullius-thermal-tank-horizontal-",
	"nullius-thermal-tank-vertical-",
}

---Gets a copy of the picture from the given `sprite_set`, scaled for the given `entity`.
---@param entity ReactorPrototype|StorageTankPrototype
---@param sprite_set SpriteSetDefinition<ReactorSpriteSet>
---@return Sprite
local function get_picture(entity, sprite_set)
	local picture = util.copy(sprite_set.set.graphics_set.picture)

	local scaler = PrototypeScaler.for_prototype(entity, {
		nominal_width = sprite_set.set.nominal_width,
		nominal_height = sprite_set.set.nominal_height,
	})
	scaler:rescale(picture)

	return picture
end

for tier = 1, 3 do
	local label_tier = _framework.tiers.get_tier({ tier = tier, prog_tier = tier + 1 })
	local tint = _framework.tiers.get_tint(label_tier)

	local sprite_set = ThermalTank.get_sprite_set({ tint = tint })

	for _, prefix in pairs(reactor_prefixes) do
		local reactor = data.raw["reactor"][prefix .. tier]
		if reactor then
			reactor.picture = get_picture(reactor, sprite_set)
		end
	end

	local build = data.raw["storage-tank"]["nullius-thermal-tank-build-" .. tier]
	if build then
		local picture = get_picture(build, sprite_set)
		local storage_tank_pictures = StorageTank.get_sprite_set({}).set.pictures

		build.pictures = {
			picture = {
				north = picture,
				east = util.copy(picture),
				south = util.copy(picture),
				west = util.copy(picture),
			},
			fluid_background = storage_tank_pictures.fluid_background,
			window_background = storage_tank_pictures.window_background,
			flow_sprite = storage_tank_pictures.flow_sprite,
			gas_flow = storage_tank_pictures.gas_flow,
		}
	end

	local targets = {
		{ name = "nullius-thermal-tank-build-" .. tier, type_name = "storage-tank" },
	}
	for _, prefix in pairs(reactor_prefixes) do
		targets[#targets + 1] = { name = prefix .. tier, type_name = "reactor" }
	end

	for _, target in pairs(targets) do
		local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
			tier = label_tier,
			name = target.name,
			type_name = target.type_name,
			composition = ThermalTank.get_icon_composition({ tint = tint }),
		})
		_sprite_utils.icons.apply_icon_assignment(icon_assignment)
	end
end
