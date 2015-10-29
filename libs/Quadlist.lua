--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  M-Like:Quadlist
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-10-29 03:48:46
-- :ddddddddddhyyddddddddddd: Modified: 2015-10-29 04:00:29
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local Quadlist = {}

function Quadlist.new(tileset)
	local i = 0
	local j = 0
	local q = {}
	local w, h = tileset.image:getDimensions()

	q[0] = tileset.image
	while j < h do
		i = 0
		while i < w do
			table.insert(q,
				love.graphics.newQuad(i, j, tileset.width, tileset.height,
					w, h))
			i = i + tileset.width
		end
		j = j + tileset.height
	end

	return q
end

return Quadlist
