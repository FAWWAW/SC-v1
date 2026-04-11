-- =========================================================
-- FAWWAW UNIVERSAL HUB - WUKONG INSPIRED UI
-- =========================================================

-- [[ 1. KONFIGURASI GLOBAL ]]
getgenv().Config = getgenv().Config or {
    ["Visual"] = {
        ["Title"] = "FAWWAW PRIVATE V1.0",
        ["MonkeyIconID"] = "rbxassetid://16104888126" -- Pastikan ID ini valid di executor-mu
    }
}

-- Nilai internal (bisa dioverride config user di loader)
getgenv().FlySpeed = 50
getgenv().FlyEnabled = false
getgenv().NoclipEnabled = false

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

-- [[ 2. PEMBUATAN UI STRUCTURE DARI NOL (INSTANCE.NEW) ]]

-- Hapus UI lama jika ada
if CoreGui:FindFirstChild("FawwawInspiredUI") then
    CoreGui.FawwawInspiredUI:Destroy()
end

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "FawwawInspiredUI"
ScreenGui.IgnoreGuiInset = true -- Agar posisi akurat di layar mobile/PC

-- Main Container (Draggable)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 600, 0, 380)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -190)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 20) -- Abu-abu gelap (matching image)
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 10)

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
Sidebar.BackgroundColor3 = Color3.fromRGB(22, 22, 25) -- Sedikit lebih cerah
Sidebar.BorderSizePixel = 0

local SidebarCorner = Instance.new("UICorner", Sidebar)
SidebarCorner.CornerRadius = UDim.new(0, 10)

-- Search Placeholder
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

-- Tab Layout
local TabListLayout = Instance.new("UIListLayout", Sidebar)
TabListLayout.Padding = UDim.new(0, 8)
TabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Helper: Buat Tab
local function createTab(name, iconID, order)
    local Tab = Instance.new("TextButton", Sidebar)
    Tab.Name = name .. "Tab"
    Tab.Size = UDim2.new(0, 140, 0, 35)
    Tab.LayoutOrder = order
    Tab.BackgroundColor3 = Color3.fromRGB(30, 30, 35) -- Matching tabs
    Tab.Text = ""
    
    local Corner = Instance.new("UICorner", Tab)
    Corner.CornerRadius = UDim.new(0, 6)

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

-- Buat Tab (Matching image structure)
createTab("Movement", "rbxassetid://16008693899", 1) -- Gunakan ID ikon yang valid
createTab("Visuals", "rbxassetid://16008693899", 2) -- Placeholder

-- Profile Section at bottom
local ProfileFrame = Instance.new("Frame", Sidebar)
ProfileFrame.Size = UDim2.new(1, -20, 0, 40)
ProfileFrame.Position = UDim2.new(0, 10, 1, -50)
ProfileFrame.BackgroundTransparency = 1

local AvatarImage = Instance.new("ImageLabel", ProfileFrame)
AvatarImage.Size = UDim2.new(0, 30, 0, 30)
AvatarImage.Position = UDim2.new(0, 5, 0.5, -15)
AvatarImage.Image = "rbxassetid://160216127" -- User placeholder
AvatarImage.BackgroundTransparency = 1

local UserLabel = Instance.new("TextLabel", ProfileFrame)
UserLabel.Size = UDim2.new(1, -45, 1, 0)
UserLabel.Position = UDim2.new(0, 40, 0, 0)
UserLabel.Text = "User"
UserLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
UserLabel.Font = Enum.Font.GothamMedium
UserLabel.TextSize = 12
UserLabel.TextXAlignment = Enum.TextXAlignment.Left
UserLabel.BackgroundTransparency = 1

-- [[ C. MAIN CONTENT AREA ]]
local Content = Instance.new("Frame", MainFrame)
Content.Size = UDim2.new(1, -170, 1, -50)
Content.Position = UDim2.new(0, 170, 0, 50)
Content.BackgroundTransparency = 1

local ContentLayout = Instance.new("UIListLayout", Content)
ContentLayout.Padding = UDim.new(0, 12)
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Helper: Section Header
local function createSectionHeader(title, parent)
    local Header = Instance.new("TextLabel", parent)
    Header.Size = UDim2.new(1, 0, 0, 25)
    Header.Text = title
    Header.TextColor3 = Color3.fromRGB(180, 180, 180)
    Header.Font = Enum.Font.GothamBold
    Header.TextSize = 14
    Header.TextXAlignment = Enum.TextXAlignment.Left
    Header.BackgroundTransparency = 1
end

-- Helper: Row Item with Toggle
local function createToggleRow(title, parent)
    local Row = Instance.new("Frame", parent)
    Row.Size = UDim2.new(1, 0, 0, 40)
    Row.BackgroundColor3 = Color3.fromRGB(22, 22, 25) -- List item color
    
    local RowCorner = Instance.new("UICorner", Row)
    RowCorner.CornerRadius = UDim.new(0, 6)

    local Label = Instance.new("TextLabel", Row)
    Label.Size = UDim2.new(1, -60, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.Text = title
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1

    -- Toggle Button (Style: Fingerprint style)
    local Toggle = Instance.new("ImageButton", Row)
    Toggle.Size = UDim2.new(0, 25, 0, 25)
    Toggle.Position = UDim2.new(1, -35, 0.5, -12.5)
    Toggle.Image = "rbxassetid://16008693899" -- Default image
    Toggle.BackgroundTransparency = 1

    return Toggle
end

-- POPULASI CONTENT (Movement Tab)
createSectionHeader("Movement Tools", Content)

local FlyToggle = createToggleRow("Fly Mode", Content)
local NoclipToggle = createToggleRow("Noclip", Content)

-- [[ 3. LOGIKA FITUR (INTEGRATION) ]]

-- Noclip Logic
RunService.Stepped:Connect(function()
    if getgenv().NoclipEnabled and LocalPlayer.Character then
        for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") and v.CanCollide == true then
                v.CanCollide = false
            end
        end
    end
end)

-- Fly Logic
task.spawn(function()
    while task.wait() do
        local _, root, hum = getCharacterParts()
        if getgenv().FlyEnabled and root and hum then
            local cam = workspace.CurrentCamera
            root.Velocity = hum.MoveDirection * getgenv().FlySpeed
        end
    end
end)

-- Interaction
FlyToggle.MouseButton1Click:Connect(function()
    getgenv().FlyEnabled = not getgenv().FlyEnabled
    -- Update visuals: Ganti Ikon atau Warna
    if getgenv().FlyEnabled then
        FlyToggle.Image = "rbxassetid://16008693899" -- Ikon Aktif
        game.StarterGui:SetCore("SendNotification", { Title = "Fawwaw Hub", Text = "Fly Enabled!" })
    else
        FlyToggle.Image = "rbxassetid://16008693899" -- Ikon Nonaktif
    }
end)

NoclipToggle.MouseButton1Click:Connect(function()
    getgenv().NoclipEnabled = not getgenv().NoclipEnabled
    -- Update visuals
    if getgenv().NoclipEnabled then
        NoclipToggle.Image = "rbxassetid://16008693899"
        game.StarterGui:SetCore("SendNotification", { Title = "Fawwaw Hub", Text = "Noclip Enabled!" })
    else
        NoclipToggle.Image = "rbxassetid://16008693899"
    }
end)

-- Notifikasi Sukses
game.StarterGui:SetCore("SendNotification", {
    Title = "Fawwaw Private",
    Text = "Universal Hub Loaded Successfully!",
    Duration = 5,
})
