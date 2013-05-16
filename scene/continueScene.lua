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
	local group = self.view

	local availableNames = Save_Game_Class.getGamesNames()
		local windowElements = {}
		
		local slotSelected
		local function 
		onChoice(event)
			slotSelected = event.target.id
		end 
		
		for i=1,#availableNames do 
			local gameSlot = widget.newButton
				{
				id = i,
				label = availableNames[i],
				height = 40,width=70,
				fontSize = 12,
				top = 20 + 50*i,
				onRelease = onChoice
				}
			gameSlot.x = sW 
			windowElements[#windowElements+1] = gameSlot
		end 
		
		if #availableNames == 0 then 
			local txt = "No games to continue"
			local message =  display.newText(txt,0,100,native.systemFont,12)
			message.x = sW 
			message.y = sH 
			message:setTextColor(0,0,0)
			windowElements[#windowElements+1] = message
		end 
		
		local function onOk()
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
		
		
		local window = Window_Class.newWindow
				{
				windowElements = windowElements,
				onOk = onOk,
				}
			window:showWindow()

end
function scene:enterScene( event )
	local group = self.view
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