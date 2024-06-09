import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/frameTimer"
import "cursor"
import "base"
import "board"

local pd <const> = playdate
local gfx <const> = pd.graphics
local drawn = false
local baseSize = 40
local board = Board(0, 0, 40)
local crsr = Cursor(200, 120, baseSize)
Base(200, 120)

function playdate.update()
    gfx.sprite.update()
    pd.frameTimer.updateTimers()
end

