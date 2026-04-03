if _G.AutoFarm then

    if not _G.ClearedMap then
        _G.ClearedMap = true

        pcall(function()
            for _, v in pairs(game:GetService("Workspace"):GetChildren()) do
                if v.Name:lower():find("tycoon")
                and v ~= game:GetService("Players").LocalPlayer.TycoonData.Tycoon.Value then
                    v:Destroy()
                end
            end

            if game:GetService("Workspace"):FindFirstChild("Exterior Terrain") then
                game:GetService("Workspace")["Exterior Terrain"]:Destroy()
            end
        end)
    end

    _G.LastRejoin = 0

    _G.IconConn = game:GetService("Players").LocalPlayer.PlayerGui.DescendantAdded:Connect(function(obj)
        if obj.Name == "ItemIcon" then
            obj:Destroy()
        end
    end)

    for i = 1,2 do
        task.spawn(function()
            while _G.AutoFarm do
                pcall(function()
                    if game:GetService("Players").LocalPlayer.Character
                    and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    and game:GetService("Players").LocalPlayer:FindFirstChild("TycoonData")
                    and game:GetService("Players").LocalPlayer.TycoonData:FindFirstChild("Tycoon")
                    and game:GetService("Players").LocalPlayer.TycoonData.Tycoon.Value then

                        firetouchinterest(
                            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart,
                            game:GetService("Players").LocalPlayer.TycoonData.Tycoon.Value.P_Coindropper_1.HouseCoinDropper.Collider,
                            0
                        )

                        firetouchinterest(
                            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart,
                            game:GetService("Players").LocalPlayer.TycoonData.Tycoon.Value.P_Coindropper_1.HouseCoinDropper.Collider,
                            1
                        )
                    end
                end)
                task.wait(0.025)
            end
        end)
    end

    task.spawn(function()
        while _G.AutoFarm do
            pcall(function()

                if game:GetService("Players").LocalPlayer.Character
                and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                and game:GetService("Workspace"):FindFirstChild("Camera")
                and game:GetService("Workspace").Camera:FindFirstChild("NextButton")
                and game:GetService("Workspace").Camera.NextButton:FindFirstChild("Target") then

                    for i = 1,14 do

                        game:GetService("TweenService"):Create(
                            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart,
                            TweenInfo.new(0.06, Enum.EasingStyle.Sine),
                            {
                                CFrame = CFrame.new(
                                    game:GetService("Workspace").Camera.NextButton.Target.Position.X + math.cos(math.rad((i/14)*360))*3,
                                    game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position.Y,
                                    game:GetService("Workspace").Camera.NextButton.Target.Position.Z + math.sin(math.rad((i/14)*360))*3
                                )
                            }
                        ):Play()

                        task.wait(0.06)

                    end
                end

            end)

            task.wait(0.1)
        end
    end)

    task.spawn(function()
        while _G.AutoFarm do
            pcall(function()

                for i = 1,3 do
                    game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("RemoteCollectGem"):FireServer()
                end

                for i = 1,3 do
                    game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunctions"):WaitForChild("IncrementSpinAvailable"):InvokeServer(100000)
                end

            end)
            task.wait(0.15)
        end
    end)

    task.spawn(function()
        while _G.AutoFarm do
            pcall(function()

                for i = 1,99 do
                    game:GetService("ReplicatedStorage")
                    :WaitForChild("RemoteEvents")
                    :WaitForChild("AttemptToClaimFunPassReward")
                    :FireServer(i,1)

                    if i % 10 == 0 then
                        task.wait(0.05)
                    end
                end

            end)
            task.wait(1)
        end
    end)

    task.spawn(function()
        while _G.AutoFarm do
            pcall(function()
                if game:GetService("Players").LocalPlayer.PlayerGui.Windows.Rebirth.Container.MainFrame.ProgressBG.ProgressLabel.Text == "100%" then
                    game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("Rebirth"):FireServer()
                end
            end)
            task.wait(1)
        end
    end)

    task.spawn(function()
        while _G.AutoFarm do
            pcall(function()
                for i = 101,103 do
                    game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("EquipPetEvent"):FireServer(i)
                end
            end)
            task.wait(3)
        end
    end)

    task.spawn(function()
        while _G.AutoFarm do
            pcall(function()

                if (not game:GetService("Workspace"):FindFirstChild("Camera")
                or not game:GetService("Workspace").Camera:FindFirstChild("NextButton")
                or not game:GetService("Workspace").Camera.NextButton:FindFirstChild("Target")) then

                    if tick() - _G.LastRejoin > 5 then
                        _G.LastRejoin = tick()

                        if game:GetService("Players").LocalPlayer.PlayerGui.Windows.Rebirth.Container.MainFrame.ProgressBG.ProgressLabel.Text ~= "100%" then
                            
                            game:GetService("Players").LocalPlayer:Kick("\nRejoining...")
                            task.wait()

                            pcall(function()
                                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game:GetService("Players").LocalPlayer)
                            end)

                            pcall(function()
                                game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
                            end)
                        end
                    end
                end

            end)
            task.wait(1)
        end
    end)

else
    _G.AutoFarm = false

    if _G.IconConn then
        _G.IconConn:Disconnect()
        _G.IconConn = nil
    end
end
