if _G.AutoFarm then

    if not _G.ClearedMap then
        _G.ClearedMap = true

        pcall(function()
            if game:GetService("Players").LocalPlayer
            and game:GetService("Players").LocalPlayer:FindFirstChild("TycoonData")
            and game:GetService("Players").LocalPlayer.TycoonData:FindFirstChild("Tycoon")
            and game:GetService("Players").LocalPlayer.TycoonData.Tycoon.Value then

                local myTycoon = game:GetService("Players").LocalPlayer.TycoonData.Tycoon.Value

                for _, v in pairs(game:GetService("Workspace"):GetChildren()) do
                    if v.Name:lower():find("tycoon") and v ~= myTycoon then
                        pcall(function()
                            v:Destroy()
                        end)
                    end
                end

                if game:GetService("Workspace"):FindFirstChild("Exterior Terrain") then
                    game:GetService("Workspace")["Exterior Terrain"]:Destroy()
                end
            end
        end)
    end

    _G.t1 = 0
    _G.t2 = 0
    _G.t3 = 0
    _G.t4 = 0
    _G.t6 = 0
    _G.t9 = 0
    _G.LastRejoin = 0

    _G.IconConn = game:GetService("Players").LocalPlayer.PlayerGui.DescendantAdded:Connect(function(obj)
        if obj.Name == "ItemIcon" then
            obj:Destroy()
        end
    end)

    _G.Connection = game:GetService("RunService").Heartbeat:Connect(function()
        pcall(function()

            local now = tick()

            if now - _G.t9 > 0.5 then
                _G.t9 = now
                if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("HUD") then
                    local g = game:GetService("Players").LocalPlayer.PlayerGui.HUD.LeftContainer.Currencies.Gems
                    if g:FindFirstChild("ItemIcon") then
                        g.ItemIcon:Destroy()
                    end
                end
            end

            if now - _G.t1 > 0.4 then
                _G.t1 = now
                for _, v in pairs(game:GetService("Players").LocalPlayer.TycoonData.Tycoon.Value:GetDescendants()) do
                    if v.Name == "Pad" and v:FindFirstChild("TouchInterest") then
                        firetouchinterest(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, v, 0)
                        task.wait(0.01)
                        firetouchinterest(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, v, 1)
                    end
                end
            end

            if now - _G.t2 > 0.25 then
                _G.t2 = now
                local d = game:GetService("Players").LocalPlayer.TycoonData.Tycoon.Value.P_Coindropper_1.HouseCoinDropper.Collider
                firetouchinterest(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, d, 0)
                task.wait(0.01)
                firetouchinterest(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, d, 1)
            end

            if now - _G.t3 > 0.5 then
                _G.t3 = now
                if game:GetService("Workspace"):FindFirstChild("Camera")
                and game.Workspace.Camera:FindFirstChild("NextButton")
                and game.Workspace.Camera.NextButton:FindFirstChild("Target") then
                    game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame =
                        game.Workspace.Camera.NextButton.Target.CFrame
                end
            end

            if now - _G.t4 > 1 then
                _G.t4 = now
                if game:GetService("Players").LocalPlayer.PlayerGui.Windows.Rebirth.Container.MainFrame.ProgressBG.ProgressLabel.Text == "100%" then
                    game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("Rebirth"):FireServer()
                end
            end

            if now - _G.t6 > 3 then
                _G.t6 = now
                for i = 101,103 do
                    game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("EquipPetEvent"):FireServer(i)
                end
            end

            for i = 1,6 do
                game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("RemoteCollectGem"):FireServer()
            end

            for i = 1,6 do
                game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunctions"):WaitForChild("IncrementSpinAvailable"):InvokeServer(100000)
            end

            for i = 1,99 do
                game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("AttemptToClaimFunPassReward"):FireServer(i,1)
            end

            if (not game:GetService("Workspace"):FindFirstChild("Camera")
            or not game.Workspace.Camera:FindFirstChild("NextButton")
            or not game.Workspace.Camera.NextButton:FindFirstChild("Target")) then

                if now - _G.LastRejoin > 5 then
                    _G.LastRejoin = now

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
    end)

else
    if _G.Connection then
        _G.Connection:Disconnect()
        _G.Connection = nil
    end

    if _G.IconConn then
        _G.IconConn:Disconnect()
        _G.IconConn = nil
    end
end
