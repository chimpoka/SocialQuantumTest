local controllerClass = require("Controller")

function love.load()
	controller = Controller:new()
	controller:start()
end

function love.update(dt)
	controller:update(dt)
end

function love.draw()
	controller:draw()
end









