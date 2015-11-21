--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  M-Like:Entity
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-10-28 20:31:30
-- :ddddddddddhyyddddddddddd: Modified: 2015-11-21 19:13:32
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
	p.speed = 4
	p.size = Point.new(42, 42)
	p.scale = Point.new(p.size.x / quadlist.tileset.width, p.size.y / quadlist.tileset.height)
	p.Pscale = Point.new(p.size.x / quadlist.tileset.width, p.size.y / quadlist.tileset.height)
	p.position = Point.new(100, 100)
	p.velocity = Point.new(0, 0)

	p.Yaxis = 42
	p.Xaxis = 666

	p.keypressed = function (self, key)
		if key == 'left' then self.scale.x = self.Pscale.x end
		if key == 'right' then self.scale.x = self.Pscale.x * -1 end
		if key == ' ' then self.velocity.y = - 4 end
	end
	p.keyreleased = function (self, key)
		if key == 'left' or key == 'right' then self.velocity.x = 0 end
	end
	p.update = function (self, dt)
		p.time = p.time + dt * 10
		self.velocity.y = self.velocity.y + dt * self.Yaxis

		local A, B = 0, 0
		if love.keyboard.isDown('left') then
			A = Lib.clamp(0 - dt * self.Xaxis, -self.speed, 0)
		end
		if love.keyboard.isDown('right') then
			B = Lib.clamp(0 + dt * self.Xaxis, 0, self.speed)
		end
		self.velocity.x = B + A

		if p.time > 60 / (math.abs(self.velocity.x) * 2) then
			self.index = self.index + 1
			if self.index == 3 then self.index = 1 end
			p.time = 0
		end

		local test = Meshes:seekCollision(Point.new(self.position.x, self.position.y + self.velocity.y +  self.size.y))
		if test then
			ttest = test.center.y - test.size - self.size.y
			self.position.y = Lib.clamp(self.position.y + self.velocity.y, self.position.y , test.center.y - test.size - self.size.y)
			self.velocity.y = 0
		end

		local test = Meshes:seekCollision(Point.new(self.position.x + self.size.x / 2, self.position.y + self.size.y / 2))
		if test then
			self.position.x = Lib.clamp(self.position.x + self.velocity.x, self.position.x, test.center.x - test.size - self.size.x / 2)
		end
		local test = Meshes:seekCollision(Point.new(self.position.x - self.size.x / 2, self.position.y + self.size.y / 2))
		if test then
			self.position.x = Lib.clamp(self.position.x + self.velocity.x, test.center.x + test.size + self.size.x / 2, self.position.x)
		end

		self.position = Point.seum(self.position, self.velocity)
		self.position.y = Lib.clamp(self.position.y, 0, love.window.getHeight() - self.size.y)
		if self.position.y == love.window.getHeight() - self.size.y then self.velocity.y = 0 end
	end
	p.draw = function (self)
		if self.scale.x > 0 then
			love.graphics.draw(quadlist[0], quadlist[self.index], self.position.x - self.size.x / 2, self.position.y, 0, self.scale.x, self.scale.y)
		else
			love.graphics.draw(quadlist[0], quadlist[self.index], self.position.x + self.size.x / 2, self.position.y, 0, self.scale.x, self.scale.y)
		end

		love.graphics.point(self.position.x, self.position.y + self.size.y)

	end

	Event:register('keypressed', p)
	Event:register('keyreleased', p)
	return p
end

return Entity
