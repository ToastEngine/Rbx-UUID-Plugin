local toolbar = plugin:CreateToolbar("UUID Generator")
local ButtonSimple = toolbar:CreateButton("UUID Generator", "Generates a UUID to output", "rbxassetid://4458901886")
local ButtonAdvanced = toolbar:CreateButton("UUID Generator Advanced", "Toggled Advanced Interface", "rbxassetid://4458901886")

local HttpService = game:GetService("HttpService")



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
widget.Title = "Adv UUID Generator"

local Background = Instance.new("Frame")
Background.Parent = widget
Background.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
Background.BorderColor3 = Color3.fromRGB(0, 0, 0)
Background.Size = UDim2.new(1, 0, 1, 0)

ButtonSimple.Click:connect(function()
    local UUID = nil
    pcall(function() 
        UUID = HttpService:GenerateGUID(false)
    end)
    if UUID then
        print(HttpService:GenerateGUID(false))
    else
        warn("Failed to generate UUID, is HttpService enabled in game settings?")
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