HUD = Class{}

function HUD:init(playerController, level, points)
  self.playerController = playerController
  self.level = level
  self.points = points
  self.hp = self.playerController.hp
end

function HUD:update(dt)

end

function HUD:render()
  love.graphics.setColor(0.5, 0.1, 0.5)
  love.graphics.setFont(FONTS['retroville-s'])
  love.graphics.printf("HP: " .. self.hp, 5, 5, VIRTUAL_SIZE.x - 5, 'left')
  love.graphics.printf("Level: " .. self.level, 5, 5, VIRTUAL_SIZE.x - 5, 'center')
  love.graphics.printf("Points: " .. self.points, 0, 5, VIRTUAL_SIZE.x - 5, 'right')
end
