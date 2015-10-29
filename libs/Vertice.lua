--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  M-Like:Vertice
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-10-26 21:14:39
-- :ddddddddddhyyddddddddddd: Modified: 2015-10-28 20:25:09
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local Vertice = {}

function Vertice.newFromCenter(x, y, size)
	local v = {}

	v.center = Point.new(x, y)
	v.collides = function(self, point)
		return point:isBoxedFromCenter(self.center, Point.new(size, size))
	end
	v.table = {
		{
			x - size, y - size,
			0, 0,
			255, 255, 255
		},
		{
			x + size, y - size,
			1, 0,
			255, 255, 255
		},
		{
			x + size, y + size,
			1, 1,
			255, 255, 255
		},
		{
			x - size, y + size,
			0, 1,
			255, 255, 255
		},
		-- {
		-- 	x - size / 8, y - size / 2,
		-- 	0, 0,
		-- 	255, 255, 255
		-- },
		-- {
		-- 	x + size, y,
		-- 	1, 0,
		-- 	255, 255, 255
		-- },
		-- {
		-- 	x + size / 8, y + size / 2,
		-- 	1, 1,
		-- 	255, 255, 255
		-- },
		-- {
		-- 	x - size, y,
		-- 	0, 1,
		-- 	255, 255, 255
		-- },
	}

	return v
end

return Vertice
