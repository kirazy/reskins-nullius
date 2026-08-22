local furnace = data.raw["assembling-machine"]["nullius-small-furnace-3"]
if not furnace then
	return
end

local animation = furnace.graphics_set and furnace.graphics_set.animation or nil
if not animation then
	return
end

if animation.layers and animation.layers[2] then
	animation.layers[2].width = 238
	animation.layers[2].height = 212
	animation.layers[2].scale = 0.3333
	animation.layers[2].shift = util.by_pixel(0.9333, 2.5833)
end

if animation.layers and animation.layers[3] then
	animation.layers[3].width = 238
	animation.layers[3].height = 212
	animation.layers[3].scale = 0.3333
	animation.layers[3].shift = util.by_pixel(0.9333, 2.5833)
end
