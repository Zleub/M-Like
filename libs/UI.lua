--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  M-Like:UI
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-10-27 11:55:09
-- :ddddddddddhyyddddddddddd: Modified: 2015-10-28 16:59:19
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local UI = {}
UI.queue = {}

function UI.container(position, size)
	local c = {
		position = position,
		size = size,
		content = {},
		insert = function (self, elem)
			if elem.position.x < self.position.x then elem.position.x = self.position.x end
			if elem.position.y < self.position.y then elem.position.y = self.position.y end
			-- if elem.size.x > self.size.x then elem.size.x = self.size.x end
			-- if elem.size.y > self.size.y then elem.size.y = self.size.y end

			local last_elem = self.content[#self.content]
			if last_elem then
				if last_elem.position.x + last_elem.size.x + elem.size.x < self.position.x + self.size.x then
					elem.position.x = last_elem.position.x + last_elem.size.x
					if last_elem.position.y > elem.position.y then
						elem.position.y = last_elem.position.y 
					end
				else
					elem.position.y = last_elem.position.y + last_elem.size.y
				end
			end
			table.insert(self.content, elem)
			return self
		end,
		draw = function (self)
			if love.mode == 'debug' then
				love.graphics.rectangle('line', self.position.x, self.position.y, self.size.x, self.size.y)
			end
		end
	}
	table.insert(UI.queue, c)
	return c
end

function UI.button(position, size, label, callback)
	local b = {
		position = position,
		size = size,
		content = callback,
		label = label,
		mousepressed = function (self, x, y, button)
			if self.position.x < x and x < self.position.x + self.size.x and 
				self.position.y < y and y < self.position.y + self.size.y and 
				button == 'l' then
				self:content()
			end
		end,
		draw = function (self)
			if self.label then
				love.graphics.print(self.label, self.position.x, self.position.y)	
			end
			if love.mode == 'debug' then
				love.graphics.rectangle('line', self.position.x, self.position.y, self.size.x, self.size.y)
			end
		end
	}

	table.insert(UI.queue, b)
	Event:register('mousepressed', b)
	return b
end

function UI.image(position, size, image)
	local i = {
		position = position,
		size = size,
		content = image,
		update = function (self, x, y, button)
			if self:trigger() then
				print(self, x, y, button)
			end
		end,
		draw = function (self)
			local sx = self.size.x / self.content:getWidth() 
			local sy = self.size.y / self.content:getHeight() 

			if love.mode == 'debug' then
				love.graphics.rectangle('line', self.position.x, self.position.y, self.size.x, self.size.y)
			end
			if love.mode == 'editor' then
				love.graphics.draw(self.content, self.position.x, self.position.y, 0, sx, sy)
			end
		end
	}

	table.insert(UI.queue, i)
	Event:register('mousepressed', i)
	Event:register('mousereleased', i)
	return i
end

function UI.text(position, size, object, string)
	local t = {
		position = position,
		size = size,
		content = object[str],
		draw = function (self)
			if string then
				love.graphics.print(object[string], self.position.x, self.position.y)
			else
				love.graphics.print(object, self.position.x, self.position.y)
			end
			if love.mode == 'debug' then
				love.graphics.rectangle('line', self.position.x, self.position.y, self.size.x, self.size.y)
			end
		end
	}
	table.insert(UI.queue, t)
	return t
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
		if v.draw then
			v:draw()
		end
	end
end

return UI
