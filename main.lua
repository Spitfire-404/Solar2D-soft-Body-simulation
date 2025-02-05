-----------------------------------------------------------------------------------------
--
-- main.lua
--
-- This project is for personal learning purposes.
-- I aim to create a simple 2D soft body physics simulation with a UI using Corona SDK.
-- this may later be expaded to use 3D and/or expanded into a library.
-----------------------------------------------------------------------------------------
Gravity = 9.8
display.setStatusBar(display.HiddenStatusBar)
local background = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
background:setFillColor(0.5, 0.5, 0.5)

require("Springs")

local testSpring = makeSpring({x = display.contentCenterX, y = display.contentCenterY}, {x = display.contentCenterX+20, y = display.contentCenterY+1}, 500,0.1,0)
local circle = display.newCircle(0, 0, 5)
local circle2 = display.newCircle(0, 0, 5)

local function update()
updateSpring(testSpring)
circle.x = testSpring.points.p1.x
circle.y = testSpring.points.p1.y
circle2.x = testSpring.points.p2.x
circle2.y = testSpring.points.p2.y

end
Runtime:addEventListener("enterFrame", update)


