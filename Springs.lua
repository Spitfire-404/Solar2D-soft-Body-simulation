-- this is a heder file for physics of a soft body, specifically springs
require("vecMath")

-- hooke's law
-- F = -kx

-- F = Force
-- k = stiffness
-- x = displacement from origional length


function makeSpring(p1, p2, length, strength, damping, airResistance)
    local s =
    {
        points = {
            p1 = {x = 0, y = 0},
            p2 = {x = 0, y = 0}
        },
        velocities = {
            p1 = {x = 0, y = 0},
            p2 = {x = 0, y = 0}
        },
        mass = {
            p1 = 1,
            p2 = 1
        },
        line = display.newLine(0,0,0,0),
        
        length = 0,
        strength = 0,
        damping = 0,

        update1 = true,
        update2 = true
    
    }
    s.points.p1 = p1
    s.points.p2 = p2
    s.strength = strength
    s.length = length
    s.damping = damping
    s.line = display.newLine(p1.x, p1.y, p2.x, p2.y)
    return s
end

function updateSpring(Spring)
    
    local force1 = scaleVec2D(scaleVec2D(normVec2D(subVec2D(Spring.points.p1, Spring.points.p2)),1), -Spring.strength*(dist2D(Spring.points.p1, Spring.points.p2)-Spring.length))
    Spring.velocities.p1 = addVec2D(Spring.velocities.p1,force1) 
    Spring.velocities.p1 = scaleVec2D(Spring.velocities.p1, Spring.damping)
    
    local force2 = scaleVec2D(scaleVec2D(normVec2D(subVec2D(Spring.points.p2, Spring.points.p1)),1), -Spring.strength*(dist2D(Spring.points.p2, Spring.points.p1)-Spring.length))
    Spring.velocities.p2 = addVec2D(Spring.velocities.p2, force2)
    Spring.velocities.p2 = scaleVec2D(Spring.velocities.p2, Spring.damping)

    
    if Spring.update1 then Spring.points.p1 = addVec2D(Spring.points.p1, Spring.velocities.p1) end
    if Spring.update2 then Spring.points.p2 = addVec2D(Spring.points.p2, Spring.velocities.p2) end

    Spring.line:removeSelf()
    Spring.line = display.newLine(Spring.points.p1.x, Spring.points.p1.y, Spring.points.p2.x, Spring.points.p2.y)
    Spring.line.strokeWidth = 5
    Spring.line:setStrokeColor(0.8,0.8,0.8)
end

