ScenePlay = Class{__includes=tiny.Scene}

function ScenePlay:init()
  self.player = self:CreatePlayer()
  self.sky = SkyLayer()
end

function ScenePlay:update(dt)
  self.sky:update(dt)
  self.player:update(dt)
end

function ScenePlay:render()
  self.sky:render()
  self.player:render()

  love.graphics.setFont(FONTS['retroville-s'])
  love.graphics.printf("cameraOffsetX: " .. math.floor(self.sky.cameraOffsetX), 5, 5, VIRTUAL_SIZE.x - 5, 'left')
end

function ScenePlay:CreatePlayer()
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