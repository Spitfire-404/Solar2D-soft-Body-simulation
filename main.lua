-----------------------------------------------------------------------------------------
--
-- main.lua
--
-- This project is for personal learning purposes.
-- I aim to create a simple 2D soft body physics simulation with a UI using Corona SDK.
-- this may later be expaded to use 3D and/or expanded into a library.
-----------------------------------------------------------------------------------------
display.setStatusBar(display.HiddenStatusBar)
local background = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
background:setFillColor(0.5, 0.5, 0.5)

require("Springs")

local testSpring = makeSpring({x = display.contentCenterX, y = display.contentCenterY-20}, {x = display.contentCenterX+1, y = display.contentCenterY+1}, 100,0.2,0.9)
local circle = display.newCircle(0, 0, 5)
local circle2 = display.newCircle(0, 0, 5)

local deleteIndex = 0
local deleteTable = {}
local helpText = display.newText("drag to move the spring", display.contentCenterX, display.contentCenterY, native.systemFont, 16)
helpText:setFillColor(0, 0, 0)

local oldPoint = { x = testSpring.points.p1.x, y = testSpring.points.p1.y }
local function update()
    if deleteIndex > 0  then
        for i = 0, deleteIndex do
            display.remove( deleteTable[i])
        end
        deleteIndex = 0
    end
    updateSpring(testSpring)


    circle.x = testSpring.points.p1.x
    circle.y = testSpring.points.p1.y
    circle2.x = testSpring.points.p2.x
    circle2.y = testSpring.points.p2.y

    l = display.newLine(oldPoint.x,oldPoint.y,testSpring.points.p1.x,testSpring.points.p1.y)
    l:setStrokeColor(0.8,0,0)
    l.strokeWidth = mag2D(testSpring.velocities.p1)/14
    l:setStrokeColor(mag2D(testSpring.velocities.p1)/200,mag2D(testSpring.velocities.p1)/200,mag2D(testSpring.velocities.p1)/100)

    oldPoint.x = testSpring.points.p1.x
    oldPoint.y = testSpring.points.p1.y

    deleteTable[deleteIndex] = l
    deleteIndex = deleteIndex + 1

    
end
function onTap( event )
    helpText.text = ""
    testSpring.points.p2.x = event.x
    testSpring.points.p2.y = event.y
end
Runtime:addEventListener("touch", onTap)
Runtime:addEventListener("enterFrame", update)


