local allClasses = allClasses
local allGlobals = allGlobals

local display = display 



local preference = preference

local screenW = allGlobals.screenW
local screenH = allGlobals.screenH
local sW = allGlobals.sW 
local sH = allGlobals.sH 



local player_class = require "class.character.player"
local enemy_class = require "class.character.enemy"

 

local GAME_CLASS = {}
GAME_CLASS.__index = GAME_CLASS



--Constants



function GAME_CLASS.getGameObject(params)

	local slot = params.slot 
	local group = params.group 
	
	local game_object = setmetatable({},GAME_CLASS)
	
	local meta = allClasses.Save_Game_Class.retrieveMetaDataFromSlot{slot = slot}

		
	game_object._slot = slot 
	game_object._meta = meta 
	game_object._group = group 
	
	game_object._player = nil 
	game_object._enemies = nil 
	
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




function GAME_CLASS:addEnemy(params)
	local enemy = enemy_class.newEnemy
		{
		group = self._group,
		name = params.name, 
		}
	enemy:show()
	
	return enemy
end 



function GAME_CLASS:addPlayer(params)
	
	local player = player_class.newPlayer
		{
		group = self._group,
		gender = self._meta.gender 
		}
	player:show()
	
	self._player = player 
	return player
end 


function GAME_CLASS:getPlayer()
	return self._player
end


function GAME_CLASS:addJoyPad(params)
	
	local group = self._group 
	
	local controlGroup = display.newGroup()
	group:insert(controlGroup)
	
	local DpadBack = display.newImageRect(controlGroup, "assets/gamescene/1.gif", 200, 200)
	DpadBack.x = 70
	DpadBack.y = screenH - 70

	local DpadUp = display.newRoundedRect(controlGroup, DpadBack.x - 35, DpadBack.y - 125, 65, 85,4)
	DpadUp:setFillColor(0,0,0)
	DpadUp.alpha = 0.5
	DpadUp.strokeWidth = 3
    DpadUp:setStrokeColor(255,255,255)

	local DpadDown = display.newRoundedRect(controlGroup, DpadBack.x - 35, DpadBack.y + 17, 65, 85,4)
	DpadDown:setFillColor(0,0,0)
	DpadDown.alpha = 0.5
	DpadDown.strokeWidth = 3
    DpadDown:setStrokeColor(255,255,255)

	local DpadLeft = display.newRoundedRect(controlGroup, DpadBack.x - 121, DpadBack.y - 39, 85, 55,4)
	DpadLeft:setFillColor(0,0,0)
	DpadLeft.alpha = 0.5
	DpadLeft.strokeWidth = 3
    DpadLeft:setStrokeColor(255,255,255)

	local DpadRight = display.newRoundedRect(controlGroup, DpadBack.x + 31, DpadBack.y - 39, 85, 55,4)
	DpadRight:setFillColor(0,0,0)
	DpadRight.alpha = 0.5
	DpadRight.strokeWidth = 3
    DpadRight:setStrokeColor(255,255,255)

	DpadBack:toFront()
	DpadUp.id = "up"
	DpadDown.id = "down"
	DpadLeft.id = "left"
	DpadRight.id = "right"
	DpadBack:toFront()
	controlGroup:setReferencePoint(display.CenterReferencePoint)
	controlGroup:scale(.5,.5)
	
	
	local function move(event)
		local player = self._player
		if event.phase == "ended" or event.phase == "cancelled" then
			player.movement = nil
		elseif event.target.id then
			player.movement = event.target.id
		end 
		return true
	end 

	DpadUp:addEventListener("touch", move)
	DpadDown:addEventListener("touch", move)
	DpadLeft:addEventListener("touch", move)
	DpadRight:addEventListener("touch", move)
end 



function GAME_CLASS:addBackButton()
	local backButton = widget.newButton
		{
		top=0,left=0,
		label = "BACK",
		fontSize = 11,
		width=40,height=40,
		onRelease = function()
						local options = {effect="fade",time=400}
						storyboard.gotoScene("scene.mainmenu",options)
					end
		}
	self._group:insert(backButton)	
end 

function GAME_CLASS:retriveGame(params)


end 












return GAME_CLASS