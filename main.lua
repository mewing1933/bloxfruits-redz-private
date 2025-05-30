-- 🌟 Blox Fruits Private GUI by mewing1933

-- Load Rayfield UI Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Buat Jendela UI
local Window = Rayfield:CreateWindow({
   Name = "Blox Fruits Private",
   LoadingTitle = "Loading...",
   LoadingSubtitle = "by mewing1933",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "BloxFruitsPrivateHub", -- nama folder penyimpanan
      FileName = "Settings"
   },
   Discord = {
      Enabled = false
   },
   KeySystem = false,
})

-- Tab Utama
local MainTab = Window:CreateTab("Main", 4483362458)

-- Auto Farm Script
local farming = false

function teleportTo(position)
   local TweenService = game:GetService("TweenService")
   local Player = game.Players.LocalPlayer
   local RootPart = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
   if RootPart then
      local tween = TweenService:Create(RootPart, TweenInfo.new(0.5), {CFrame = CFrame.new(position)})
      tween:Play()
   end
end

function startAutoFarm()
   farming = true
   while farming and task.wait(1) do
      local enemy = workspace.Enemies:FindFirstChild("Bandit")
      if enemy and enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
         teleportTo(enemy.HumanoidRootPart.Position + Vector3.new(0, 5, 0))
         wait(0.3)
         game:GetService("ReplicatedStorage").Remotes.Combat:FireServer(enemy)
      end
   end
end

function stopAutoFarm()
   farming = false
end

-- Tombol Start Auto Farm
MainTab:CreateButton({
   Name = "▶ Start Auto Farm Bandit",
   Callback = function()
      startAutoFarm()
   end,
})

-- Tombol Stop Auto Farm
MainTab:CreateButton({
   Name = "⏹ Stop Auto Farm",
   Callback = function()
      stopAutoFarm()
   end,
})
