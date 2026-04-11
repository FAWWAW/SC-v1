-- =========================================================
-- FAWWAW UNIVERSAL HUB V1.4 - LIGHT BLUE THEME & FULL FEATURES
-- =========================================================

-- Konfigurasi & Palet Warna (Biru Muda)
getgenv().FawwawConfig = getgenv().FawwawConfig or {
    ["Visual"] = {
        ["Title"] = "FAWWAW PRIVATE V1.4",
        ["MonkeyIconID"] = "rbxassetid://16104888126",
        ["MovementIcon"] = "rbxassetid://6031082533", 
        ["VisualsIcon"] = "rbxassetid://6031262846",
        ["PlayerIcon"] = "rbxassetid://6031075929", -- Ikon Player
        ["FaqIcon"] = "rbxassetid://6031082533"     -- Ikon Info/FAQ
    }
}

local Palette = {
    MainBG = Color3.fromRGB(220, 240, 255),    -- Biru Muda (Background Utama)
    Header = Color3.fromRGB(150, 210, 255),    -- Biru Langit (Header)
    Sidebar = Color3.fromRGB(180, 225, 255),   -- Biru Pucat (Sidebar)
    Button = Color3.fromRGB(100, 180, 255),    -- Biru Tombol Aktif
    ButtonOff = Color3.fromRGB(160, 200, 230), -- Biru Tombol Mati
    Text = Color3.fromRGB(20, 40, 60),         -- Teks Gelap
    SubText = Color3.fromRGB(50, 80, 110),     -- Teks Abu-abu Kebiruan
    White = Color3.fromRGB(255, 255, 255)
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
getgenv().WalkSpeed = 16

local SelectedPlayer = nil
local Ctrl = {F = 0, B = 0, L = 0, R = 0}

-- Bersihkan UI lama
if CoreGui:FindFirstChild("FawwawInspiredUI") then
    CoreGui.FawwawInspiredUI:Destroy()
end

-- [[ 1. PEMBUATAN UI STRUCTURE ]]
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "FawwawInspiredUI"
ScreenGui.IgnoreGuiInset = true

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 580, 0, 400)
MainFrame.Position = UDim2.new(0.5, -290, 0.5, -200)
MainFrame.BackgroundColor3 = Palette.MainBG
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

-- Header
local Header = Instance.new("Frame", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 45)
Header.BackgroundColor3 = Palette.Header
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 10)

local MonkeyIcon = Instance.new("ImageLabel", Header)
MonkeyIcon.Size = UDim2.new(0, 28, 0, 28)
MonkeyIcon.Position = UDim2.new(0, 15, 0.5, -14)
MonkeyIcon.Image = getgenv().FawwawConfig.Visual.MonkeyIconID
MonkeyIcon.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1, -60, 1, 0)
Title.Position = UDim2.new(0, 55, 0, 0)
Title.Text = getgenv().FawwawConfig.Visual.Title
Title.TextColor3 = Palette.Text
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1

-- Sidebar
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 160, 1, -45)
Sidebar.Position = UDim2.new(0, 0, 0, 45)
Sidebar.BackgroundColor3 = Palette.Sidebar
Sidebar.BorderSizePixel = 0
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 10)

local TabContainer = Instance.new("ScrollingFrame", Sidebar)
TabContainer.Size = UDim2.new(1, 0, 1, -95)
TabContainer.BackgroundTransparency = 1
TabContainer.ScrollBarThickness = 0
local TabListLayout = Instance.new("UIListLayout", TabContainer)
TabListLayout.Padding = UDim.new(0, 6)
TabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder

Instance.new("Frame", TabContainer).Size = UDim2.new(1,0,0,5) -- Spacer

-- Player Profile (Pojok Kiri Bawah)
local ProfileFrame = Instance.new("Frame", Sidebar)
ProfileFrame.Size = UDim2.new(1, 0, 0, 95)
ProfileFrame.Position = UDim2.new(0, 0, 1, -95)
ProfileFrame.BackgroundColor3 = Palette.Header
ProfileFrame.BorderSizePixel = 0
Instance.new("UICorner", ProfileFrame).CornerRadius = UDim.new(0, 10)

local userId = LocalPlayer.UserId
local avatarImage = Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)

local Avatar = Instance.new("ImageLabel", ProfileFrame)
Avatar.Size = UDim2.new(0, 35, 0, 35)
Avatar.Position = UDim2.new(0, 10, 0, 10)
Avatar.Image = avatarImage
Avatar.BackgroundColor3 = Palette.White
Instance.new("UICorner", Avatar).CornerRadius = UDim.new(1, 0)

local PlayerName = Instance.new("TextLabel", ProfileFrame)
PlayerName.Size = UDim2.new(1, -55, 0, 16)
PlayerName.Position = UDim2.new(0, 55, 0, 10)
PlayerName.Text = LocalPlayer.DisplayName
PlayerName.TextColor3 = Palette.Text
PlayerName.Font = Enum.Font.GothamBold
PlayerName.TextSize = 12
PlayerName.TextXAlignment = Enum.TextXAlignment.Left
PlayerName.BackgroundTransparency = 1

local PlayerID = Instance.new("TextLabel", ProfileFrame)
PlayerID.Size = UDim2.new(1, -55, 0, 14)
PlayerID.Position = UDim2.new(0, 55, 0, 28)
PlayerID.Text = "ID: " .. tostring(userId)
PlayerID.TextColor3 = Palette.SubText
PlayerID.Font = Enum.Font.Gotham
PlayerID.TextSize = 10
PlayerID.TextXAlignment = Enum.TextXAlignment.Left
PlayerID.BackgroundTransparency = 1

local Watermark = Instance.new("TextLabel", ProfileFrame)
Watermark.Size = UDim2.new(1, 0, 0, 20)
Watermark.Position = UDim2.new(0, 0, 1, -25)
Watermark.Text = "Made With ❤️ By Fawwaw"
Watermark.TextColor3 = Palette.Text
Watermark.Font = Enum.Font.GothamBold
Watermark.TextSize = 10
Watermark.BackgroundTransparency = 1

-- Content Container
local ContentContainer = Instance.new("Frame", MainFrame)
ContentContainer.Size = UDim2.new(1, -170, 1, -55)
ContentContainer.Position = UDim2.new(0, 165, 0, 50)
ContentContainer.BackgroundTransparency = 1

-- [[ 2. FUNGSI PEMBUATAN UI ]]
local TabFrames = {}
local TabButtons = {}

local function createTab(name, iconID, order)
    local TabBtn = Instance.new("TextButton", TabContainer)
    TabBtn.Size = UDim2.new(0, 140, 0, 38)
    TabBtn.LayoutOrder = order
    TabBtn.BackgroundColor3 = Palette.ButtonOff
    TabBtn.Text = ""
    TabBtn.AutoButtonColor = false
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 8)

    local Icon = Instance.new("ImageLabel", TabBtn)
    Icon.Size = UDim2.new(0, 20, 0, 20)
    Icon.Position = UDim2.new(0, 12, 0.5, -10)
    Icon.Image = iconID
    Icon.BackgroundTransparency = 1
    Icon.ImageColor3 = Palette.Text

    local Label = Instance.new("TextLabel", TabBtn)
    Label.Size = UDim2.new(1, -40, 1, 0)
    Label.Position = UDim2.new(0, 40, 0, 0)
    Label.Text = name
    Label.TextColor3 = Palette.SubText
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1

    local ContentFrame = Instance.new("ScrollingFrame", ContentContainer)
    ContentFrame.Size = UDim2.new(1, 0, 1, 0)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.ScrollBarThickness = 4
    ContentFrame.BorderSizePixel = 0
    ContentFrame.Visible = false
    
    local ContentLayout = Instance.new("UIListLayout", ContentFrame)
    ContentLayout.Padding = UDim.new(0, 10)
    
    TabFrames[name] = ContentFrame
    TabButtons[name] = {Btn = TabBtn, Label = Label, Icon = Icon}

    TabBtn.MouseButton1Click:Connect(function()
        for tName, frame in pairs(TabFrames) do
            frame.Visible = (tName == name)
            TabButtons[tName].Btn.BackgroundColor3 = Palette.ButtonOff
            TabButtons[tName].Label.TextColor3 = Palette.SubText
            TabButtons[tName].Icon.ImageColor3 = Palette.SubText
        end
        TabBtn.BackgroundColor3 = Palette.Button
        Label.TextColor3 = Palette.White
        Icon.ImageColor3 = Palette.White
    end)
    return ContentFrame
end

local function createSectionHeader(title, parent)
    local HeaderSec = Instance.new("TextLabel", parent)
    HeaderSec.Size = UDim2.new(1, -10, 0, 25)
    HeaderSec.Text = title
    HeaderSec.TextColor3 = Palette.Text
    HeaderSec.Font = Enum.Font.GothamBold
    HeaderSec.TextSize = 14
    HeaderSec.TextXAlignment = Enum.TextXAlignment.Left
    HeaderSec.BackgroundTransparency = 1
end

local function createToggle(title, parent, callback)
    local Row = Instance.new("Frame", parent)
    Row.Size = UDim2.new(1, -10, 0, 45)
    Row.BackgroundColor3 = Palette.Header
    Instance.new("UICorner", Row).CornerRadius = UDim.new(0, 8)

    local Label = Instance.new("TextLabel", Row)
    Label.Size = UDim2.new(1, -70, 1, 0)
    Label.Position = UDim2.new(0, 15, 0, 0)
    Label.Text = title
    Label.TextColor3 = Palette.Text
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1

    local ToggleBtn = Instance.new("TextButton", Row)
    ToggleBtn.Size = UDim2.new(0, 46, 0, 24)
    ToggleBtn.Position = UDim2.new(1, -60, 0.5, -12)
    ToggleBtn.Text = ""
    ToggleBtn.BackgroundColor3 = Palette.ButtonOff
    Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

    local Circle = Instance.new("Frame", ToggleBtn)
    Circle.Size = UDim2.new(0, 20, 0, 20)
    Circle.Position = UDim2.new(0, 2, 0.5, -10)
    Circle.BackgroundColor3 = Palette.White
    Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)

    local state = false
    ToggleBtn.MouseButton1Click:Connect(function()
        state = not state
        callback(state)
        local goalPos = state and UDim2.new(1, -22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
        local goalColor = state and Color3.fromRGB(0, 200, 100) or Palette.ButtonOff
        TweenService:Create(Circle, TweenInfo.new(0.2), {Position = goalPos}):Play()
        TweenService:Create(ToggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = goalColor}):Play()
    end)
end

local function createButton(title, parent, callback)
    local Btn = Instance.new("TextButton", parent)
    Btn.Size = UDim2.new(1, -10, 0, 40)
    Btn.BackgroundColor3 = Palette.Button
    Btn.Text = title
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 13
    Btn.TextColor3 = Palette.White
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)
    Btn.MouseButton1Click:Connect(callback)
end

local function createSlider(title, min, max, default, parent, callback)
    local Row = Instance.new("Frame", parent)
    Row.Size = UDim2.new(1, -10, 0, 60)
    Row.BackgroundColor3 = Palette.Header
    Instance.new("UICorner", Row).CornerRadius = UDim.new(0, 8)

    local Label = Instance.new("TextLabel", Row)
    Label.Size = UDim2.new(1, -20, 0, 25)
    Label.Position = UDim2.new(0, 15, 0, 5)
    Label.Text = title .. " : " .. default
    Label.TextColor3 = Palette.Text
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1

    local SliderBG = Instance.new("Frame", Row)
    SliderBG.Size = UDim2.new(1, -30, 0, 10)
    SliderBG.Position = UDim2.new(0, 15, 0, 35)
    SliderBG.BackgroundColor3 = Palette.ButtonOff
    Instance.new("UICorner", SliderBG).CornerRadius = UDim.new(1, 0)

    local SliderFill = Instance.new("Frame", SliderBG)
    SliderFill.Size = UDim2.new((default/max), 0, 1, 0)
    SliderFill.BackgroundColor3 = Palette.Button
    Instance.new("UICorner", SliderFill).CornerRadius = UDim.new(1, 0)

    local SliderBtn = Instance.new("TextButton", SliderBG)
    SliderBtn.Size = UDim2.new(1, 0, 1, 0)
    SliderBtn.BackgroundTransparency = 1
    SliderBtn.Text = ""

    local isDragging = false
    local function updateSlider(input)
        local pos = math.clamp((input.Position.X - SliderBG.AbsolutePosition.X) / SliderBG.AbsoluteSize.X, 0, 1)
        local value = math.floor(min + (max - min) * pos)
        SliderFill.Size = UDim2.new(pos, 0, 1, 0)
        Label.Text = title .. " : " .. value
        callback(value)
    end

    SliderBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDragging = true
            updateSlider(input)
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDragging = false
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateSlider(input)
        end
    end)
end

-- [[ 3. MENGISI TABS ]]
local MovementTab = createTab("Movement", getgenv().FawwawConfig.Visual.MovementIcon, 1)
local VisualsTab  = createTab("Visuals", getgenv().FawwawConfig.Visual.VisualsIcon, 2)
local PlayerTab   = createTab("Player", "rbxassetid://6031075929", 3)
local FaqTab      = createTab("FAQ", "rbxassetid://6031082807", 4)

-- === MOVEMENT TAB ===
createSectionHeader("Movement Tools", MovementTab)
createToggle("Fly Mode", MovementTab, function(state) getgenv().FlyEnabled = state end)
createToggle("Noclip", MovementTab, function(state) getgenv().NoclipEnabled = state end)

createSlider("Walk Speed", 0, 1000, 16, MovementTab, function(val)
    getgenv().WalkSpeed = val
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = val
    end
end)

-- === VISUALS TAB (Teleport) ===
createSectionHeader("Player Teleport", VisualsTab)
-- [Bagian Dropdown Teleport disederhanakan untuk contoh, logika sama dengan v1.3]
local TeleportBtn = Instance.new("TextButton", VisualsTab)
TeleportBtn.Size = UDim2.new(1, -10, 0, 40)
TeleportBtn.BackgroundColor3 = Palette.Button
TeleportBtn.Text = "TELEPORT TO RANDOM PLAYER"
TeleportBtn.Font = Enum.Font.GothamBold
TeleportBtn.TextSize = 13
TeleportBtn.TextColor3 = Palette.White
Instance.new("UICorner", TeleportBtn).CornerRadius = UDim.new(0, 8)
TeleportBtn.MouseButton1Click:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame
            break
        end
    end
end)

-- === PLAYER TAB ===
createSectionHeader("Player Modifications", PlayerTab)
createToggle("Invisible Avatar", PlayerTab, function(state)
    local char = LocalPlayer.Character
    if char then
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.Transparency = state and 1 or 0
            elseif part:IsA("Decal") then
                part.Transparency = state and 1 or 0
            end
        end
    end
end)

createButton("Get Custom Speedcola", PlayerTab, function()
    local tool = Instance.new("Tool")
    tool.Name = "Speedcola (Bypass)"
    tool.RequiresHandle = false
    tool.Equipped:Connect(function() 
        if LocalPlayer.Character then LocalPlayer.Character.Humanoid.WalkSpeed = 150 end 
    end)
    tool.Unequipped:Connect(function() 
        if LocalPlayer.Character then LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().WalkSpeed end 
    end)
    tool.Parent = LocalPlayer.Backpack
    game.StarterGui:SetCore("SendNotification", {Title="Success", Text="Cek Inventory/Tas kamu!"})
end)

createButton("Get Karpet Terbang", PlayerTab, function()
    local tool = Instance.new("Tool")
    tool.Name = "Karpet Terbang"
    tool.RequiresHandle = false
    tool.Equipped:Connect(function() getgenv().FlyEnabled = true end)
    tool.Unequipped:Connect(function() getgenv().FlyEnabled = false end)
    tool.Parent = LocalPlayer.Backpack
    game.StarterGui:SetCore("SendNotification", {Title="Success", Text="Pegang karpet untuk terbang!"})
end)

-- === FAQ TAB ===
createSectionHeader("Information", FaqTab)
local InfoTxt = Instance.new("TextLabel", FaqTab)
InfoTxt.Size = UDim2.new(1, -10, 0, 50)
InfoTxt.Text = "Script ini dikembangkan oleh Fawwaw.\nDibuat khusus untuk memberikan kenyamanan bermain."
InfoTxt.TextColor3 = Palette.Text
InfoTxt.Font = Enum.Font.Gotham
InfoTxt.TextSize = 12
InfoTxt.TextWrapped = true
InfoTxt.BackgroundTransparency = 1

local function createCopyRow(title, copyText, parent)
    local Row = Instance.new("Frame", parent)
    Row.Size = UDim2.new(1, -10, 0, 45)
    Row.BackgroundColor3 = Palette.Header
    Instance.new("UICorner", Row).CornerRadius = UDim.new(0, 8)

    local Lbl = Instance.new("TextLabel", Row)
    Lbl.Size = UDim2.new(1, -60, 1, 0)
    Lbl.Position = UDim2.new(0, 15, 0, 0)
    Lbl.Text = title
    Lbl.TextColor3 = Palette.Text
    Lbl.Font = Enum.Font.GothamBold
    Lbl.TextSize = 11
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.BackgroundTransparency = 1

    local CopyBtn = Instance.new("TextButton", Row)
    CopyBtn.Size = UDim2.new(0, 40, 0, 26)
    CopyBtn.Position = UDim2.new(1, -50, 0.5, -13)
    CopyBtn.BackgroundColor3 = Palette.Button
    CopyBtn.Text = "COPY"
    CopyBtn.TextColor3 = Palette.White
    CopyBtn.Font = Enum.Font.GothamBold
    CopyBtn.TextSize = 10
    Instance.new("UICorner", CopyBtn).CornerRadius = UDim.new(0, 6)
    
    CopyBtn.MouseButton1Click:Connect(function()
        if setclipboard then
            setclipboard(copyText)
            CopyBtn.Text = "OK!"
            task.wait(1)
            CopyBtn.Text = "COPY"
        end
    end)
end

createSectionHeader("Support & Community", FaqTab)
createCopyRow("BTC Wallet\n12Txz1Wx8NcTz...", "12Txz1Wx8NcTzE7hhjZHBxTDBYspAahr5Q", FaqTab)
createCopyRow("WhatsApp Community", "https://whatsapp.com/channel/0029VaoMEFPDTkK17znQLC2t", FaqTab)

-- Set Default Tab
TabFrames["Movement"].Visible = true
TabButtons["Movement"].Btn.BackgroundColor3 = Palette.Button
TabButtons["Movement"].Label.TextColor3 = Palette.White
TabButtons["Movement"].Icon.ImageColor3 = Palette.White


-- [[ 4. LOGIKA NOCLIP & SUPER FLY 3D ]]

RunService.Stepped:Connect(function()
    -- Noclip Logic
    if getgenv().NoclipEnabled and LocalPlayer.Character then
        for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") and v.CanCollide then v.CanCollide = false end
        end
    end
end)

-- Kontrol Input untuk Fly
UIS.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.W or input.KeyCode == Enum.KeyCode.Up then Ctrl.F = 1
    elseif input.KeyCode == Enum.KeyCode.S or input.KeyCode == Enum.KeyCode.Down then Ctrl.B = -1
    elseif input.KeyCode == Enum.KeyCode.A or input.KeyCode == Enum.KeyCode.Left then Ctrl.L = -1
    elseif input.KeyCode == Enum.KeyCode.D or input.KeyCode == Enum.KeyCode.Right then Ctrl.R = 1
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.W or input.KeyCode == Enum.KeyCode.Up then Ctrl.F = 0
    elseif input.KeyCode == Enum.KeyCode.S or input.KeyCode == Enum.KeyCode.Down then Ctrl.B = 0
    elseif input.KeyCode == Enum.KeyCode.A or input.KeyCode == Enum.KeyCode.Left then Ctrl.L = 0
    elseif input.KeyCode == Enum.KeyCode.D or input.KeyCode == Enum.KeyCode.Right then Ctrl.R = 0
    end
end)

RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    
    -- Fly Logic (Bebas Arah Kamera)
    if getgenv().FlyEnabled and root then
        local cam = workspace.CurrentCamera
        local moveDir = Vector3.new(0,0,0)
        
        -- Deteksi gerakan dari Mobile (Joystick) atau PC
        if char:FindFirstChild("Humanoid") and char.Humanoid.MoveDirection.Magnitude > 0 then
            -- Terbang ke arah kamera melihat
            moveDir = cam.CFrame.LookVector * (Ctrl.F + Ctrl.B) + cam.CFrame.RightVector * (Ctrl.R + Ctrl.L)
            if moveDir.Magnitude == 0 then
                -- Fallback untuk Joystick HP
                moveDir = char.Humanoid.MoveDirection
                moveDir = Vector3.new(moveDir.X, cam.CFrame.LookVector.Y, moveDir.Z)
            end
        end

        root.Velocity = Vector3.new(0, 0, 0)
        if moveDir.Magnitude > 0 then
            root.CFrame = root.CFrame + (moveDir.Unit * (getgenv().FlySpeed / 20))
        end
    end
    
    -- Kunci WalkSpeed agar tidak di-reset oleh game
    if char and char:FindFirstChild("Humanoid") and not getgenv().FlyEnabled then
        if char.Humanoid.WalkSpeed ~= getgenv().WalkSpeed then
            char.Humanoid.WalkSpeed = getgenv().WalkSpeed
        end
    end
end)
