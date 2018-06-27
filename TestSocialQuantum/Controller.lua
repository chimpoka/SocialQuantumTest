Controller = {}
function Controller:new()

	local mathClass = require("Math")
	local enumClass = require("Enum")
	local buttonClass = require("Button")
	local birdClass = require("Bird")
	local obstaclesClass = require("Obstacles")

	gameState = enum({"play", "pause", "start"})
	score = 0
	state = gameState.start

	local obj = {}

		-- Window
		obj.windowWidth = 1280
		obj.windowHeight = 720
		love.window.setMode(obj.windowWidth, obj.windowHeight)
		love.graphics.setNewFont(40)

		-- Bird
		obj.birdImage = love.graphics.newImage("bird.png")
		obj.birdSize = 100
		obj.startX = obj.windowWidth / 5
		obj.startY = obj.windowHeight / 2
		obj.jumpForce = 800
		obj.gravity= 2500
		obj.bird = Bird:new(obj.birdImage, obj.birdSize, obj.startX, obj.startY, obj.jumpForce, obj.gravity)
		
		-- Obstacles
		obj.obsWidth = 30
		obj.obsSpeed = 400
		obj.obstacles = Obstacles:new(obj.obsWidth, obj.obsSpeed, obj.startX + obj.birdSize / 2)
		obj.isComplicated = false

	 	-- Button
		obj.buttonName = "Play"
		obj.buttonWidth = 120
		obj.buttonHeight = 50
		obj.buttonX = obj.windowWidth / 2 - obj.buttonWidth / 2
		obj.buttonY = obj.windowHeight / 2 - obj.buttonHeight / 2
	 	obj.button = Button:new(obj.buttonName, obj.buttonX, obj.buttonY, obj.buttonWidth, obj.buttonHeight)

	function obj:start()
		obj.bird:start()
		obj.obstacles:start()
		score = 0
	end

	function love.mousepressed(x, y, button)
		if (state == gameState.play) then
			if button == 1 then 
				obj.bird:jump()
			end
		else
			if (obj.button:isEnabled()) then
				if (obj:checkButtonHit(x, y) == true) then
					obj:start()
					state = gameState.play
				end
			end
		end
	end

	function obj:update(dt)
		if (obj:checkObstacleHit() == true) then
			state = gameState.pause
		end

		if (state ~= gameState.start) then	
			obj.bird:update(dt)
		end

		if (state == gameState.play) then	
			obj.obstacles:update(dt)
		end

		if (math.fmod(score, 2) == 0) then
			if (obj.isComplicated == false) then
				obj:complicateGame()
				obj.isComplicated = true
			end
		else
			obj.isComplicated = false
		end
	end

	function obj:draw()
		love.graphics.setBackgroundColor(0.2, 0.2, 0.2)

		obj:drawScore()
		obj.bird:draw()
		obj.obstacles:draw()

		if (state == gameState.pause or state == gameState.start) then
			obj.button:draw()
		end
	end



	function obj:drawScore()
		love.graphics.printf(tostring(score), obj.windowWidth / 2 - 14, 40, 200, "left")
	end

	function obj:complicateGame()
		obj.obstacles:decreaseHole()
	end

	function obj:checkObstacleHit()
		x, y, width, height = obj.bird:getCoordinates()

		if (y > obj.windowHeight or y < 0) then
			return true
		else
			for i = 1, table.getn(obj.obstacles.obstacles), 1 do
				x1, y1, width1, height1, x2, y2, width2, height2 = obj.obstacles.obstacles[i]:getCoordinates()
				if (CheckCollision(x, y, width, height, x1, y1, width1, height1) == true) then
					return true
				elseif (CheckCollision(x, y, width, height, x2, y2, width2, height2) == true) then
					return true
				end
			end
		end
		return false
	end

	function obj:checkButtonHit(mouseX, mouseY)
		x, y, width, height = obj.button:getCoordinates()
		obj.test = x
		return CheckPointInBox(mouseX, mouseY, x, y, width, height)
	end

	setmetatable(obj, self)
    self.__index = self; return obj
		
end








