Button = {}
function Button:new(name, x, y, width, height)

	local obj = {}
		
		obj.name = name
		obj.x = x
		obj.y = y
		obj.width = width
		obj.height = height
		obj.enabled = true

	function obj:enable()
		obj.enabled = true
	end

	function obj:disable()
		obj.enabled = false
	end

	function obj:isEnabled()
		return obj.enabled == true
	end

	function obj:getCoordinates()
		return obj.x, obj.y, obj.width, obj.height
	end

	function obj:draw()
		love.graphics.setColor(0, 0.7, 1, 1)
		love.graphics.rectangle("fill", obj.x, obj.y, obj.width, obj.height)
		love.graphics.setColor(0, 0, 0, 1)
		love.graphics.printf(obj.name, obj.x, obj.y, obj.width, "center")
		love.graphics.setColor(255, 255,255, 1)
	end

	setmetatable(obj, self)
    self.__index = self; return obj
		
end