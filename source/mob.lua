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
    if mag >= 1 then
        self:moveTo(self.x + dx/mag*self.speed, self.y + dy/mag*self.speed)
    end
end

function Mob:takeDamage(damage)
    self.hp = self.hp - damage
end

function Mob:isDead()
    return self.hp <= 0
end
