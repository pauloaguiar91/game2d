-----------------------------------------------------------------------------------------
--
-- main.lua
-- Entry point of the game

-- Million Tile Engine... License bought by Paulo Aguiar on May 4, 2013.
-- "Game2D" Property of Paulo Aguiar

-- Objects and listeners created should be distroyed now. Not sure if this is the best way to do it though

-- Main menu map background should scroll slowly. 

--SATHEESH
--CREATE NEW CHARACTER MENU WITH NAME INPUT & GENDER CHOICE. YOU CAN SET THE GIRL SPRITE TO ANY ONE ON THE SPRITE SHEET.
--CREATE SAVE GAME FEATURE IN GAME.
--CREATE CONTINUE GAME MENU WITH 3 CHARACTER SLOTS. IT SHOULD HAVE THE NAME UNDER THE SPRITE AND WHEN YOU CLICK ON IT IT RETURNS A SAVED GAME
--IF TIME PERMITS(UNDER 3 HOURS)
--check out continueGame.lua for comments
-----------------------------------------------------------------------------------------
display.setStatusBar(display.HiddenStatusBar)





--require all libraries
storyboard = require "storyboard"
widget = require "widget"
json = require "json"
preference = require "lib.preference"
mte = require "lib.mte"

_G.allClasses = 
	{
	Window_Class = require "class.window.basic",
	}
	

	
--assign all constants
_G.allGlobals = 
	{
	screenW = display.contentWidth,
	screenH = display.contentHeight,
	sW = display.contentWidth*.5,
	sH = display.contentHeight*.5,
	}



--initialize all data which have to be saved 
--for instance, we have to save user choices like gender and name
--so on the very first running of the app, the following code will create an empty table
--after the user chooses, we can save the choices in this table 
local userData = preference.getValue("user_data")
if not userData then 
	local initializationTable = {}
	preference.save{user_data = initializationTable}
end 

local gameState = preference.getValue("game_state")
if not gameState then 
	local initializationTable = {}
	preference.save{game_state = initializationTable}
end 


	
	
	
	
	
--storyboard is the controller for difference scenes 
--it automatically changes scenes, taking care of the objects in each scene
storyboard.gotoScene("scene.introscene",{effect="crossFade",time=500,})
if true then return end 









