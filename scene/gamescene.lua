--mainmenu.lua
-- game scene for Game2D. Includes storyboard

--Paulo Aguiar
 
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

local scene = storyboard.newScene()

function scene:createScene( event )
	local group = self.view
	local pageParams = event.params or {}

	mte.__mapIsLoaded = pageParams.slot 

	------------------------------------------------
	--INITIALIZE GAME OBJECT
	--all the functions (like addPlayer, addEnemy) are called using this object only
	------------------------------------------------
	local gameObject = Game_Class.getGameObject
		{
		group = group,
		slot = pageParams.slot
		}
	

	
	
	

	--Create and insert the map into our group 
	mte.loadMap("assets/maps/map01")
	group:insert(mte.getMapObj())
	mte.goto({locX=5,locY=0, blockScale = 30 })

	
	
	



	local healthBar = display.newRect(0,0,150,10)
	healthBar:setReferencePoint(display.TopLeftReferencePoint)healthBar.x = 50;
	healthBar.y = 10
	healthBar:setFillColor(255,0,0)
	group:insert(healthBar)

	local energyBar = display.newRect(0,0,150,10)
	energyBar:setReferencePoint(display.TopLeftReferencePoint)energyBar.x = 50;
	energyBar.y = 30
	energyBar:setFillColor(200,255,0)
	group:insert(energyBar)

	gameObject:addBackButton()
	gameObject:addJoyPad()
	gameObject:addPlayer()
	
	group._gameObject = gameObject

end
 
function scene:enterScene( event )
	local pageParams = event.params or {}
	local group = self.view

	local gameObject = group._gameObject
	local player = gameObject:getPlayer()

	
	
	
	
	-----------------------------------------------------
	--check if there is a user location saved previously 
	--is yes the update player and camera location 
	--else give player a default position
	local playerLocX,playerLocY=4,8	
	if pageParams.continueGame then 
		local saveMapData = gameObject:retrieveSavedGame()
		playerLocX = saveMapData.playerLocX
		playerLocY = saveMapData.playerLocY
	end
	player:setPosition
		{
		locX = playerLocX,
		locY = playerLocY,
		}
	-----------------------------------------------------


	
	
	
	--add an enemy 
	local enemy = gameObject:addEnemy
		{
		name = "enemy1",
		}
	enemy:setPosition
		{
		locX = 10,
		locY = 8,
		}
	enemy:setDirection("left")

	
	
	
	
	
	
	
	
	--This function is called once every frame
	gameLoop = function()
		player:update()
		mte.update()
	end 
	Runtime:addEventListener( "enterFrame", gameLoop)
end
 
 
 
 
 
-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	for i,v in pairs(event) do print(i,v) end 
	local group = self.view


	local gameObject = group._gameObject
	local player = gameObject:getPlayer()

	--WILL HAVE TO SAVE THE GAME STATE HERE
	local locX,locY = player:getLoc()
	local saveData =
		{
		playerLocX = locX,
		playerLocY = locY,
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