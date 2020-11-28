Level = Class{}

function Level:init(player, levelNum)
  self.num = levelNum
  
  self.data = LEVELS[self.num]
  
  self.bgSky = SkyLayer(20)
  self.mgSky = SkyLayer(25)
  self.fgSky = SkyLayer(30)
  
  self.player = player
  self.playerController = self.player.components['Script']['PlayerController']
  self.playerController.canInput = false
  self.player.position = tiny.Vector2D(-PLAYER_SIZE.x, VIRTUAL_SIZE.y / 2)
  
  self.pods = {}
  if self.data.pods then
    for k, p in ipairs(self.data.pods) do
      table.insert(self.pods, self:CreatePod(p.position))
    end
  end
  
  self.enemies = {}
  for k, e in ipairs(self.data.enemies) do
    table.insert(self.enemies, self:CreateEnemy(e.type_id, e.position, e.movement, e.shooting))
  end
  
  -- level transitions
  self.fadeInDuration = 2
  self.fadeIn = Fade({0, 0, 0, 1}, {0, 0, 0, 0}, self.fadeInDuration,
    function() 
      self.fadeIn = nil
    end)
  
  self.fadeOutDuration = 1
  self.fadeOut = nil
   
  Timer.after(self.fadeInDuration + 1, function()
    Timer.tween(1, {
      [self.player.position] = { x = PLAYER_SIZE.x * 2 }
    })
    :finish(function() 
              if self.data.dialogue then
                -- push in reverse order, since it is a stack based FSM
                for k = #self.data.dialogue, 1, -1 do
                  gameManager:Push(StateDialogue(self.data.dialogue[k].speaker, self.data.dialogue[k].message, function() end))
                end
              end
              self.playerController.canInput = true 
            end)
  end)

  self.explosions = {}
end

function Level:update(dt)
  self.bgSky:update(dt)
  self.mgSky:update(dt)
  self.fgSky:update(dt)
  
  for k, pod in ipairs(self.pods) do
    pod:update(dt)
  end
  
  for k, enemy in ipairs(self.enemies) do
    enemy:update(dt)
  end
  
  for k = #self.explosions, 1, -1 do
    local explosion = self.explosions[k]
    explosion:update(dt)
    if explosion.particleSystem:getCount() == 0 then
      table.remove(self.explosions, k)
    end
  end
  
  -- check for collisions between player and enemies
  -- iterate backwards for safe removal
  if not self.playerController.invulnerable then
    for k = #self.enemies, 1, -1 do
      if self.enemies[k].components['Collider'] then
        if self.player.components['Collider'][1]:Collides(self.enemies[k].components['Collider'][1]) then
          table.remove(self.enemies, k)
          self.playerController:TakeDamage(1)
          if self.playerController.hp <= 0 then
            local playerFadeOutDuration = 5
            gameManager:Push(StateGameOver(self, playerFadeOutDuration))
            self.playerController.invulnerable = true
            local sprite = self.player.components['Sprite']
            Timer.tween(playerFadeOutDuration, {
              [sprite.color] = { 1, 1, 1, 0 }
            })
          else
            self.playerController:MakeInvulnerable(1.5)
          end
        end
      end
    end
  end
  
  for i = #self.playerController.gunshots, 1, -1 do
    -- destroy them once they get out of bounds
    if self.playerController.gunshots[i].entity.position.x > VIRTUAL_SIZE.x then
      table.remove(self.playerController.gunshots, i)
      break
    end
    
    -- check for collisions between gunshots and enemies
    for j = #self.enemies, 1, -1 do
      if self.playerController.gunshots[i].entity.components['Collider'][1]:Collides(self.enemies[j].components['Collider'][1]) then
        local explosion = Explosion(self.enemies[j].position, 50)
        table.insert(self.explosions, explosion)
        table.remove(self.enemies, j)
        table.remove(self.playerController.gunshots, i)
        self.playerController:GetPoints(1)
        break
      end
    end
  end
end

function Level:render()
  self.bgSky:render()
  self.mgSky:render()
  self.fgSky:render()
  
  for k, pod in ipairs(self.pods) do
    pod:render()
  end
  
  for k, enemy in ipairs(self.enemies) do
    enemy:render()
    local controller = enemy.components['Script']['EnemyController']
    for i, gunshot in ipairs(controller.gunshots) do
      gunshot:render()
    end
  end
  
  for k, explosion in ipairs(self.explosions) do
    explosion:render()
  end
  
  if self.fadeIn then
    self.fadeIn:render()
 end
end

function Level:CreateEnemy(type_id, pos, movement, shooting)
  local enemy = tiny.Entity(pos.x, pos.y)
  
  -- variables that depend on the type of enemy (sprite)
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
  enemyController.speed_y = enemy.position.y < VIRTUAL_SIZE.y / 2 and enemyController.speed_x or -enemyController.speed_x
  enemyController.level = self
  
  if movement then
    enemyController.movement = movement
  else
    enemyController.movement = 'straight'
  end
  
  if shooting then
    enemyController.shooting = shooting
  else
    enemyController.shooting = false
  end
  
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

function Level:CreatePod(pos)
  local pod = tiny.Entity(pos.x, pos.y)
    
  local sprite = tiny.Sprite(TEXTURES['pod'])
  pod:AddComponent(sprite)
  
  local colliderCenter = tiny.Vector2D(0, 0)
  local colliderSize = POD_SIZE - tiny.Vector2D(8, 8)
  
  local collider = tiny.Collider(colliderCenter, colliderSize)
  pod:AddComponent(collider)
  
  local controller = pod:AddScript('PodController')
  
  return pod
end