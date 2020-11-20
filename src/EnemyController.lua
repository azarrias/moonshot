EnemyController = Class{__includes=tiny.Script}

function EnemyController:init()
  tiny.Script.init(self, 'EnemyController')
  self.cameraOffsetX = 0
  self.cameraSpeedX = nil
  self.speed_x = 100
end

function EnemyController:update(dt)
  local position = self.entity.position
  self.cameraOffsetX = self.cameraOffsetX + self.cameraSpeedX * dt
  
  position.x = position.x - self.speed_x * dt
  if position.x - self.cameraOffsetX < VIRTUAL_SIZE.x / 2 then
    position.y = position.y + self.speed_y * 0.5 * dt
  end
end
