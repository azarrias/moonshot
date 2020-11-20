EnemyController = Class{__includes=tiny.Script}

function EnemyController:init()
  tiny.Script.init(self, 'EnemyController')
  self.cameraOffsetX = 0
  self.cameraSpeedX = nil
  self.speed = 100
end

function EnemyController:update(dt)
  local position = self.entity.position
  self.cameraOffsetX = self.cameraOffsetX + self.cameraSpeedX * dt
  
  if self.cameraOffsetX + VIRTUAL_SIZE.x + ENEMY_TYPE_2_SIZE.x / 2 > position.x then
    position.x = position.x - self.speed * dt
  end
end
