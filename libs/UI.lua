--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  M-Like:UI
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-10-27 11:55:09
-- :ddddddddddhyyddddddddddd: Modified: 2015-10-28 08:48:43
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local UI = {}
UI.queue = {}

function UI.button(position, size, callback)
	table.insert(UI.queue, {
		position = position,
		size = size,
		content = callback,
		update = function (self, x, y)
			local x, y = love.mouse.getPosition()

			if self.position.x < x and x < self.position.x + self.size.x and
				self.position.y < y and y < self.position.y + self.size.y then
				self.content()
			end
		end,
		draw = function (self)
			love.graphics.rectangle('line', self.position.x, self.position.y, self.size.x, self.size.y)
		end
	})
end

function UI.image(image)
	table.insert(UI.queue, {
		content = image,
		draw = function (self)
			love.graphics.draw(self.content)
		end
	})
end

function UI.text(str)
	table.insert(UI.queue, {
		content = str,
		draw = function (self)
			love.graphics.print(self.content)
		end
	})
end

function UI:update(dt)
	for i,v in ipairs(self.queue) do
		if v.update then
			v:update()
		end
	end
end

function UI:draw()
	for i,v in ipairs(self.queue) do
		v:draw()
	end
end

return UI
