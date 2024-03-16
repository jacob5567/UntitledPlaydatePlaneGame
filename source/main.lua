-- Main Playdate file
import "CoreLibs/graphics"
local Player = import "player"
local Area = import "area"

local pd <const> = playdate
local gfx <const> = pd.graphics

local player = Player.new(120, 200)
local area1 = Area.new(1000, 1000, "assets/simplecloud.png")

local pd <const> = playdate
local gfx <const> = pd.graphics

function pd.update()
    -- Update game state
    gfx.clear()
    player:draw()
    area1:drawBackgroundElements()
end
