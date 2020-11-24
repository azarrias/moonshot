StateDialogue = Class{__includes = tiny.State}

function StateDialogue:init(text, callback)
  self.leftMargin = 150
  self.bottomMargin = 30
  self.height = 64
  self.textbox = Textbox(self.leftMargin, VIRTUAL_SIZE.y - self.height - self.bottomMargin, 
    VIRTUAL_SIZE.x - self.leftMargin * 2, self.height, text, FONTS['retroville-s'])
  self.callback = callback or function() end
end

function StateDialogue:update(dt)
  self.textbox:update(dt)
  
  if self.textbox:isClosed() then
    self.callback()
    gameManager:Pop()
  end
end

function StateDialogue:render()
  self.textbox:render()
end