Sky = Class{}

function Sky:init()
  -- create image data from point on canvas
  local canvas = love.graphics.newCanvas(1, 1)
  love.graphics.setCanvas(canvas)
  love.graphics.clear()
  love.graphics.setColor(1, 1, 1)
  love.graphics.points(1, 1)
  love.graphics.setCanvas()
  self.starImage = love.graphics.newImage(canvas:newImageData())
  self.stars = {}
  for i = 1, 100 do
    self:AddStar(math.random(VIRTUAL_SIZE.x), math.random(VIRTUAL_SIZE.y))
  end
end

function Sky:AddStar(x, y)
  table.insert(self.stars, { x = x, y = y })
end

function Sky:render()
  for k, star in ipairs(self.stars) do
    love.graphics.draw(self.starImage, star.x, star.y, 0, 1, 1)
  end
end