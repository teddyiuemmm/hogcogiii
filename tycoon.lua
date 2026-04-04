if _G.AutoFarm then
    loadstring(game:HttpGet("https://pastefy.app/mWZZYsht/raw", true))()

    -- CLEAR MAP (SAFE, giữ Camera)
    if not _G.ClearedMap then
        _G.ClearedMap = true
        pcall(function()
            local player = game:GetService("Players").LocalPlayer
            local myTycoon = player:FindFirstChild("TycoonData")
                and player.TycoonData:FindFirstChild("Tycoon")
                and player.TycoonData.Tycoon.Value

            for _, v in pairs(game:GetService("Workspace"):GetChildren()) do
                if v.Name:lower():find("tycoon") 
                and v ~= myTycoon
                and v ~= game:GetService("Workspace"):FindFirstChild("Camera") then
                    pcall(function() v:Destroy() end)
                end
            end
        end)
    end

    -- ITEM ICON
    if _G.IconConn then _G.IconConn:Disconnect() end
    _G.IconConn = game:GetService("Players").LocalPlayer.PlayerGui.DescendantAdded:Connect(function(v)
        if v.Name == "ItemIcon" then v:Destroy() end
    end)

    -- AUTO COIN
    task.spawn(function()
        while _G.AutoFarm do
            pcall(function()
                local hrp = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
                local collider = game:GetService("Players").LocalPlayer.TycoonData.Tycoon.Value
                    .P_Coindropper_1.HouseCoinDropper.Collider

                firetouchinterest(hrp, collider, 0)
                firetouchinterest(hrp, collider, 1)
            end)
            task.wait(0.03)
        end
    end)

    -- AUTO MOVE
    task.spawn(function()
        while _G.AutoFarm do
            pcall(function()
                local hrp = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
                local target = game:GetService("Workspace").Camera.NextButton.Target.Position
                for i = 1, 12 do
                    local angle = math.rad((i/12)*360)
                    hrp.CFrame = CFrame.new(
                        target.X + math.cos(angle)*2.5,
                        hrp.Position.Y,
                        target.Z + math.sin(angle)*2.5
                    )
                    task.wait(0.05)
                end
            end)
            task.wait(0.05)
        end
    end)

    -- AUTO GEM + SPIN
    task.spawn(function()
        while _G.AutoFarm do
            pcall(function()
                local rs = game:GetService("ReplicatedStorage")
                rs.RemoteEvents.RemoteCollectGem:FireServer()
                rs.RemoteFunctions.IncrementSpinAvailable:InvokeServer(100000)
            end)
            task.wait(0.2)
        end
    end)

    -- FUNPASS
    task.spawn(function()
        while _G.AutoFarm do
            pcall(function()
                local rs = game:GetService("ReplicatedStorage")
                for i = 1, 99 do
                    rs.RemoteEvents.AttemptToClaimFunPassReward:FireServer(i,1)
                    if i % 15 == 0 then task.wait(0.01) end
                end
            end)
            task.wait(1)
        end
    end)

    -- REBIRTH
    task.spawn(function()
        while _G.AutoFarm do
            pcall(function()
                local prog = game:GetService("Players").LocalPlayer.PlayerGui
                    .Windows.Rebirth.Container.MainFrame.ProgressBG.ProgressLabel
                if prog.Text == "100%" then
                    game:GetService("ReplicatedStorage").RemoteEvents.Rebirth:FireServer()
                end
            end)
            task.wait(0.5)
        end
    end)

    -- EQUIP PET
    task.spawn(function()
        while _G.AutoFarm do
            pcall(function()
                local rs = game:GetService("ReplicatedStorage")
                for i = 101,103 do
                    rs.RemoteEvents.EquipPetEvent:FireServer(i)
                end
            end)
            task.wait(1)
        end
    end)

    -- EASTER EGG
    task.spawn(function()
        while _G.AutoFarm do
            pcall(function()
                local hrp = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
                for _, v in pairs(game:GetService("Workspace")["Exterior Terrain"]["Easter Event Area"]:GetDescendants()) do
                    if v:IsA("BasePart") and v.Name == "EasterEgg" then
                        firetouchinterest(hrp, v, 0)
                        firetouchinterest(hrp, v, 1)
                    end
                end
            end)
            task.wait(0.05)
        end
    end)

    -- AUTO REJOIN
    task.spawn(function()
        while _G.AutoFarm do
            pcall(function()
                local camera = game:GetService("Workspace"):FindFirstChild("Camera")
                if not camera
                or not camera:FindFirstChild("NextButton")
                or not camera.NextButton:FindFirstChild("Target") then

                    if not _G.LastRejoin or tick() - _G.LastRejoin > 5 then
                        _G.LastRejoin = tick()
                        local prog = game:GetService("Players").LocalPlayer.PlayerGui
                            .Windows.Rebirth.Container.MainFrame.ProgressBG.ProgressLabel
                        if prog.Text ~= "100%" then
                            game:GetService("Players").LocalPlayer:Kick("\nRejoining...")
                            task.wait(0.5)
                            pcall(function()
                                game:GetService("TeleportService"):TeleportToPlaceInstance(
                                    game.PlaceId,
                                    game.JobId,
                                    game:GetService("Players").LocalPlayer
                                )
                            end)
                            pcall(function()
                                game:GetService("TeleportService"):Teleport(
                                    game.PlaceId,
                                    game:GetService("Players").LocalPlayer
                                )
                            end)
                        end
                    end
                end
            end)
            task.wait(0.5)
        end
    end)

else
    if _G.IconConn then
        _G.IconConn:Disconnect()
        _G.IconConn = nil
    end
end
