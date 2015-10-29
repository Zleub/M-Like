--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  M-Like:Meshes
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-10-26 21:48:39
-- :ddddddddddhyyddddddddddd: Modified: 2015-10-28 20:27:30
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local Meshes = {}
Meshes.queue = {}

function Meshes:add(vertice, image)
	local m = {
		vertice = vertice,
		mousereleased = function(self, point, button)
			if self.vertice:collides(point) and button == 'l' then
				print('I should get something to load')
				if Event.content then
					self.mesh = love.graphics.newMesh(vertice.table, Event.content, 'fan')
					-- Event.content = nil
				end
			end
		end,

		mesh = love.graphics.newMesh(vertice.table, image, 'fan')
	}



	Event:register('mousereleased', m)
	table.insert(self.queue, m)

end

function Meshes:draw()
	for i,v in ipairs(self.queue) do
		love.graphics.draw(v.mesh)
	end
end

return Meshes
