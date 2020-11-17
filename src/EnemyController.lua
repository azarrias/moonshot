EnemyController = Class{__includes=tiny.Script}

function EnemyController:init()
  tiny.Script.init(self, 'EnemyController')
  self.cameraOffsetX = 0
  self.cameraSpeedX = nil
end

function EnemyController:update(dt)
  self.cameraOffsetX = self.cameraOffsetX + self.cameraSpeedX * dt
end
