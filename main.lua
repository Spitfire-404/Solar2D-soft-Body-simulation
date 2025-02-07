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

local testSpring  = makeSpring({x = display.contentCenterX, y = display.contentCenterY-20}, {x = display.contentCenterX+1,  y = display.contentCenterY+1}, 100,0.95,0.75)
local testSpring2 = makeSpring({x = display.contentCenterX, y = display.contentCenterY-20}, {x = display.contentCenterX+10, y = display.contentCenterY+1}, 141,0.95,0.75)
local testSpring3 = makeSpring({x = display.contentCenterX, y = display.contentCenterY-20}, {x = display.contentCenterX+30, y = display.contentCenterY+1}, 100,0.95,0.75)


local deleteIndex = 0
local deleteTable = {}
local helpText = display.newText("drag to move the spring", display.contentCenterX, display.contentCenterY, native.systemFont, 16)
helpText:setFillColor(0, 0, 0)



local fill = false
local oldPoint = { x = testSpring.points.p1.x, y = testSpring.points.p1.y }
local oldPoint2 = { x = testSpring2.points.p1.x, y = testSpring2.points.p1.y }
local oldPoint3 = { x = testSpring3.points.p1.x, y = testSpring3.points.p1.y }
local screenPressed = false
touch = {x = 0, y = 0}
local function update()
    if deleteIndex > 2 then
        for i = 0, deleteIndex do
            display.remove( deleteTable[i])
        end
        deleteIndex = 0
    end
    
    if screenPressed then
        testSpring.points.p2 = touch
        testSpring2.points.p2 = touch
        testSpring3.points.p2 = touch

    end


    
    --testSpring3.points.p2 = scaleVec2D(addVec2D(testSpring3.points.p2, testSpring2.points.p1), 0.5)
    --testSpring2.points.p2 = scaleVec2D(addVec2D(testSpring2.points.p2, testSpring.points.p1), 0.5)
    --testSpring.points.p2 = scaleVec2D(addVec2D(testSpring.points.p2, testSpring3.points.p1), 0.5)
    
    updateSpring(testSpring)
    updateSpring(testSpring2)
    updateSpring(testSpring3)

    testSpring3.points.p2 = scaleVec2D(addVec2D(testSpring3.points.p2, testSpring2.points.p1), 0.5)
    testSpring2.points.p2 = scaleVec2D(addVec2D(testSpring2.points.p2, testSpring.points.p1), 0.5)
    testSpring.points.p2 = scaleVec2D(addVec2D(testSpring.points.p2, testSpring3.points.p1), 0.5)
    
    --testSpring3.points.p2 = testSpring2.points.p1
    --testSpring2.points.p2 = testSpring.points.p1
    --testSpring.points.p2 = testSpring3.points.p1

    if fill then
        local div = 300

        l = display.newLine(oldPoint.x,oldPoint.y,testSpring.points.p1.x,testSpring.points.p1.y)
        l:setStrokeColor(0.8,0,0)
        l.strokeWidth = mag2D(testSpring.velocities.p1)/10
        if l.strokeWidth < 3 then
            l.strokeWidth = 3
        end
        l:setStrokeColor(mag2D(testSpring.velocities.p1)/2/div,mag2D(testSpring.velocities.p1)/2/div,mag2D(testSpring.velocities.p1)/1/div)

        l2 = display.newLine(oldPoint2.x,oldPoint2.y,testSpring2.points.p1.x,testSpring2.points.p1.y)
        l2:setStrokeColor(0.8,0,0)
        l2.strokeWidth = mag2D(testSpring2.velocities.p1)/10
        if l2.strokeWidth < 3 then
            l2.strokeWidth = 3
        end
        l2:setStrokeColor(mag2D(testSpring2.velocities.p1)/1/div,mag2D(testSpring2.velocities.p1)/2/div,mag2D(testSpring2.velocities.p1)/2/div)

        l3 = display.newLine(oldPoint3.x,oldPoint3.y,testSpring3.points.p1.x,testSpring3.points.p1.y)
        l3:setStrokeColor(0.8,0,0)
        l3.strokeWidth = mag2D(testSpring3.velocities.p1)/10
        if l3.strokeWidth < 3 then
            l3.strokeWidth = 3
        end
        l3:setStrokeColor(mag2D(testSpring3.velocities.p1)/2/div,mag2D(testSpring3.velocities.p1)/1/div,mag2D(testSpring3.velocities.p1)/2/div)

        deleteTable[deleteIndex] = l
        deleteIndex = deleteIndex + 1
        deleteTable[deleteIndex] = l2
        deleteIndex = deleteIndex + 1
        deleteTable[deleteIndex] = l3
        deleteIndex = deleteIndex + 1
    end

    oldPoint.x = testSpring.points.p1.x
    oldPoint.y = testSpring.points.p1.y

    oldPoint2.x = testSpring2.points.p1.x
    oldPoint2.y = testSpring2.points.p1.y

    oldPoint3.x = testSpring3.points.p1.x
    oldPoint3.y = testSpring3.points.p1.y


    testSpring2.line:removeSelf()
    testSpring2.line = display.newLine(testSpring2.points.p2.x, testSpring2.points.p2.y, testSpring.points.p2.x, testSpring.points.p2.y)
    testSpring2.line.strokeWidth = 5
    testSpring2.line:setStrokeColor(0.8,0.8,0.8)

    testSpring3.line:removeSelf()
    testSpring3.line = display.newLine(testSpring3.points.p2.x, testSpring3.points.p2.y, testSpring2.points.p2.x, testSpring2.points.p2.y)
    testSpring3.line.strokeWidth = 5
    testSpring3.line:setStrokeColor(0.8,0.8,0.8)

    testSpring.line:removeSelf()
    testSpring.line = display.newLine(testSpring.points.p2.x, testSpring.points.p2.y, testSpring3.points.p2.x, testSpring3.points.p2.y)
    testSpring.line.strokeWidth = 5
    testSpring.line:setStrokeColor(0.8,0.8,0.8)


    
end

function onTap( event )
    touch = {x = event.x, y = event.y}
    if event.phase == "began" then
        screenPressed = true
    elseif event.phase == "ended" then
        screenPressed = false
    end
    fill = true
    helpText.text = ""
end

Runtime:addEventListener("touch", onTap)
Runtime:addEventListener("enterFrame", update)


