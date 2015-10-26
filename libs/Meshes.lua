--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  M-Like:Meshes
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-10-26 21:48:39
-- :ddddddddddhyyddddddddddd: Modified: 2015-10-26 21:52:18
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local Meshes = {}
Meshes.queue = {}

function Meshes:add(vertice, image)
	table.insert(self.queue, love.graphics.newMesh(vertice, image, 'fan'))
end

function Meshes:draw()
	for i,v in ipairs(self.queue) do
		love.graphics.draw(v)
	end
end

return Meshes
