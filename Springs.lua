-- this is a heder file for physics of a soft body, specifically springs
require("VecMath")

-- template spring table
local Spring =
{
    points = {
        p1 = {x = 0, y = 0},
        p2 = {x = 0, y = 0}
    },
    strength = 0,
    length = 0,
    damping = 0,

    init = function(Spring, p1, p2, strength, length, damping)
        Spring.points.p1 = p1
        Spring.points.p2 = p2
        Spring.strength = strength
        Spring.length = length
        Spring.damping = damping
    end

}
function makeSpring(p1, p2, strength, length, damping)
    local s = Spring
    s:init(p1, p2, strength, length, damping)
    return s
end

function updateSpring(Spring)
    local velocity = scaleVec2D(scaleVec2D(subVec2D(addVec2D(Spring.points.p1,(scaleVec2D((subVec2D(Spring.points.p2,Spring.points.p1)),0.5))),Spring.points.p1),(dist2D(Spring.points.p2,Spring.points.p1)-Spring.length)),Spring.strength)
    Spring.points.p1 = addVec2D(Spring.points.p1,velocity)
end

