local allClasses = allClasses
local allGlobals = allGlobals

local display = display 



local preference = preference

local screenW = allGlobals.screenW
local screenH = allGlobals.screenH
local sW = allGlobals.sW 
local sH = allGlobals.sH 

local mte = mte 



 

local ENEMY_CLASS = {}


local base_class = require "class.character._base"
setmetatable(ENEMY_CLASS,{__index=base_class})


--Constants


local enemySpriteData = 
	{
	["enemy1"] =	{
				["down"] = 7,
				["left"] = 19,
				["right"] = 31,
				["up"] = 43,
				},
				
	["enemy2"] = 	{
					["down"] = 10,
					["left"] = 22,
					["right"] = 34,
					["up"] = 46,
					},
	}
	
	
		

function ENEMY_CLASS.newEnemy(params)
	local params = params or {}


	local spriteData = enemySpriteData[params.name]
	params.sequenceData = {
						{name = "up", count=3,start = spriteData["up"], time = 400, loopCount = 0},
						{name = "down",count=3, start = spriteData["down"], time = 400, loopCount = 0},
						{name = "left",count=3, start = spriteData["left"], time = 400, loopCount = 0},
						{name = "right",count=3, start = spriteData["right"], time = 400, loopCount = 0}
						}
						
						
	local base_object = base_class.newCharacter(params)
	local enemy = setmetatable(base_object,{__index=ENEMY_CLASS})
	
	
	--enemy PROPERTIES
	enemy.__hp = 100 
					
	return enemy
end 














return ENEMY_CLASS