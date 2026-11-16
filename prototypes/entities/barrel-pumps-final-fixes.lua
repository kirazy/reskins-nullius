---@using data

local names = { "nullius-barrel-pump-1", "nullius-barrel-pump-2" }

---Gets the first fluid in the given ingredients or products, if any.
---@param entries (data.IngredientPrototype|data.ProductPrototype)[]?
---@return data.FluidPrototype?
local function get_fluid(entries)
	for _, entry in pairs(entries or {}) do
		if entry.type == "fluid" then
			return data.raw.fluid[entry.name]
		end
	end
end

---@type table<string, true>
local categories = {}
for _, name in pairs(names) do
	local entity = data.raw["assembling-machine"][name]
	if entity then
		for _, category in pairs(entity.crafting_categories) do
			categories[category] = true
		end
	end
end

-- The barrel pumps draw their liquid in the primary color of the recipe. A recipe the pumps craft that defines no
-- colors uses the colors of its fluid ingredient, or of its fluid product when it has no fluid ingredient.
for _, recipe in pairs(data.raw.recipe) do
	if recipe.crafting_machine_tint then
		goto continue
	end

	for _, category in pairs(recipe.categories or { "crafting" }) do
		if categories[category] then
			local fluid = get_fluid(recipe.ingredients) or get_fluid(recipe.results)
			if fluid then
				recipe.crafting_machine_tint = {
					primary = util.copy(fluid.base_color),
					secondary = util.copy(fluid.flow_color),
				}
			end

			break
		end
	end

	::continue::
end
