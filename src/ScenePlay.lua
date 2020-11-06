ScenePlay = Class{__includes=tiny.Scene}

function ScenePlay:init()
  self.player = self:CreatePlayer()
  self.sky = Sky()
end

function ScenePlay:update(dt)
  self.player:update(dt)
end

function ScenePlay:render()
  self.sky:render()
  self.player:render()
end

function ScenePlay:CreatePlayer()
  local player = tiny.Entity(math.floor(VIRTUAL_SIZE.x / 2), math.floor(VIRTUAL_SIZE.y / 2))
  
  -- sprite component
  local playerSprite = tiny.Sprite(TEXTURES['player'], QUADS['player'][2])
  player:AddComponent(playerSprite)
  
  -- register controller script
  local playerController = player:AddScript('PlayerController')
  
  return player
end