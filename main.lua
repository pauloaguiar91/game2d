-----------------------------------------------------------------------------------------
--
-- main.lua
-- Entry point of the game. loads the intro

-- Million Tile Engine... License bought by Paulo Aguiar on May 4, 2013.
-- "Game2D" Property of Paulo Aguiar

--What needs to be done

--TOP PRIORITIES--
--"Story Scene" before loading first map should be created
--combat system. should support swipe attacks for now 
--Stats system (included with combat system)
--if player clicks on map screen and they are still walking they should stop
--load NPC onto the screen with chat conversations

--Worry about later--

-----------------------------------------------------------------------------------------
display.setStatusBar(display.HiddenStatusBar)

--assign all constants
_G.allGlobals = 
	{
	screenW = display.contentWidth,
	screenH = display.contentHeight,
	sW = display.contentWidth*.5,
	sH = display.contentHeight*.5,
	}

--require all libraries & make them global
storyboard = require "storyboard"
widget = require "widget"
json = require "json"
preference = require "lib.preference"
mte = require "lib.mte"

_G.allClasses = {}

allClasses.Window_Class = require "class.window.basic"
allClasses.Save_Game_Class = require "class.game.save_game"
allClasses.Game_Class = require "class.game.game"	

--start	
storyboard.gotoScene("scene.introscene",{effect="crossFade",time=500,})

