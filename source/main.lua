import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "cursor"

local gfx <const> = playdate.graphics
local drawn = false
local baseSize = 40
local crsr = Cursor(200, 120, baseSize)

function playdate.update()
    gfx.sprite.update()
end

