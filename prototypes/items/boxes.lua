-- Nullius builds the icons of its boxes, and of the box and unbox recipes and their signals, from the item icons in
-- its own data-final-fixes (prototypes/item/box_icons.lua), which runs before ours. Items reskinned in our
-- data-final-fixes have changed since then, so rebuild them all from the final item icons, the same way Nullius does.

local ICON_PATH = "__nullius__/graphics/icons/"
local ITEM_TYPES = { "item", "ammo", "capsule", "module", "rail-planner", "tool", "repair-tool" }

local function find_item(name)
	for _, type_name in pairs(ITEM_TYPES) do
		local item = data.raw[type_name] and data.raw[type_name][name]
		if item then
			return item
		end
	end
end

---Returns the icons of a box of `item` and of its unbox recipe: a crate with the item's icon layers on top.
---@param item data.ItemPrototype
---@param suffix string? The box name without "nullius-box-".
---@return data.IconData[]? boxed
---@return data.IconData[]? unboxed
local function get_box_icons(item, suffix)
	local layers = item.icons or { { icon = item.icon, icon_size = item.icon_size } }
	if not layers[1] or not layers[1].icon then
		return nil, nil
	end

	local backdrop = "crate.png"
	local icon_scale = 0.9
	if suffix == "acrylic-fiber" then
		icon_scale = 1
	elseif suffix == "carbon-fiber" then
		icon_scale = 1
		backdrop = "boxing.png"
	end

	local base_size = layers[1].icon_size or item.icon_size or 64
	local boxed = {
		{ icon = ICON_PATH .. backdrop, icon_size = 64 },
		{ icon = layers[1].icon, icon_size = base_size, tint = layers[1].tint, scale = icon_scale * 32 / base_size },
	}

	for index = 2, 9 do
		local layer = layers[index]
		if layer then
			local size = layer.icon_size or item.icon_size or 64
			local shift = layer.shift and { layer.shift[1] * icon_scale, layer.shift[2] * icon_scale } or nil
			table.insert(boxed, {
				icon = layer.icon,
				icon_size = layer.icon_size,
				tint = layer.tint,
				scale = layer.scale and layer.scale * icon_scale or icon_scale * 32 / size,
				shift = shift,
			})
		end
	end

	local unboxed = table.deepcopy(boxed)
	unboxed[1].icon = ICON_PATH .. "un" .. backdrop

	return boxed, unboxed
end

local function set_signal_icons(recipe)
	local signal = data.raw["virtual-signal"][recipe.name]
	if signal then
		signal.icons = table.deepcopy(recipe.icons)
	end
end

for name, recipe in pairs(data.raw.recipe) do
	local product = recipe.results and recipe.results[1]
	local item = product and find_item(product.name)

	if item and name:sub(1, 14) == "nullius-unbox-" then
		local suffix = name:sub(15)
		local box = data.raw.item["nullius-box-" .. suffix]
		local boxed, unboxed = get_box_icons(item, suffix)
		if box and boxed then
			box.icons = boxed
			recipe.icons = unboxed
			set_signal_icons(recipe)
		end
	elseif item and name:sub(1, 14) == "nullius-boxed-" and product.name:sub(1, 12) ~= "nullius-box-" then
		local boxed = get_box_icons(item)
		if boxed then
			recipe.icons = boxed
			set_signal_icons(recipe)
		end
	end
end
