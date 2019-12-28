local toolbar = plugin:CreateToolbar("UUID Generator")
local ButtonSimple = toolbar:CreateButton("UUID Generator", "Generates a UUID to output", "rbxassetid://4458901886")
--local ButtonAdvanced = toolbar:CreateButton("UUID Generator Advanced", "Toggled Advanced Interface", "rbxassetid://4458901886")
local HttpService = game:GetService("HttpService")


ButtonSimple.Click:connect(function()
    print(HttpService:GenerateGUID(false))
end)