local enumClass = require("Enum")

events = enum({"generateObs", "earnScore", "destroy"})

Obstacle = {}
function Obstacle:new(x, width, speed, holeTopPoint, holeSize)
	local obj = {}
		obj.x = x

		obj.x1 = x
		obj.y1 = 0
		obj.width1 = width
		obj.height1 = holeTopPoint

		obj.x2 = x
		obj.y2 = holeTopPoint + holeSize
		obj.width2 = width
		obj.height2 = love.graphics.getHeight()

		obj.speed = speed
		obj.generateObsTrigger = false
		obj.earnScoreTrigger = false
		obj.destroyTrigger = false

	function obj:update(dt)
		obj.x = obj.x - speed * dt
		obj.x1 = obj.x
		obj.x2 = obj.x
	end

	function obj:draw()
		love.graphics.rectangle("fill", obj.x1 , obj.y1, obj.width1, obj.height1)
		love.graphics.rectangle("fill", obj.x2 , obj.y2, obj.width2, obj.height2)
	end

	function obj:isPassedPoint(pointX, event)
		if (obj.x < pointX) then
			if (event == events.generateObs and obj.generateObsTrigger == false) then
				obj.generateObsTrigger = true
				return true
			elseif (event == events.earnScore and obj.earnScoreTrigger == false) then
				obj.earnScoreTrigger = true
				return true
			elseif (event == events.destroy and obj.destroyTrigger == false) then
				obj.destroyTrigger = true
				return true
			else
				return false
			end
		else 
			return false
		end
	end

	function obj:getCoordinates()
		return obj.x1, obj.y1, obj.width1, obj.height1, 
			   obj.x2, obj.y2, obj.width2, obj.height2
	end

	return obj
end

