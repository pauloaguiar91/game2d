local allClasses = allClasses
local allGlobals = allGlobals

local display = display 



local preference = preference

local screenW = allGlobals.screenW
local screenH = allGlobals.screenH
local sW = allGlobals.sW 
local sH = allGlobals.sH 

local mte = mte 


local atlas = {}
				--x		y
atlas["left"] 	= { -1,  0,}
atlas["right"]  = {  1,  0,}
atlas["up"]     = {  0, -1,}
atlas["down"]   = {  0,  1,}

 

local CHARACTER_CLASS = {}



--Constants


local options = {width = 32,height=32,numFrames=96}
local characterSpriteSheet = graphics.newImageSheet("assets/sprites/spritesheet1.png",options)	
	


function CHARACTER_CLASS.newCharacter(params)
	local params = params or {}

	local characterSprite
	
	local character = setmetatable({},{__index = CHARACTER_CLASS})
						
	local group = params.group

	
	local sequenceData = params.sequenceData

	characterSprite = display.newSprite(characterSpriteSheet, sequenceData)
	group:insert(characterSprite)
	characterSprite.isVisible = false 
	
	character._lookupTables = {}
	character._sprite = characterSprite
	return character
end 




function CHARACTER_CLASS:show(gameData)
		
	-------ADD THE PLAYER SPRITE TO THE MAP------
	local characterSprite = self._sprite
	
	characterSprite.isVisible = true 
	
	local setup = {
		kind = "sprite",
		layer = mte.getSpriteLayer(1),
		locX = 0,
		locY = 0,
		levelWidth = 32,
		levelHeight = 32,
		}
	mte.addSprite(characterSprite, setup)
	
	if self._isPlayer then 
		mte.setCameraFocus(characterSprite)
	end 
	

end 	


function CHARACTER_CLASS:setPosition(params)
	local sprite = self._sprite 
	local locX = params.locX 
	local locY = params.locY 
	

	mte.sendSpriteTo
		{
		sprite=sprite,
		locX = locX,
		locY = locY,
		}
		
	if self._isPlayer then
		mte.moveCameraTo
				{
				levelPosX = sprite.levelPosX,
				levelPosY = sprite.levelPosY,
				}
	end 
	
	mte.update()
end 	

function CHARACTER_CLASS:moveSpriteTo(params)
	params.sprite = self._sprite 
	mte.moveSpriteTo(params)
end 


function CHARACTER_CLASS:setDirection(movement)
	local sprite = self._sprite
	if sprite.sequence ~= movement then
		sprite:setSequence(movement)
	end
end 

function CHARACTER_CLASS:startAnimation()
	if self._sprite.isPlaying then return end 
	self._sprite:play()
end 

function CHARACTER_CLASS:pauseAnimation()
	self._sprite:pause()
end 

function CHARACTER_CLASS:getLoc()
	local sprite = self._sprite
	return sprite.locX,sprite.locY
end 

function CHARACTER_CLASS:getLevel()
	return self._sprite.level
end 






local function 
isObstacle(level, locX, locY)
	----------------------------
	--DETECT OBSTACLES -------
	----------------------------
	local detect = mte.getTileProperties({level = level, locX = locX, locY = locY})

	for i = 1, #detect, 1 do
		if detect[i].properties then
			if detect[i].properties.solid  then
				detect = "stop"
				return detect
			end
		end
	end
end




function CHARACTER_CLASS:update()
	
	local movement = self.movement
	
	if movement then
		local locX,locY = self:getLoc()
		local level = self:getLevel()
		local xTile, yTile = locX + atlas[movement][1], locY + atlas[movement][2]

		self:setDirection(movement)

		
		local result = isObstacle( level, xTile, yTile )
		if result then 	
			self:pauseAnimation()
		else 
			self:startAnimation()
			self:moveSpriteTo({  locX = xTile, locY = yTile, time = 300, easing = "linear" })
		end


	else
		self:pauseAnimation()
	end
end 



function CHARACTER_CLASS.getSpriteSheet()
	return characterSpriteSheet
end 




return CHARACTER_CLASS