--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  M-Like:Event
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-10-28 11:21:29
-- :ddddddddddhyyddddddddddd: Modified: 2015-11-19 14:20:50
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local Event = {}

function love.keypressed(key)
	for i,v in ipairs(Event.keypressed) do
		v:keypressed(key)
	end
end

function love.keyreleased(key)
	for i,v in ipairs(Event.keyreleased) do
		v:keyreleased(key)
	end
end

function love.mousepressed(x, y, button)
	for i,v in ipairs(Event.mousepressed) do
		v:mousepressed(Point.new(x, y), button)
	end
end

function love.mousereleased(x, y, button)
	for i,v in ipairs(Event.mousereleased) do
		v:mousereleased(Point.new(x, y), button)
	end
end

function love.gamepadpressed( joystick, button )
	print ( joystick, button )
end

function Event:register(type, object)
	if not Event[type] then Event[type] = {} end

	table.insert(Event[type], object)
end

return Event
