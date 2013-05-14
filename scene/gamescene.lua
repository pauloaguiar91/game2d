
 
local allClasses = allClasses
local allGlobals = allGlobals

local display = display 
local widget = widget 
local storyboard = storyboard
local preference = preference

local Window_Class = allClasses.Window_Class

local screenW = allGlobals.screenW
local screenH = allGlobals.screenH
local sW = allGlobals.sW 
local sH = allGlobals.sH 

local scene = storyboard.newScene()

function scene:createScene( event )
	local group = self.view
	
	
	
	
	local userData = preference.getValue("user_data")
	
	local bg = display.newImage(group,"assets/mainmenu/bg1.png",0, 0, screenW, screenH)
	
	
	--display boy or girl depending on user choice 
	local options = {width = 32,height=32,numFrames=96}
	local imageSheet = graphics.newImageSheet("assets/sprites/spritesheet1.png",options)
	local character
	if userData.gender == "boy" then
		character= display.newImage(group,imageSheet,1)
	elseif userData.gender == "girl" then
		character = display.newImage(group,imageSheet,4)
	end 
	character:scale(2,2)
	character.x = sW 
	character.y = sH
	
	
	--Back Button
	local backButton = widget.newButton
		{
		top=0,left=0,
		label = "BACK",
		fontSize = 11,
		width=40,height=40,
		onRelease = 
					function()
						storyboard.gotoScene("scene.mainmenu")
					end
		}
		group:insert(backButton)

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