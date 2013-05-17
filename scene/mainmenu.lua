--mainmenu.lua
-- menu scene for Game2D. Includes storyboard

--Paulo Aguiar

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

	------------------------------------------
	----Functions which are called on Click of Buttons--
	------------------------------------------
	local function onNewGame()
		local options = {
				effect = "fade",
				time = 400,
			}
		storyboard.gotoScene("scene.newGameScene",options)
	end 
	
	
	local function onContinueGame()	

		local options = {
				effect = "fade",
				time = 400,
			}
		storyboard.gotoScene("scene.continueScene",options)
		
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
			label = "High Scores",
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