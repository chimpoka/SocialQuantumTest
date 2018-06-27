Bird = {}
function Bird:new(image, size, x, y, startJumpForce, gravity)
	local obj = {}
		obj.image = image
		obj.size = size
		obj.scale = size / image:getWidth()
		obj.startX = x
		obj.startY = y
		obj.x = x
		obj.y = y
		obj.startJumpForce = startJumpForce
		obj.jumpForce = startJumpForce
		obj.gravity = gravity	

	function obj:start()
		obj.y = obj.startY - size / 2
		obj.jumpForce = obj.startJumpForce
	end

	function obj:update(dt)
		obj.y = obj.y - obj.jumpForce * dt
		obj.jumpForce = obj.jumpForce - obj.gravity * dt
	end

	function obj:draw()
		love.graphics.draw(obj.image, obj.x, obj.y, 0, obj.scale, obj.scale)
	end

	function obj:jump()
		obj.jumpForce = obj.startJumpForce
	end

	function obj:getCoordinates()
		return obj.x, obj.y, obj.image:getWidth() * obj.scale, obj.image:getHeight() * obj.scale
	end

	setmetatable(obj, self)
    self.__index = self; return obj
		
end
