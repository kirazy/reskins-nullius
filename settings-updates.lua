---@using data

-- The `util` global is not available during the settings stage and must be imported.
local util = require("util")

data.raw["color-setting"]["reskins-framework-custom-colors-tier-4"].default_value = util.color("#67e55c") --[[@as Color]]
data.raw["color-setting"]["reskins-framework-custom-colors-tier-5"].default_value = util.color("#b459ff") --[[@as Color]]
data.raw["color-setting"]["reskins-framework-custom-colors-tier-6"].default_value = util.color("#ff8533") --[[@as Color]]

data.raw["color-setting"]["reskins-framework-default-colors-tier-4"].default_value = util.color("#67e55c") --[[@as Color]]
data.raw["color-setting"]["reskins-framework-default-colors-tier-5"].default_value = util.color("#b459ff") --[[@as Color]]
data.raw["color-setting"]["reskins-framework-default-colors-tier-6"].default_value = util.color("#ff8533") --[[@as Color]]
