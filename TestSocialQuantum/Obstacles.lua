local obstacleClass = require("Obstacle")

Obstacles = {}
function Obstacles:new(width, speed, birdPositionX)
	local obj = {}
		obj.width = width
		obj.speed = speed
		obj.startHoleSize = love.graphics.getHeight() / 2
		obj.holeSize = obj.startHoleSize
		obj.obstacles = {}
		obj.generateObsTriggerPoint = love.graphics.getWidth() * 0.65
		obj.earnScoreTriggerPoint = birdPositionX
		obj.destroyObsTriggerPoint = 0 - width * 2

	function obj:start()
		for i = table.getn(obj.obstacles), 1, -1 do
			obj:destroy(i)
		end
		obj.holeSize = obj.startHoleSize
		obj:addObstacle()
	end

	function obj:decreaseHole()
		if (obj.holeSize > love.graphics.getHeight() / 3) then
			obj.holeSize = obj.holeSize - love.graphics.getHeight() * 0.02
		end
	end

	function obj:addObstacle()
		holeTopPoint = love.math.random(0, love.graphics.getHeight() - obj.holeSize)
		x = love.math.random(love.graphics.getWidth(), love.graphics.getWidth() * 1.5)
		obj.obstacles[table.getn(obj.obstacles) + 1] = Obstacle:new(x, obj.width, obj.speed, holeTopPoint, obj.holeSize)
	end

	function obj:update(dt)
		for i = 1, table.getn(obj.obstacles), 1 do
			obj.obstacles[i]:update(dt)
		end
		for i = 1, table.getn(obj.obstacles), 1 do
			if (obj.obstacles[i]:isPassedPoint(obj.generateObsTriggerPoint, events.generateObs) == true) then
				obj:addObstacle()
			end
			if (obj.obstacles[i]:isPassedPoint(obj.earnScoreTriggerPoint, events.earnScore) == true) then
				obj:earnScore(1)
			end
			if (obj.obstacles[i]:isPassedPoint(obj.destroyObsTriggerPoint, events.destroy) == true) then
				obj:destroy(i)
				return
			end
		end
	end

	function obj:draw()
		for i = 1, table.getn(obj.obstacles), 1 do
			obj.obstacles[i]:draw()
		end
	end

	function obj:destroy(index)	
		table.remove(obj.obstacles, index)
	end

	function obj:earnScore(count)
		score = score + count
	end



	setmetatable(obj, self)
	    self.__index = self; return obj
	
end
