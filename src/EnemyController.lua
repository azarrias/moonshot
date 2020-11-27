EnemyController = Class{__includes=tiny.Script}

function EnemyController:init()
  tiny.Script.init(self, 'EnemyController')
  self.speed_x = 100
  self.movement = nil
  
  self.gunshots = {}
  self.gunCooldown = 0.5
  
  self.canShootGun = true
end

function EnemyController:update(dt)
  local position = self.entity.position
  position.x = position.x - self.speed_x * dt
  if self.movement == 'straight-diagonal' and position.x < VIRTUAL_SIZE.x / 2 then
    position.y = position.y + self.speed_y * 0.5 * dt
  end
  if self.movement == 'shooting' then
    if self.canShootGun then
      self.canShootGun = false
      self:FireGun(position)
      Timer.after(self.gunCooldown,
        function() self.canShootGun = true end)
    end
  end
  
  for k, gunshot in ipairs(self.gunshots) do
    gunshot:update(dt)
  end
end

function EnemyController:FireGun()
  local gunshot = Gunshot(self.entity.position + tiny.Vector2D(16, 1), 'enemy')
  table.insert(self.gunshots, gunshot)
end