-- util global is not available during settings stage and must be imported.
local util = require("util")

data.raw["color-setting"]["reskins-framework-custom-colors-tier-4"].default_value = util.color("#67e55c")
data.raw["color-setting"]["reskins-framework-custom-colors-tier-5"].default_value = util.color("#b459ff")
data.raw["color-setting"]["reskins-framework-custom-colors-tier-6"].default_value = util.color("#ff8533")

data.raw["color-setting"]["reskins-framework-default-colors-tier-4"].default_value = util.color("#67e55c")
data.raw["color-setting"]["reskins-framework-default-colors-tier-5"].default_value = util.color("#b459ff")
data.raw["color-setting"]["reskins-framework-default-colors-tier-6"].default_value = util.color("#ff8533")
