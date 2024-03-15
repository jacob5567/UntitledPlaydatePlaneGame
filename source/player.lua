-- player.lua
local pd <const> = playdate
local gfx <const> = pd.graphics

---@class Player
local Player = {}

function Player:new(o)
    o = o or {
        center = pd.geometry.point.new(200, 120),
        base = 15,
        height = 15,
        angle = 0,
        speed = 2,
        velocity = pd.geometry.vector2D.new(0, 0),
        maxVelocity = 30,
        gravity = 0.5
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

function Player:draw()
    if self.center == nil then
        print("self.center is nil")
        return
    end
    local crankPosition = pd.getCrankPosition()
    self.angle = crankPosition
    gfx.setColor(gfx.kColorBlack)
    gfx.fillTriangle(self.getTrianglePoints(self.center.x, self.center.y, self.base, self.height, math.rad(self.angle)))
    gfx.setColor(gfx.kColorWhite)
    gfx.drawPixel(self.center.x, self.center.y)

    self:move()
end

function Player:doGravity()
    self.velocity.y = self.velocity.y + self.gravity
end

function Player:accelerate()
    if (pd.buttonIsPressed(pd.kButtonB)) then
        self.velocity:addVector(pd.geometry.vector2D.newPolar(self.speed, self.angle))
    end
end

function Player:move()
    if self.center.y > 240 then
        self.center.y = 0
    end
    if self.center.y < 0 then
        self.center.y = 240
    end
    if self.center.x > 400 then
        self.center.x = 0
    end
    if self.center.x < 0 then
        self.center.x = 400
    end
    if self.velocity:magnitude() > self.maxVelocity then
        self.velocity = self.velocity:normalized() * self.maxVelocity
    end
    self:doGravity()
    self:accelerate()
    self.center = self.center + self.velocity
end

function Player.rotatePoint(px, py, ox, oy, a)
    local cos_a = math.cos(a)
    local sin_a = math.sin(a)
    return cos_a * (px - ox) - sin_a * (py - oy) + ox,
        sin_a * (px - ox) + cos_a * (py - oy) + oy
end

function Player.getTrianglePoints(cx, cy, b, h, a)
    local x1, y1 = Player.rotatePoint(cx, cy - h, cx, cy, a)
    local x2, y2 = Player.rotatePoint(cx - b / 2, cy + h / 2, cx, cy, a)
    local x3, y3 = Player.rotatePoint(cx + b / 2, cy + h / 2, cx, cy, a)
    return x1, y1, x2, y2, x3, y3
end

return Player
