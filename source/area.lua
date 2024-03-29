-- player.lua
local pd <const> = playdate
local gfx <const> = pd.graphics

---@class Area
local Area = {}
Area.__index = Area

-- Constructor function
function Area.new(width, height, backgroundImage)
    local self = setmetatable({}, Area)
    self.width = width
    self.height = height
    self.backgroundImage = gfx.image.new(backgroundImage)
    self.imageLocations = self:randomlyGenerateBackgroundElements()
    return self
end

function Area:drawBackgroundElements(camera)
    for i, location in ipairs(self.imageLocations) do
        -- Only draw the background element if it's visible
        if camera:isPointVisible(location) then
            local screenLocation = camera:worldToScreen(location)
            self.backgroundImage:draw(screenLocation)
        end
    end
end

function Area:randomlyGenerateBackgroundElements()
    local locations = {}
    for i = 1, 100 do
        local x = math.random(0, self.width)
        local y = math.random(0, self.height)
        table.insert(locations, pd.geometry.point.new(x, y))
    end
    return locations
end

return Area