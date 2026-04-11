-- =========================================================
-- FAWWAW UNIVERSAL HUB - WUKONG UI + TELEPORT DROPDOWN
-- =========================================================

-- [[ 1. KONFIGURASI GLOBAL & VARIABEL ]]
getgenv().Config = getgenv().Config or {
    ["Visual"] = {
        ["Title"] = "FAWWAW PRIVATE V1.0",
        ["MonkeyIconID"] = "rbxassetid://16104888126"
    }
}

getgenv().FlySpeed = 50
getgenv().FlyEnabled = false
getgenv().NoclipEnabled = false
local SelectedPlayer = nil -- Variabel untuk menyimpan pemain yang dipilih

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

-- Helper: Ambil referensi karakter
local function getCharacterParts()
    local char = LocalPlayer.Character
    if char then
        local root = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChild("Humanoid")
        return char, root, hum
    end
    return nil, nil, nil
end

-- [[ 2. PEMBUATAN UI STRUCTURE ]]

if CoreGui:FindFirstChild("FawwawInspiredUI") then
    CoreGui.FawwawInspiredUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "FawwawInspiredUI"
ScreenGui.IgnoreGuiInset = true

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 600, 0, 380)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -190)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

-- [[ A. HEADER BAR ]]
local Header = Instance.new("Frame", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundTransparency = 1

local MonkeyIcon = Instance.new("ImageLabel", Header)
MonkeyIcon.Size = UDim2.new(0, 30, 0, 30)
MonkeyIcon.Position = UDim2.new(0, 10, 0.5, -15)
MonkeyIcon.Image = getgenv().Config.Visual.MonkeyIconID
MonkeyIcon.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1, -90, 1, 0)
Title.Position = UDim2.new(0, 50, 0, 0)
Title.Text = getgenv().Config.Visual.Title
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1

-- [[ B. LEFT SIDEBAR ]]
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 160, 1, -40)
Sidebar.Position = UDim2.new(0, 0, 0, 40)
Sidebar.BackgroundColor3 = Color3.fromRGB(22, 22, 25)
Sidebar.BorderSizePixel = 0
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 10)

local SearchBar = Instance.new("Frame", Sidebar)
SearchBar.Size = UDim2.new(1, -20, 0, 30)
SearchBar.Position = UDim2.new(0, 10, 0, 10)
SearchBar.BackgroundColor3 = Color3.fromRGB(30, 30, 35)

local SearchText = Instance.new("TextLabel", SearchBar)
SearchText.Size = UDim2.new(1, -10, 1, 0)
SearchText.Position = UDim2.new(0, 10, 0, 0)
SearchText.Text = "Search all tabs..."
SearchText.TextColor3 = Color3.fromRGB(150, 150, 150)
SearchText.Font = Enum.Font.Gotham
SearchText.TextSize = 12
SearchText.TextXAlignment = Enum.TextXAlignment.Left
SearchText.BackgroundTransparency = 1

local TabListLayout = Instance.new("UIListLayout", Sidebar)
TabListLayout.Padding = UDim.new(0, 8)
TabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function createTab(name, iconID, order)
    local Tab = Instance.new("TextButton", Sidebar)
    Tab.Size = UDim2.new(0, 140, 0, 35)
    Tab.LayoutOrder = order
    Tab.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    Tab.Text = ""
    Instance.new("UICorner", Tab).CornerRadius = UDim.new(0, 6)

    local Icon = Instance.new("ImageLabel", Tab)
    Icon.Size = UDim2.new(0, 20, 0, 20)
    Icon.Position = UDim2.new(0, 10, 0.5, -10)
    Icon.Image = iconID
    Icon.BackgroundTransparency = 1

    local Label = Instance.new("TextLabel", Tab)
    Label.Size = UDim2.new(1, -40, 1, 0)
    Label.Position = UDim2.new(0, 35, 0, 0)
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(200, 200, 200)
    Label.Font = Enum.Font.GothamMedium
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1
end

createTab("Movement", "rbxassetid://16008693899", 1)
createTab("Visuals", "rbxassetid://16008693899", 2)

-- [[ C. MAIN CONTENT AREA ]]
local Content = Instance.new("ScrollingFrame", MainFrame)
Content.Size = UDim2.new(1, -170, 1, -50)
Content.Position = UDim2.new(0, 170, 0, 50)
Content.BackgroundTransparency = 1
Content.CanvasSize = UDim2.new(0, 0, 2, 0) -- Agar bisa di-scroll jika itemnya banyak
Content.ScrollBarThickness = 4
Content.BorderSizePixel = 0

local ContentLayout = Instance.new("UIListLayout", Content)
ContentLayout.Padding = UDim.new(0, 12)
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder

local function createSectionHeader(title, parent)
    local HeaderSec = Instance.new("TextLabel", parent)
    HeaderSec.Size = UDim2.new(1, -10, 0, 25)
    HeaderSec.Text = title
    HeaderSec.TextColor3 = Color3.fromRGB(180, 180, 180)
    HeaderSec.Font = Enum.Font.GothamBold
    HeaderSec.TextSize = 14
    HeaderSec.TextXAlignment = Enum.TextXAlignment.Left
    HeaderSec.BackgroundTransparency = 1
end

local function createToggleRow(title, parent)
    local Row = Instance.new("Frame", parent)
    Row.Size = UDim2.new(1, -10, 0, 40)
    Row.BackgroundColor3 = Color3.fromRGB(22, 22, 25)
    Instance.new("UICorner", Row).CornerRadius = UDim.new(0, 6)

    local Label = Instance.new("TextLabel", Row)
    Label.Size = UDim2.new(1, -60, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.Text = title
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1

    local Toggle = Instance.new("ImageButton", Row)
    Toggle.Size = UDim2.new(0, 25, 0, 25)
    Toggle.Position = UDim2.new(1, -35, 0.5, -12.5)
    Toggle.Image = "rbxassetid://16008693899"
    Toggle.BackgroundTransparency = 1

    return Toggle
end

-- === POPULASI KONTEN MOVEMENT ===
createSectionHeader("Movement Tools", Content)
local FlyToggle = createToggleRow("Fly Mode", Content)
local NoclipToggle = createToggleRow("Noclip", Content)

-- === POPULASI KONTEN TELEPORT (Ditambahkan dari V2) ===
createSectionHeader("Player Teleport", Content)

local DropdownFrame = Instance.new("Frame", Content)
DropdownFrame.Size = UDim2.new(1, -10, 0, 40)
DropdownFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
Instance.new("UICorner", DropdownFrame).CornerRadius = UDim.new(0, 6)

local SelectedLabel = Instance.new("TextLabel", DropdownFrame)
SelectedLabel.Size = UDim2.new(1, -40, 1, 0)
SelectedLabel.Position = UDim2.new(0, 10, 0, 0)
SelectedLabel.Text = "Select Player..."
SelectedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
SelectedLabel.Font = Enum.Font.Gotham
SelectedLabel.TextSize = 13
SelectedLabel.BackgroundTransparency = 1
SelectedLabel.TextXAlignment = Enum.TextXAlignment.Left

local DropBtn = Instance.new("TextButton", DropdownFrame)
DropBtn.Size = UDim2.new(0, 30, 0, 30)
DropBtn.Position = UDim2.new(1, -35, 0.5, -15)
DropBtn.Text = "V"
DropBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
DropBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", DropBtn).CornerRadius = UDim.new(0, 6)

local PlayerList = Instance.new("ScrollingFrame", Content)
PlayerList.Size = UDim2.new(1, -10, 0, 100)
PlayerList.Visible = false
PlayerList.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
PlayerList.BorderSizePixel = 0
PlayerList.ScrollBarThickness = 3
Instance.new("UICorner", PlayerList).CornerRadius = UDim.new(0, 6)
local PlayerListLayout = Instance.new("UIListLayout", PlayerList)
PlayerListLayout.Padding = UDim.new(0, 2)

local TeleportBtn = Instance.new("TextButton", Content)
TeleportBtn.Size = UDim2.new(1, -10, 0, 40)
TeleportBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
TeleportBtn.Text = "TELEPORT TO PLAYER"
TeleportBtn.Font = Enum.Font.GothamBold
TeleportBtn.TextSize = 13
TeleportBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", TeleportBtn).CornerRadius = UDim.new(0, 6)


-- [[ 3. LOGIKA FITUR ]]

-- A. Noclip & Fly Logic
RunService.Stepped:Connect(function()
    if getgenv().NoclipEnabled and LocalPlayer.Character then
        for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") and v.CanCollide == true then
                v.CanCollide = false
            end
        end
    end
end)

task.spawn(function()
    while task.wait() do
        local _, root, hum = getCharacterParts()
        if getgenv().FlyEnabled and root and hum then
            local cam = workspace.CurrentCamera
            root.Velocity = hum.MoveDirection * getgenv().FlySpeed
        end
    end
end)

FlyToggle.MouseButton1Click:Connect(function()
    getgenv().FlyEnabled = not getgenv().FlyEnabled
    if getgenv().FlyEnabled then
        FlyToggle.Image = "rbxassetid://16008693899" 
        game.StarterGui:SetCore("SendNotification", { Title = "Fawwaw Hub", Text = "Fly Enabled!" })
    else
        FlyToggle.Image = "rbxassetid://16008693899" 
    end -- Typo diperbaiki disini
end)

NoclipToggle.MouseButton1Click:Connect(function()
    getgenv().NoclipEnabled = not getgenv().NoclipEnabled
    if getgenv().NoclipEnabled then
        NoclipToggle.Image = "rbxassetid://16008693899"
        game.StarterGui:SetCore("SendNotification", { Title = "Fawwaw Hub", Text = "Noclip Enabled!" })
    else
        NoclipToggle.Image = "rbxassetid://16008693899"
    end -- Typo diperbaiki disini
end)

-- B. Teleport Dropdown Logic
local function updatePlayerList()
    -- Bersihkan list lama
    for _, v in pairs(PlayerList:GetChildren()) do
        if v:IsA("TextButton") then v:Destroy() end
    end
    
    -- Isi dengan pemain terbaru
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local pBtn = Instance.new("TextButton", PlayerList)
            pBtn.Size = UDim2.new(1, 0, 0, 30)
            pBtn.Text = "  " .. p.DisplayName .. " (@" .. p.Name .. ")"
            pBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
            pBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
            pBtn.Font = Enum.Font.Gotham
            pBtn.TextSize = 12
            pBtn.TextXAlignment = Enum.TextXAlignment.Left
            pBtn.BorderSizePixel = 0
            
            pBtn.MouseButton1Click:Connect(function()
                SelectedPlayer = p
                SelectedLabel.Text = p.Name
                PlayerList.Visible = false
            end)
        end
    end
end

DropBtn.MouseButton1Click:Connect(function()
    PlayerList.Visible = not PlayerList.Visible
    if PlayerList.Visible then updatePlayerList() end
end)

TeleportBtn.MouseButton1Click:Connect(function()
    if SelectedPlayer and SelectedPlayer.Character and SelectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local myChar = LocalPlayer.Character
        if myChar and myChar:FindFirstChild("HumanoidRootPart") then
            -- Teleport 3 stud di belakang pemain target
            myChar.HumanoidRootPart.CFrame = SelectedPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
            game.StarterGui:SetCore("SendNotification", {Title = "Success", Text = "Teleported to " .. SelectedPlayer.Name})
        end
    else
        game.StarterGui:SetCore("SendNotification", {Title = "Error", Text = "Player not found or dead!"})
    end
end)

-- Notifikasi Sukses Load
game.StarterGui:SetCore("SendNotification", {
    Title = "Fawwaw Private",
    Text = "Universal Hub Loaded Successfully!",
    Duration = 5,
})
