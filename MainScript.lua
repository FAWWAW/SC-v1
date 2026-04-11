-- [[ MAIN SCRIPT - HOSTED ON GITHUB ]]

-- 1. Cek apakah Config ada, jika tidak gunakan default (Agar tidak error)
local Settings = getgenv().Config or {
    ["FlySettings"] = { ["Enabled"] = false, ["Speed"] = 50 },
    ["Visual"] = { ["Title"] = "FAWWAW HUB", ["Color"] = Color3.fromRGB(30, 30, 30) }
}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- 2. Terapkan Nilai dari Config ke Variabel Global
getgenv().FlyEnabled = Settings["FlySettings"]["Enabled"]
getgenv().FlySpeed = Settings["FlySettings"]["Speed"]
getgenv().NoclipEnabled = false -- Default off

-- 3. Pembuatan UI (Custom)
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
ScreenGui.Name = "FawwawHubUI"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 180, 0, 150)
MainFrame.Position = UDim2.new(0.1, 0, 0.4, 0)
MainFrame.BackgroundColor3 = Settings["Visual"]["Color"]
MainFrame.Active = true
MainFrame.Draggable = true

local Corner = Instance.new("UICorner", MainFrame)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = Settings["Visual"]["Title"]
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold

-- [LOGIC FLY & NOCLIP]
RunService.Stepped:Connect(function()
    if getgenv().NoclipEnabled and LocalPlayer.Character then
        for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if getgenv().FlyEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local root = LocalPlayer.Character.HumanoidRootPart
            local hum = LocalPlayer.Character:FindFirstChild("Humanoid")
            root.Velocity = hum.MoveDirection * getgenv().FlySpeed
        end
    end
end)

-- Notifikasi Sukses
game.StarterGui:SetCore("SendNotification", {
    Title = "Fawwaw Store",
    Text = "Script Loaded via Config!",
    Duration = 5
})
