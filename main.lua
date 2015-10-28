--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  M-Like:main
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-10-26 21:10:55
-- :ddddddddddhyyddddddddddd: Modified: 2015-10-28 16:58:34
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

face = love.graphics.newImage('assets/image.bmp')
image = love.graphics.newImage('assets/tile.png')

UI = require 'libs.UI'
Event = require 'libs.Event'
Meshes = require 'libs.Meshes'
Point = require 'libs.Point'
Vertice = require 'libs.Vertice'

inspect = require 'libs.inspect'

print(inspect(_G._VERSION))

Modes =  {
	'none',
	'editor',
	'debug'
}

love.mode = 'debug'

function love.mousepressed(x, y, button)
	for i,v in ipairs(Event.mousepressed) do
		v:mousepressed(x, y, button)
	end
end

function love.load()
	v = Vertice.newFromCenter(love.window.getWidth() / 2, love.window.getHeight() / 2, 50)
	Meshes:add(v.table, image)
	v = Vertice.newFromCenter(love.window.getWidth() / 2 - 50, love.window.getHeight() / 2 - 50 , 50)
	Meshes:add(v.table, image)

	local button = UI.button(
		Point.new(0, 0),
		Point.new(100, 20),

		'Change mode:',
		function (self)
			for i,v in ipairs(Modes) do
				if love.mode == v and i ~= #Modes then
					love.mode = Modes[i + 1]
					return
				elseif i == #Modes then
					love.mode = Modes[1]
					return
				end
			end

			love.mode = Modes[index + 1]
		end
	)

	local text = UI.text(
		Point.new(0, 0),
		Point.new(100, 20),
		love, 'mode'
	)

	local text2 = UI.text(
		Point.new(0, 0),
		Point.new(250, 20),
		''
	)

	local i = UI.image(Point.new(0, 0), Point.new(100, 100), image)
	local i2 = UI.image(Point.new(0, 0), Point.new(100, 100), face)

	UI.container(Point.new(10, 10), Point.new(250, 300))
	:insert(button)
	:insert(text)
	:insert(text2)
	:insert(i)
	:insert(i2)

end

function love.update(dt)
end

function love.draw()
	Meshes:draw()
	UI:draw()
end
