--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  M-Like:Meshes
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-10-26 21:48:39
-- :ddddddddddhyyddddddddddd: Modified: 2015-11-25 17:16:36
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
				-- print('I should get something to load')
				if Event.content then
					self.mesh = love.graphics.newMesh(vertice.table, Event.content, 'fan')
					-- Event.content = nil
				end
			end
		end,
		refresh = function (self) self.mesh:setVertices(self.vertice.table) end,
		mesh = love.graphics.newMesh(vertice.table, image, 'fan')
	}

	-- Event:register('mousereleased', m)
	table.insert(self.queue, m)
end

function Meshes:move(point)
	for k,v in ipairs(self.queue) do
		v.vertice:move(point)
		v:refresh()
	end
end

function Meshes:seekCollision(entity)
	local w,h = love.window.getDimensions()

	for i,v in ipairs(self.queue) do
		if 0 < v.vertice.center.x and v.vertice.center.x < w and
			0 < v.vertice.center.y and v.vertice.center.y < h then

				local xAxis = v.vertice:getXAxis()
				local yAxis = v.vertice:getYAxis()
				local yEntity = entity.position.y + entity.size.y + entity.velocity.y
				local xEntity = entity.position.x + entity.size.x + entity.velocity.x

				if (yAxis[1] < yEntity and yEntity < yAxis[2]) and
					(xAxis[1] < xEntity and xEntity < xAxis[2])
				then
					print(xAxis[1] - xEntity, xAxis[2] - xEntity)

					-- entity.position.x = xAxis[1] - entity.size.x
					-- entity.position.y = yAxis[1] - entity.size.y
					-- entity.velocity.y = 0
				end
		end
	end
end

function Meshes:draw()
	for i,v in ipairs(self.queue) do
		if love.mode == 'debug' and v.mesh then
			love.graphics.rectangle("line", v.vertice.table[1][1], v.vertice.table[1][2], v.vertice.size * 2, v.vertice.size * 2)
		elseif v.mesh then
			love.graphics.draw(v.mesh) end
	end
end

return Meshes
