-- 🌟 Blox Fruits Private GUI by mewing1933 (Auto Raid + Teleport Sea 3)

-- Load Rayfield UI Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Buat Jendela UI
local Window = Rayfield:CreateWindow({
   Name = "Blox Fruits Private",
   LoadingTitle = "Loading...",
   LoadingSubtitle = "by mewing1933",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "BloxFruitsPrivateHub",
      FileName = "Settings"
   },
   Discord = {Enabled = false},
   KeySystem = false,
})

-- Tab Utama
local MainTab = Window:CreateTab("Main", 4483362458)

-- Dropdown Enemy
local selectedEnemy = "Bandit" -- default
MainTab:CreateDropdown({
   Name = "Pilih Musuh",
   Options = {"Bandit", "Brute", "Marine", "Pirate", "God's Guard", "Shanda", "Royal Squad", "Marine Captain"},
   CurrentOption = "Bandit",
   Callback = function(Value)
      selectedEnemy = Value
   end,
})

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
      local Enemies = workspace:FindFirstChild("Enemies") or workspace:FindFirstChild("Enemy") or workspace:FindFirstChild("Mobs")
      if not Enemies then continue end

      local enemy = Enemies:FindFirstChild(selectedEnemy)
      if enemy and enemy:FindFirstChild("HumanoidRootPart") and enemy.Humanoid.Health > 0 then
         teleportTo(enemy.HumanoidRootPart.Position + Vector3.new(0, 5, 0))
         wait(0.3)
         pcall(function()
            game:GetService("ReplicatedStorage").Remotes.Combat:FireServer(enemy)
         end)
      end
   end
end

function stopAutoFarm()
   farming = false
end

MainTab:CreateButton({
   Name = "▶ Start Auto Farm",
   Callback = function()
      startAutoFarm()
   end,
})

MainTab:CreateButton({
   Name = "⏹ Stop Auto Farm",
   Callback = function()
      stopAutoFarm()
   end,
})

-- Auto Raid Function
function startAutoRaid()
   local ReplicatedStorage = game:GetService("ReplicatedStorage")
   local CommF_ = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")
   local args = {
       [1] = "RaidsNpc",
       [2] = "Select",
       [3] = "Flame" -- Ganti dengan elemen raid yang diinginkan
   }
   CommF_:InvokeServer(unpack(args))
   wait(1)
   local startArgs = {
       [1] = "RaidsNpc",
       [2] = "Start"
   }
   CommF_:InvokeServer(unpack(startArgs))
end

MainTab:CreateButton({
   Name = "🔥 Start Auto Raid",
   Callback = function()
      startAutoRaid()
   end,
})

-- Teleport Sea 3
local Sea3Tab = Window:CreateTab("Sea 3 Teleport", 4483362458)

local islands = {
   ["Hydra Island"] = Vector3.new(5225, 25, -1100),
   ["Great Tree"] = Vector3.new(2250, 25, -700),
   ["Castle on the Sea"] = Vector3.new(-500, 25, 300),
   ["Port Town"] = Vector3.new(-1000, 25, 500),
   ["Floating Turtle"] = Vector3.new(3000, 25, 1500),
}

Sea3Tab:CreateDropdown({
   Name = "Pilih Pulau",
   Options = {"Hydra Island", "Great Tree", "Castle on the Sea", "Port Town", "Floating Turtle"},
   CurrentOption = "Hydra Island",
   Callback = function(Value)
      teleportTo(islands[Value])
   end,
})
