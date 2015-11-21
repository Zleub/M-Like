--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  M-Like:Event
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-10-28 11:21:29
-- :ddddddddddhyyddddddddddd: Modified: 2015-11-21 19:05:01
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local Event = {}

function love.textinput(text)
	UI.textinput(text)
end

function love.keypressed(key, isrepeat)
	UI.keypressed(key, isrepeat)

	if not Event.keypressed then return end

	for i,v in ipairs(Event.keypressed) do
		v:keypressed(key)
	end
end

function love.keyreleased(key)
	UI.keyreleased(key)
	if not Event.keyreleased then return end

	for i,v in ipairs(Event.keyreleased) do
		v:keyreleased(key)
	end
end

function love.mousepressed(x, y, button)
	UI.mousepressed(x, y, button)

	if not Event.mousepressed then return end

	for i,v in ipairs(Event.mousepressed) do
		v:mousepressed(Point.new(x, y), button)
	end
end

function love.mousereleased(x, y, button)
	UI.mousereleased(x, y, button)

	if not Event.mousereleased then return end

	for i,v in ipairs(Event.mousereleased) do
		v:mousereleased(Point.new(x, y), button)
	end
end

function Event:register(type, object)
	if not Event[type] then Event[type] = {} end
	table.insert(Event[type], object)
end

return Event
