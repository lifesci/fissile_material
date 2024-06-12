import "tower"
import "mob"
import "constants"

local pd <const> = playdate
local gfx <const> = pd.graphics

class("Cursor").extends(gfx.sprite)

function Cursor:init(x, y, board)
    Cursor.super.init(self)
    self.boardX = x
    self.boardY = y
    self.board = board
    local img = gfx.image.new(board.gridSize, board.gridSize)
    gfx.pushContext(img)
    gfx.drawRect(0, 0, board.gridSize, board.gridSize)
    gfx.popContext()
    self:setImage(img)
    self:setTag(TAGS.cursor)
    local xPos, yPos = self.board:getPosition(x, y)
    self:moveTo(xPos, yPos)
    self:add()
end

function Cursor:update()
    Cursor.super.update(self)
    if pd.buttonJustPressed("up") then
        self.boardY -= 1
        self:move()
    end
    if pd.buttonJustPressed("down") then
        self.boardY += 1
        self:move()
    end
    if pd.buttonJustPressed("left") then
        self.boardX -= 1
        self:move()
    end
    if pd.buttonJustPressed("right") then
        self.boardX += 1
        self:move()
    end
    if pd.buttonJustPressed("a") then
        Tower(self.x, self.y, self.board.gridSize, 50)
    end
    if pd.buttonJustPressed("b") then
        Mob(self.x, self.y, 10, 1)
    end
end

function Cursor:move()
    local buffer = self.board.gridSize/2
    local left, right, top, bottom = self.board:getBoundaries()
    local x, y = self.board:getPosition(self.boardX, self.boardY)
    if x + buffer > right then
        self.board:moveRight()
    elseif x - buffer < left then
        self.board:moveLeft()
    elseif y + buffer > bottom then
        self.board:moveDown()
    elseif y - buffer < top then
        self.board:moveUp()
    else
        self:moveTo(x, y)
    end
end

