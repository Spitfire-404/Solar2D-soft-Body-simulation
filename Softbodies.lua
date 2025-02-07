-- softbodie file
require("Springs")

function makeSoftbody(points, center, mass)
    local softbody = {
        points = {},
        springs = {},
        lengths = {},

        center = makeVec2D(0,0),
        mass = 0
    }
    softbody.points = points
    softbody.center = center
    softbody.mass = mass
    
    for i = 1, #points -1 do
        softbody.springs[i] = makeSpring(points[i], points[i+1], dist2D(points[i], points[i+1]), 0.8, 0.5)
    end
    softbody.springs[#points] = makeSpring(points[#points], points[1], dist2D(points[#points], points[1]), 0.8, 0.5)

    --for e = 1, #softbody.springs do
    --    softbody.springs[#softbody.springs+e-1] = makeSpring(softbody.center, softbody.springs[(e)].points.p2, 100, 0.8, 0.5)
    --    
    --    --softbody.lengths[i] = dist2D(softbody.springs[i].points.p1, softbody.springs[i].points.p2)
    --end

    return softbody
    
end

function updateSoftbody(softbody)
    for i = 1, #softbody.springs -1 do
        updateSpring(softbody.springs[i])

        softbody.springs[(i)].points.p2 = softbody.springs[(i+1)].points.p1 
        --display.newCircle(softbody.springs[(i)].points.p2.x, softbody.springs[(i)].points.p2.y, 5)
    end
    updateSpring(softbody.springs[#softbody.springs])
    softbody.springs[#softbody.springs].points.p2 = softbody.springs[1].points.p1
end

