

local allClasses = allClasses
local allGlobals = allGlobals

local timer = timer 
local display = display 
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
	
	local listOfGames = preference.getValue("list_of_games")
	

	
	
	local function goToGameScene(options)
		
		local sceneName = "scene.gamescene"
		
		local params = options.params
		if (params.continueGame and params.slot ~= mte.__mapIsLoaded) or params.newGame then
			storyboard.purgeScene(sceneName)
		end
		
		storyboard.gotoScene(sceneName,options)
	end 
	
	
	----------------------------------------------
	--Function to get user data (gender and name)--
	--this function is called if the program cannot find any user data stored 
	----------------------------------------------
	local function getUserData()
		local windowElements = {}
		
		local options = {width = 32,height=32,numFrames=96}
		local imageSheet = graphics.newImageSheet("assets/sprites/spritesheet1.png",options)
		
		
		local gender 
		local name 
		
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
	
	
		local function 
		onOk()
			if not gender then 	
				return true 	--dont close
			end 
			
			local slot = Save_Game_Class.addGameToSlot
				{
				gender=gender,
				name = name or "Default_Name"..math.random(100),
				}
				
			timer.performWithDelay(1000,function()
							local options = {effect="fade",params={newGame=true,slot=slot}}
							goToGameScene(options)
						end,1)
			
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
		

		
			
			
		windowElements[#windowElements+1] = boy
		windowElements[#windowElements+1] = girl 
		windowElements[#windowElements+1] = textField 
		
		
		
		local window = Window_Class.newWindow
			{
			windowElements = windowElements,
			onOk = onOk
			}
		window:showWindow()
	end 
	
	
	
	------------------------------------------
	----Functions which are called on Click of Buttons--
	------------------------------------------
	local function onNewGame()
		
		local noOfAvalableGames = Save_Game_Class.getGamesCount()
		if noOfAvalableGames == Save_Game_Class._MAX_GAME_SLOTS then 
			local windowElements = {}
			
			local txt = "Not enought slots"
			local message =  display.newText(txt,0,100,native.systemFont,12)
			message.x = sW 
			message.y = sH 
			message:setTextColor(0,0,0)
			windowElements[#windowElements+1] = message
			
			local window = Window_Class.newWindow
				{
				windowElements = windowElements	
				}
			window:showWindow()
			
		else 
			getUserData()
		end 
		
	end 
	
	
	local function onContinueGame()	
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
		
		local function 
		onOk()
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
	
	
	--opening Facebook URL is just a stop-gap thing.  
	--Corona has the entire Facebook library built-in. So we can do anything yuo want like Share link, post photo, post on Friend's wall, etc.
	local function onFacebook()
		system.openURL("www.facebook.com/")
		return true
	end

	
	local function onRankings()
		local windowElements = {}
		
		local title =  display.newText("RANKINGS",0,100,native.systemFont,15)
		title.x = sW 
		title.y = sH - 30
		title:setTextColor(0,0,0)
		windowElements[#windowElements+1] = title
		
		local notImplemented =  display.newText("This feature is not yet implemented",0,100,native.systemFont,12)
		notImplemented.x = sW 
		notImplemented.y = sH 
		notImplemented:setTextColor(0,0,0)
		windowElements[#windowElements+1] = notImplemented
		
		local window = Window_Class.newWindow
			{
			windowElements = windowElements	
			}
		window:showWindow()
	end 
	
	local function onCredits()
		local windowElements = {}
		
		local title =  display.newText("CREDITS",0,100,native.systemFont,15)
		title.x = sW 
		title.y = sH 
		title:setTextColor(0,0,0)
		windowElements[#windowElements+1] = title
		
		local window = Window_Class.newWindow
			{
			windowElements = windowElements	
			}
		window:showWindow()
	end 
	
	------------------------------------------
	------------------------------------------
	------------------------------------------

	
	
	
	--function to display all items
	local function displayMenuItems()
			
		local bg = display.newImage(group,"assets/mainmenu/bg1.png",0, 0, screenW, screenH)
		
		
		local title = display.newText(group,"Game2D", 0, 0, native.systemFont, 75)
		title:setTextColor(255, 255, 255)

		local w,h = 170,40
		local l = screenW-w-10
		local t = {50,100,150,200,250}
		local fontSize = 12
		
		local newGameButton = widget.newButton 
			{
			label = "New Game",
			onRelease = onNewGame,
			width=w,height=h,
			left = l,top = t[1],
			fontSize = fontSize,
			}
		group:insert(newGameButton)
			
		local continueButton = widget.newButton 
			{
			label = "Continue Game",
			fontSize = fontSize,
			onRelease = onContinueGame,
			width=w,height=h,
			left = l,top = t[2],
			}
		group:insert(continueButton)
			
		local facebookButton = widget.newButton 
			{
			label = "Like us on Facebook",
			fontSize = fontSize,
			onRelease = onFacebook,
			width=w,height=h,
			left = l,top = t[3],
			}
		group:insert(facebookButton)
			
		local rankingsBtn = widget.newButton 
			{
			label = "Rankings",
			fontSize = fontSize,
			onRelease = onRankings,
			width=w,height=h,
			left = l,top = t[4],
			}
		group:insert(rankingsBtn)
			
		local creditsButton = widget.newButton 
			{
			label = "Credits",
			fontSize = fontSize,
			onRelease = onCredits,
			width=w,height=h,
			left = l,top = t[5],
			}
		group:insert(creditsButton)
	end 
	
	
	displayMenuItems()

end
 
 
-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	
	
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