--mainmenu.lua
-- new game scene for Game2D. Includes storyboard

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

local function goToGameScene(options)
		
local sceneName = "scene.gamescene"
		
local params = options.params
if (params.continueGame and params.slot ~= mte.__mapIsLoaded) or params.newGame then storyboard.purgeScene(sceneName)
	
end
	
storyboard.gotoScene(sceneName,options)
end 
	----------------------------------------------
	--Function to get user data (gender and name)--
	--this function is called if the program cannot find any user data stored 
	----------------------------------------------
function onChoice(event)

local options = {
	effect = "fade",
	time = 400,
}
			
local slot = Save_Game_Class.addGameToSlot
	{
	gender=gender,
	name = name or "Character "..math.random(100),
	}
				
timer.performWithDelay(1000,function()
					local options = {effect="fade",params={newGame=true,slot=slot}}
				goToGameScene(options)
				end,1)

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

function scene:createScene( event )
	local group = self.view
end
	
function onBack()
local options = {
	effect = "fade",
	time = 400,
}

storyboard.gotoScene("scene.mainmenu",options)
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
local group = self.view

--local bg = display.newRect(0,0,display.contentWidth,display.contentHeight)
local options = {width = 32,height=32,numFrames=96}
local imageSheet = graphics.newImageSheet("assets/sprites/spritesheet1.png",options)
local gender,name
		
local backBttn = widget.newButton
{
label = "Back",
onRelease = onBack,
width=75,height=40,
left = 0,
top = 1,
fontSize = 12,
}
group:insert(backBttn)

local create = widget.newButton
{
	label = "Create",
	onRelease = onChoice,
	width=75,height=40,
	left = 350,
	top = display.contentHeight / 1.5,
	fontSize = 12,
}
group:insert(create)

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

local noOfAvalableGames = Save_Game_Class.getGamesCount()
if noOfAvalableGames == Save_Game_Class._MAX_GAME_SLOTS then 
	girl.alpha=0
	boy.alpha=0
	create.alpha = 0

local txt = "Not enough character slots\nPlease delete a character to create a new one"
local message =  display.newText(txt,0,500,native.systemFont,12)
	message.x = sW 
	message.y = sH 
	message:setTextColor(255,255,255)
	group:insert(message)
	end 	
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