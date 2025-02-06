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

local testSpring = makeSpring({x = display.contentCenterX, y = display.contentCenterY-20}, {x = display.contentCenterX+1, y = display.contentCenterY+1}, 100,0.3,0.9)
local testSpring2 = makeSpring({x = display.contentCenterX, y = display.contentCenterY-20}, {x = display.contentCenterX+1, y = display.contentCenterY+1}, 200,0.2,0.9)
local circle = display.newCircle(0, 0, 5)
local circle2 = display.newCircle(0, 0, 5)
local circle3 = display.newCircle(0, 0, 5)
local circle4 = display.newCircle(0, 0, 5)

local deleteIndex = 0
local deleteTable = {}
local helpText = display.newText("drag to move the spring", display.contentCenterX, display.contentCenterY, native.systemFont, 16)
helpText:setFillColor(0, 0, 0)



local fill = false
local oldPoint = { x = testSpring.points.p1.x, y = testSpring.points.p1.y }
local oldPoint2 = { x = testSpring2.points.p1.x, y = testSpring2.points.p1.y }
local function update()
    if deleteIndex > 0 and false then
        for i = 0, deleteIndex do
            display.remove( deleteTable[i])
        end
        deleteIndex = 0
    end
    updateSpring(testSpring)
    updateSpring(testSpring2)
    
    testSpring2.points.p2.x = testSpring.points.p1.x
    testSpring2.points.p2.y = testSpring.points.p1.y


    circle.x = testSpring.points.p1.x
    circle.y = testSpring.points.p1.y
    circle2.x = testSpring.points.p2.x
    circle2.y = testSpring.points.p2.y
    circle3.x = testSpring2.points.p2.x
    circle3.y = testSpring2.points.p2.y
    circle4.x = testSpring2.points.p1.x
    circle4.y = testSpring2.points.p1.y

    if fill then
        l = display.newLine(oldPoint.x,oldPoint.y,testSpring.points.p1.x,testSpring.points.p1.y)
        l:setStrokeColor(0.8,0,0)
        l.strokeWidth = mag2D(testSpring.velocities.p1)/14
        if l.strokeWidth < 3 then
            l.strokeWidth = 3
        end
        l:setStrokeColor(mag2D(testSpring.velocities.p1)/200,mag2D(testSpring.velocities.p1)/200,mag2D(testSpring.velocities.p1)/100)

        l2 = display.newLine(oldPoint2.x,oldPoint2.y,testSpring2.points.p1.x,testSpring2.points.p1.y)
        l2:setStrokeColor(0.8,0,0)
        l2.strokeWidth = mag2D(testSpring.velocities.p1)/10
        if l2.strokeWidth < 3 then
            l2.strokeWidth = 3
        end
        l2:setStrokeColor(mag2D(testSpring.velocities.p1)/100,mag2D(testSpring.velocities.p1)/200,mag2D(testSpring.velocities.p1)/200)
    end

    oldPoint.x = testSpring.points.p1.x
    oldPoint.y = testSpring.points.p1.y

    oldPoint2.x = testSpring2.points.p1.x
    oldPoint2.y = testSpring2.points.p1.y

    deleteTable[deleteIndex] = l
    deleteIndex = deleteIndex + 1

    
end
function onTap( event )
    fill = true
    helpText.text = ""
    testSpring.points.p2.x = event.x
    testSpring.points.p2.y = event.y
end
Runtime:addEventListener("touch", onTap)
Runtime:addEventListener("enterFrame", update)


