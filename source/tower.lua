import "constants"
import "projectiles/bullet"
import "CoreLibs/frameTimer"

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
    self.range = towerBase.range
    self.rotationSpeed = 5
    self.fireRate = 10
    local img = gfx.image.new(self.size, self.size)
    gfx.pushContext(img)
    gfx.drawRect(
        self.size//2 - self.size//10,
        self.size//2 - self.size//2,
        self.size//5,
        self.size//4
    )
    gfx.popContext()
    self:setImage(img)
    self:moveTo(towerBase.x, towerBase.y)
    self:setRotation(0)
    self:add()
    pd.frameTimer.performAfterDelay(self.fireRate, function () self:fire() end)
end

function TowerTurret:fire()
    Bullet(self)
    pd.frameTimer.performAfterDelay(self.fireRate, function () self:fire() end)
end

function TowerTurret:update()
    -- find closest enemy
    -- gfx.sprite.getAllSprites()
    local closestEnemy = nil
    local closestDistance = nil
    for _, sprite in ipairs(gfx.sprite.getAllSprites()) do
        if sprite:getTag() == TAGS.mob then
            local dSquared = pd.geometry.squaredDistanceToPoint(self.x, self.y, sprite.x, sprite.y)
            if closestDistance == nil or dSquared < closestDistance then
                closestDistance = dSquared
                closestEnemy = sprite
            end
        end
    end
    if closestEnemy ~= nil and pd.geometry.distanceToPoint(self.x, self.y, closestEnemy.x, closestEnemy.y) <= self.range then
        -- rotate toward enemy
        local curAngle = self:getRotation()
        local curVec = pd.geometry.vector2D.newPolar(1, curAngle)
        local targetVec = pd.geometry.vector2D.new(closestEnemy.x - self.x, closestEnemy.y - self.y)
        local targetAngle = curVec:angleBetween(targetVec)
        local dr = math.min(math.abs(self.rotationSpeed), math.abs(targetAngle))
        if targetAngle < 0 then
            dr = -dr
        end
        self:setRotation(curAngle + dr)
    end
end

