--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  M-Like:Entity
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-10-28 20:31:30
-- :ddddddddddhyyddddddddddd: Modified: 2015-10-31 19:24:05
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local Entity = {}

function Entity.player(quadlist)
	local p = {}

	p.size = Point.new(42, 42)
	p.scale = Point.new(p.size.x / quadlist.tileset.width, p.size.y / quadlist.tileset.height)
	p.position = Point.new(100, 100)
	p.velocity = Point.new(0, 0)
	p.update = function (self, dt)
		self.velocity.y = self.velocity.y + 1

		if love.keyboard.isDown('left') then
			self.velocity.x = self.velocity.x - dt
		end
		if love.keyboard.isDown('right') then
			self.velocity.x = self.velocity.x + dt
		end

		self.position = Point.seum(self.position, self.velocity)
		if self.position.y + self.size.y > love.window.getHeight() then
			self.position.y = love.window.getHeight() - self.size.y
		end
	end
	p.draw = function (self)
		love.graphics.draw(quadlist[0], quadlist[2], self.position.x, self.position.y, 0, self.scale.x, self.scale.y)
	end

	return p
end

return Entity
