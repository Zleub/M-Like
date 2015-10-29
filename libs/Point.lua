--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  M-Like:Point
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-10-26 21:41:59
-- :ddddddddddhyyddddddddddd: Modified: 2015-10-29 04:13:01
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local Point = {}

function Point.isBoxedFromCenter(self, center, size)
	return center.x - size.x < self.x and self.x < center.x + size.x and
			center.y - size.y < self.y and self.y < center.y + size.y
end

function Point.isBoxedFromCorner(self, corner, size)
	return corner.x < self.x and self.x < corner.x + size.x and
			corner.y < self.y and self.y < corner.y + size.y
end

function Point.seum(A, B)
	return Point.new(A.x + B.x, A.y + B.y)
end

function Point.new(x, y)
	return {
		x = x,
		y = y,
		isBoxedFromCenter = Point.isBoxedFromCenter,
		isBoxedFromCorner = Point.isBoxedFromCorner
	}
end

return Point
