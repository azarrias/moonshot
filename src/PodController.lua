PodController = Class{__includes=tiny.Script}

function PodController:init()
  tiny.Script.init(self, 'PodController')
  self.speed_x = 40
end

function PodController:update(dt)
  local position = self.entity.position
  position.x = position.x - self.speed_x * dt
end