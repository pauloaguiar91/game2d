

local preference = preference

local allClasses = allClasses

local SAVE_GAME_CLASS = {}
SAVE_GAME_CLASS._MAX_GAME_SLOTS = 3

function SAVE_GAME_CLASS.getGamesCount()
	local count = 0 
	
	local listOfGames = preference.getValue("list_of_games")
	for i=1,#listOfGames do 
		local game = listOfGames[i]
		if game.slotFilled then 
			count = count + 1
		end 
	end
	
	return count 
end 

 
function SAVE_GAME_CLASS.getGamesNames()
	local final = {}
	
	local listOfGames = preference.getValue("list_of_games")
	for i=1,#listOfGames do 
		local game = listOfGames[i]
		if game.slotFilled then
			local name = game.meta.name 
			final[#final+1] = name
		end 
	end
	
	return final 
end 


function SAVE_GAME_CLASS.initializeListOfGames()
	local listOfGames = preference.getValue("list_of_games")
	if not listOfGames then 
		local initializationTable = 
			{
			[1]={},
			[2]={},
			[3]={}
			}	--3 save-game slots 
		preference.save{list_of_games = initializationTable}
	end 
end 


function SAVE_GAME_CLASS.getSlot()
	local listOfGames = preference.getValue("list_of_games")
	for i=1,#listOfGames do 
		local game = listOfGames[i]
		if not game.slotFilled then 
			return i
		end 
	end

end 

function SAVE_GAME_CLASS.deleteGameFromSlot(params)
 local listOfGames = preference.getValue("list_of_games")
 local slotIndex = SAVE_GAME_CLASS.getSlot()
 
 listOfGames[slotIndex] = nil 
 
 preference.save{list_of_games = listOfGames}
 
end

function SAVE_GAME_CLASS.addGameToSlot(params)
	local listOfGames = preference.getValue("list_of_games")
	local slotIndex = SAVE_GAME_CLASS.getSlot()
	
	local slot = listOfGames[slotIndex]
	slot.meta = 
		{
		name = params.name,
		gender = params.gender,
		}
		
	preference.save{list_of_games = listOfGames}
	return slotIndex
end 	


function SAVE_GAME_CLASS.saveDataToSlot(params)
	local listOfGames = preference.getValue("list_of_games")

	local slot = listOfGames[params.slot]
	slot.gameData = params.gameData
	slot.slotFilled = true 
	
	preference.save{list_of_games = listOfGames}
	return slotIndex
end 


function SAVE_GAME_CLASS.retrieveDataFromSlot(params)
	local listOfGames = preference.getValue("list_of_games")
	local slot = listOfGames[params.slot]
	
	return slot.gameData
end 


function SAVE_GAME_CLASS.retrieveMetaDataFromSlot(params)
	local listOfGames = preference.getValue("list_of_games")
	local slot = listOfGames[params.slot]
	
	return slot.meta
end 

SAVE_GAME_CLASS.initializeListOfGames()

return SAVE_GAME_CLASS