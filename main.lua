--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  M-Like:main
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-10-26 21:10:55
-- :ddddddddddhyyddddddddddd: Modified: 2015-12-01 04:57:35
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

Lib = require 'libs.Lib'
Box = require 'libs.Box'
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
	-- 'editor',
	'debug'
}

love.mode = Modes[2]

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

	local slider_speed_mul = UI.Create("slider")
		slider_speed_mul:SetPos(42, 50)
		slider_speed_mul:SetWidth(100)
		slider_speed_mul:SetMinMax(0, 1000)
		slider_speed_mul.value = player.speed_mul
		slider_speed_mul.Update = function (object, dt)
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
	local slider_speed_max = UI.Create("slider")
		slider_speed_max:SetPos(42, 150)
		slider_speed_max:SetWidth(100)
		slider_speed_max:SetMinMax(0, 100)
		slider_speed_max.value = player.speed_max
		slider_speed_max.Update = function (object, dt)
			player.speed_max = math.floor(object.value)
		end
	local slider_jump = UI.Create("slider")
		slider_jump:SetPos(42, 200)
		slider_jump:SetWidth(100)
		slider_jump:SetMinMax(0, 100)
		slider_jump.value = player.jump
		slider_jump.Update = function (object, dt)
			player.jump = math.floor(object.value)
		end


	local button_mode = UI.Create("button")
		button_mode:SetText(love.mode)
		button_mode:SetPos(700, 10)
		button_mode.OnClick = function (object, x, y)
			for i,v in ipairs(Modes) do
				if v == love.mode then
					if i ~= #Modes then love.mode = Modes[i + 1]
					else love.mode = Modes[1] end
					object:SetText(love.mode)
					return
				end
			end
		end
end

function love.update(dt)
	love.last_dt = dt
	local x, y = player.position.x, player.position.y
	player:update(dt)
	local newx, newy = player.position.x, player.position.y
	Meshes:move(Point.new(x - newx, y - newy))
	UI.update(dt)
end

function love.draw()
	Meshes:draw()
	player:draw()
	love.graphics.print('Speed Mul', 5, 30)
	love.graphics.print(player.speed_mul, 150, 30)
	love.graphics.print('Mass', 5, 80)
	love.graphics.print(player.mass, 50, 80)
	love.graphics.print('Speed Max', 5, 130)
	love.graphics.print(player.speed_max, 100, 130)
	love.graphics.print('Jump Str', 5, 180)
	love.graphics.print(player.jump, 100, 180)
	UI:draw()
end
