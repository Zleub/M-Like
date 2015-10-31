--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  M-Like:main
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-10-26 21:10:55
-- :ddddddddddhyyddddddddddd: Modified: 2015-10-31 19:30:25
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

UI = require 'libs.UI'
Event = require 'libs.Event'
Meshes = require 'libs.Meshes'
Quadlist = require 'libs.Quadlist'
Point = require 'libs.Point'
Vertice = require 'libs.Vertice'
Entity = require 'libs.Entity'

inspect = require 'libs.inspect'

print(inspect(_G._VERSION))

Modes =  {
	'none',
	'editor',
	'debug'
}

love.mode = 'editor'

function love.mousepressed(x, y, button)
	for i,v in ipairs(Event.mousepressed) do
		v:mousepressed(Point.new(x, y), button)
	end
end

function love.mousereleased(x, y, button)
	for i,v in ipairs(Event.mousereleased) do
		v:mousereleased(Point.new(x, y), button)
	end
	print(inspect(Event.content))
end

function love.load()

	face = love.graphics.newImage('assets/image.bmp')
	image = love.graphics.newImage('assets/tile.png')

	player_image = love.graphics.newImage('assets/PlayerLeft.png')
	player_image:setFilter('nearest', 'nearest')
	player_quad = Quadlist.new({image = player_image, width = 8, height = 8})

	v = Vertice.newFromCenter(love.window.getWidth() / 2, love.window.getHeight() / 2, 50)
	Meshes:add(v, image)
	v = Vertice.newFromCenter(love.window.getWidth() / 2 - 50, love.window.getHeight() / 2 - 50 , 50)
	Meshes:add(v, image)

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

	local i = UI.image(Point.new(0, 0), Point.new(50, 50), image)
	local i2 = UI.image(Point.new(0, 0), Point.new(50, 50), face)
	local i3 = UI.quad(Point.new(0, 0), Point.new(50, 50), player_quad, 1)

	player = Entity.player(player_quad)

	UI.container(Point.new(10, 10), Point.new(250, 300))
	:insert(button)
	:insert(text)
	:insert(text2)
	:insert(i)
	:insert(i2)
	:insert(i3)

end

function love.update(dt)
	player:update(dt)
end

function love.draw()
	Meshes:draw()
	UI:draw()
	player:draw()
end
