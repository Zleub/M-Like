local lib = {}

function lib.clamp(num, min, max)
	if num < min then return min
	elseif num > max then return max
	else return num end
end

function lib.debug(obj)
		print(inspect(obj))
end

return lib
