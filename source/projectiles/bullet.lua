import "constants"

local pd <const> = playdate
local gfx <const> = pd.graphics

class("Bullet").extends(gfx.sprite)

function Bullet:init(towerTurret)
    Bullet.super.init(self)
    self.speed = 5
    self.damage = 10
    self.angle = towerTurret:getRotation()
    self.vector = pd.geometry.vector2D.newPolar(self.speed, self.angle)
    local img = gfx.image.new(2, 2)
    gfx.pushContext(img)
    gfx.drawRect(0, 0, 2, 2)
    gfx.popContext()
    self:setImage(img)
    self:moveTo(towerTurret.x, towerTurret.y)
    self:setGroups(COLLISION_GROUPS.towerProjectile)
    self:setCollidesWithGroups(COLLISION_GROUPS.mob)
    self:setCollideRect(0, 0, self:getSize())
    self:add()
end

function Bullet:update()
    local targetX = self.x + self.vector.x
    local targetY = self.y + self.vector.y
    local actualX, actualY, collisions, numCollisions = self:moveWithCollisions(
        targetX,
        targetY
    )
    if numCollisions > 0 then
        local hit = collisions[1]
        hit.other:takeDamage(self.damage)
        self:remove()
    end
end

function Bullet:collisionResponse(other)
    return gfx.sprite.kCollisionTypeOverlap
end
