-- Main Playdate file
import "CoreLibs/graphics"
local Player = import "player"
local Area = import "area"
local Camera = import "camera"

local pd <const> = playdate
local gfx <const> = pd.graphics

local player = Player.new(pd.geometry.point.new(200, 120))
local area1 = Area.new(1000, 1000, "assets/simplecloud.png")
local camera = Camera.new(pd.geometry.point.new(0, 0), 1)

local pd <const> = playdate
local gfx <const> = pd.graphics

function pd.update()
    -- Update game state
    gfx.clear()
    player:draw(camera)
    area1:drawBackgroundElements(camera)
end
