--mainmenu.lua
-- continue scene for Game2D. Includes storyboard

--Paulo Aguiar

local allClasses = allClasses
local allGlobals = allGlobals
local widget = widget 

local storyboard = storyboard

local preference = preference

local Window_Class = allClasses.Window_Class

local Save_Game_Class = allClasses.Save_Game_Class

local screenW = allGlobals.screenW
local screenH = allGlobals.screenH
local sW = allGlobals.sW 
local sH = allGlobals.sH 

local scene = storyboard.newScene()	

function scene:createScene( event )
--local bg = display.newImage()
	local group = self.view

		local message =  display.newText("No games to continue",0,100,native.systemFont,12)
		message.x = sW 
		message.y = sH 
		message.alpha = 0
		message:setTextColor(255,255,255)
		group:insert(message)

		if  Save_Game_Class.getGamesCount() == 0 then
			message.alpha = 1


		else if Save_Game_Class.getGamesCount() >= 1 then
				message.alpha = 0
	end


end 


function scene:enterScene( event )

	local group = self.view
	local availableNames = Save_Game_Class.getGamesNames()
	local slotSelected

		local options =
		{
			effect = "fade",
			time = 400
		}

	local backBtn = widget.newButton
				{
				label = "Back",
				height = 40,width=60,
				fontSize = 12,
				top = 0,
				left = 0,
				onRelease = function() 
				storyboard.gotoScene("scene.mainmenu",options)
				end,
				}
				group:insert(backBtn)
	
	
	local function goToGameScene(options)
		local sceneName = "scene.gamescene"
		local params = options.params

		if (params.continueGame and params.slot ~= mte.__mapIsLoaded) or params.newGame then 
			storyboard.purgeScene(sceneName)
		end
		storyboard.gotoScene(sceneName,options)
	end 

	
	
	local function onChoice(event)
		slotSelected = event.target.id
		if #availableNames == 0 then 
			return false 
		end 
		if not slotSelected then 
			return true 
		end
	local options =
		{
			effect = "fade",
			time = 400,
			params =
			{
			slot = slotSelected,
			continueGame=true,
			}
		}
		goToGameScene(options)


	end 

	local max = Save_Game_Class._MAX_GAME_SLOTS
	
	for i=1,max do 
		local gameName = availableNames[i]
		if gameName then

			local gameSlot = widget.newButton
				{
				id = i,
				label = gameName,
				height = 40,width=110,
				fontSize = 12,
				top = 20 + 50*i,
				onRelease = onChoice
				}
			local deleteBtn = widget.newButton
				{
				id = i,
				label = "Delete",
				height = 40,width=60,
				fontSize = 12,
				top = 20 + 50*i,
				left = i + 400,
				onRelease = function()						
							Save_Game_Class.deleteGameFromSlot{slot=i}

							storyboard.purgeScene("scene.continueScene")
							storyboard.gotoScene("scene.continueScene",options)
				end,
				}
			group:insert(deleteBtn)

			gameSlot.x = sW 
			group:insert(gameSlot)

--bug:if you see this message and then come back into the scene even with a new character this message shows up.
		else


		end 

	end 
	
	


	end 
end

function scene:exitScene( event )
	local group = self.view	
end

function scene:destroyScene( event )
local group = self.view
end 

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene