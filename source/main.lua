-- Main Playdate file
import "CoreLibs/graphics"

local pd <const> = playdate
local gfx <const> = pd.graphics

local playerCenter = pd.geometry.point.new(200, 120)
local playerBase = 15
local playerHeight = 15
local playerAngle = 0
local playerSpeed = 3

function drawPlayer()
    if playerCenter == nil then
        print("playerCenter is nil")
        return
    end
    playerAngle = math.rad(pd.getCrankPosition())
    gfx.setColor(gfx.kColorBlack)
    gfx.fillTriangle(getTrianglePoints(playerCenter.x, playerCenter.y, playerBase, playerHeight, playerAngle))
    gfx.setColor(gfx.kColorWhite)
    gfx.drawPixel(playerCenter.x, playerCenter.y)
end

function rotatePoint(px, py, ox, oy, a)
    local cos_a = math.cos(a)
    local sin_a = math.sin(a)
    return cos_a * (px - ox) - sin_a * (py - oy) + ox,
           sin_a * (px - ox) + cos_a * (py - oy) + oy
end

function getTrianglePoints(cx, cy, b, h, a)
    local x1, y1 = rotatePoint(cx, cy - h, cx, cy, a)
    local x2, y2 = rotatePoint(cx - b / 2, cy + h / 2, cx, cy, a)
    local x3, y3 = rotatePoint(cx + b / 2, cy + h / 2, cx, cy, a)
    return x1, y1, x2, y2, x3, y3
end

function pd.update()
    -- Update game state
    gfx.clear()
    drawPlayer()
end