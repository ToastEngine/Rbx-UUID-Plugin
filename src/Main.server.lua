local toolbar = plugin:CreateToolbar("UUID Generator")
local ButtonSimple = toolbar:CreateButton("UUID Generator", "Performs Action", "http://www.roblox.com/asset/?id=4557915127")
local ButtonAdvanced = toolbar:CreateButton("UUID Generator Settings", "Toggles Settings", "http://www.roblox.com/asset/?id=4557914743")

local HttpService = game:GetService("HttpService")
local SelectionService = game:GetService("Selection")
local Mode = "Print"


local widgetInfo = DockWidgetPluginGuiInfo.new(
	Enum.InitialDockState.Right,  -- Widget will be initialized in floating panel
	false,   -- Widget will be initially enabled
	false,  -- Don't override the previous enabled state
	200,    -- Default width of the floating window
	300,    -- Default height of the floating window
	150,    -- Minimum width of the floating window
	150     -- Minimum height of the floating window
)
local widget = plugin:CreateDockWidgetPluginGui("UUID Interface", widgetInfo)
widget.Title = "UUID Generator"

local Background = Instance.new("Frame")
local List = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")
local PRINT = Instance.new("TextButton")
local NAME = Instance.new("TextButton")
local STRINGVALUE = Instance.new("TextButton")
local Title = Instance.new("TextLabel")

Background.Name = "Background"
Background.Parent = widget
Background.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
Background.BorderColor3 = Color3.fromRGB(0, 0, 0)
Background.Size = UDim2.new(1, 0, 1, 0)

List.Name = "List"
List.Parent = Background
List.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
List.BackgroundTransparency = 1.000
List.BorderColor3 = Color3.fromRGB(0, 0, 0)
List.Position = UDim2.new(0, 0, 0, 30)
List.Size = UDim2.new(1, 0, 1, 0)

UIListLayout.Parent = List
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

PRINT.Name = "PRINT"
PRINT.Parent = List
PRINT.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
PRINT.BorderSizePixel = 0
PRINT.Size = UDim2.new(0, 120, 0, 30)
PRINT.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
PRINT.Font = Enum.Font.SourceSansBold
PRINT.Text = "Print"
PRINT.TextColor3 = Color3.fromRGB(255, 255, 255)
PRINT.TextSize = 24.000

NAME.Name = "NAME"
NAME.Parent = List
NAME.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
NAME.BorderSizePixel = 0
NAME.Size = UDim2.new(0, 120, 0, 30)
NAME.Style = Enum.ButtonStyle.RobloxRoundButton
NAME.Font = Enum.Font.SourceSansBold
NAME.Text = "Name"
NAME.TextColor3 = Color3.fromRGB(255, 255, 255)
NAME.TextSize = 24.000

STRINGVALUE.Name = "STRINGVALUE"
STRINGVALUE.Parent = List
STRINGVALUE.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
STRINGVALUE.BorderSizePixel = 0
STRINGVALUE.Size = UDim2.new(0, 120, 0, 30)
STRINGVALUE.Style = Enum.ButtonStyle.RobloxRoundButton
STRINGVALUE.Font = Enum.Font.SourceSansBold
STRINGVALUE.Text = "String Value"
STRINGVALUE.TextColor3 = Color3.fromRGB(255, 255, 255)
STRINGVALUE.TextSize = 24.000

Title.Name = "Title"
Title.Parent = Background
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1.000
Title.Size = UDim2.new(1, 0, 0, 20)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "Mode: "
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 24.000

PRINT.MouseButton1Down:connect(function()
    Mode = "Print"
    STRINGVALUE.Style = Enum.ButtonStyle.RobloxRoundButton
    NAME.Style = Enum.ButtonStyle.RobloxRoundButton
    PRINT.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
end)
NAME.MouseButton1Down:connect(function()
    Mode = "Name"
    STRINGVALUE.Style = Enum.ButtonStyle.RobloxRoundButton
    PRINT.Style = Enum.ButtonStyle.RobloxRoundButton
    NAME.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
end)
STRINGVALUE.MouseButton1Down:connect(function()
    Mode = "String Value"
    PRINT.Style = Enum.ButtonStyle.RobloxRoundButton
    NAME.Style = Enum.ButtonStyle.RobloxRoundButton
    STRINGVALUE.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
end)


ButtonSimple.Click:connect(function()
    local UUID = nil
    if Mode == "Print" then
        pcall(function() 
            UUID = HttpService:GenerateGUID(false)
        end)
        if UUID then
            print(HttpService:GenerateGUID(false))
        else
            warn("Failed to generate UUID, is HttpService enabled in game settings?")
        end
    elseif Mode == "Name" then
        local test = nil
        pcall(function() test = HttpService:GenerateGUID(false) end)
        if test then
            pcall(function()
                for _, obj in pairs(SelectionService:Get())do
                    obj.Name = HttpService:GenerateGUID(false)
                end
            end)
        else
            warn("Failed to generate UUID, is HttpService enabled in game settings?")
        end
    elseif Mode == "String Value" then
        local test = nil
        pcall(function() test = HttpService:GenerateGUID(false) end)
        if test then
            pcall(function()
                for _, obj in pairs(SelectionService:Get())do
                    local tmp = Instance.new("StringValue")
                    tmp.Name = "UUID"
                    tmp.Value = HttpService:GenerateGUID(false)
                    tmp.Parent = obj
                end
            end)
        else
            warn("Failed to generate UUID, is HttpService enabled in game settings?")
        end
    end
end)

ButtonAdvanced.Click:connect(function()
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

syncGuiColors(widget:GetDescendants())