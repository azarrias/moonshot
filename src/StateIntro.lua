StateIntro = Class{__includes=tiny.State}

function StateIntro:init()
  self.bgSky = SkyLayer(0)
  
  -- level transitions
  self.fadeColor = {0, 0, 0, 0.4}
  self.fadeInDuration = 2
  self.fadeIn = Fade({0, 0, 0, 1}, {0, 0, 0, 0.4}, self.fadeInDuration,
    function() 
      self.fadeIn = nil
      Timer.every(2, function()
        Timer.tween(1, {
          [self.fadeColor] = { 0, 0, 0, 0.4 },
        })
        :finish(function()
          Timer.tween(1, {
            [self.fadeColor] = { 0, 0, 0, 0.6 }
          })
        end)
      end)
    end)
  
  self.text = {
    { string = "\n\n\n\n\n\n\nYear 2678.\n\nIt has been a couple hundred years since\nhumanity started populating\nsettlements on the Moon.\n\nWe live in the era of space\nexploration and development.\n\nThe excitement in the space and\naeronautics communities hit its peak\nwhen the Ulnods, an alien species\nfirst contacted us.\n\nSoon enough we found out that\ntheir intentions were not so kind,\nand after a few failed attempts by\ndiplomats trying to reach an understanding,\nthe Ulnods began the hostilities.\n\nFirst they attacked and destroyed the\nMoon, and now they are coming for the Earth.\n\nThis crisis calls for desperate measures.\nYou must reach the Moon remains asap,\nhelp the surviving to get away in one piece,\nand destroy all hostiles on your way there.\n\nWe trust you with this huge\nresponsibility, SR Comet.\n\nAll our hopes are on you.", font = FONTS['retro-m'], textColor = {0.5, 0.1, 0.5} },
  }
  
  self.textPos = 0
  self.destroying = false
end

function StateIntro:update(dt)
  --self.bgSky:update(dt)
  if not self.destroying then
    if self.textPos < -2150 then
      self.destroying = true
      local fadeOutDuration = 2
      Timer.after(0.5, function()
        self.fadeOut = Fade({0, 0, 0, 0}, {0, 0, 0, 1}, fadeOutDuration,
          function()
            gameManager:Pop()
            gameManager:Push(StatePlay())
          end)
      end)
    else
      if love.keyboard.isDown('space') or love.keyboard.isDown('kpenter') or love.keyboard.isDown('return') or love.mouse.isDown(1) then
        self.textPos = self.textPos - 200 * dt
      else
        self.textPos = self.textPos - 40 * dt
      end
    end
  end
end

function StateIntro:render()
  self.bgSky:render()
  
  if self.fadeIn == nil then
    love.graphics.setColor(self.fadeColor)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_SIZE.x, VIRTUAL_SIZE.y)
  end
  
  RenderCenteredText(self.text, math.floor(self.textPos + 0.5))
  
  if self.fadeIn then
    self.fadeIn:render()
  end
  
  if self.fadeOut then
    self.fadeOut:render()
  end
end
