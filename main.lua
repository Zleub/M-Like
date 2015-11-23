--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  M-Like:main
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-10-26 21:10:55
-- :ddddddddddhyyddddddddddd: Modified: 2015-11-23 21:44:08
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
		slider_jump:SetPos(42, 50)
		slider_jump:SetWidth(100)
		slider_jump:SetMinMax(0, 1000)
		slider_jump.value = player.speed_mul
		slider_jump.Update = function (object, dt)
			player.speed_mul = math.floor(object.value)
		end
	local slider_gravity = UI.Create("slider")
		slider_gravity:SetPos(42, 100)
		slider_gravity:SetWidth(100)
		slider_gravity:SetMinMax(0, 100)
		slider_gravity.value = player.mass
		slider_gravity.Update = function (object, dt)
			player.mass = math.floor(object.value)
		end
end

function love.update(dt)
	love.last_dt = dt
	player:update(dt)
	-- Meshes:move(pla)
	UI.update(dt)
end

function love.draw()
	love.graphics.print('Speed mult', 5, 30)
	love.graphics.print(player.speed_mul, 150, 30)
	love.graphics.print('Mass', 5, 80)
	love.graphics.print(player.mass, 50, 80)
	UI:draw()
	Meshes:draw()
	player:draw()
end
