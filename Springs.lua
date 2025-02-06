-- this is a heder file for physics of a soft body, specifically springs
require("vecMath")

-- hooke's law
-- F = -kx

-- F = Force
-- k = stiffness
-- x = displacement from origional length


function makeSpring(p1, p2, length, strength, damping)
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
    
        length = 0,
        strength = 0,
        damping = 0,
        gravity = 2,

        update1 = true,
        update2 = true
    
    }
    s.points.p1 = p1
    s.points.p2 = p2
    s.strength = strength
    s.length = length
    s.damping = damping
    return s
end

function updateSpring(Spring)
    
    local grav = scaleVec2D(makeVec2D(0,1),Spring.gravity)
    local force1 = scaleVec2D(normVec2D(subVec2D(Spring.points.p1, Spring.points.p2)), -Spring.strength*(dist2D(Spring.points.p1, Spring.points.p2)-Spring.length))
    Spring.velocities.p1 = addVec2D(Spring.velocities.p1,force1) 
    Spring.velocities.p1 = scaleVec2D(Spring.velocities.p1, Spring.damping)
    --Spring.velocities.p1 = addVec2D(Spring.velocities.p1, grav)

    
    local force2 = scaleVec2D(normVec2D(subVec2D(Spring.points.p2, Spring.points.p1)), -Spring.strength*(dist2D(Spring.points.p2, Spring.points.p1)-Spring.length))
    Spring.velocities.p2 = addVec2D(Spring.velocities.p2, force2)
    Spring.velocities.p2 = scaleVec2D(Spring.velocities.p2, Spring.damping)
    --Spring.velocities.p2 = addVec2D(Spring.velocities.p2, grav)

    
    if Spring.update1 then Spring.points.p1 = addVec2D(Spring.points.p1, Spring.velocities.p1) end
    if Spring.update2 then Spring.points.p2 = addVec2D(Spring.points.p2, Spring.velocities.p2) end
end

