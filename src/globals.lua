--[[
    constants
  ]]
GAME_TITLE = 'Moonshot'
DEBUG_MODE = false

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
--require 'BehaviourPlayerMovingDown'
--require 'BehaviourPlayerMovingLeft'
--require 'BehaviourPlayerMovingRight'
--require 'BehaviourPlayerMovingUp'
--require 'BehaviourPlayerShooting'
require 'EnemyController'
require 'HUD'
require 'Level'
require 'PlayerController'
require 'StateLevelClear'
require 'StatePlay'
require 'StateStart'
require 'StateVictory'
require 'SkyLayer'
require 'util'

-- data
require 'data.levels'

-- pixels resolution
WINDOW_SIZE = tiny.Vector2D(1920, 1080) -- 16:9 aspect ratio
VIRTUAL_SIZE = tiny.Vector2D(640, 360)
--PLAYER_SIZE = tiny.Vector2D(16, 10)
PLAYER_SIZE = tiny.Vector2D(30, 37)
ENEMY_SIZE = tiny.Vector2D(29, 31)

-- resources
FONTS = {
  ['retro-l'] = love.graphics.newFont('fonts/retro.ttf', 64),
  ['retroville-s'] = love.graphics.newFont('fonts/Retroville NC.ttf', 10) -- 10px bitmap
}

TEXTURES = {
  ['player'] = love.graphics.newImage('graphics/player.png'),
  ['enemy'] = love.graphics.newImage('graphics/enemy_1.png')
}

QUADS = {
  --['player'] = GenerateQuads(TEXTURES['player'], 3, 1, PLAYER_SIZE)
  ['player-idle'] = GenerateQuads(TEXTURES['player'], 1, 4, PLAYER_SIZE),
  ['player-shoot'] = GenerateQuads(TEXTURES['player'], 1, 3, PLAYER_SIZE, tiny.Vector2D(120, 0)),
  ['player-right'] = GenerateQuads(TEXTURES['player'], 1, 4, PLAYER_SIZE, tiny.Vector2D(210, 0)),
  ['player-left'] = GenerateQuads(TEXTURES['player'], 1, 4, PLAYER_SIZE, tiny.Vector2D(330, 0)),
  ['player-up'] = GenerateQuads(TEXTURES['player'], 1, 2, PLAYER_SIZE, tiny.Vector2D(450, 0)),
  ['player-down'] = GenerateQuads(TEXTURES['player'], 1, 2, PLAYER_SIZE, tiny.Vector2D(510, 0)),
  ['enemy-moving'] = GenerateQuads(TEXTURES['enemy'], 1, 6, ENEMY_SIZE)
}