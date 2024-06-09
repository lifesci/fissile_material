class("Board").extends()

local <const> CENTER_X = 200
local <const> CENTER_Y = 120

function Board:init(offsetX, offsetY, gridSize)
    Board.super.init(self)
    self.offsetX = 0
    self.offsetY = 0
    self.gridSize = gridSize
end

function Board:getPosition(x, y)
    return 
end
