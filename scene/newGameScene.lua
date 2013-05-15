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

	----------------------------------------------
	--Function to get user data (gender and name)--
	--this function is called if the program cannot find any user data stored 
	----------------------------------------------
local function onChoice(event)
			local target = event.target or {}
			if target.id == "boy" then 
				gender = "boy"
			elseif target.id == "girl" then 
				gender = "girl"
			elseif target.id == "name" then 
				if event.phase == "submitted" then 
					name = target.text
				end 
			end 
		end 
	
	
		local function onOk()
			if not gender then 	
				return true 	--dont close
			end 
			
			local slot = Save_Game_Class.addGameToSlot
				{
				gender=gender,
				name = name or "Character "..math.random(100),
				}
				
			timer.performWithDelay(1000,function()
							local options = {effect="fade",params={newGame=true,slot=slot}}
							goToGameScene(options)
						end,1)

	end
function scene:createScene( event )
		local group = self.view

		
end

	
local function onBack()

storyboard.gotoScene("scene.mainmenu",options)
	end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view

	local background = display.newImage(group ,"assets/introscene/example.png", 0, 0,display.contentWidth,display.contentHeight)

			local options = {
				effect = "fade",
				time = 400,
			}

		local options = {width = 32,height=32,numFrames=96}
		local imageSheet = graphics.newImageSheet("assets/sprites/spritesheet1.png",options)
		
		
		local gender,name
	    

	local back = widget.newButton
			{
			label = "Back",
			onRelease = onBack,
			width=75,height=30,
			left = l,
			top = 1,
			fontSize = 12,
			}
		group:insert(back)


	local noOfAvalableGames = Save_Game_Class.getGamesCount()
		if noOfAvalableGames == Save_Game_Class._MAX_GAME_SLOTS then 
			
			local txt = "Not enought slots"
			local message =  display.newText(txt,0,400,native.systemFont,12)
			message.x = sW 
			message.y = sH 
			message:setTextColor(0,0,0)
			
		else 
			--getUserData()
		end 

local boy = widget.newButton
			{
			sheet = imageSheet,
			defaultFrame=4,overFrame=5,
			id = "boy",
			left = sW-40,top=sH-30,
			width = 40,height = 40,
			onRelease = onChoice,
			}
		group:insert(boy)
		
local girl = widget.newButton
			{
			sheet = imageSheet,
			defaultFrame=1,overFrame=2,
			id = "girl",
			left = sW+40,top=sH-30,
			width = 40,height = 40,
			onRelease = onChoice,
			}
		group:insert(girl)
		

		local textField = native.newTextField(0,sH+30,100,30)
		textField.x = sW 
		textField.id = "name"
		textField:addEventListener( "userInput", onChoice )
		
	
end
 
 
-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	
	
end
 
 
-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local group = self.view

end
 

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene