local tier_map = {
	["nullius-solar-collector-1"] = { material = "silver-aluminum" },
	["nullius-solar-collector-2"] = {},
	["nullius-solar-collector-3"] = { material = "gold-copper" },
}

local function heat_pipe_sprite(material, sprite_name, shift)
	return {
		filename = "__reskins-assets-bobs__/graphics/entity/heat-pipe/" .. material .. "/heat-pipe-" .. sprite_name .. ".png",
		priority = "extra-high",
		width = 64,
		height = 64,
		scale = 0.5,
		shift = shift,
	}
end

local function collector_pipe_layers(material)
	return {
		heat_pipe_sprite(material, "straight-horizontal-3", { -2, 0.5 }),
		heat_pipe_sprite(material, "straight-horizontal-1", { -1, 0.5 }),
		heat_pipe_sprite(material, "straight-horizontal-2", { 0, 0.5 }),
		heat_pipe_sprite(material, "straight-horizontal-3", { 1, 0.5 }),
		heat_pipe_sprite(material, "straight-horizontal-1", { 2, 0.5 }),
	}
end

local function replace_pipe_layer(layers, material)
	if not layers or not material then
		return
	end

	local panel_layer = layers[1]
	local pipe_layers = collector_pipe_layers(material)

	layers[1] = panel_layer
	for i = 1, #pipe_layers do
		layers[i + 1] = pipe_layers[i]
	end
	for i = #pipe_layers + 2, #layers do
		layers[i] = nil
	end
end

for name, map in pairs(tier_map) do
	---@type data.ReactorPrototype
	local entity = data.raw["reactor"][name]
	if entity then
		replace_pipe_layer(entity.picture and entity.picture.layers, map.material)
		replace_pipe_layer(entity.working_light_picture and entity.working_light_picture.layers, map.material)
	end
end
