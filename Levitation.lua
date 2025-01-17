local UserInputService = game:GetService("UserInputService")
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("HumanoidRootPart")
local isLevitating = false
local levitateForce = Instance.new("BodyVelocity")

levitateForce.MaxForce = Vector3.new(0, 5000, 0)
levitateForce.P = 1250
levitateForce.Velocity = Vector3.new(0, 0, 0)
levitateForce.Parent = humanoid

local function toggleLevitation()
    isLevitating = not isLevitating
    if isLevitating then
        levitateForce.Velocity = Vector3.new(0, 50, 0)
        levitateForce.Enabled = true
    else
        levitateForce.Enabled = false
    end
end

game:GetService("RunService").RenderStepped:Connect(function()
    if isLevitating then
        local moveDirection = humanoid.CFrame:VectorToWorldSpace(Vector3.new(
            UserInputService:IsKeyDown(Enum.KeyCode.A) and -1 or UserInputService:IsKeyDown(Enum.KeyCode.D) and 1 or 0,
            0,
            UserInputService:IsKeyDown(Enum.KeyCode.W) and -1 or UserInputService:IsKeyDown(Enum.KeyCode.S) and 1 or 0
        ))
        levitateForce.Velocity = Vector3.new(moveDirection.X * 20, 50, moveDirection.Z * 20)
    end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.F then
        toggleLevitation()
    end
end)
