import "tower"
import "mob"

local pd <const> = playdate
local gfx <const> = pd.graphics

class("Cursor").extends(gfx.sprite)

function Cursor:init(x, y, board)
    Cursor.super.init(self)
    self.x = x
    self.y = y
    self.board = board
    local img = gfx.image.new(board.gridSize, board.gridSize)
    gfx.pushContext(img)
    gfx.drawRect(0, 0, board.gridSize, board.gridSize)
    gfx.popContext()
    self:setImage(img)
    self:moveTo(x, y)
    self:add()
end

function Cursor:update()
    Cursor.super.update(self)
    if pd.buttonJustPressed("up") then
        self:moveTo(self.x, self.y - self.size)
    end
    if pd.buttonJustPressed("down") then
        self:moveTo(self.x, self.y + self.size)
    end
    if pd.buttonJustPressed("left") then
        self:moveTo(self.x - self.size, self.y)
    end
    if pd.buttonJustPressed("right") then
        self:moveTo(self.x + self.size, self.y)
    end
    if pd.buttonJustPressed("a") then
        Tower(self.x, self.y, self.size, 50)
    end
    if pd.buttonJustPressed("b") then
        Mob(self.x, self.y, 10, 1)
    end
end

