-- Main Playdate file
import "CoreLibs/graphics"
local Player = import "player"

local pd <const> = playdate
local gfx <const> = pd.graphics

local player = Player:new()

local pd <const> = playdate
local gfx <const> = pd.graphics

function pd.update()
    -- Update game state
    gfx.clear()
    player:draw()
end
