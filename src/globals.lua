--[[
    constants
  ]]
GAME_TITLE = 'Zoom to the Moon'
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
require 'EnemyController'
require 'Explosion'
require 'Fade'
require 'Gunshot'
require 'HUD'
require 'Level'
require 'Panel'
require 'PlayerController'
require 'PodController'
require 'StateDialogue'
require 'StateGameOver'
require 'StateIntro'
require 'StateLevelClear'
require 'StatePlay'
require 'StateStart'
require 'StateVictory'
require 'SkyLayer'
require 'Textbox'
require 'util'

-- pixels resolution
WINDOW_SIZE = tiny.Vector2D(1920, 1080) -- 16:9 aspect ratio
VIRTUAL_SIZE = tiny.Vector2D(640, 360)
LEVEL_OFFSET = tiny.Vector2D(0, math.floor(VIRTUAL_SIZE.y / 20))
PLAYER_SIZE = tiny.Vector2D(30, 37)
ENEMY_TYPE_1_SIZE = tiny.Vector2D(29, 31)
ENEMY_TYPE_2_SIZE = tiny.Vector2D(42, 34)
AVATAR_SIZE = tiny.Vector2D(69, 87)
POD_SIZE = tiny.Vector2D(55, 49)

-- data
require 'data.levels'

-- resources
FONTS = {
  ['retro-l'] = love.graphics.newFont('fonts/retro.ttf', 64),
  ['retro-m'] = love.graphics.newFont('fonts/retro.ttf', 32),
  ['retro-s'] = love.graphics.newFont('fonts/retro.ttf', 16),
  ['retroville-m'] = love.graphics.newFont('fonts/Retroville NC.ttf', 20),
  ['retroville-s'] = love.graphics.newFont('fonts/Retroville NC.ttf', 10) -- 10px bitmap
}

TEXTURES = {
  ['player'] = love.graphics.newImage('graphics/player.png'),
  ['enemy_1'] = love.graphics.newImage('graphics/enemy_1.png'),
  ['enemy_2'] = love.graphics.newImage('graphics/enemy_2.png'),
  ['boss-001'] = love.graphics.newImage('graphics/boss-001-sheet.png'),
  ['boss-101'] = love.graphics.newImage('graphics/boss-101-sheet.png'),
  ['player-001'] = love.graphics.newImage('graphics/player_001-sheet.png'),
  ['pod'] = love.graphics.newImage('graphics/pod.png'),
}

QUADS = {
  --['player'] = GenerateQuads(TEXTURES['player'], 3, 1, PLAYER_SIZE)
  ['player-idle'] = GenerateQuads(TEXTURES['player'], 1, 4, PLAYER_SIZE),
  ['player-shoot'] = GenerateQuads(TEXTURES['player'], 1, 3, PLAYER_SIZE, tiny.Vector2D(120, 0)),
  ['player-right'] = GenerateQuads(TEXTURES['player'], 1, 4, PLAYER_SIZE, tiny.Vector2D(210, 0)),
  ['player-left'] = GenerateQuads(TEXTURES['player'], 1, 4, PLAYER_SIZE, tiny.Vector2D(330, 0)),
  ['player-up'] = GenerateQuads(TEXTURES['player'], 1, 2, PLAYER_SIZE, tiny.Vector2D(450, 0)),
  ['player-down'] = GenerateQuads(TEXTURES['player'], 1, 2, PLAYER_SIZE, tiny.Vector2D(510, 0)),
  ['enemy_1-moving'] = GenerateQuads(TEXTURES['enemy_1'], 1, 6, ENEMY_TYPE_1_SIZE),
  ['enemy_2-moving'] = GenerateQuads(TEXTURES['enemy_2'], 1, 6, ENEMY_TYPE_2_SIZE),
  ['boss-001'] = GenerateQuads(TEXTURES['boss-001'], 1, 5, AVATAR_SIZE),
  ['boss-101'] = GenerateQuads(TEXTURES['boss-101'], 1, 5, AVATAR_SIZE),
  ['player-001'] = GenerateQuads(TEXTURES['player-001'], 1, 9, AVATAR_SIZE),
}

SOUNDS = {
  ['enemy-gunshot'] = love.audio.newSource('sounds/Laser_Shoot15.wav', 'static'),
  ['player-gunshot'] = love.audio.newSource('sounds/Laser_Shoot11.wav', 'static'),
  ['pod-explosion'] = love.audio.newSource('sounds/Explosion15.wav', 'static'),
  ['enemy-explosion'] = love.audio.newSource('sounds/Explosion20.wav', 'static'),
  ['player-killed'] = love.audio.newSource('sounds/Hit_Hurt47.wav', 'static'),
  ['player-hit'] = love.audio.newSource('sounds/Hit_Hurt83.wav', 'static'),
  ['new-game'] = love.audio.newSource('sounds/Select.wav', 'static'),
  ['select'] = love.audio.newSource('sounds/Blip_Select56.wav', 'static'),
  ['skip'] = love.audio.newSource('sounds/Select_195.wav', 'static'),
  ['music'] = love.audio.newSource('sounds/music.mp3', 'stream'),
  ['buzz'] = love.audio.newSource('sounds/background_buzz.mp3', 'stream'),
  ['win'] = love.audio.newSource('sounds/win.mp3', 'stream'),
}

SOUNDS['enemy-gunshot']:setVolume(0.8)
SOUNDS['player-gunshot']:setVolume(0.8)
SOUNDS['pod-explosion']:setVolume(0.8)
SOUNDS['new-game']:setVolume(0.9)
SOUNDS['select']:setVolume(0.9)
SOUNDS['skip']:setVolume(0.3)
SOUNDS['buzz']:setVolume(0.5)
