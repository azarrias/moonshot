Level = Class{}

function Level:init(player, levelNum)
  self.num = levelNum
  
  self.data = LEVELS[self.num]
  
  self.bgSky = SkyLayer(20)
  self.mgSky = SkyLayer(25)
  self.fgSky = SkyLayer(30)
  
  self.enemies = {}
  for k, e in ipairs(self.data.enemies) do
    table.insert(self.enemies, self:CreateEnemy(e.type_id, e.position))
  end
  
  self.player = player
  self.playerController = self.player.components['Script']['PlayerController']
end

function Level:update(dt)
  self.bgSky:update(dt)
  self.mgSky:update(dt)
  self.fgSky:update(dt)
  
  for k, enemy in ipairs(self.enemies) do
    enemy:update(dt)
  end
  
  -- check for collisions between player and enemies
  -- iterate backwards for safe removal
  for k = #self.enemies, 1, -1 do
    if self.enemies[k].components['Collider'] then
      if self.player.components['Collider'][1]:Collides(self.enemies[k].components['Collider'][1]) then
        table.remove(self.enemies, k)
        self.playerController:TakeDamage(1)
      end
    end
  end
end

function Level:render()
  self.bgSky:render()
  self.mgSky:render()
  self.fgSky:render()
  
  for k, enemy in ipairs(self.enemies) do
    enemy:render()
  end
end

function Level:CreateEnemy(type_id, pos)
  local enemy = tiny.Entity(pos.x, pos.y)
  
  -- variables that depend on the type of enemy
  local enemySize = ENEMY_TYPE_1_SIZE
  if type_id == 2 then
    enemySize = ENEMY_TYPE_2_SIZE
  end
  
  local colliderCenter = tiny.Vector2D(0, 2)
  if type_id == 2 then
    colliderCenter = tiny.Vector2D(0, 0)
  end
  
  local colliderSize = enemySize - tiny.Vector2D(6, 10)
  if type_id == 2 then
    colliderSize = enemySize - tiny.Vector2D(6, 4)
  end
  
  local sprite = tiny.Sprite(TEXTURES['enemy_'..type_id], QUADS['enemy_'..type_id..'-moving'][1])
  enemy:AddComponent(sprite)
  
  local enemyController = enemy:AddScript('EnemyController')
  enemyController.cameraSpeedX = self.bgSky.cameraSpeedX
  enemyController.speed_y = enemy.position.y < VIRTUAL_SIZE.y / 2 and enemyController.speed_x or -enemyController.speed_x
  
  local collider = tiny.Collider(colliderCenter, colliderSize)
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
  stateMoving.animation:AddFrame(TEXTURES['enemy_'..type_id], QUADS['enemy_'..type_id..'-moving'][1], movingFrameDuration)
  stateMoving.animation:AddFrame(TEXTURES['enemy_'..type_id], QUADS['enemy_'..type_id..'-moving'][2], movingFrameDuration)
  stateMoving.animation:AddFrame(TEXTURES['enemy_'..type_id], QUADS['enemy_'..type_id..'-moving'][3], movingFrameDuration)
  stateMoving.animation:AddFrame(TEXTURES['enemy_'..type_id], QUADS['enemy_'..type_id..'-moving'][4], movingFrameDuration)
  stateMoving.animation:AddFrame(TEXTURES['enemy_'..type_id], QUADS['enemy_'..type_id..'-moving'][5], movingFrameDuration)
  stateMoving.animation:AddFrame(TEXTURES['enemy_'..type_id], QUADS['enemy_'..type_id..'-moving'][6], movingFrameDuration)
  
  return enemy
end