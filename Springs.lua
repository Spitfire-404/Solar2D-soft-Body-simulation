-- this is a heder file for physics of a soft body, specifically springs
require("vecMath")

-- hooke's law
-- F = -kx

-- F = Force
-- k = stiffness
-- x = displacement from origional length


-- template spring table
local Spring =
{
    points = {
        p1 = {x = 0, y = 0},
        p2 = {x = 0, y = 0}
    },
    length = 0,
    strength = 0,
    damping = 0,

    init = function(Spring, p1, p2, strength, length, damping)
        Spring.points.p1 = p1
        Spring.points.p2 = p2
        Spring.strength = strength
        Spring.length = length
        Spring.damping = damping
    end

}
function makeSpring(p1, p2, length, strength, damping)
    local s = Spring
    s:init(p1, p2, strength, length, damping)
    return s
end

function updateSpring(Spring)
    --Spring.points.p1.y = Spring.points.p1.y + 9.8
    
    local force1 = scaleVec2D(normVec2D(subVec2D(Spring.points.p1, Spring.points.p2)), -Spring.strength*(dist2D(Spring.points.p1, Spring.points.p2)-Spring.length))
    Spring.points.p1 = addVec2D(Spring.points.p1,force1) 
end

