ScenePlay = Class{__includes=tiny.Scene}

function ScenePlay:init()
  self.player = self:CreatePlayer()
  self.bgSky = SkyLayer(20)
  self.mgSky = SkyLayer(25)
  self.fgSky = SkyLayer(30)
  
  self.shader = love.graphics.newShader("shaders/laser_beam.fs")
  self.shader:send("resolution", { VIRTUAL_SIZE.x, VIRTUAL_SIZE.y })
  self.start_time = love.timer.getTime()
end

function ScenePlay:update(dt)
  self.bgSky:update(dt)
  self.mgSky:update(dt)
  self.fgSky:update(dt)
  self.player:update(dt)
  self.shader:send("time", love.timer.getTime() - self.start_time)
  self.shader:send("position", { self.player.position.x + 24, self.player.position.y + 1 })
end

function ScenePlay:render()
  self.bgSky:render()
  self.mgSky:render()
  self.fgSky:render()
  self.player:render()
  love.graphics.setShader(self.shader)
  love.graphics.setColor(1, 0, 0, 0)
  love.graphics.rectangle('fill', 0, 0, VIRTUAL_SIZE.x * 5, VIRTUAL_SIZE.y)
  love.graphics.setShader()
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