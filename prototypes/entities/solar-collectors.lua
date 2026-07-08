local _lib = require("_lib")

local ENTITY_PATH = "__reskins-nullius__/graphics/entity/collector/"
local ICON_PATH = "__reskins-nullius__/graphics/icons/collector/"

local blend_mode = _lib.get_setting("reskins-lib-blend-mode") or "additive"

local do_entities = _lib.is_scope_enabled("entities")
local do_items = _lib.is_scope_enabled("items-and-fluids")

if not (do_entities or do_items) then
	return
end

local collectors = {
	["nullius-solar-collector-1"] = {
		tier = 1,
		tint = util.color("#ff3333"),
	},
	["nullius-solar-collector-2"] = {
		tier = 2,
		tint = util.color("#ff9f1c"),
	},
	["nullius-solar-collector-3"] = {
		tier = 3,
		tint = util.color("#ffe55c"),
	},
}

local function make_collector_layers(tint)
	return {
		{
			filename = ENTITY_PATH .. "collector-base.png",
			width = 440,
			height = 280,
			scale = 0.45,
			shift = { 0, -0.25 },
		},
		{
			filename = ENTITY_PATH .. "collector-mask.png",
			width = 440,
			height = 280,
			scale = 0.45,
			shift = { 0, -0.25 },
			tint = tint,
		},
		{
			filename = ENTITY_PATH .. "collector-highlights.png",
			width = 440,
			height = 280,
			scale = 0.45,
			shift = { 0, -0.25 },
			blend_mode = blend_mode,
		},
	}
end

local function replace_collector_body(picture, tint)
	if not picture or not picture.layers then
		return
	end

	local original_layers = picture.layers
	local layers = make_collector_layers(tint)

	for i = 2, #original_layers do
		layers[#layers + 1] = util.table.deepcopy(original_layers[i])
	end

	picture.layers = layers
end

local function make_icon(tint)
	return {
		{
			icon = ICON_PATH .. "collector-icon-base.png",
			icon_size = 64,
			mipmap_count = 4,
		},
		{
			icon = ICON_PATH .. "collector-icon-mask.png",
			icon_size = 64,
			mipmap_count = 4,
			tint = tint,
		},
		{
			icon = ICON_PATH .. "collector-icon-highlights.png",
			icon_size = 64,
			mipmap_count = 4,
		},
	}
end

for name, options in pairs(collectors) do
	local entity =
		data.raw.reactor
		and data.raw.reactor[name]

	if do_entities and entity then
		replace_collector_body(entity.picture, options.tint)
		replace_collector_body(entity.working_light_picture, options.tint)
	end

	if do_entities or do_items then
		local icon =
			_lib.add_tier_labels_to_icons(
				options.tier,
				make_icon(options.tint)
			)

		if do_entities then
			_lib.assign_icons_to_prototype("reactor", name, icon)
		end

		if do_items then
			local index = tostring(options.tier)
			local boxed_icon = _lib.make_boxed_icon(icon)

			_lib.assign_icons_to_prototype("item", name, icon)
			_lib.assign_icons_to_prototype("recipe", name, icon)
			_lib.assign_icons_to_prototype("item", "nullius-box-solar-collector-" .. index, boxed_icon)
			_lib.assign_icons_to_prototype("recipe", "nullius-boxed-solar-collector-" .. index, boxed_icon)
			_lib.assign_icons_to_prototype("recipe", "nullius-box-solar-collector-" .. index, boxed_icon)
			_lib.assign_icons_to_prototype("recipe", "nullius-unbox-solar-collector-" .. index, boxed_icon)
		end
	end
end
