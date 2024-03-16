-- Main Playdate file
import "CoreLibs/graphics"
local Player = import "player"
local Area = import "area"

local pd <const> = playdate
local gfx <const> = pd.graphics

local player = Player:new()
local area1 = Area:new(400, 240, "assets/simplecloud.png")

local pd <const> = playdate
local gfx <const> = pd.graphics

function pd.update()
    -- Update game state
    gfx.clear()
    player:draw()
    area1:drawBackgroundElements()
end
