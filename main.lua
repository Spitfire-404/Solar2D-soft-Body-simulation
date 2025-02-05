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

local testSpring = makeSpring({x = display.contentCenterX, y = display.contentCenterY-20}, {x = display.contentCenterX+1, y = display.contentCenterY+1}, 200,0.1,0)
local circle = display.newCircle(0, 0, 5)
local circle2 = display.newCircle(0, 0, 5)

local deleteIndex = 0
local deleteTable = {}

local oldPoint = { x = testSpring.points.p1.x, y = testSpring.points.p1.y }
local function update()
    updateSpring(testSpring)
    circle.x = testSpring.points.p1.x
    circle.y = testSpring.points.p1.y
    circle2.x = testSpring.points.p2.x
    circle2.y = testSpring.points.p2.y

    l = display.newLine(oldPoint.x,oldPoint.y,testSpring.points.p1.x,testSpring.points.p1.y)
    l:setStrokeColor(0.8,0,0)
    l.strokeWidth = mag2D(testSpring.velocities.p1)/14

    oldPoint.x = testSpring.points.p1.x
    oldPoint.y = testSpring.points.p1.y

    deleteTable[deleteIndex] = l
    deleteIndex = deleteIndex + 1

    if deleteIndex > 1000 then
    for i = 0, deleteIndex do
        display.remove( deleteTable[i])
    end
    deleteIndex = 0
    end
end
Runtime:addEventListener("enterFrame", update)


