import "tower"
import "mob"

local pd <const> = playdate
local gfx <const> = pd.graphics

class("Cursor").extends(gfx.sprite)

function Cursor:init(x, y, size)
    Cursor.super.init(self)
    self.size = size
    local img = gfx.image.new(size, size)
    gfx.pushContext(img)
    gfx.drawRect(0, 0, size, size)
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
        Tower(self.x, self.y, self.size, 5)
    end
    if pd.buttonJustPressed("b") then
        Mob(self.x, self.y, 10, 1)
    end
end

