-- player.lua
local pd <const> = playdate
local gfx <const> = pd.graphics

local player = {
    center = pd.geometry.point.new(200, 120),
    base = 15,
    height = 15,
    angle = 0
}

function player.draw()
    if player.center == nil then
        print("player.center is nil")
        return
    end
    local crankPosition = pd.getCrankPosition()
    player.angle = crankPosition and math.rad(crankPosition) or 0
    gfx.setColor(gfx.kColorBlack)
    gfx.fillTriangle(player.getTrianglePoints(player.center.x, player.center.y, player.base, player.height, player.angle))
    gfx.setColor(gfx.kColorWhite)
    gfx.drawPixel(player.center.x, player.center.y)
end

function player.rotatePoint(px, py, ox, oy, a)
    local cos_a = math.cos(a)
    local sin_a = math.sin(a)
    return cos_a * (px - ox) - sin_a * (py - oy) + ox,
        sin_a * (px - ox) + cos_a * (py - oy) + oy
end

function player.getTrianglePoints(cx, cy, b, h, a)
    local x1, y1 = player.rotatePoint(cx, cy - h, cx, cy, a)
    local x2, y2 = player.rotatePoint(cx - b / 2, cy + h / 2, cx, cy, a)
    local x3, y3 = player.rotatePoint(cx + b / 2, cy + h / 2, cx, cy, a)
    return x1, y1, x2, y2, x3, y3
end

return player
