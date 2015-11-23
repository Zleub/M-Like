--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  M-Like:Meshes
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-10-26 21:48:39
-- :ddddddddddhyyddddddddddd: Modified: 2015-11-23 21:39:27
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local Meshes = {}
Meshes.queue = {}

function Meshes:add(vertice, image)
	local m = {
		vertice = vertice, -- handle a collides method
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

function Meshes:move(point)
	for k,v in ipairs(self.queue) do
		v:move(point)
	end
end

function Meshes:seekCollision(point)

	local w,h = love.window.getDimensions()
	for i,v in ipairs(self.queue) do
		if 0 < v.vertice.center.x and v.vertice.center.x < w and
			0 < v.vertice.center.y and v.vertice.center.y < h then
				local test = v.vertice:collides(point)
				if test then return test end
		end
	end
end

function Meshes:draw()
	for i,v in ipairs(self.queue) do
		if love.mode == 'debug' and v.mesh then love.graphics.rectangle("line", v.vertice.table[1][1], v.vertice.table[1][2], v.vertice.size * 2, v.vertice.size * 2)
		elseif v.mesh then love.graphics.draw(v.mesh) end
	end
end

return Meshes
