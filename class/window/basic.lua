
local display = display 
local screenW = display.contentWidth
local screenH = display.contentHeight
local sW = screenW*.5 
local sH = screenH*.5





 

local WINDOW_CLASS = {}

local base_class = require "class.window._base"
setmetatable(WINDOW_CLASS,{__index=base_class})


function WINDOW_CLASS.newWindow(params)
	local params = params or {}
	
	local base_class_object = base_class.newWindow(params)
	local window_object = setmetatable(base_class_object,{__index=WINDOW_CLASS})
	



	return window_object
end 







return WINDOW_CLASS