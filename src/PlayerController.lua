PlayerController = Class{__includes=tiny.Script}

function PlayerController:init()
  tiny.Script.init(self, 'PlayerController')
  self.speed = 200
  
  self.gunshots = {}
  self.gunCooldown = 0.3
  self.laserBeamShader = love.graphics.newShader("shaders/laser_beam.fs")
  self.laserBeamShader:send("resolution", { VIRTUAL_SIZE.x, VIRTUAL_SIZE.y })
  self.laserBeamStartTime = nil
  self.laserBeamDuration = 0.8
  self.laserBeamCooldown = 1.5
  self.canShootGun = true
  self.canShootLaser = true
  
  self.hp = 3
  self.hud = nil

  self.invulnerable = false
  self.flashingInterval = 0.1
  
  self.canInput = true
end

function PlayerController:update(dt)
  if not self.canInput then
    return
  end
  
  local position = self.entity.position
  local upper_bound = math.floor(PLAYER_SIZE.y / 2 + VIRTUAL_SIZE.y / 20)
  local lower_bound = math.floor(VIRTUAL_SIZE.y - PLAYER_SIZE.y / 2 - VIRTUAL_SIZE.y / 20)
  local left_bound = math.floor(PLAYER_SIZE.x / 2 + VIRTUAL_SIZE.x / 20)
  local right_bound = math.floor(VIRTUAL_SIZE.x - PLAYER_SIZE.x / 2 - VIRTUAL_SIZE.x / 30)
  
  -- update the animator controller's parameters with the given input
  local playerAnimatorController = self.entity.components['AnimatorController']
  
  local isDownDown = love.keyboard.isDown('down')
  local isDownUp = love.keyboard.isDown('up')
  local isDownLeft = love.keyboard.isDown('left')
  local isDownRight = love.keyboard.isDown('right')
  
  playerAnimatorController:SetValue('MoveDown', isDownDown)
  playerAnimatorController:SetValue('MoveUp', isDownUp)
  playerAnimatorController:SetValue('MoveLeft', isDownLeft)
  playerAnimatorController:SetValue('MoveRight', isDownRight)
  
  if love.keyboard.keysPressed['space'] and self.canShootGun then
    self.canShootGun = false
    playerAnimatorController:SetTrigger('Shoot')
    self:FireGun(position)
    Timer.after(self.gunCooldown,
      function() self.canShootGun = true end)
  end
  
  if love.keyboard.keysPressed['m'] and self.canShootLaser then
    self.laserBeamStartTime = love.timer.getTime()
    self.canShootLaser = false
    playerAnimatorController:SetTrigger('Shoot')
    Timer.after(self.laserBeamDuration, 
      function() self.laserBeamStartTime = nil end)
    Timer.after(self.laserBeamCooldown, 
      function() self.canShootLaser = true end)
  end
  
  if not love.keyboard.isDown('down') and not love.keyboard.isDown('up') then
    --if self.current_quad_id ~= 2 then
    --  self.entity.components['Sprite']:SetDrawable(TEXTURES['player'], QUADS['player'][2])
    --  self.current_quad_id = 2
    --end
  else
    if love.keyboard.isDown('down') then
      position.y = position.y + self.speed * dt
    --  if self.current_quad_id ~= 3 then
    --    self.entity.components['Sprite']:SetDrawable(TEXTURES['player'], QUADS['player'][3])
    --    self.current_quad_id = 3
    --  end
      if position.y >= lower_bound then
        position.y = lower_bound
      end
    end
    if love.keyboard.isDown('up') then
      position.y = position.y - self.speed * dt
    --  if self.current_quad_id ~= 1 then
    --    self.entity.components['Sprite']:SetDrawable(TEXTURES['player'], QUADS['player'][1])
    --    self.current_quad_id = 1
    --  end
      if position.y <= upper_bound then
        position.y = upper_bound
      end
    end
  end
  if love.keyboard.isDown('right') then
    position.x = position.x + self.speed * dt
    if position.x >= right_bound then
      position.x = right_bound
    end
  end
  if love.keyboard.isDown('left') then
    position.x = position.x - self.speed * dt
    if position.x <= left_bound then
      position.x = left_bound
    end
  end
  
  -- if a laser beam has been shot, the shader will be active, pass it uniform variables
  if self.laserBeamStartTime then
    self.laserBeamShader:send("time", love.timer.getTime() - self.laserBeamStartTime)
    self.laserBeamShader:send("position", { position.x + 42, position.y + 1 })
  end
  
  for k, gunshot in ipairs(self.gunshots) do
    gunshot:update(dt)
  end
end

function PlayerController:FireGun()
  local gunshot = Gunshot(self.entity.position + tiny.Vector2D(16, 1))
  table.insert(self.gunshots, gunshot)
end

function PlayerController:MakeInvulnerable(duration)
  self.invulnerable = true
  local flashing = true
  local sprite = self.entity.components['Sprite']
  
  -- make the player's sprite flash when it is invulnerable
  Timer.every(self.flashingInterval, 
    function() 
      flashing = not flashing
      if sprite then
        if flashing then
          Timer.tween(self.flashingInterval, {
            [sprite.color] = { 1, 1, 1, 1 }
          })
        else
          Timer.tween(self.flashingInterval, {
            [sprite.color] = { 1, 1, 1, 64 / 255 }
          })         
        end
      end
    end)
    :finish(function() 
              self.invulnerable = false 
              sprite.color = { 1, 1, 1, 1 }
            end)
    :limit(math.floor(duration / self.flashingInterval))
end

function PlayerController:TakeDamage(value)
  self.hp = self.hp - value
  self.hud.hp = self.hp
end
