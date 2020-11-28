PodController = Class{__includes=tiny.Script}

function PodController:init()
  tiny.Script.init(self, 'PodController')
  self.speed_x = math.random(4000, 4500) / 100
end

function PodController:update(dt)
  local position = self.entity.position
  position.x = position.x - self.speed_x * dt
end