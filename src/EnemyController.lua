EnemyController = Class{__includes=tiny.Script}

function EnemyController:init()
  tiny.Script.init(self, 'EnemyController')
  self.speed_x = 100
  self.speed_y = nil
  self.movement = nil
  self.shooting = nil
  
  self.gunshots = {}
  self.gunCooldown = 0.6
  
  self.canShootGun = true
  self.engagingMargin = tiny.Vector2D(VIRTUAL_SIZE.x / 2, PLAYER_SIZE.y)
  
  self.level = nil
end

function EnemyController:update(dt)
  local position = self.entity.position
  position.x = position.x - self.speed_x * dt
  if self.movement == 'straight-diagonal' and position.x < VIRTUAL_SIZE.x / 2 then
    position.y = position.y + self.speed_y * 0.5 * dt
  end
  if self.shooting then
    if self.canShootGun and position.x < VIRTUAL_SIZE.x then
      for k, pod in ipairs(self.level.pods) do
        if math.abs(position.y - pod.position.y) < self.engagingMargin.y and
          position.x - pod.position.x < self.engagingMargin.x and
          position.x - pod.position.x > POD_SIZE.x / 2 then
            self.canShootGun = false
            self:FireGun(position)
            Timer.after(self.gunCooldown,
              function() self.canShootGun = true end)
            break
        end
      end
      if math.abs(position.y - self.level.player.position.y) < self.engagingMargin.y and
        position.x - self.level.player.position.x < self.engagingMargin.x and
        position.x - self.level.player.position.x > PLAYER_SIZE.x / 2 then
          self.canShootGun = false
          self:FireGun(position)
          Timer.after(self.gunCooldown,
            function() self.canShootGun = true end)
      end
    end
  end
  
  for k, gunshot in ipairs(self.gunshots) do
    gunshot:update(dt)
  end
end

function EnemyController:FireGun()
  local gunshot = Gunshot(self.entity.position + tiny.Vector2D(-16, 6), 'enemy')
  table.insert(self.gunshots, gunshot)
end