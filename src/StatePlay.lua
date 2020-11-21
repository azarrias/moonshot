StatePlay = Class{__includes=tiny.State}

function StatePlay:init()
  self.hud = nil
  self.points = 0
  self.level = nil
  self.player = self:CreatePlayer()
  self.playerController = self.player.components['Script']['PlayerController']
  self:NewLevel()
end

function StatePlay:NewLevel()
  local levelNum = self.level ~= nil and self.level.num ~= nil and self.level.num + 1 or 1
  self.level = Level(self.player, levelNum)
  self.hud = HUD(self.playerController, levelNum, self.points)
  self.playerController.hud = self.hud
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
  for k, gunshot in ipairs(self.playerController.gunshots) do
    gunshot:render()
  end
end

function StatePlay:CreatePlayer()
  local player = tiny.Entity(math.floor(VIRTUAL_SIZE.x / 2), math.floor(VIRTUAL_SIZE.y / 2))
  
  local sprite = tiny.Sprite(TEXTURES['player'], QUADS['player-idle'][1])
  player:AddComponent(sprite)
  
  local playerController = player:AddScript('PlayerController')
  
  local collider = tiny.Collider(tiny.Vector2D(-1, 2), PLAYER_SIZE - tiny.Vector2D(18, 10))
  player:AddComponent(collider)
  
  -- create animator controller and setup parameters
  local animatorController = tiny.AnimatorController('PlayerAnimatorController')
  player:AddComponent(animatorController)
  animatorController:AddParameter('MoveDown', tiny.AnimatorControllerParameterType.Bool)
  animatorController:AddParameter('MoveUp', tiny.AnimatorControllerParameterType.Bool)
  animatorController:AddParameter('MoveLeft', tiny.AnimatorControllerParameterType.Bool)
  animatorController:AddParameter('MoveRight', tiny.AnimatorControllerParameterType.Bool)
  animatorController:AddParameter("Shoot", tiny.AnimatorControllerParameterType.Trigger)
  
  -- create state machine states (first state to be created will be the default state)
  local idleFrameDuration = 0.2
  local movingFrameDuration = 0.2
  local shootingFrameDuration = 0.1
  local stateIdle = animatorController:AddAnimation('Idle')
  stateIdle.animation:AddFrame(TEXTURES['player'], QUADS['player-idle'][1], idleFrameDuration)
  stateIdle.animation:AddFrame(TEXTURES['player'], QUADS['player-idle'][2], idleFrameDuration)
  stateIdle.animation:AddFrame(TEXTURES['player'], QUADS['player-idle'][3], idleFrameDuration)
  stateIdle.animation:AddFrame(TEXTURES['player'], QUADS['player-idle'][4], idleFrameDuration)
  local stateShooting = animatorController:AddAnimation('Shooting')
  stateShooting.animation:AddFrame(TEXTURES['player'], QUADS['player-shoot'][1], shootingFrameDuration)
  stateShooting.animation:AddFrame(TEXTURES['player'], QUADS['player-shoot'][2], shootingFrameDuration)
  stateShooting.animation:AddFrame(TEXTURES['player'], QUADS['player-shoot'][3], shootingFrameDuration)
  local stateMovingRight = animatorController:AddAnimation('MovingRight')
  stateMovingRight.animation:AddFrame(TEXTURES['player'], QUADS['player-right'][1], movingFrameDuration)
  stateMovingRight.animation:AddFrame(TEXTURES['player'], QUADS['player-right'][2], movingFrameDuration)
  stateMovingRight.animation:AddFrame(TEXTURES['player'], QUADS['player-right'][3], movingFrameDuration)
  stateMovingRight.animation:AddFrame(TEXTURES['player'], QUADS['player-right'][4], movingFrameDuration)
  local stateMovingLeft = animatorController:AddAnimation('MovingLeft')
  stateMovingLeft.animation:AddFrame(TEXTURES['player'], QUADS['player-left'][1], movingFrameDuration)
  stateMovingLeft.animation:AddFrame(TEXTURES['player'], QUADS['player-left'][2], movingFrameDuration)
  stateMovingLeft.animation:AddFrame(TEXTURES['player'], QUADS['player-left'][3], movingFrameDuration)
  stateMovingLeft.animation:AddFrame(TEXTURES['player'], QUADS['player-left'][4], movingFrameDuration)
  local stateMovingUp = animatorController:AddAnimation('MovingUp')
  stateMovingUp.animation:AddFrame(TEXTURES['player'], QUADS['player-up'][1], movingFrameDuration)
  stateMovingUp.animation:AddFrame(TEXTURES['player'], QUADS['player-up'][2], movingFrameDuration)
  local stateMovingDown = animatorController:AddAnimation('MovingDown')
  stateMovingDown.animation:AddFrame(TEXTURES['player'], QUADS['player-down'][1], movingFrameDuration)
  stateMovingDown.animation:AddFrame(TEXTURES['player'], QUADS['player-down'][2], movingFrameDuration)

  -- animation states behaviours
  --stateMovingLeft:AddStateMachineBehaviour('BehaviourPlayerMovingLeft')
  --stateMovingRight:AddStateMachineBehaviour('BehaviourPlayerMovingRight')
  --stateMovingUp:AddStateMachineBehaviour('BehaviourPlayerMovingUp')
  --stateMovingDown:AddStateMachineBehaviour('BehaviourPlayerMovingDown')
  --stateShooting:AddStateMachineBehaviour('BehaviourPlayerShooting')
  
  -- transitions and conditions
  local anyToShootingTransition = animatorController.stateMachine:AddAnyStateTransition(stateShooting)
  anyToShootingTransition:AddCondition('Shoot', tiny.AnimatorConditionOperatorType.Equals, true)
  local shootingToIdleTransition = animatorController.stateMachine.states[stateShooting.name]:AddTransition(stateIdle)
  shootingToIdleTransition.exitTime = 1
  shootingToIdleTransition:AddCondition('MoveDown', tiny.AnimatorConditionOperatorType.Equals, false)
  shootingToIdleTransition:AddCondition('MoveLeft', tiny.AnimatorConditionOperatorType.Equals, false)
  shootingToIdleTransition:AddCondition('MoveRight', tiny.AnimatorConditionOperatorType.Equals, false)
  shootingToIdleTransition:AddCondition('MoveUp', tiny.AnimatorConditionOperatorType.Equals, false)
  local idleToMovingDownTransition = animatorController.stateMachine.states[stateIdle.name]:AddTransition(stateMovingDown)
  idleToMovingDownTransition:AddCondition('MoveDown', tiny.AnimatorConditionOperatorType.Equals, true)
  local idleToMovingLeftTransition = animatorController.stateMachine.states[stateIdle.name]:AddTransition(stateMovingLeft)
  idleToMovingLeftTransition:AddCondition('MoveLeft', tiny.AnimatorConditionOperatorType.Equals, true)
  local idleToMovingRightTransition = animatorController.stateMachine.states[stateIdle.name]:AddTransition(stateMovingRight)
  idleToMovingRightTransition:AddCondition('MoveRight', tiny.AnimatorConditionOperatorType.Equals, true)
  local idleToMovingUpTransition = animatorController.stateMachine.states[stateIdle.name]:AddTransition(stateMovingUp)
  idleToMovingUpTransition:AddCondition('MoveUp', tiny.AnimatorConditionOperatorType.Equals, true)
  local movingDownToIdleTransition = animatorController.stateMachine.states[stateMovingDown.name]:AddTransition(stateIdle)
  movingDownToIdleTransition:AddCondition('MoveDown', tiny.AnimatorConditionOperatorType.Equals, false)
  local movingLeftToIdleTransition = animatorController.stateMachine.states[stateMovingLeft.name]:AddTransition(stateIdle)
  movingLeftToIdleTransition:AddCondition('MoveLeft', tiny.AnimatorConditionOperatorType.Equals, false)
  local movingRightToIdleTransition = animatorController.stateMachine.states[stateMovingRight.name]:AddTransition(stateIdle)
  movingRightToIdleTransition:AddCondition('MoveRight', tiny.AnimatorConditionOperatorType.Equals, false)
  local movingUpToIdleTransition = animatorController.stateMachine.states[stateMovingUp.name]:AddTransition(stateIdle)
  movingUpToIdleTransition:AddCondition('MoveUp', tiny.AnimatorConditionOperatorType.Equals, false)

  return player
end