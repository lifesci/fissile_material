import "constants"

local CENTER_X <const> = 200
local CENTER_Y <const> = 120

local gfx <const> = playdate.graphics

class("Board").extends()

function Board:init(offsetX, offsetY, gridSize)
    Board.super.init(self)
    self.offsetX = 0
    self.offsetY = 0
    self.gridSize = gridSize
end

function Board:getPosition(x, y)
    local xPos = (x - self.offsetX)*self.gridSize + CENTER_X
    local yPos = (y - self.offsetY)*self.gridSize + CENTER_Y
    return xPos, yPos
end

function Board:updateOffset(dx, dy)
    self.offsetX = self.offsetX + dx
    self.offsetY = self.offsetY + dy

    gfx.sprite.performOnAllSprites(
        function (sprite)
            if sprite:getTag() ~= TAGS.cursor then
                sprite:moveTo(sprite.x - self.gridSize*dx, sprite.y - self.gridSize*dy)
            end
        end
    )
end

function Board:moveRight()
    self:updateOffset(1, 0)
end

function Board:moveLeft()
    self:updateOffset(-1, 0)
end

function Board:moveUp()
    self:updateOffset(0, -1)
end

function Board:moveDown()
    self:updateOffset(0, 1)
end

function Board:getBoundaries()
    return
        0,
        CENTER_X*2,
        0,
        CENTER_Y*2
end

