HUD = Class{}

function HUD:init(level, points)
  self.level = level
  self.points = points
end

function HUD:update(dt)

end

function HUD:render()
  love.graphics.setColor(0.5, 0.1, 0.5)
  love.graphics.setFont(FONTS['retroville-s'])
  love.graphics.printf("Level: " .. self.level, 5, 5, VIRTUAL_SIZE.x - 5, 'left')
  love.graphics.printf("Points: " .. self.points, 5, 5, VIRTUAL_SIZE.x - 5, 'center')
end