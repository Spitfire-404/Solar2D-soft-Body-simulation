-- this is a header file with many functions for vector math in 2D

-- this is a template vector table
local Vec2D = {
    x = 0,
    y = 0
}

function makeVec2D(x, y)
    local v = Vec2D
    v.x = x
    v.y = y
    return v
end

function addVec2D(v1, v2)
    return makeVec2D(v1.x + v2.x, v1.y + v2.y)
end

function subVec2D(v1, v2)
    return makeVec2D(v1.x - v2.x, v1.y - v2.y)
end

function multVec2D(v1, v2)
    return makeVec2D(v1.x * v2.x, v1.y * v2.y)
end

function divVec2D(v1, v2)
    return makeVec2D(v1.x / v2.x, v1.y / v2.y)
end

function scaleVec2D(v, s)
    return makeVec2D(v.x * s, v.y * s)
end

function dot2D(v1, v2)
    return v1.x * v2.x + v1.y * v2.y
end

function cross2D(v1, v2)
    return v1.x * v2.y - v1.y * v2.x
end

function mag2D(v)
    return math.sqrt(v.x * v.x + v.y * v.y)
end

function norm2D(v)
    local m = mag2D(v)
    return makeVec2D(v.x / m, v.y / m)
end

function dist2D(v1, v2)
    return mag2D(subVec2D(v1, v2))
end

function angle2D(v1, v2)
    return math.acos(dot2D(v1, v2) / (mag2D(v1) * mag2D(v2)))
end



