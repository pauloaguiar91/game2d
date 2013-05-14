local allClasses = allClasses
local allGlobals = allGlobals

local display = display 



local preference = preference

local screenW = allGlobals.screenW
local screenH = allGlobals.screenH
local sW = allGlobals.sW 
local sH = allGlobals.sH 





 

local GAME_CLASS = {}
GAME_CLASS.__index = GAME_CLASS



--Constants



function GAME_CLASS.getGameObject(params)
	local params = params or {}
	local slot = params.slot 
	
	local game_object = setmetatable({},GAME_CLASS)
	
	local meta = allClasses.Save_Game_Class.retrieveMetaDataFromSlot{slot = slot}

		
	game_object._slot = slot 
	game_object._meta = meta 
	
	return game_object
end 




function GAME_CLASS:saveGame(gameData)
	local slot = self._slot
	
	allClasses.Save_Game_Class.saveDataToSlot
		{
		slot = slot,
		gameData = gameData,
		}
end 


function GAME_CLASS:retrieveSavedGame()
	local slot = self._slot
	
	return allClasses.Save_Game_Class.retrieveDataFromSlot
		{
		slot = slot,
		}
end 



function GAME_CLASS:retriveGame(params)


end 












return GAME_CLASS