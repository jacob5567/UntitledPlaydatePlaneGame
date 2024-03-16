-- player.lua
local pd <const> = playdate
local gfx <const> = pd.graphics

---@class Player
local Player = {}
Player.__index = Player

-- Constructor function
function Player.new(centerPoint)
    local self = setmetatable({}, Player)
    self.center = centerPoint or pd.geometry.point.new(200, 120)
    self.base = 15
    self.height = 15
    self.angle = 0
    self.speed = 2
    self.velocity = pd.geometry.vector2D.new(0, 0)
    self.maxVelocity = 30
    self.gravity = 0.5
    return self
end

function Player:draw(camera)
    if self.center == nil then
        print("self.center is nil")
        return
    end
    local crankPosition = pd.getCrankPosition()
    self.angle = crankPosition
    gfx.setColor(gfx.kColorBlack)
    -- gfx.fillTriangle(self.getTrianglePoints(self.center, self.base, self.height, math.rad(self.angle)))
    local globalSpaceTrianglePoints = self.getTrianglePoints(self.center, self.base, self.height, math.rad(self.angle))
    local trianglePoints = {}
    for i, point in ipairs(globalSpaceTrianglePoints) do
        trianglePoints[i] = camera:worldToScreen(point)
    end
    gfx.fillTriangle(trianglePoints[1].x, trianglePoints[1].y, trianglePoints[2].x, trianglePoints[2].y,
        trianglePoints[3].x, trianglePoints[3].y)
    gfx.setColor(gfx.kColorWhite)
    gfx.drawPixel(camera:worldToScreen(self.center))

    self:move(camera)
end

function Player:doGravity()
    self.velocity.y = self.velocity.y + self.gravity
end

function Player:accelerate()
    if (pd.buttonIsPressed(pd.kButtonB)) then
        self.velocity:addVector(pd.geometry.vector2D.newPolar(self.speed, self.angle))
    end
end

function Player:move(camera)
    -- if self.center.y > 240 then
    --     self.center.y = 0
    -- end
    -- if self.center.y < 0 then
    --     self.center.y = 240
    -- end
    -- if self.center.x > 400 then
    --     self.center.x = 0
    -- end
    -- if self.center.x < 0 then
    --     self.center.x = 400
    -- end
    if self.velocity:magnitude() > self.maxVelocity then
        self.velocity = self.velocity:normalized() * self.maxVelocity
    end
    self:doGravity()
    self:accelerate()
    self.center = self.center + self.velocity
    camera:move(self.velocity)
end

function Player.rotatePoint(px, py, ox, oy, angle)
    local cos_a = math.cos(angle)
    local sin_a = math.sin(angle)
    return pd.geometry.point.new(cos_a * (px - ox) - sin_a * (py - oy) + ox,
        sin_a * (px - ox) + cos_a * (py - oy) + oy)
end

function Player.getTrianglePoints(center, base, height, angle)
    local point1 = Player.rotatePoint(center.x, center.y - height, center.x, center.y, angle)
    local point2 = Player.rotatePoint(center.x - base / 2, center.y + height / 2, center.x, center.y, angle)
    local point3 = Player.rotatePoint(center.x + base / 2, center.y + height / 2, center.x, center.y, angle)
    return { point1, point2, point3 }
end

return Player
