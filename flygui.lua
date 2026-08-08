-- Delta Executor Speed Script - Completely Rewritten

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Speed Variables
local speedEnabled = false
local currentSpeed = 50
local maxSpeed = 1000000

-- Create UI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SpeedGUI"
screenGui.Parent = game:GetService("CoreGui")

-- Main Speed Button (Top Right)
local speedButton = Instance.new("TextButton")
speedButton.Name = "SpeedButton"
speedButton.Size = UDim2.new(0, 100, 0, 40)
speedButton.Position = UDim2.new(1, -120, 0, 20)
speedButton.Text = "Speed"
speedButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
speedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
speedButton.BorderSizePixel = 0
speedButton.Font = Enum.Font.SourceSansBold
speedButton.TextSize = 16
speedButton.Parent = screenGui

-- Settings Frame (Hidden by default)
local speedFrame = Instance.new("Frame")
speedFrame.Name = "SpeedFrame"
speedFrame.Size = UDim2.new(0, 250, 0, 150)
speedFrame.Position = UDim2.new(1, -270, 0, 60)
speedFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
speedFrame.BorderSizePixel = 0
speedFrame.Visible = false
speedFrame.Parent = screenGui

-- Frame Title
local speedFrameTitle = Instance.new("TextLabel")
speedFrameTitle.Name = "SpeedFrameTitle"
speedFrameTitle.Size = UDim2.new(1, 0, 0, 30)
speedFrameTitle.Position = UDim2.new(0, 0, 0, 0)
speedFrameTitle.Text = "Speed Settings"
speedFrameTitle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
speedFrameTitle.BorderSizePixel = 0
speedFrameTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
speedFrameTitle.Font = Enum.Font.SourceSansBold
speedFrameTitle.TextSize = 18
speedFrameTitle.Parent = speedFrame

-- Speed Input
local speedInput = Instance.new("TextBox")
speedInput.Name = "SpeedInput"
speedInput.Size = UDim2.new(1, -20, 0, 30)
speedInput.Position = UDim2.new(0, 10, 0, 50)
speedInput.Text = "50"
speedInput.PlaceholderText = "Enter speed (max 1,000,000)"
speedInput.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
speedInput.BorderSizePixel = 0
speedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
speedInput.Font = Enum.Font.SourceSans
speedInput.TextSize = 14
speedInput.Parent = speedFrame

-- OK Button
local okButton = Instance.new("TextButton")
okButton.Name = "OKButton"
okButton.Size = UDim2.new(0.5, -15, 0, 30)
okButton.Position = UDim2.new(0, 10, 0, 90)
okButton.Text = "OK"
okButton.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
okButton.BorderSizePixel = 0
okButton.TextColor3 = Color3.fromRGB(255, 255, 255)
okButton.Font = Enum.Font.SourceSansBold
okButton.TextSize = 14
okButton.Parent = speedFrame

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0.5, -15, 0, 30)
closeButton.Position = UDim2.new(0.5, 5, 0, 90)
closeButton.Text = "Close"
closeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeButton.BorderSizePixel = 0
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextSize = 14
closeButton.Parent = speedFrame

-- Speed Toggle Function
local function toggleSpeed()
    speedEnabled = not speedEnabled
    
    if speedEnabled then
        speedButton.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
        speedButton.Text = "Speed ON"
    else
        speedButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        speedButton.Text = "Speed"
    end
end

-- Update Speed Function
local function updateSpeed()
    local newSpeed = tonumber(speedInput.Text)
    if newSpeed and newSpeed > 0 then
        currentSpeed = math.min(newSpeed, maxSpeed)
        speedInput.Text = tostring(currentSpeed)
    else
        speedInput.Text = tostring(currentSpeed)
    end
end

-- Event Connections
speedButton.MouseButton1Click:Connect(function()
    toggleSpeed()
    speedFrame.Visible = true
end)

okButton.MouseButton1Click:Connect(function()
    updateSpeed()
    speedFrame.Visible = false
end)

closeButton.MouseButton1Click:Connect(function()
    speedFrame.Visible = false
end)

-- Input validation for speed
speedInput.FocusLost:Connect(function()
    updateSpeed()
end)

-- Character Wait Function
local function waitForCharacter()
    if Player.Character then
        return Player.Character
    end
    
    local character = Player.CharacterAdded:Wait()
    return character
end

-- Speed Application Function
local function applySpeed()
    if not speedEnabled then return end
    
    local character = waitForCharacter()
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    
    if humanoid then
        humanoid.WalkSpeed = currentSpeed
    end
end

-- Main Loop
RunService.Heartbeat:Connect(function()
    applySpeed()
end)

-- Character Respawn Handling
Player.CharacterAdded:Connect(function()
    if speedEnabled then
        -- Reapply speed when character respawns
        task.wait(0.5)
        applySpeed()
    end
end)

-- Load Message
print("Speed script loaded successfully! Click the Speed button to activate.")