--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  M-Like:Meshes
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-10-26 21:48:39
-- :ddddddddddhyyddddddddddd: Modified: 2015-12-01 09:19:46
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local Meshes = {}
Meshes.queue = {}

function Meshes:add(vertice, image)
	local m = {
		color = {255, 255, 255, 255},
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

	local EntityBox = Box.FromCorner(
		Point.seum(entity.position, entity.velocity),
		entity.size
	)

	for i,v in ipairs(self.queue) do
		if 0 < v.vertice.center.x and v.vertice.center.x < w and
			0 < v.vertice.center.y and v.vertice.center.y < h then

			local p = Box.collides(EntityBox, Box.FromCenter(
				v.vertice.center,
				Point.new(v.vertice.size, v.vertice.size)
			))

			if p and p.y >= 0 and p.x >= 0 then
				-- print(i..inspect(p))
				if p.y > 0 then
					entity.position.y = v.vertice.center.y - v.vertice.size - entity.size.y
					entity.velocity.y = 0
				-- else
				end
				if p.x < p.y then
					entity.position.x = v.vertice.center.x - v.vertice.size - entity.size.x
					entity.velocity.x = 0
				end
			end
		end
	end
end

function Meshes:draw()
	-- love.graphics.print(toPrintA, 15, 15)
	-- love.graphics.print(toPrintB, 45, 15)
	for i,v in ipairs(self.queue) do
		if love.mode == 'debug' and v.mesh then
			love.graphics.setColor(v.color)
			love.graphics.print(i, v.vertice.table[1][1], v.vertice.table[1][2])
			love.graphics.rectangle("line", v.vertice.table[1][1], v.vertice.table[1][2], v.vertice.size * 2, v.vertice.size * 2)
			love.graphics.setColor({255, 255, 255, 255})
		elseif v.mesh then
			love.graphics.draw(v.mesh) end
	end
end

return Meshes
