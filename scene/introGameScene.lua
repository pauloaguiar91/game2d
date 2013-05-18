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

function scene:createScene( event )
	local group = self.view
	local txtBox = display.newRect(10,sH / 2, sW * 1.8,sH)
	txtBox:setFillColor(255, 255,255)

	local txt = {}
	txt[1] = "Welcome to Game2D!"
	txt[2] = "rawr"

	local displayTxt = display.newText(txt[1],10,sH / 2,native.systemFont,12)
	displayTxt:setTextColor(0,0,0)
    group:insert(txtBox)
    group:insert(displayTxt)
end

	
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