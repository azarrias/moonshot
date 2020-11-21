Gunshot = Class{}

function Gunshot:init(pos)
  self.entity = tiny.Entity(pos.x, pos.y)
  self.speed = 300
  self.length = 6
end

function Gunshot:update(dt)
  self.entity.position.x = self.entity.position.x + self.speed * dt
end

function Gunshot:render()
  love.graphics.setColor(199 / 255, 36 / 255, 177 / 255)
  love.graphics.setLineWidth(3)
  love.graphics.line(math.floor(self.entity.position.x - self.length / 2), self.entity.position.y,
    math.floor(self.entity.position.x + self.length / 2), self.entity.position.y)
end