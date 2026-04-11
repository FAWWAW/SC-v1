-- =========================================================
-- FAWWAW UNIVERSAL HUB V1.2 - IMPROVED UI & MECHANICS
-- =========================================================

getgenv().FawwawConfig = getgenv().FawwawConfig or {
    ["Visual"] = {
        ["Title"] = "FAWWAW PRIVATE V1.2",
        ["MonkeyIconID"] = "rbxassetid://16104888126"
    }
}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Camera = workspace.CurrentCamera

-- Global States
getgenv().FlyEnabled = false
getgenv().NoclipEnabled = false
getgenv().FlySpeed = 50

local SelectedPlayer = nil
local Ctrl = {F = 0, B = 0, L = 0, R = 0}
local LastCtrl = {F = 0, B = 0, L = 0, R = 0}
local Speed = 0

-- Bersihkan UI lama jika ada
if CoreGui:FindFirstChild("FawwawInspiredUI") then
    CoreGui.FawwawInspiredUI:Destroy()
end

-- [[ 1. PEMBUATAN UI STRUCTURE ]]
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "FawwawInspiredUI"
ScreenGui.IgnoreGuiInset = true

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 550, 0, 350)
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 23)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

-- Header Bar
local Header = Instance.new("Frame", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 8)

local MonkeyIcon = Instance.new("ImageLabel", Header)
MonkeyIcon.Size = UDim2.new(0, 25, 0, 25)
MonkeyIcon.Position = UDim2.new(0, 10, 0.5, -12.5)
MonkeyIcon.Image = getgenv().FawwawConfig.Visual.MonkeyIconID
MonkeyIcon.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1, -50, 1, 0)
Title.Position = UDim2.new(0, 45, 0, 0)
Title.Text = getgenv().FawwawConfig.Visual.Title
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1

-- Sidebar
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 150, 1, -40)
Sidebar.Position = UDim2.new(0, 0, 0, 40)
Sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 28)
Sidebar.BorderSizePixel = 0
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 8)

local TabListLayout = Instance.new("UIListLayout", Sidebar)
TabListLayout.Padding = UDim.new(0, 5)
TabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Spacer untuk Sidebar
local Spacer = Instance.new("Frame", Sidebar)
Spacer.Size = UDim2.new(1, 0, 0, 5)
Spacer.BackgroundTransparency = 1

-- Content Container (Tempat frame tab ditampilkan)
local ContentContainer = Instance.new("Frame", MainFrame)
ContentContainer.Size = UDim2.new(1, -160, 1, -50)
ContentContainer.Position = UDim2.new(0, 155, 0, 45)
ContentContainer.BackgroundTransparency = 1

local TabFrames = {}
local TabButtons = {}

-- [[ 2. FUNGSI PEMBUATAN ELEMEN UI ]]

local function createTab(name, iconID, order)
    local TabBtn = Instance.new("TextButton", Sidebar)
    TabBtn.Size = UDim2.new(0, 130, 0, 35)
    TabBtn.LayoutOrder = order
    TabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    TabBtn.Text = ""
    TabBtn.AutoButtonColor = false
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)

    local Icon = Instance.new("ImageLabel", TabBtn)
    Icon.Size = UDim2.new(0, 18, 0, 18)
    Icon.Position = UDim2.new(0, 10, 0.5, -9)
    Icon.Image = iconID
    Icon.BackgroundTransparency = 1

    local Label = Instance.new("TextLabel", TabBtn)
    Label.Size = UDim2.new(1, -35, 1, 0)
    Label.Position = UDim2.new(0, 35, 0, 0)
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(200, 200, 200)
    Label.Font = Enum.Font.GothamMedium
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1

    -- Frame Konten untuk Tab ini
    local ContentFrame = Instance.new("ScrollingFrame", ContentContainer)
    ContentFrame.Size = UDim2.new(1, 0, 1, 0)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.ScrollBarThickness = 3
    ContentFrame.BorderSizePixel = 0
    ContentFrame.Visible = false
    
    local ContentLayout = Instance.new("UIListLayout", ContentFrame)
    ContentLayout.Padding = UDim.new(0, 10)
    ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder

    TabFrames[name] = ContentFrame
    TabButtons[name] = {Btn = TabBtn, Label = Label}

    -- Logika Pindah Tab
    TabBtn.MouseButton1Click:Connect(function()
        for tName, frame in pairs(TabFrames) do
            frame.Visible = (tName == name)
            TabButtons[tName].Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
            TabButtons[tName].Label.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
        TabBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
        Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)

    return ContentFrame
end

local function createToggle(title, parent, callback)
    local Row = Instance.new("Frame", parent)
    Row.Size = UDim2.new(1, -10, 0, 40)
    Row.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    Instance.new("UICorner", Row).CornerRadius = UDim.new(0, 6)

    local Label = Instance.new("TextLabel", Row)
    Label.Size = UDim2.new(1, -70, 1, 0)
    Label.Position = UDim2.new(0, 15, 0, 0)
    Label.Text = title
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1

    local ToggleBtn = Instance.new("TextButton", Row)
    ToggleBtn.Size = UDim2.new(0, 40, 0, 20)
    ToggleBtn.Position = UDim2.new(1, -55, 0.5, -10)
    ToggleBtn.Text = ""
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
    Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

    local Circle = Instance.new("Frame", ToggleBtn)
    Circle.Size = UDim2.new(0, 16, 0, 16)
    Circle.Position = UDim2.new(0, 2, 0.5, -8)
    Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)

    local state = false
    ToggleBtn.MouseButton1Click:Connect(function()
        state = not state
        callback(state)
        
        local goalPos = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
        local goalColor = state and Color3.fromRGB(0, 200, 80) or Color3.fromRGB(60, 60, 65)
        
        TweenService:Create(Circle, TweenInfo.new(0.2), {Position = goalPos}):Play()
        TweenService:Create(ToggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = goalColor}):Play()
    end)
end

local function createSectionHeader(title, parent)
    local HeaderSec = Instance.new("TextLabel", parent)
    HeaderSec.Size = UDim2.new(1, -10, 0, 25)
    HeaderSec.Text = title
    HeaderSec.TextColor3 = Color3.fromRGB(150, 150, 150)
    HeaderSec.Font = Enum.Font.GothamBold
    HeaderSec.TextSize = 12
    HeaderSec.TextXAlignment = Enum.TextXAlignment.Left
    HeaderSec.BackgroundTransparency = 1
end

-- [[ 3. MENGISI KONTEN TABS ]]

local MovementTab = createTab("Movement", "rbxassetid://16008693899", 1)
local VisualsTab = createTab("Visuals", "rbxassetid://16008693899", 2)

-- === TAB MOVEMENT ===
createSectionHeader("  Movement Tools", MovementTab)

createToggle("Fly Mode", MovementTab, function(state)
    getgenv().FlyEnabled = state
end)

createToggle("Noclip", MovementTab, function(state)
    getgenv().NoclipEnabled = state
end)

-- === TAB VISUALS (Teleport) ===
createSectionHeader("  Player Teleport", VisualsTab)

local DropdownFrame = Instance.new("Frame", VisualsTab)
DropdownFrame.Size = UDim2.new(1, -10, 0, 40)
DropdownFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
Instance.new("UICorner", DropdownFrame).CornerRadius = UDim.new(0, 6)

local SelectedLabel = Instance.new("TextLabel", DropdownFrame)
SelectedLabel.Size = UDim2.new(1, -40, 1, 0)
SelectedLabel.Position = UDim2.new(0, 15, 0, 0)
SelectedLabel.Text = "Select Player..."
SelectedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
SelectedLabel.Font = Enum.Font.Gotham
SelectedLabel.TextSize = 13
SelectedLabel.BackgroundTransparency = 1
SelectedLabel.TextXAlignment = Enum.TextXAlignment.Left

local DropBtn = Instance.new("TextButton", DropdownFrame)
DropBtn.Size = UDim2.new(0, 30, 0, 30)
DropBtn.Position = UDim2.new(1, -35, 0.5, -15)
DropBtn.Text = "▼"
DropBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
DropBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", DropBtn).CornerRadius = UDim.new(0, 4)

local PlayerList = Instance.new("ScrollingFrame", VisualsTab)
PlayerList.Size = UDim2.new(1, -10, 0, 100)
PlayerList.Visible = false
PlayerList.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
PlayerList.BorderSizePixel = 0
PlayerList.ScrollBarThickness = 3
Instance.new("UICorner", PlayerList).CornerRadius = UDim.new(0, 6)
local PlayerListLayout = Instance.new("UIListLayout", PlayerList)

local TeleportBtn = Instance.new("TextButton", VisualsTab)
TeleportBtn.Size = UDim2.new(1, -10, 0, 40)
TeleportBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
TeleportBtn.Text = "TELEPORT"
TeleportBtn.Font = Enum.Font.GothamBold
TeleportBtn.TextSize = 13
TeleportBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", TeleportBtn).CornerRadius = UDim.new(0, 6)

local function updatePlayerList()
    for _, v in pairs(PlayerList:GetChildren()) do
        if v:IsA("TextButton") then v:Destroy() end
    end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local pBtn = Instance.new("TextButton", PlayerList)
            pBtn.Size = UDim2.new(1, 0, 0, 30)
            pBtn.Text = "   " .. p.DisplayName
            pBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
            pBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
            pBtn.Font = Enum.Font.Gotham
            pBtn.TextSize = 12
            pBtn.TextXAlignment = Enum.TextXAlignment.Left
            
            pBtn.MouseButton1Click:Connect(function()
                SelectedPlayer = p
                SelectedLabel.Text = p.DisplayName
                PlayerList.Visible = false
                DropBtn.Text = "▼"
            end)
        end
    end
end

DropBtn.MouseButton1Click:Connect(function()
    PlayerList.Visible = not PlayerList.Visible
    DropBtn.Text = PlayerList.Visible and "▲" or "▼"
    if PlayerList.Visible then updatePlayerList() end
end)

TeleportBtn.MouseButton1Click:Connect(function()
    if SelectedPlayer and SelectedPlayer.Character and SelectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local myChar = LocalPlayer.Character
        if myChar and myChar:FindFirstChild("HumanoidRootPart") then
            myChar.HumanoidRootPart.CFrame = SelectedPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
        end
    end
end)

-- Set Default Tab Terbuka
TabFrames["Movement"].Visible = true
TabButtons["Movement"].Btn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
TabButtons["Movement"].Label.TextColor3 = Color3.fromRGB(255, 255, 255)


-- [[ 4. LOGIKA NOCLIP & FLY (SUPER) ]]

-- Noclip (Bypass Brookhaven)
RunService.Stepped:Connect(function()
    if getgenv().NoclipEnabled then
        local char = LocalPlayer.Character
        if char then
            for _, v in pairs(char:GetDescendants()) do
                if v:IsA("BasePart") and v.CanCollide then
                    v.CanCollide = false
                end
            end
        end
    end
end)

-- Sistem Kontrol Fly (Dukungan Mobile & PC)
UIS.InputBegan:Connect(function(input, isProcessed)
    if isProcessed then return end
    if input.KeyCode == Enum.KeyCode.W or input.KeyCode == Enum.KeyCode.Up then Ctrl.F = 1
    elseif input.KeyCode == Enum.KeyCode.S or input.KeyCode == Enum.KeyCode.Down then Ctrl.B = -1
    elseif input.KeyCode == Enum.KeyCode.A or input.KeyCode == Enum.KeyCode.Left then Ctrl.L = -1
    elseif input.KeyCode == Enum.KeyCode.D or input.KeyCode == Enum.KeyCode.Right then Ctrl.R = 1
    end
end)

UIS.InputEnded:Connect(function(input, isProcessed)
    if input.KeyCode == Enum.KeyCode.W or input.KeyCode == Enum.KeyCode.Up then Ctrl.F = 0
    elseif input.KeyCode == Enum.KeyCode.S or input.KeyCode == Enum.KeyCode.Down then Ctrl.B = 0
    elseif input.KeyCode == Enum.KeyCode.A or input.KeyCode == Enum.KeyCode.Left then Ctrl.L = 0
    elseif input.KeyCode == Enum.KeyCode.D or input.KeyCode == Enum.KeyCode.Right then Ctrl.R = 0
    end
end)

-- Fly Logic (CFrame method)
RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChild("Humanoid")
    
    if getgenv().FlyEnabled and root and hum then
        -- Cek arah gerakan (dari keyboard pc atau joystick mobile)
        local moveDir = hum.MoveDirection
        local lookVector = Camera.CFrame.LookVector
        local rightVector = Camera.CFrame.RightVector
        
        -- Override gravitasi dengan velocity 0
        root.Velocity = Vector3.new(0, 0, 0)
        
        -- Hitung pergerakan
        if moveDir.Magnitude > 0 then
            root.CFrame = root.CFrame + (moveDir * (getgenv().FlySpeed / 50))
        end
    end
end)

