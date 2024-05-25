import "tags"

local pd <const> = playdate
local gfx <const> = pd.graphics

class("Tower").extends(gfx.sprite)

function Tower:init(x, y, size, range)
    Tower.super.init(self)
    self.size = size
    self.range = range
    local img = gfx.image.new(size, size)
    gfx.pushContext(img)
    gfx.drawCircleAtPoint(size//2, size//2, size//4)
    gfx.popContext()
    self:setImage(img)
    self:moveTo(x, y)
    self:add()
    self.towerTurret = TowerTurret(self)
end

class("TowerTurret").extends(gfx.sprite)

function TowerTurret:init(towerBase)
    TowerTurret.super.init(self)
    self.size = towerBase.size
    self.angle = 0
    local img = gfx.image.new(self.size, self.size)
    gfx.pushContext(img)
    gfx.drawRect(self.size//2 - self.size//10, self.size//2 - self.size//2, self.size//5, self.size//4)
    gfx.popContext()
    self:setImage(img)
    self:moveTo(towerBase.x, towerBase.y)
    self:add()
end

function TowerTurret:update()
    -- find closest enemy
    -- gfx.sprite.getAllSprites()
    for _, sprite in ipairs(gfx.sprite.getAllSprites()) do
        if sprite:getTag() == TAGS.mob then
            
        end
    end
end

