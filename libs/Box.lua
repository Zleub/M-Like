--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  M-Like:Box
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-12-01 03:38:03
-- :ddddddddddhyyddddddddddd: Modified: 2015-12-01 08:57:21
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local Box = {}

function Box.FromCenter(point, size)
	return {
		center = point,
		A = Point.new(point.x - size.x, point.y - size.y),
		B = Point.new(point.x + size.x, point.y - size.y),
		C = Point.new(point.x + size.x, point.y + size.y),
		D = Point.new(point.x - size.x, point.y + size.y)
	}
end

function Box.FromCorner(point, size)
	return {
		center = Point.new(point.x + size.x / 2, point.y + size.y / 2),
		A = Point.new(point.x, point.y),
		B = Point.new(point.x + size.x, point.y),
		C = Point.new(point.x + size.x, point.y + size.y),
		D = Point.new(point.x, point.y + size.y)
	}
end

function Box.get_collision(corner, values)
	return Point.new(
		values.x - corner.x,
		values.y - corner.y
	)
end

function Box.collides(EntityBox, MeshBox)
	if EntityBox.center.x - MeshBox.center.x < 0 and
	EntityBox.center.y - MeshBox.center.y < 0 then
		return Box.get_collision(MeshBox.A, EntityBox.C)
	elseif EntityBox.center.x - MeshBox.center.x > 0 and
	EntityBox.center.y - MeshBox.center.y < 0 then
		return Box.get_collision(Point.new(EntityBox.D.x, MeshBox.B.y), Point.new(MeshBox.B.x, EntityBox.D.y))
	elseif EntityBox.center.x - MeshBox.center.x < 0 and
	EntityBox.center.y - MeshBox.center.y > 0 then
		return Box.get_collision(Point.new(MeshBox.D.x, EntityBox.B.y), Point.new(EntityBox.B.x, MeshBox.D.y))
	elseif EntityBox.center.x - MeshBox.center.x > 0 and
	EntityBox.center.y - MeshBox.center.y > 0 then
		return Box.get_collision(EntityBox.A, MeshBox.C)
	else
		return Point.new(0, 0)
	end
end

return Box
