-----------------------------------------------------------------------------------------
--
-- main.lua
-- Entry point of the game

-- Million Tile Engine... License bought by Paulo Aguiar on May 4, 2013.
-- "Game2D" Property of Paulo Aguiar

--What needs to be done

--TOP PRIORITIES--
--Collision Detection
--NewGame & Continue game should be scenes not windows.
-- 
--


--MINOR--
--Fix sprites being rotated instead of animation changed on move
--"Story Scene" before loading first map should be created
-- character should stay fixed to bottom of screen when walking. even through continue game.
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

--require all libraries set them global
storyboard = require "storyboard"
widget = require "widget"
json = require "json"
preference = require "lib.preference"
mte = require "lib.mte"

_G.allClasses = {}

allClasses.Window_Class = require "class.window.basic"
allClasses.Save_Game_Class = require "class.game.save_game"
allClasses.Game_Class = require "class.game.game"	
	
	
--storyboard is the controller for difference scenes 
--it automatically changes scenes, taking care of the objects in each scene
storyboard.gotoScene("scene.introscene",{effect="crossFade",time=500,})
if true then return end 









