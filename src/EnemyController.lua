EnemyController = Class{__includes=tiny.Script}

function EnemyController:init()
  tiny.Script.init(self, 'EnemyController')
  self.speed_x = 100
end

function EnemyController:update(dt)
  local position = self.entity.position
  
  position.x = position.x - self.speed_x * dt
  if position.x < VIRTUAL_SIZE.x / 2 then
    position.y = position.y + self.speed_y * 0.5 * dt
  end
end
