local allClasses = allClasses
local allGlobals = allGlobals

local display = display 



local preference = preference

local screenW = allGlobals.screenW
local screenH = allGlobals.screenH
local sW = allGlobals.sW 
local sH = allGlobals.sH 

local mte = mte 



 

local PLAYER_CLASS = {}


local base_class = require "class.character._base"
setmetatable(PLAYER_CLASS,{__index=base_class})


--Constants


local playerSpriteData = 
	{
	["boy"] =	{
				["down"] = 4,
				["left"] = 16,
				["right"] = 28,
				["up"] = 40,
				},
				
	["girl"] = 	{
				["down"] = 1,
				["left"] = 13,
				["right"] = 25,
				["up"] = 37,
				},
	}
	
	
		

function PLAYER_CLASS.newPlayer(params)
	local params = params or {}


	local spriteData = playerSpriteData[params.gender]
	params.sequenceData = {
						{name = "up", count=3,start = spriteData["up"], time = 400, loopCount = 0},
						{name = "down",count=3, start = spriteData["down"], time = 400, loopCount = 0},
						{name = "left",count=3, start = spriteData["left"], time = 400, loopCount = 0},
						{name = "right",count=3, start = spriteData["right"], time = 400, loopCount = 0}
						}
						
						
	local base_object = base_class.newCharacter(params)
	local player = setmetatable(base_object,{__index=PLAYER_CLASS})
	
	
	--PLAYER PROPERTIES
	player.__hp = 100 
					
					
					
					
	player._isPlayer = true 
	
	return player
end 














return PLAYER_CLASS