Gunshot = Class{}

function Gunshot:init(pos, shotType)
  self.entity = tiny.Entity(pos.x, pos.y)
  self.speed = 300
  self.length = 8
  self.height = 3
  self.color = { 199 / 255, 36 / 255, 177 / 255 }
  
  if shotType and shotType == 'enemy' then
    self.speed = -300
    self.length = 12
    self.height = 2
    self.color = { 21 / 255, 244 / 256, 238 / 255 }
  end
  
  local collider = tiny.Collider(tiny.Vector2D(0, math.floor(self.height / 2)), tiny.Vector2D(self.length, self.height))
  self.entity:AddComponent(collider)
end

function Gunshot:update(dt)
  self.entity.position.x = self.entity.position.x + self.speed * dt
end

function Gunshot:render()
  love.graphics.setColor(self.color)
  love.graphics.setLineWidth(self.height)
  love.graphics.line(math.floor(self.entity.position.x - self.length / 2), self.entity.position.y,
    math.floor(self.entity.position.x + self.length / 2), self.entity.position.y)
end