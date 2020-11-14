--[[
    constants
  ]]
GAME_TITLE = 'Moonshot'
DEBUG_MODE = true

-- OS checks in order to make necessary adjustments to support multiplatform
MOBILE_OS = (love._version_major > 0 or love._version_minor >= 9) and (love.system.getOS() == 'Android' or love.system.getOS() == 'OS X')
WEB_OS = (love._version_major > 0 or love._version_minor >= 9) and love.system.getOS() == 'Web'

-- libraries
Class = require 'libs.class'
push = require 'libs.push'
require 'libs.slam'
Timer = require 'libs.knife.timer'
tiny = require 'libs.tiny'

-- general purpose / utility
require 'HUD'
require 'Level'
require 'PlayerController'
require 'ScenePlay'
require 'SceneStart'
require 'SkyLayer'
require 'util'

-- data
require 'data.levels'

-- pixels resolution
WINDOW_SIZE = tiny.Vector2D(1920, 1080) -- 16:9 aspect ratio
VIRTUAL_SIZE = tiny.Vector2D(640, 360)
--PLAYER_SIZE = tiny.Vector2D(16, 10)
PLAYER_SIZE = tiny.Vector2D(32, 40)

-- resources
FONTS = {
  ['retro-l'] = love.graphics.newFont('fonts/retro.ttf', 64),
  ['retroville-s'] = love.graphics.newFont('fonts/Retroville NC.ttf', 10) -- 10px bitmap
}

TEXTURES = {
  --['player'] = love.graphics.newImage('graphics/player_placeholder.png')
  ['player'] = love.graphics.newImage('graphics/Sprite-0001.png')
}

QUADS = {
  --['player'] = GenerateQuads(TEXTURES['player'], 3, 1, PLAYER_SIZE)
  ['player'] = GenerateQuads(TEXTURES['player'], 2, 1, PLAYER_SIZE, tiny.Vector2D(30, 96), tiny.Vector2D(0, 13))
}