
 
local allClasses = allClasses
local allGlobals = allGlobals

local mte = mte
local display = display 
local widget = widget 
local storyboard = storyboard
local preference = preference

local Window_Class = allClasses.Window_Class
local Game_Class  = allClasses.Game_Class

local screenW = allGlobals.screenW
local screenH = allGlobals.screenH
local sW = allGlobals.sW 
local sH = allGlobals.sH 

local gameLoop
local atlas = {}
				--x		y	rot
atlas["left"] 	= { -1,  0,	90}
atlas["right"]  = {  1,  0,	-90 }
atlas["up"]     = {  0, -1,	180 }
atlas["down"]   = {  0,  1,	0 }




local scene = storyboard.newScene()

function scene:createScene( event )
	local group = self.view
	local pageParams = event.params or {}
	
	
	mte.__mapIsLoaded = pageParams.slot 
	
	local gameObject = Game_Class.getGameObject
		{
		slot = pageParams.slot
		}
	group._gameObject = gameObject
	
	
	--Create Map
	--and insert the map into our group 
	mte.loadMap("assets/maps/map01")
	group:insert(mte.getMapObj())
	mte.goto(
		{
		locX=3,locY=3, 
		blockScale = 32
		})


	
	
	
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
		-- backButton.isVisible = false 
		

			
	local controlGroup = display.newGroup()
	group:insert(controlGroup)
	local DpadBack = display.newImageRect(controlGroup, "assets/gamescene/Dpad.png", 200, 200)
	DpadBack.x = 70
	DpadBack.y = screenH - 70
	local DpadUp = display.newRect(controlGroup, DpadBack.x - 37, DpadBack.y - 100, 75, 75)
	local DpadDown = display.newRect(controlGroup, DpadBack.x - 37, DpadBack.y + 25, 75, 75)
	local DpadLeft = display.newRect(controlGroup, DpadBack.x - 100, DpadBack.y - 37, 75, 75)
	local DpadRight = display.newRect(controlGroup, DpadBack.x + 25, DpadBack.y - 37, 75, 75)
	DpadBack:toFront()
	DpadUp.id = "up"
	DpadDown.id = "down"
	DpadLeft.id = "left"
	DpadRight.id = "right"
	DpadBack:toFront()
	controlGroup:setReferencePoint(display.CenterReferencePoint)
	controlGroup:scale(.5,.5)

	
	
	
	group.DpadUp = DpadUp
	group.DpadRight = DpadRight
	group.DpadLeft = DpadLeft
	group.DpadDown = DpadDown
	
	
	local function 
	move(event)
		group._onJoyStickMove(event)
	end 
	
	group.DpadUp:addEventListener("touch", move)
	group.DpadDown:addEventListener("touch", move)
	group.DpadLeft:addEventListener("touch", move)
	group.DpadRight:addEventListener("touch", move)
	
	
	
	
	
		
	---------CREATE A SPRITE------
	local frameStart = gameObject._meta.gender == "girl" and 1 or 4
	local options = {width = 32,height=32,numFrames=96}
	local spriteSheet = graphics.newImageSheet("assets/sprites/spritesheet1.png",options)
	local sequenceData = 	{
							{name = "walk", sheet = imageSheet, start=frameStart,count=3, time = 400,loopCount = 0},
							}						
	

	local player = display.newSprite(spriteSheet, sequenceData)
	group:insert(player)
	group._player = player 
	
	
	
	-------ADD THE SPRITE TO THE MAP------
	local setup = {
		kind = "sprite",
		layer = mte.getSpriteLayer(1),
		locX = 0,
		locY = 0,
		levelWidth = 32,
		levelHeight = 32,
		}
	mte.addSprite(player, setup)
	mte.setCameraFocus(player)

end
 
 
 
 
 
 
 
function scene:enterScene( event )


	
	
	local pageParams = event.params or {}
	local group = self.view
	
	local player = group._player
	local gameObject = group._gameObject
	
	
	


	--check if there is a user location saved previously 
	--is yes the update player and camera location 
	local playerLocX,playerLocY=0,0	
	if pageParams.continueGame then 
		local saveMapData = gameObject:retrieveSavedGame()
		playerLocX = saveMapData.playerLocX
		playerLocY = saveMapData.playerLocY
	end 
	
	mte.sendSpriteTo
		{
		sprite=player,
		locX = playerLocX,
		locY = playerLocY,
		}
	mte.moveCameraTo
		{
		sprite=player,
		}
	
	
	-------------------------------------
	-------JOYPAD HANDLER-------------
	------------------------------------
	local movement
	group._onJoyStickMove = 
	function(event) 
		if event.phase == "ended" or event.phase == "cancelled" then
			movement = nil
		elseif event.target.id then
			movement = event.target.id
		end
		return true
	end
	
	
	
	
	
	
	
	--------------------------------------------------------
	-------this function is called everyframe-------------
	-------------------------------------------------------
	
	gameLoop = function()
		if movement then
			--checks if joypad is pressed and moves the player 
			local xTile, yTile = player.locX + atlas[movement][1], player.locY + atlas[movement][2]
			player:play()
			mte.moveSpriteTo( { sprite = player, locX = xTile, locY = yTile, time = 200, easing = "linear" } )
			player.rotation = atlas[movement][3]
		else
			player:pause()
		end
		mte.update()
	end 
	Runtime:addEventListener( "enterFrame", gameLoop)
	


end
 
 
-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	

	local player = group._player
	local gameObject = group._gameObject
	
	--WILL HAVE TO SAVE THE GAME STATE HERE
	local saveData =
		{
		playerLocX = player.locX,
		playerLocY = player.locY,
		}
	gameObject:saveGame(saveData)


	
	Runtime:removeEventListener("enterFrame",gameLoop)
end
 
 
-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local group = self.view
	mte.cleanup()
	mte.__mapIsLoaded = nil
end
 

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene