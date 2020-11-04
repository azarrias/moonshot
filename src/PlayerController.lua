PlayerController = Class{__includes=tiny.Script}

function PlayerController:init()
  tiny.Script.init(self, 'PlayerController')
  self.speed = 120
end

function PlayerController:update(dt)
  local position = self.entity.position
  
  if love.keyboard.isDown('down') then
    position.y = position.y + self.speed * dt
  end
  if love.keyboard.isDown('up') then
    position.y = position.y - self.speed * dt
  end
  if love.keyboard.isDown('right') then
    position.x = position.x + self.speed * dt
  end
  if love.keyboard.isDown('left') then
    position.x = position.x - self.speed * dt
  end
end