--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  M-Like:Entity
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-10-28 20:31:30
-- :ddddddddddhyyddddddddddd: Modified: 2015-11-12 03:00:58
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
	p.size = Point.new(42, 42)
	p.scale = Point.new(p.size.x / quadlist.tileset.width, p.size.y / quadlist.tileset.height)
	p.Pscale = Point.new(p.size.x / quadlist.tileset.width, p.size.y / quadlist.tileset.height)
	p.position = Point.new(100, 100)
	p.velocity = Point.new(0, 0)
	p.keypressed = function (self, key)
		if key == 'left' then self.scale.x = self.Pscale.x end
		if key == 'right' then self.scale.x = self.Pscale.x * -1 end
		if key == ' ' then self.velocity.y = - 60 end
	end
	p.keyreleased = function (self, key)
		if key == 'left' or key == 'right' then self.velocity.x = 0 end
	end
	p.update = function (self, dt)
		p.time = p.time + dt * 10
		self.velocity.y = self.velocity.y + dt * 100

		local A, B = 0, 0
		if love.keyboard.isDown('left') then
			A = Lib.clamp(-6 - dt * 10, -6, 0)
		end
		if love.keyboard.isDown('right') then
			B = Lib.clamp(6 + dt * 10, 0, 6)
		end
		self.velocity.x = B + A

		if p.time > 60 / (math.abs(self.velocity.x) * 2) then
			self.index = self.index + 1
			if self.index == 3 then self.index = 1 end
			p.time = 0
		end
		self.position = Point.seum(self.position, self.velocity)
		self.position.y = Lib.clamp(self.position.y + self.size.y, 0, love.window.getHeight() - self.size.y)
	end
	p.draw = function (self)
		love.graphics.print(self.velocity.y)
		if self.scale.x > 0 then
			love.graphics.draw(quadlist[0], quadlist[self.index], self.position.x - self.size.x / 2, self.position.y, 0, self.scale.x, self.scale.y)
		else
			love.graphics.draw(quadlist[0], quadlist[self.index], self.position.x, self.position.y, 0, self.scale.x, self.scale.y)
		end
	end

	Event:register('keypressed', p)
	Event:register('keyreleased', p)
	return p
end

return Entity
