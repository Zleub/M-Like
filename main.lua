--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  M-Like:main
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-10-26 21:10:55
-- :ddddddddddhyyddddddddddd: Modified: 2015-10-28 08:48:08
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

image = love.graphics.newImage('assets/image.bmp')

UI = require 'libs.UI'
Meshes = require 'libs.Meshes'
Point = require 'libs.Point'
Vertice = require 'libs.Vertice'

local mode = 'none'

function love.mousepressed(x, y, button)
end

function love.load()
	v = Vertice.newFromCenter(love.window.getWidth() / 2, love.window.getHeight() / 2, 50)
	Meshes:add(v.table, image)
	v = Vertice.newFromCenter(love.window.getWidth() / 2, love.window.getHeight() / 2, 50)
	Meshes:add(v.table, image)
	v = Vertice.newFromCenter(love.window.getWidth() / 2 - 50, love.window.getHeight() / 2 - 50 , 50)
	Meshes:add(v.table, image)

	text = UI.text(mode)
	-- UI.image(image)
	UI.button(Point.new(100, 100), Point.new(100, 100), function () print('Hello World') end)
end

function love.update(dt)
	UI:update(dt)
end

function love.draw()
	Meshes:draw()
	UI:draw()
end
