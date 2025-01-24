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

    init = function(self, p1, p2, strength, length, damping)
        self.points.p1 = p1
        self.points.p2 = p2
        self.strength = strength
        self.length = length
        self.damping = damping
    end,


    update = function(self)
        -- todo: update vertex positions based on spring forces?
        if dist2D(self.points.p1, self.points.p2) > self.length then
            local force = subVec2D(self.points.p1, self.points.p2)
            force = norm2D(force)
            force = scaleVec2D(force, self.strength * (dist2D(self.points.p1, self.points.p2) - self.length))
            force = subVec2D(force, scaleVec2D(self.points.p1, self.damping))
            force = subVec2D(force, scaleVec2D(self.points.p2, self.damping))
            self.points.p1 = addVec2D(self.points.p1, force)
            self.points.p2 = subVec2D(self.points.p2, force)
        end
    end
}
function makeSpring(p1, p2, strength, length, damping)
    local s = Spring
    s:init(p1, p2, strength, length, damping)
    return s
end

