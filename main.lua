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

require("softbodies")

local test = makeSoftbody({
    {x=100, y=100},
    {x=300, y=100},
    {x=200, y=200},
    {x=100, y=200}
}, {x=200, y=200}, 1)



local deleteIndex = 0
local deleteTable = {}
local helpText = display.newText("drag to move the spring", display.contentCenterX, display.contentCenterY, native.systemFont, 16)
helpText:setFillColor(0, 0, 0)



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
        test.center = touch
    end

    updateSoftbody(test)
    
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


