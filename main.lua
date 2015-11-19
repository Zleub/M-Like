--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  M-Like:main
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-10-26 21:10:55
-- :ddddddddddhyyddddddddddd: Modified: 2015-11-19 14:55:11
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

Lib = require 'libs.Lib'
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

function love.load()

	face = love.graphics.newImage('assets/image.bmp')
	image = love.graphics.newImage('assets/tile.png')

	player_image = love.graphics.newImage('assets/PlayerLeft.png')
	player_image:setFilter('nearest', 'nearest')
	player_quad = Quadlist.new({image = player_image, width = 8, height = 8})

	tiles_image = love.graphics.newImage('assets/Tiles_Basic.png')
	tiles_image:setFilter('nearest', 'nearest')
	tiles_quad = Quadlist.new({image = tiles_image, width = 8, height = 8})

	-- for i=1, love.window.getWidth() ,42 do
	-- 	for j=1,love.window.getHeight(),42 do
	-- 		v = Vertice.newFromCenter(i, j, 21)
	-- 		Meshes:add(v, tiles_quad.images[6])
	-- 	end
	-- end

	v = Vertice.newFromCenter(love.window.getWidth() / 2, love.window.getHeight(), 42)
	Meshes:add(v, tiles_quad.images[3])
	v = Vertice.newFromCenter(love.window.getWidth() / 2 - 50, love.window.getHeight() - 50 , 42)
	Meshes:add(v, tiles_quad.images[3])
	v = Vertice.newFromCenter(love.window.getWidth() / 2 - 100, love.window.getHeight() - 100 , 42)
	Meshes:add(v, tiles_quad.images[3])

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

	local container = UI.container(Point.new(10, 10), Point.new(250, 300))
	:insert(button)
	:insert(text)
	:insert(text2)

	-- local i = UI.image(Point.new(0, 0), Point.new(50, 50), image)
	-- local i2 = UI.image(Point.new(0, 0), Point.new(50, 50), face)
	for i,v in ipairs(tiles_quad.images) do
		container:insert( UI.image(Point.new(0, 0), Point.new(50, 50), v) )
	end
	-- local i3 = UI.quad(Point.new(0, 0), Point.new(50, 50), player_quad, 1)

	player = Entity.player(player_quad)


end

function love.update(dt)
	love.last_dt = dt
	player:update(dt)
end

function love.draw()
	Meshes:draw()
	UI:draw()
	player:draw()
end
