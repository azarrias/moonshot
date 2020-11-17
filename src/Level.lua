Level = Class{}

function Level:init(levelNum)
  self.num = levelNum
  
  self.data = LEVELS[self.num]
  
  self.bgSky = SkyLayer(20)
  self.mgSky = SkyLayer(25)
  self.fgSky = SkyLayer(30)
  
  self.enemies = {}
  for k, enemyX in ipairs(self.data.enemies) do
    table.insert(self.enemies, self:CreateEnemy(enemyX, VIRTUAL_SIZE.y / 2, DegreesToRadians(270), 0.25, 0.5))
  end
end

function Level:update(dt)
  self.bgSky:update(dt)
  self.mgSky:update(dt)
  self.fgSky:update(dt)
  
  for k, enemy in ipairs(self.enemies) do
    enemy:update(dt)
  end
end

function Level:render()
  self.bgSky:render()
  self.mgSky:render()
  self.fgSky:render()
  
  for k, enemy in ipairs(self.enemies) do
    love.graphics.push()
    love.graphics.translate(math.floor(-enemy.components['Script']['EnemyController'].cameraOffsetX + 0.5), 0)
    enemy:render()
    love.graphics.pop()
  end

end

function Level:CreateEnemy(posx, posy, rot, scalex, scaley)
  local enemy = tiny.Entity(posx, posy, rot, scalex, scaley)
  local quad_id = 1
  
  -- sprite component
  local enemySprite = tiny.Sprite(TEXTURES['enemies'], QUADS['enemies'][quad_id])
  enemy:AddComponent(enemySprite)
  
  -- register controller script
  local enemyController = enemy:AddScript('EnemyController')
  enemyController.cameraSpeedX = self.bgSky.cameraSpeedX
  
  return enemy
end