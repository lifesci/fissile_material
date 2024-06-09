import "constants"
import "projectiles/bullet"
import "CoreLibs/frameTimer"

local pd <const> = playdate
local gfx <const> = pd.graphics

class("Base").extends(gfx.sprite)

function Base:init(x, y)
    Base.super.init(self)
    self.size = 40
    self.health = 500
    local img = gfx.image.new(self.size, self.size)
    gfx.pushContext(img)
    gfx.drawRect(0, 0, self.size, self.size)
    gfx.popContext()
    self:setImage(img)
    self:moveTo(x, y)
    self:setCollideRect(0, 0, self:getSize())
    self:setGroups(COLLISION_GROUPS.base)
    self:add()
end
