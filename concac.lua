--// Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")

--// UI Library Wizard
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()
local window = Library:NewWindow("Remote Interaction Menu")
local mainSection = window:NewSection("Main Features")

--// Function to find objects by class
local function findAll(className)
    local found = {}
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA(className) then
            table.insert(found, obj)
        end
    end
    return found
end

--// State variables for buttons
local stateShowPrompt = false
local stateFirePrompt = false
local stateFireTouch = false
local stateFireClick = false

--// 1. Scan & SendNotification
mainSection:CreateButton("Scan & Notify", function()
    local prompts = findAll("ProximityPrompt")
    local touches = {}
    for _, part in ipairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") and part:FindFirstChildOfClass("TouchTransmitter") then
            table.insert(touches, part)
        end
    end
    local clicks = findAll("ClickDetector")

    StarterGui:SetCore("SendNotification", {
        Title = "Scan Complete",
        Text = "ProximityPrompts: "..#prompts.."\nTouchInterests: "..#touches.."\nClickDetectors: "..#clicks,
        Duration = 5
    })
end)

--// 2. Show Prompts button
mainSection:CreateButton("Toggle Show Prompts", function()
    stateShowPrompt = not stateShowPrompt
end)

--// 3. Activate Prompts button
mainSection:CreateButton("Toggle Activate Prompts", function()
    stateFirePrompt = not stateFirePrompt
end)

--// 4. Fire TouchInterests button
mainSection:CreateButton("Toggle Fire TouchInterests", function()
    stateFireTouch = not stateFireTouch
end)

--// 5. Fire ClickDetectors button
mainSection:CreateButton("Toggle Fire ClickDetectors", function()
    stateFireClick = not stateFireClick
end)

--// Loop to handle button states
RunService.Heartbeat:Connect(function()
    -- Show Prompts
    if stateShowPrompt then
        for _, prompt in ipairs(findAll("ProximityPrompt")) do
            pcall(function()
                prompt.RequiresLineOfSight = false
                prompt.MaxActivationDistance = 99999
                prompt.Enabled = true
            end)
        end
    end

    -- Activate Prompts
    if stateFirePrompt then
        for _, prompt in ipairs(findAll("ProximityPrompt")) do
            pcall(function()
                fireproximityprompt(prompt)
            end)
        end
    end

    -- Fire TouchInterests
    if stateFireTouch then
        for _, part in ipairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") and part:FindFirstChildOfClass("TouchTransmitter") then
                pcall(function()
                    firetouchinterest(root, part, 0)
                    task.wait(0.05)
                    firetouchinterest(root, part, 1)
                end)
            end
        end
    end

    -- Fire ClickDetectors
    if stateFireClick then
        for _, click in ipairs(findAll("ClickDetector")) do
            pcall(function()
                click.MaxActivationDistance = 99999
                fireclickdetector(click)
            end)
        end
    end
end)
