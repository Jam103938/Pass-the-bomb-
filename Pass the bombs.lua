repeat task.wait(0.25) until game:IsLoaded()

getgenv().Image = "rbxassetid://18853503513" 
getgenv().ToggleUI = "Q"

task.spawn(function()
    if not getgenv().LoadedMobileUI then 
        getgenv().LoadedMobileUI = true
        local OpenUI = Instance.new("ScreenGui")
        local ImageButton = Instance.new("ImageButton")
        local UICorner = Instance.new("UICorner")

        OpenUI.Name = "OpenUI"
        OpenUI.Parent = game:GetService("CoreGui")
        OpenUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

        ImageButton.Parent = OpenUI
        ImageButton.BackgroundColor3 = Color3.fromRGB(105,105,105)
        ImageButton.BackgroundTransparency = 0.8
        ImageButton.Position = UDim2.new(0.9,0,0.1,0)
        ImageButton.Size = UDim2.new(0,50,0,50)
        ImageButton.Image = getgenv().Image
        ImageButton.Draggable = true

        UICorner.CornerRadius = UDim.new(0,200)
        UICorner.Parent = ImageButton

        ImageButton.MouseButton1Click:Connect(function()
            game:GetService("VirtualInputManager"):SendKeyEvent(true, getgenv().ToggleUI, false, game)
        end)
    end
end)

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Pass the Bomb",
    SubTitle = "by Jaimz",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.Q
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
} 

local Toggle = Tabs.Main:AddToggle("Toggle the button auto pass the bomb", {
    Title = "Toggle",
    Description = "This will auto pass the bomb",
    Default = false,
    Callback = function(state)
        local function runScript()
            local TeleportService = game:GetService("TeleportService")
            local Players = game:GetService("Players")
            local player = Players.LocalPlayer
            
            if game.PlaceId ~= 2961583129 then
                local screenGui = Instance.new("ScreenGui")
                local frame = Instance.new("Frame")
                local yesButton = Instance.new("TextButton")
                local noButton = Instance.new("TextButton")
                local titleLabel = Instance.new("TextLabel")

                screenGui.Name = "TeleportGui"
                screenGui.Parent = player:WaitForChild("PlayerGui")

                frame.Size = UDim2.new(0.4, 0, 0.3, 0)
                frame.Position = UDim2.new(0.3, 0, 0.35, 0)
                frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                frame.BackgroundTransparency = 0.5
                frame.Parent = screenGui

                titleLabel.Size = UDim2.new(1, 0, 0.4, 0)
                titleLabel.Text = "Do you want to teleport to the Pass the Bomb game?"
                titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                titleLabel.TextScaled = true
                titleLabel.BackgroundTransparency = 1
                titleLabel.Parent = frame

                yesButton.Size = UDim2.new(0.4, 0, 0.3, 0)
                yesButton.Position = UDim2.new(0.1, 0, 0.55, 0)
                yesButton.Text = "Yes"
                yesButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                yesButton.Parent = frame

                noButton.Size = UDim2.new(0.4, 0, 0.3, 0)
                noButton.Position = UDim2.new(0.5, 0, 0.55, 0)
                noButton.Text = "No"
                noButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                noButton.Parent = frame

                yesButton.MouseButton1Click:Connect(function()
                    TeleportService:Teleport(2961583129, player)
                end)

                noButton.MouseButton1Click:Connect(function()
                    screenGui:Destroy()
                end)
            end
            
            local function isHoldingBomb()
                return player.Character and player.Character:FindFirstChild("Bomb") ~= nil
            end

            local function teleportToRandomPlayer()
                local otherPlayers = Players:GetPlayers()
                if #otherPlayers < 2 then return end

                local randomPlayer = otherPlayers[math.random(1, #otherPlayers)]
                while randomPlayer == player or (randomPlayer.Character and randomPlayer.Character:FindFirstChild("Bomb")) do
                    randomPlayer = otherPlayers[math.random(1, #otherPlayers)]
                end

                local destination = randomPlayer.Character and randomPlayer.Character:FindFirstChild("HumanoidRootPart")
                local character = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

                if destination and character then
                    character.CFrame = destination.CFrame
                end
            end

            if state then
                game:GetService("RunService").Heartbeat:Connect(function()
                    if isHoldingBomb() then
                        teleportToRandomPlayer()
                    end
                end)
                print("Toggle On")
            else
                print("Toggle Off")
            end
        end

        runScript()
    end
})
