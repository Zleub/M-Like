--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  M-Like:main
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-10-26 21:10:55
-- :ddddddddddhyyddddddddddd: Modified: 2015-10-26 21:52:56
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

image = love.graphics.newImage('assets/image.bmp')

Meshes = require 'libs.Meshes'
Point = require 'libs.Point'
Vertice = require 'libs.Vertice'

function love.load()
	v = Vertice.newFromCenter(love.window.getWidth() / 2, love.window.getHeight() / 2, 50)
	Meshes:add(v.table, image)
	v = Vertice.newFromCenter(love.window.getWidth() / 2, love.window.getHeight() / 2, 50)
	Meshes:add(v.table, image)
	v = Vertice.newFromCenter(love.window.getWidth() / 2 - 50, love.window.getHeight() / 2 - 50 , 50)
	Meshes:add(v.table, image)
end

function love.update()
end

function love.draw()
	Meshes:draw()
end
