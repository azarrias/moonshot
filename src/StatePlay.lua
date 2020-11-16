StatePlay = Class{__includes=tiny.State}

function StatePlay:init()
  self.hud = nil
  self.points = 0
  self:NewLevel()
  self.player = self:CreatePlayer()
  self.playerController = self.player.components['Script']['PlayerController']
end

function StatePlay:NewLevel()
  local levelNum = self.level ~= nil and self.level.num ~= nil and self.level.num + 1 or 1
  self.level = Level(levelNum)
  self.hud = HUD(levelNum, self.points)
end

function StatePlay:enter()
end

function StatePlay:update(dt)
  self.level:update(dt)
  self.hud:update(dt)
  self.player:update(dt)
  if love.keyboard.keysPressed['p'] then
    print(self.level.bgSky.cameraOffsetX)
  end
  -- use the x camera offset of the background sky layer to check if level was cleared
  if self.level.bgSky.cameraOffsetX > self.level.data.finalXPos then
    if LEVELS[self.level.num + 1] ~= nil then
      gameManager:Push(StateLevelClear(self))
    else
      gameManager:Push(StateVictory(self.points))
    end
  end
end

function StatePlay:render()
  self.level:render()
  self.hud:render()
  self.player:render()
  if self.playerController.laserBeamStartTime then
    love.graphics.setShader(self.playerController.laserBeamShader)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_SIZE.x * 5, VIRTUAL_SIZE.y)
    love.graphics.setShader()
  end
end

function StatePlay:CreatePlayer()
  local player = tiny.Entity(math.floor(VIRTUAL_SIZE.x / 2), math.floor(VIRTUAL_SIZE.y / 2))
  local defaultQuadId = 1
  
  -- sprite component
  local playerSprite = tiny.Sprite(TEXTURES['player'], QUADS['player'][defaultQuadId])
  player:AddComponent(playerSprite)
  
  -- register controller script
  local playerController = player:AddScript('PlayerController')
  playerController.current_quad_id = defaultQuadId
  
  return player
end