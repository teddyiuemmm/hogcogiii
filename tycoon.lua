if _G.AutoFarm then
    _G.Connection = game:GetService("RunService").Heartbeat:Connect(function()
        pcall(function()

            -- Xoá ItemIcon
            if game:GetService("Players").LocalPlayer
            and game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")
            and game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("HUD")
            and game:GetService("Players").LocalPlayer.PlayerGui.HUD.LeftContainer.Currencies.Gems:FindFirstChild("ItemIcon") then

                game:GetService("Players").LocalPlayer
                .PlayerGui
                .HUD
                .LeftContainer
                .Currencies
                .Gems
                .ItemIcon:Destroy()
            end

            -- Tween tới NextButton
            if game:GetService("Players").LocalPlayer
            and game:GetService("Players").LocalPlayer.Character
            and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            and game:GetService("Workspace"):FindFirstChild("Camera")
            and game.Workspace.Camera:FindFirstChild("NextButton")
            and game.Workspace.Camera.NextButton:FindFirstChild("Target") then

                if (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position
                - game.Workspace.Camera.NextButton.Target.Position).Magnitude > 5 then

                    game:GetService("TweenService"):Create(
                        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart,
                        TweenInfo.new(0.3),
                        {
                            CFrame = game.Workspace.Camera.NextButton.Target.CFrame
                        }
                    ):Play()
                end
            end

            -- Coin Dropper
            if game:GetService("Players").LocalPlayer
            and game:GetService("Players").LocalPlayer.Character
            and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            and game:GetService("Players").LocalPlayer:FindFirstChild("TycoonData")
            and game:GetService("Players").LocalPlayer.TycoonData:FindFirstChild("Tycoon")
            and game:GetService("Players").LocalPlayer.TycoonData.Tycoon.Value
            and game:GetService("Players").LocalPlayer.TycoonData.Tycoon.Value:FindFirstChild("P_Coindropper_1")
            and game:GetService("Players").LocalPlayer.TycoonData.Tycoon.Value.P_Coindropper_1:FindFirstChild("HouseCoinDropper")
            and game:GetService("Players").LocalPlayer.TycoonData.Tycoon.Value.P_Coindropper_1.HouseCoinDropper:FindFirstChild("Collider") then

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

            -- Auto Rebirth
            if game:GetService("Players").LocalPlayer
            and game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")
            and game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Windows")
            and game:GetService("Players").LocalPlayer.PlayerGui.Windows:FindFirstChild("Rebirth")
            and game:GetService("Players").LocalPlayer.PlayerGui.Windows.Rebirth.Container.MainFrame.ProgressBG:FindFirstChild("ProgressLabel") then
                
                if game:GetService("Players").LocalPlayer
                .PlayerGui
                .Windows
                .Rebirth
                .Container
                .MainFrame
                .ProgressBG
                .ProgressLabel.Text == "100%" then

                    game:GetService("ReplicatedStorage")
                    :WaitForChild("RemoteEvents")
                    :WaitForChild("Rebirth")
                    :FireServer()
                end
            end

            -- Claim FunPass
            for i = 1, 99 do
                game:GetService("ReplicatedStorage")
                :WaitForChild("RemoteEvents")
                :WaitForChild("AttemptToClaimFunPassReward")
                :FireServer(i, 1)
            end

            -- Equip Pet
            for i = 101, 103 do
                game:GetService("ReplicatedStorage")
                :WaitForChild("RemoteEvents")
                :WaitForChild("EquipPetEvent")
                :FireServer(i)
            end

            -- Gem
            for i = 1, 6 do
                game:GetService("ReplicatedStorage")
                :WaitForChild("RemoteEvents")
                :WaitForChild("RemoteCollectGem")
                :FireServer()
            end

            -- Spin
            for i = 1, 6 do
                game:GetService("ReplicatedStorage")
                :WaitForChild("RemoteFunctions")
                :WaitForChild("IncrementSpinAvailable")
                :InvokeServer(100000)
            end

        end)
    end)
else
    if _G.Connection then
        _G.Connection:Disconnect()
        _G.Connection = nil
    end
end
