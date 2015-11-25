--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  M-Like:Entity
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-10-28 20:31:30
-- :ddddddddddhyyddddddddddd: Modified: 2015-11-25 15:27:10
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local Entity = {}

function Entity.player(quadlist)
	local p = {}

	p.time = 0
	p.index = 1
	p.size = Point.new(21, 42)
	p.position = Point.new(100, 100)
	p.velocity = Point.new(0, 0)
	p.scale = Point.new(p.size.x / quadlist.tileset.width * 2, p.size.y / quadlist.tileset.height)
	p.Pscale = Point.new(p.size.x / quadlist.tileset.width * 2, p.size.y / quadlist.tileset.height)

	-- Watched
	p.speed_mul = 50
	p.mass = 42
	p.speed_max = 8
	p.jump = 12

	p.keypressed = function (self, key)
		if key == 'left' then self.scale.x = self.Pscale.x end
		if key == 'right' then self.scale.x = self.Pscale.x * -1 end
		if key == ' ' and self.velocity.y == 0 then self.velocity.y = -self.jump end
	end
	p.keyreleased = function (self, key)
		if key == 'left' or key == 'right' then self.velocity.x = 0 end
	end
	p.update = function (self, dt)
		p.time = p.time + dt * 10
		self.velocity.y = self.velocity.y + dt * self.mass

		local A, B = 0, 0
		if love.keyboard.isDown('left') then
			A = Lib.clamp(self.velocity.x - dt * self.speed_mul, -self.speed_max, 0)
		end
		if love.keyboard.isDown('right') then
			B = Lib.clamp(self.velocity.x + dt * self.speed_mul, 0, self.speed_max)
		end
		self.velocity.x = B + A

		if p.time > 60 / (math.abs(self.velocity.x) * 2) then
			self.index = self.index + 1
			if self.index == 3 then self.index = 1 end
			p.time = 0
		end

		Meshes:seekCollision(player)

		self.position = Point.seum(self.position, self.velocity)
		self.position.y = Lib.clamp(self.position.y, 0, love.window.getHeight() - self.size.y)
		if self.position.y == love.window.getHeight() - self.size.y then self.velocity.y = 0 end
	end
	p.draw = function (self)
		love.graphics.print(self.position.x..' '..self.position.y)

		if self.scale.x > 0 then
			love.graphics.draw(quadlist[0], quadlist[self.index], self.position.x - self.size.x / 2, self.position.y, 0, self.scale.x, self.scale.y)
		else
			love.graphics.draw(quadlist[0], quadlist[self.index], self.position.x + self.size.x / 2, self.position.y, 0, self.scale.x, self.scale.y)
		end

		love.graphics.point(self.position.x, self.position.y)

	end

	Event:register('keypressed', p)
	Event:register('keyreleased', p)
	return p
end

return Entity
