-- Blox Fruits Private Script by mewing1933
-- Basic auto-farm script (harus disesuaikan dengan karakter dan lokasi)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- Fungsi untuk teleport ke posisi
function teleportTo(pos)
    local tween = TweenService:Create(LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(1), {CFrame = CFrame.new(pos)})
    tween:Play()
end

-- Fungsi auto-farm musuh
function autoFarm()
    while true do
        local enemy = workspace.Enemies:FindFirstChild("Bandit")
        if enemy and enemy:FindFirstChild("HumanoidRootPart") then
            teleportTo(enemy.HumanoidRootPart.Position + Vector3.new(0, 5, 0))
            wait(0.5)
            -- Simulasi serangan
            game:GetService("ReplicatedStorage").Remotes.Combat:FireServer(enemy)
        end
        wait(1)
    end
end

-- Mulai auto-farm
autoFarm()
