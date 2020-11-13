ScenePlay = Class{__includes=tiny.Scene}

function ScenePlay:init()
  self.player = self:CreatePlayer()
  self.cameraOffsetX = 0
  self.cameraSpeedX = 15
  self.sky = SkyLayer()
end

function ScenePlay:update(dt)
  self.cameraOffsetX = self.cameraOffsetX + self.cameraSpeedX * dt
  self.sky:update(dt)
  self.player:update(dt)
end

function ScenePlay:render()
  love.graphics.push()
  love.graphics.translate(math.floor(-self.cameraOffsetX + 0.5), 0)
  self.sky:render()
  love.graphics.pop()
  self.player:render()
end

function ScenePlay:CreatePlayer()
  local player = tiny.Entity(math.floor(VIRTUAL_SIZE.x / 2), math.floor(VIRTUAL_SIZE.y / 2))
  local defaultQuadId = 2
  
  -- sprite component
  local playerSprite = tiny.Sprite(TEXTURES['player'], QUADS['player'][defaultQuadId])
  player:AddComponent(playerSprite)
  
  -- register controller script
  local playerController = player:AddScript('PlayerController')
  playerController.current_quad_id = defaultQuadId
  
  return player
end