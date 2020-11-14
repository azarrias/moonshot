PlayerController = Class{__includes=tiny.Script}

function PlayerController:init()
  tiny.Script.init(self, 'PlayerController')
  self.speed = 200
  --self.current_quad_id = 2
  self.current_quad_id = 1
  
  self.laserBeamShader = love.graphics.newShader("shaders/laser_beam.fs")
  self.laserBeamShader:send("resolution", { VIRTUAL_SIZE.x, VIRTUAL_SIZE.y })
  self.laserBeamStartTime = nil
  self.laserBeamDuration = 0.5
end

function PlayerController:update(dt)
  local position = self.entity.position
  local upper_bound = math.floor(PLAYER_SIZE.y / 2 + VIRTUAL_SIZE.y / 20)
  local lower_bound = math.floor(VIRTUAL_SIZE.y - PLAYER_SIZE.y / 2 - VIRTUAL_SIZE.y / 20)
  local left_bound = math.floor(PLAYER_SIZE.x / 2 + VIRTUAL_SIZE.x / 20)
  local right_bound = math.floor(VIRTUAL_SIZE.x - PLAYER_SIZE.x / 2 - VIRTUAL_SIZE.x / 30)
  
  -- handle input
  -- shoot laser beam
  if love.keyboard.keysPressed['space'] then
    self.laserBeamStartTime = love.timer.getTime()
    self.laserBeamTimer = Timer.after(self.laserBeamDuration, 
      function() self.laserBeamStartTime = nil end)
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
    self.laserBeamShader:send("position", { position.x + 24, position.y + 1 })
  end
end
