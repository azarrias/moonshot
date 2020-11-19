Level = Class{}

function Level:init(levelNum)
  self.num = levelNum
  
  self.data = LEVELS[self.num]
  
  self.bgSky = SkyLayer(20)
  self.mgSky = SkyLayer(25)
  self.fgSky = SkyLayer(30)
  
  self.enemies = {}
  for k, enemyX in ipairs(self.data.enemies) do
    table.insert(self.enemies, self:CreateEnemy(enemyX, VIRTUAL_SIZE.y / 2))
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
  
  local sprite = tiny.Sprite(TEXTURES['enemy'], QUADS['enemy-moving'][1])
  enemy:AddComponent(sprite)
  
  local enemyController = enemy:AddScript('EnemyController')
  enemyController.cameraSpeedX = self.bgSky.cameraSpeedX
  
  local collider = tiny.Collider(tiny.Vector2D(0, 0), ENEMY_SIZE - tiny.Vector2D(4, 4))
  enemy:AddComponent(collider)
  
  -- create animator controller and setup parameters
  local animatorController = tiny.AnimatorController('EnemyAnimatorController')
  enemy:AddComponent(animatorController)
  --animatorController:AddParameter('MoveDown', tiny.AnimatorControllerParameterType.Bool)
  --animatorController:AddParameter('MoveUp', tiny.AnimatorControllerParameterType.Bool)
  --animatorController:AddParameter('MoveLeft', tiny.AnimatorControllerParameterType.Bool)
  --animatorController:AddParameter('MoveRight', tiny.AnimatorControllerParameterType.Bool)
  --animatorController:AddParameter("Shoot", tiny.AnimatorControllerParameterType.Trigger)
  
  -- create state machine states (first state to be created will be the default state)
  local movingFrameDuration = 0.2
  local stateMoving = animatorController:AddAnimation('Moving')
  stateMoving.animation:AddFrame(TEXTURES['enemy'], QUADS['enemy-moving'][1], movingFrameDuration)
  stateMoving.animation:AddFrame(TEXTURES['enemy'], QUADS['enemy-moving'][2], movingFrameDuration)
  stateMoving.animation:AddFrame(TEXTURES['enemy'], QUADS['enemy-moving'][3], movingFrameDuration)
  stateMoving.animation:AddFrame(TEXTURES['enemy'], QUADS['enemy-moving'][4], movingFrameDuration)
  stateMoving.animation:AddFrame(TEXTURES['enemy'], QUADS['enemy-moving'][5], movingFrameDuration)
  stateMoving.animation:AddFrame(TEXTURES['enemy'], QUADS['enemy-moving'][6], movingFrameDuration)
  
  return enemy
end