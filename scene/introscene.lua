-- introscene.lua
-- intro scene for Game2D. Includes storyboard

--Paulo Aguiar

local storyboard = storyboard
local display = display 


local scene = storyboard.newScene()

function scene:createScene( event )
	local group = self.view
	local background = display.newImage(group ,"assets/introscene/example.png", 0, 0,display.contentWidth,display.contentHeight)
	local studioName = display.newText(group ,"Paulo Aguiar Presents", 0, 125, native.systemFont, 40)
	studioName:setTextColor(0,0,0)
end
 
function scene:enterScene( event )
local group = self.view
	
local function gotoNextScene()
local options = {
		effect = "fade",
		time = 400,
}
	storyboard.gotoScene("scene.mainmenu",options)
end 
	
timer.performWithDelay( 1000, gotoNextScene,1)
end
 
-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view	
end 
 
-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local group = self.view
end

scene:addEventListener("createScene", scene)
scene:addEventListener("enterScene", scene)
scene:addEventListener("exitScene", scene)
scene:addEventListener("destroyScene", scene)
return scene