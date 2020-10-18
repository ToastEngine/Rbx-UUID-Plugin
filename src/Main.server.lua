local toolbar = plugin:CreateToolbar("Rich Text Console")
local toggle = toolbar:CreateButton("Rich Text Console", "Toggles", "http://www.roblox.com/asset/?id=5830400689")
local version = 1
local logService = game:GetService("LogService")

local widgetInfo = DockWidgetPluginGuiInfo.new(
	Enum.InitialDockState.Right,  -- Widget will be initialized in floating panel
	false,   -- Widget will be initially enabled
	false,  -- Don't override the previous enabled state
	200,    -- Default width of the floating window
	300,    -- Default height of the floating window
	150,    -- Minimum width of the floating window
	150     -- Minimum height of the floating window
)
local widget = plugin:CreateDockWidgetPluginGui("Output", widgetInfo)
widget.Title = "Output"

for _, obj in pairs(script.Parent.consolegui:GetChildren())do
   obj.Parent = widget
end
script.Parent.consolegui:Destroy()
local out = widget.frame.scrollingFrame

for _, guiObject in pairs(widget:GetDescendants()) do
    pcall(function()
        guiObject.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainBackground)
    end)
    pcall(function()
        guiObject.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText)
    end)
end


toggle.Click:Connect(function()
    print(version)
    if widget.Enabled then
        widget.Enabled = false
    else
        widget.Enabled = true
    end
end)

local function syncGuiColors(objects)
	local function setColors()
		for _, guiObject in pairs(objects) do
            pcall(function()
                guiObject.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainBackground)
            end)
            pcall(function()
                guiObject.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText)
            end)
		end
	end
	setColors()
	settings().Studio.ThemeChanged:Connect(setColors)
end

local function log(str)
   local tmp = out.template:Clone()
   tmp.Parent = out
   tmp.Name = tick()
   tmp.Text = os.date("%X - "..str,os.time())
   tmp.Visible = true

   out.CanvasSize = UDim2.new(0,0,0,(18*#out:GetChildren()))
   out.CanvasPosition = Vector2.new(0,out.CanvasSize.Y.Offset)
end

_G.log = function(str)
    log(str)
end

logService.MessageOut:Connect(function(message, messageType)
    if messageType == Enum.MessageType.MessageWarning then
        log("<font color='rgb(255,128,0)'>[U][WARN]: </font>"..message)
    elseif messageType == Enum.MessageType.MessageError then
        log("<font color='rgb(255,0,0)'>[U][ERROR]: </font>"..message)
    elseif messageType == Enum.MessageType.MessageInfo then
        log("<font color='rgb(25,217,255)'>[U][INFO]: </font>"..message)
    else
        log(message)
    end
end)

syncGuiColors(widget:GetDescendants())