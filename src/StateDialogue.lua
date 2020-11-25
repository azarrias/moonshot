StateDialogue = Class{__includes = tiny.State}

function StateDialogue:init(speaker, text, callback)
  self.size = tiny.Vector2D(0.7 * VIRTUAL_SIZE.x, 0.2 * VIRTUAL_SIZE.y):Floor()
  self.leftMargin = math.floor((VIRTUAL_SIZE.x - self.size.x) / 2)
  self.bottomMargin = VIRTUAL_SIZE.y * 0.1
  self.avatarSize = tiny.Vector2D(69, 87)
  self.avatar = self:CreateAvatar()
  self.textbox = Textbox(self.leftMargin + self.avatarSize.x, VIRTUAL_SIZE.y - self.size.y - self.bottomMargin, 
    VIRTUAL_SIZE.x - self.leftMargin * 2 - self.avatarSize.x, self.size.y, text, FONTS['retroville-s'])
  self.speaker = speaker
  self.speakerTabBorderColor = self.textbox.panel.borderColor
  self.speakerTabBodyColor = self.textbox.panel.bodyColor  
  self.callback = callback or function() end
  self.destroying = false
end

function StateDialogue:update(dt)
  self.textbox:update(dt)
  self.avatar:update(dt)
  
  if self.textbox:isClosed() and not self.destroying then
    local avatarFadeOutDuration = 0.5
    local sprite = self.avatar.components['Sprite']
    self.destroying = true
    Timer.tween(avatarFadeOutDuration, {
      [sprite.color] = { 1, 1, 1, 0 },
      [self.textbox.triangleColor] = { 1, 1, 1, 0 },
      [self.textbox.panel.borderColor] = { 0, 0, 0, 0 },
      [self.textbox.panel.bodyColor] = { 0, 0, 0, 0 }
    })
    :finish(function()
      self.callback()
      gameManager:Pop()
    end)
  end
end

function StateDialogue:render()
  self.textbox:render()
  self.avatar:render()
  
  -- draw tab with the name of the speaker
  love.graphics.setColor(self.textbox.panel.borderColor)
  love.graphics.rectangle('fill', self.textbox.x + 30, self.textbox.y - 20, 100, 22, 3)
  love.graphics.setColor(self.textbox.panel.borderColor)
  love.graphics.rectangle('fill', self.textbox.x + 30 + 2, self.textbox.y - 20 + 2, 100 - 4, 22, 3)
  
  if not self.textbox.closed then  
    love.graphics.setFont(FONTS['retroville-s'])
    love.graphics.setColor(0.4, 0.3, 0.2, 1)
    love.graphics.print(self.speaker, self.textbox.x + 30 + 2 + 10, self.textbox.y - 20 + 2 + 3)
  end
  
  love.graphics.setColor(1, 1, 1, 1)
end

function StateDialogue:CreateAvatar()
  local avatar = tiny.Entity(self.leftMargin + self.avatarSize.x / 2, VIRTUAL_SIZE.y - self.size.y - self.bottomMargin - 10 + self.avatarSize.y / 2)
  
  local sprite = tiny.Sprite(TEXTURES['boss-101'])
  avatar:AddComponent(sprite)
  
  -- create animator controller and setup parameters
  local animatorController = tiny.AnimatorController('AvatarAnimatorController')
  avatar:AddComponent(animatorController)
  
  -- create state machine states (first state to be created will be the default state)
  local talkingFrameDuration = 0.2
  local stateTalking = animatorController:AddAnimation('Talking')
  stateTalking.animation:AddFrame(TEXTURES['boss-101'])
  stateTalking.animation:AddFrame(TEXTURES['boss-102'])
  stateTalking.animation:AddFrame(TEXTURES['boss-101'])
  stateTalking.animation:AddFrame(TEXTURES['boss-102'])
  stateTalking.animation:AddFrame(TEXTURES['boss-101'])
  stateTalking.animation:AddFrame(TEXTURES['boss-102'])
  stateTalking.animation:AddFrame(TEXTURES['boss-101'])
  stateTalking.animation:AddFrame(TEXTURES['boss-102'])
  stateTalking.animation:AddFrame(TEXTURES['boss-103'])
  
  for k, frame in ipairs(stateTalking.animation.frames) do
    frame.duration = talkingFrameDuration
  end
  
  return avatar
end