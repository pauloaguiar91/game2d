
local display = display 
local screenW = display.contentWidth
local screenH = display.contentHeight
local sW = screenW*.5 
local sH = screenH*.5



 --THIS IS A CLASS FOR CREATING AND DESTROYING CUSTOM WINDOWS 
 --THIS IS JUST A BASE CLASS USED FOR INHERITANCE

local WINDOW_CLASS = {}
WINDOW_CLASS.__index = WINDOW_CLASS




function WINDOW_CLASS.newWindow(params)
	local params = params or {}
	
	local window_object = setmetatable({},WINDOW_CLASS)
	
	local group = display.newGroup()
	if params.group then 
		params.group:insert(group)
	end 
	
	local base = display.newRect(group,0,0,200,200)
	base.x = sW 
	base.y = sH 
	
	
	local okButton = widget.newButton
		{
		label = "OK",
		width = 70,height=40,
		top = base.contentBounds.yMax - 50,
		onRelease = 
					function(event)
						if params.onOk then 
							local okIsHandled = params.onOk()
							if okIsHandled then return end 
						end 
						window_object:destroyWindow()
						
					end 
		}
	okButton.x = sW
	group:insert(okButton)
	
	
	local cw,ch = 25,25
	local closeButton = widget.newButton
		{
		defaultFile = "assets/misc/window_close.png",
		overFile = "assets/misc/window_closec.png",
		width = cw,height =ch,
		left = base.contentBounds.xMax-cw/2,top = base.contentBounds.yMin-ch/2,
		onRelease = 
					function()
						window_object:destroyWindow()
					end 
		}
	group:insert(closeButton)
	
	
	--These are the list of elements to be displayed in the window(other than the buttons)
	local windowElements = params.windowElements or {}
	for i=1,#windowElements do 
		group:insert(windowElements[i])
	end 
	
	
	
	group:setReferencePoint(display.CenterReferencePoint)
	group.isVisible = false
	
	
	
	
	window_object._group = group
	return window_object

end 


function WINDOW_CLASS:showWindow()
	local group = self._group
	group.isVisible = true 
	transition.from(group,{xScale=0.1,yScale=0.1,time=400})
end 

function WINDOW_CLASS:hideWindow()
	local group = self._group
	transition.from(group,{xScale=0.1,yScale=0.1,time=400,onComplete = 
					function()
						group.isVisible = false
					end })
end 

function WINDOW_CLASS:destroyWindow()
	transition.to(self._group,{xScale=0.01,yScale=0.01,time=400,onComplete = 
		function(obj)
			if obj and obj.x then obj:removeSelf() end 
		end})
end 


return WINDOW_CLASS