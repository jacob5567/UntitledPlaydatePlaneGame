-- camera.lua
local pd <const> = playdate

-- Define the Camera class
local Camera = {}
Camera.__index = Camera

-- Constructor function
function Camera.new(startingPoint)
    local self = setmetatable({}, Camera)
    self.location = startingPoint or pd.geometry.point.new(0, 0)
    self.height = 240
    self.width = 400
    return self
end

-- Translate a point from world coordinates to screen coordinates
function Camera:worldToScreen(point)
    local screenX = point.x - self.location.x
    local screenY = point.y - self.location.y
    return pd.geometry.point.new(screenX, screenY)
end

-- Translate a point from screen coordinates to world coordinates
function Camera:screenToWorld(screenPoint)
    local x = screenPoint.x + self.location.x
    local y = screenPoint.y + self.location.y
    return pd.geometry.point.new(x, y)
end

-- Check if a point is visible on the screen
function Camera:isPointVisible(point)
    local screenPoint = self:worldToScreen(point)
    return screenPoint.x >= 0 and screenPoint.x <= self.width and screenPoint.y >= 0 and screenPoint.y <= self.height
end

-- Move the camera by a given amount (delta should be a pd.geometry.vector2D)
function Camera:move(delta)
    self.location = self.location + delta
end

return Camera
