import "constants"

local pd <const> = playdate
local gfx <const> = pd.graphics

class("Mob").extends(gfx.sprite)

function Mob:init(x, y, size, speed)
    self.speed = speed
    Mob.super.init(self)
    self:setTag(TAGS.mob)
    self.hp = 50
    local img = gfx.image.new(size, size)
    gfx.pushContext(img)
    gfx.drawRect(0, 0, size, size)
    gfx.popContext()
    self:setImage(img)
    self:moveTo(x, y)
    self:setGroups(COLLISION_GROUPS.mob)
    self:setCollidesWithGroups({
        COLLISION_GROUPS.tower,
        COLLISION_GROUPS.base
    })
    self:setCollideRect(0, 0, self:getSize())
    self:add()
end

function Mob:update()
    Mob.super.update(self)
    if self:isDead() then
        self:remove()
        return
    end
    local centerX = 200
    local centerY = 120
    local dx = centerX - self.x
    local dy = centerY - self.y
    local mag = math.sqrt(dx^2 + dy^2)
    local targetX = self.x + dx/mag*self.speed
    local targetY = self.y + dy/mag*self.speed
    if mag >= 1 then
        local actualX, actualY, collisions, numCollisions = self:moveWithCollisions(
            targetX,
            targetY
        )
    end
end

function Mob:takeDamage(damage)
    self.hp = self.hp - damage
end

function Mob:isDead()
    return self.hp <= 0
end

function Mob:collisionResponse(other)
    return gfx.sprite.kCollisionTypeSlide
end
