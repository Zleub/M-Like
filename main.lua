--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  M-Like:main
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-10-26 21:10:55
-- :ddddddddddhyyddddddddddd: Modified: 2015-11-21 19:14:21
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

Lib = require 'libs.Lib'
UI = require 'libs.loveframes'
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

	local size = 42
	for i=love.window.getWidth() - (size * 10), love.window.getWidth() ,size do
		local v = Vertice.newFromCenter(i, love.window.getHeight() - size / 2 , size / 2)
		Meshes:add(v, tiles_quad.images[3])
	end

	local size = 42
	for i=0, size * 5 ,size do
		local v = Vertice.newFromCenter(i, love.window.getHeight() - (size + 10) * 2 , size / 2)
		Meshes:add(v, tiles_quad.images[3])
	end

	local size = 42
	for i=love.window.getWidth() - (size * 10), love.window.getWidth() ,size do
		local v = Vertice.newFromCenter(i, love.window.getHeight() - size * 4 , size / 2)
		Meshes:add(v, tiles_quad.images[3])
	end

	local size = 42
	for i=love.window.getHeight() - (size * 10), love.window.getHeight() ,size do
		local v = Vertice.newFromCenter(love.window.getWidth() - size / 2, i , size / 2)
		Meshes:add(v, tiles_quad.images[3])
	end


	player = Entity.player(player_quad)

	local slider_jump = UI.Create("slider")
		slider_jump:SetPos(42, 30)
		slider_jump:SetWidth(100)
		slider_jump:SetMinMax(0, 1000)
		slider_jump.value = player.Xaxis
		slider_jump.Update = function (object, dt)
			player.Xaxis = math.floor(object.value)
		end
	local slider_gravity = UI.Create("slider")
		slider_jump:SetPos(42, 30)
		slider_jump:SetWidth(100)
		slider_jump:SetMinMax(0, 1000)
		slider_jump.value = player.Xaxis
		slider_jump.Update = function (object, dt)
			player.Xaxis = math.floor(object.value)
		end
end

function love.update(dt)
	love.last_dt = dt
	player:update(dt)
	UI.update(dt)
end

function love.draw()
	love.graphics.print('Movement Speed', 5, 30)
	love.graphics.print(player.Xaxis, 5, 30)
	UI:draw()
	Meshes:draw()
	player:draw()
end
