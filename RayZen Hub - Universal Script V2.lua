-- =========================================================
-- FGZ UNIVERSAL SCRIPT V2 - UI & TELEPORT FIX
-- + UPDATE AUTO AIM, AUTO SHOT, AUTO RUN
-- =========================================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local CoreGui = game:GetService("CoreGui")

-- Konfigurasi Ikon (Mendukung ID dan Emoji)
getgenv().FgzConfig = {
    Title = "RayZen Universal Script",
    Subtitle = "Made With ❤️ By Fawwazx",
    Icon = "rbxthumb://type=Asset&id=119144536888000&w=150&h=150",
    MainIcon = "rbxassetid://7733960981",     
    MovementIcon = "👣",                      
    VisualsIcon = "👀",                       
    PlayerIcon = "rbxassetid://7734068321",   
    PremiumIcon = "💲"                        
}

-- Palet Warna
local Palette = {
    MainBG = Color3.fromRGB(235, 245, 255),
    Header = Color3.fromRGB(255, 255, 255),
    Sidebar = Color3.fromRGB(220, 235, 250),
    Button = Color3.fromRGB(85, 170, 255),
    ButtonOff = Color3.fromRGB(200, 220, 240),
    Text = Color3.fromRGB(30, 50, 70),
    SubText = Color3.fromRGB(100, 120, 140),
    White = Color3.fromRGB(255, 255, 255),
    Black = Color3.fromRGB(0, 0, 0),
    Accent = Color3.fromRGB(180, 210, 255)
}

-- Global States
getgenv().FlyEnabled = false
getgenv().NoclipEnabled = false
getgenv().InfJumpEnabled = false
getgenv().EspEnabled = false
getgenv().FullbrightEnabled = false
getgenv().AntiSitEnabled = false
getgenv().WalkOnWaterEnabled = false
getgenv().FlySpeed = 50
getgenv().WalkSpeed = 16
getgenv().JumpPower = 50

-- [UPDATE BARU]: Variabel Global State untuk Fitur Auto
getgenv().AutoAimEnabled = false
getgenv().AutoShotEnabled = false
getgenv().AutoRunEnabled = false

local Ctrl = {F = 0, B = 0, L = 0, R = 0}
local ActiveConnections = {}
local EspHighlights = {}

if CoreGui:FindFirstChild("FgzPremiumUI") then
    CoreGui.FgzPremiumUI:Destroy()
end

-- [[ 1. PEMBUATAN UI STRUCTURE ]]
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "FgzPremiumUI"
ScreenGui.IgnoreGuiInset = true

local function addStroke(parent, color, thickness)
    local stroke = Instance.new("UIStroke", parent)
    stroke.Color = color or Palette.Accent
    stroke.Thickness = thickness or 1.5
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    return stroke
end

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 480, 0, 300) 
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -150)
MainFrame.BackgroundColor3 = Palette.MainBG
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
addStroke(MainFrame, Palette.Button, 2)

-- Header
local Header = Instance.new("Frame", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundColor3 = Palette.Header
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 10)
addStroke(Header)

local TopIcon = Instance.new("TextLabel", Header)
TopIcon.Size = UDim2.new(0, 25, 0, 25)
TopIcon.Position = UDim2.new(0, 10, 0.5, -12)
TopIcon.Text = getgenv().FgzConfig.Icon
TopIcon.BackgroundTransparency = 1
TopIcon.TextSize = 18

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1, -120, 0, 20)
Title.Position = UDim2.new(0, 40, 0, 6)
Title.Text = getgenv().FgzConfig.Title
Title.TextColor3 = Palette.Text
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1

local Subtitle = Instance.new("TextLabel", Header)
Subtitle.Size = UDim2.new(1, -120, 0, 15)
Subtitle.Position = UDim2.new(0, 40, 0, 26)
Subtitle.Text = getgenv().FgzConfig.Subtitle
Subtitle.TextColor3 = Palette.SubText
Subtitle.Font = Enum.Font.GothamBold
Subtitle.TextSize = 10
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.BackgroundTransparency = 1

-- Kontrol Jendela
local WindowControls = Instance.new("Frame", Header)
WindowControls.Size = UDim2.new(0, 65, 1, 0)
WindowControls.Position = UDim2.new(1, -70, 0, 0)
WindowControls.BackgroundTransparency = 1

local MinimizeBtn = Instance.new("TextButton", WindowControls)
MinimizeBtn.Size = UDim2.new(0, 25, 0, 25)
MinimizeBtn.Position = UDim2.new(0, 5, 0.5, -12)
MinimizeBtn.BackgroundColor3 = Palette.ButtonOff
MinimizeBtn.Text = "-"
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 18
MinimizeBtn.TextColor3 = Palette.Text
Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(0, 6)

local CloseBtn = Instance.new("TextButton", WindowControls)
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(0, 35, 0.5, -12)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
CloseBtn.Text = "X"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.TextColor3 = Palette.White
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

local FloatingLogo = Instance.new("TextButton", ScreenGui)
FloatingLogo.Size = UDim2.new(0, 45, 0, 45)
FloatingLogo.Position = UDim2.new(0, 20, 0, 20)
FloatingLogo.BackgroundColor3 = Palette.Button
FloatingLogo.Text = getgenv().FgzConfig.Icon
FloatingLogo.TextSize = 22
FloatingLogo.Visible = false
FloatingLogo.Active = true
FloatingLogo.Draggable = true
Instance.new("UICorner", FloatingLogo).CornerRadius = UDim.new(1, 0)
addStroke(FloatingLogo, Palette.White, 2)

MinimizeBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false; FloatingLogo.Visible = true end)
FloatingLogo.MouseButton1Click:Connect(function() MainFrame.Visible = true; FloatingLogo.Visible = false end)
CloseBtn.MouseButton1Click:Connect(function()
    getgenv().FlyEnabled = false; getgenv().NoclipEnabled = false; getgenv().EspEnabled = false; getgenv().FullbrightEnabled = false
    -- Reset Auto features
    getgenv().AutoAimEnabled = false; getgenv().AutoShotEnabled = false; getgenv().AutoRunEnabled = false
    
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 16
        LocalPlayer.Character.Humanoid.JumpPower = 50
    end
    for _, h in pairs(EspHighlights) do if h then h:Destroy() end end
    for _, conn in ipairs(ActiveConnections) do conn:Disconnect() end
    ScreenGui:Destroy()
end)

-- Sidebar
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 130, 1, -55)
Sidebar.Position = UDim2.new(0, 8, 0, 58)
Sidebar.BackgroundColor3 = Palette.Sidebar
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 8)

-- 🟡 PERBAIKAN: UKURAN TAB DAN RUANG UNTUK PROFILE
local TabContainer = Instance.new("ScrollingFrame", Sidebar)
TabContainer.Size = UDim2.new(1, 0, 1, -85) -- Disempurnakan agar tidak menabrak Profile Frame
TabContainer.BackgroundTransparency = 1
TabContainer.ScrollBarThickness = 0
local TabListLayout = Instance.new("UIListLayout", TabContainer)
TabListLayout.Padding = UDim.new(0, 5)
TabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
Instance.new("Frame", TabContainer).Size = UDim2.new(1,0,0,2)

-- 🟡 PERBAIKAN: LAYOUT ABOUT PLAYER YANG PAS
local ProfileFrame = Instance.new("Frame", Sidebar)
ProfileFrame.Size = UDim2.new(1, -10, 0, 75) -- Tinggi Disesuaikan (Lebih pas)
ProfileFrame.Position = UDim2.new(0, 5, 1, -80) -- Posisi dinaikkan agar fit dalam sidebar
ProfileFrame.BackgroundColor3 = Palette.Header
Instance.new("UICorner", ProfileFrame).CornerRadius = UDim.new(0, 8)
addStroke(ProfileFrame)

local AvatarImage = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
local Avatar = Instance.new("ImageLabel", ProfileFrame)
Avatar.Size = UDim2.new(0, 26, 0, 26)
Avatar.Position = UDim2.new(0, 6, 0, 8)
Avatar.Image = AvatarImage
Instance.new("UICorner", Avatar).CornerRadius = UDim.new(1, 0)

local PName = Instance.new("TextLabel", ProfileFrame)
PName.Size = UDim2.new(1, -45, 0, 14)
PName.Position = UDim2.new(0, 40, 0, 8)
PName.Text = LocalPlayer.DisplayName
PName.Font = Enum.Font.GothamBold
PName.TextSize = 10
PName.TextColor3 = Palette.Text
PName.TextXAlignment = Enum.TextXAlignment.Left
PName.TextTruncate = Enum.TextTruncate.AtEnd
PName.BackgroundTransparency = 1

local PId = Instance.new("TextLabel", ProfileFrame)
PId.Size = UDim2.new(1, -45, 0, 12)
PId.Position = UDim2.new(0, 40, 0, 22)
PId.Text = "@" .. LocalPlayer.Name
PId.Font = Enum.Font.Gotham
PId.TextSize = 9
PId.TextColor3 = Palette.SubText
PId.TextXAlignment = Enum.TextXAlignment.Left
PId.TextTruncate = Enum.TextTruncate.AtEnd
PId.BackgroundTransparency = 1

local Watermark = Instance.new("TextLabel", ProfileFrame)
Watermark.Size = UDim2.new(1, 0, 0, 15)
Watermark.Position = UDim2.new(0, 0, 1, -20)
Watermark.Text = "Made By Fawwazxx With ❤️"
Watermark.Font = Enum.Font.GothamBold
Watermark.TextSize = 8 
Watermark.TextColor3 = Palette.Button
Watermark.TextXAlignment = Enum.TextXAlignment.Center
Watermark.BackgroundTransparency = 1

local ContentContainer = Instance.new("Frame", MainFrame)
ContentContainer.Size = UDim2.new(1, -155, 1, -65)
ContentContainer.Position = UDim2.new(0, 145, 0, 58)
ContentContainer.BackgroundTransparency = 1

-- [[ 2. FUNGSI PEMBUATAN UI ]]
local TabFrames = {}
local TabButtons = {}

local function createTab(name, iconID, order)
    local TabBtn = Instance.new("TextButton", TabContainer)
    TabBtn.Size = UDim2.new(0, 115, 0, 28)
    TabBtn.LayoutOrder = order
    TabBtn.BackgroundColor3 = Palette.MainBG
    TabBtn.Text = ""
    TabBtn.AutoButtonColor = false
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)
    addStroke(TabBtn, Palette.ButtonOff, 1)

    local Icon
    if string.find(iconID, "rbxassetid") then
        Icon = Instance.new("ImageLabel", TabBtn)
        Icon.Image = iconID
        Icon.ImageColor3 = Palette.Black
    else
        Icon = Instance.new("TextLabel", TabBtn)
        Icon.Text = iconID
        Icon.TextColor3 = Palette.Black
        Icon.Font = Enum.Font.GothamBold
        Icon.TextSize = 12
    end
    
    Icon.Size = UDim2.new(0, 14, 0, 14)
    Icon.Position = UDim2.new(0, 8, 0.5, -7)
    Icon.BackgroundTransparency = 1

    local Label = Instance.new("TextLabel", TabBtn)
    Label.Size = UDim2.new(1, -30, 1, 0)
    Label.Position = UDim2.new(0, 28, 0, 0)
    Label.Text = name
    Label.TextColor3 = Palette.Black
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 10
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1

    local ContentFrame = Instance.new("ScrollingFrame", ContentContainer)
    ContentFrame.Size = UDim2.new(1, 0, 1, 0)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.ScrollBarThickness = 2
    ContentFrame.ScrollBarImageColor3 = Palette.Button
    ContentFrame.BorderSizePixel = 0
    ContentFrame.Visible = false
    
    local ContentLayout = Instance.new("UIListLayout", ContentFrame)
    ContentLayout.Padding = UDim.new(0, 6)
    ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
    TabFrames[name] = ContentFrame
    TabButtons[name] = {Btn = TabBtn, Label = Label, Icon = Icon}

    TabBtn.MouseButton1Click:Connect(function()
        for tName, frame in pairs(TabFrames) do
            frame.Visible = (tName == name)
            TabButtons[tName].Btn.BackgroundColor3 = Palette.MainBG
            TabButtons[tName].Label.TextColor3 = Palette.Black
            if TabButtons[tName].Icon:IsA("ImageLabel") then
                TabButtons[tName].Icon.ImageColor3 = Palette.Black
            else
                TabButtons[tName].Icon.TextColor3 = Palette.Black
            end
        end
        TabBtn.BackgroundColor3 = Palette.ButtonOff
        Label.TextColor3 = Palette.Button
        if Icon:IsA("ImageLabel") then Icon.ImageColor3 = Palette.Button else Icon.TextColor3 = Palette.Button end
    end)
    return ContentFrame
end

local function createSectionHeader(title, parent)
    local HeaderSec = Instance.new("TextLabel", parent)
    HeaderSec.Size = UDim2.new(1, -5, 0, 20)
    HeaderSec.Text = title
    HeaderSec.TextColor3 = Palette.Text
    HeaderSec.Font = Enum.Font.GothamBlack
    HeaderSec.TextSize = 12
    HeaderSec.TextXAlignment = Enum.TextXAlignment.Left
    HeaderSec.BackgroundTransparency = 1
    HeaderSec.LayoutOrder = #parent:GetChildren()
end

local function createToggle(title, parent, callback)
    local Row = Instance.new("Frame", parent)
    Row.Size = UDim2.new(1, -5, 0, 35)
    Row.BackgroundColor3 = Palette.Header
    Row.LayoutOrder = #parent:GetChildren()
    Instance.new("UICorner", Row).CornerRadius = UDim.new(0, 8)
    addStroke(Row)

    local Label = Instance.new("TextLabel", Row)
    Label.Size = UDim2.new(1, -60, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.Text = title
    Label.TextColor3 = Palette.Text
    Label.Font = Enum.Font.GothamMedium
    Label.TextSize = 11
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1

    local ToggleBtn = Instance.new("TextButton", Row)
    ToggleBtn.Size = UDim2.new(0, 38, 0, 20)
    ToggleBtn.Position = UDim2.new(1, -48, 0.5, -10)
    ToggleBtn.Text = ""
    ToggleBtn.BackgroundColor3 = Palette.ButtonOff
    Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

    local Circle = Instance.new("Frame", ToggleBtn)
    Circle.Size = UDim2.new(0, 16, 0, 16)
    Circle.Position = UDim2.new(0, 2, 0.5, -8)
    Circle.BackgroundColor3 = Palette.White
    Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)

    local state = false
    ToggleBtn.MouseButton1Click:Connect(function()
        state = not state
        callback(state)
        local goalPos = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
        local goalColor = state and Color3.fromRGB(40, 200, 120) or Palette.ButtonOff
        TweenService:Create(Circle, TweenInfo.new(0.3), {Position = goalPos}):Play()
        TweenService:Create(ToggleBtn, TweenInfo.new(0.3), {BackgroundColor3 = goalColor}):Play()
    end)
end

local function createButton(title, parent, callback)
    local Btn = Instance.new("TextButton", parent)
    Btn.Size = UDim2.new(1, -5, 0, 35)
    Btn.LayoutOrder = #parent:GetChildren()
    Btn.BackgroundColor3 = Palette.Button
    Btn.Text = title
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 11
    Btn.TextColor3 = Palette.White
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)
    Btn.MouseButton1Click:Connect(callback)
    return Btn
end

local function createSlider(title, min, max, default, parent, callback)
    local Row = Instance.new("Frame", parent)
    Row.Size = UDim2.new(1, -5, 0, 48)
    Row.BackgroundColor3 = Palette.Header
    Row.LayoutOrder = #parent:GetChildren()
    Instance.new("UICorner", Row).CornerRadius = UDim.new(0, 8)
    addStroke(Row)

    local Label = Instance.new("TextLabel", Row)
    Label.Size = UDim2.new(1, -20, 0, 20)
    Label.Position = UDim2.new(0, 10, 0, 3)
    Label.Text = title .. " : " .. default
    Label.TextColor3 = Palette.Text
    Label.Font = Enum.Font.GothamMedium
    Label.TextSize = 11
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1

    local SliderBG = Instance.new("Frame", Row)
    SliderBG.Size = UDim2.new(1, -20, 0, 6)
    SliderBG.Position = UDim2.new(0, 10, 0, 30)
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
            isDragging = true; updateSlider(input)
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then isDragging = false end
    end)
    UIS.InputChanged:Connect(function(input)
        if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then updateSlider(input) end
    end)
end

-- [[ 3. MENGISI TABS BERDASARKAN URUTAN ]]
local MainTab     = createTab("Main", getgenv().FgzConfig.MainIcon, 1)
local MovementTab = createTab("Movement", getgenv().FgzConfig.MovementIcon, 2)
local VisualsTab  = createTab("Visuals", getgenv().FgzConfig.VisualsIcon, 3)
local PlayerTab   = createTab("Player", getgenv().FgzConfig.PlayerIcon, 4)
local PremiumTab  = createTab("Premium", getgenv().FgzConfig.PremiumIcon, 5)

-- === MAIN TAB ===
createSectionHeader("Welcome to FGZ", MainTab)
local InfoBG = Instance.new("Frame", MainTab)
InfoBG.Size = UDim2.new(1, -5, 0, 110)
InfoBG.BackgroundColor3 = Palette.Header
InfoBG.LayoutOrder = #MainTab:GetChildren()
Instance.new("UICorner", InfoBG).CornerRadius = UDim.new(0, 8)
addStroke(InfoBG)

local InfoTxt = Instance.new("TextLabel", InfoBG)
InfoTxt.Size = UDim2.new(1, -16, 1, -16)
InfoTxt.Position = UDim2.new(0, 8, 0, 8)
InfoTxt.Text = "Developer: Fawzxz\n\nDidedikasikan secara khusus untuk memberikan kontrol penuh dan kenyamanan bermain. Jelajahi fitur eksklusif, jadilah yang terbaik, dan dominasi server dengan gaya! 👑🔥"
InfoTxt.TextColor3 = Palette.Text
InfoTxt.Font = Enum.Font.GothamMedium
InfoTxt.TextSize = 11
InfoTxt.TextWrapped = true
InfoTxt.TextYAlignment = Enum.TextYAlignment.Top
InfoTxt.BackgroundTransparency = 1

-- === MOVEMENT TAB ===
createSectionHeader("Movement Tools", MovementTab)
createToggle("Fly Mode", MovementTab, function(state) getgenv().FlyEnabled = state end)
createToggle("Noclip", MovementTab, function(state) getgenv().NoclipEnabled = state end)
createToggle("Infinite Jump", MovementTab, function(state) getgenv().InfJumpEnabled = state end)
createSlider("Walk Speed", 0, 500, 16, MovementTab, function(val)
    getgenv().WalkSpeed = val
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = val
    end
end)
createSlider("Super Jump", 0, 500, 50, MovementTab, function(val)
    getgenv().JumpPower = val
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.UseJumpPower = true
        LocalPlayer.Character.Humanoid.JumpPower = val
    end
end)

-- === VISUALS TAB ===
createSectionHeader("Visual Hacks", VisualsTab)
createToggle("Player ESP (Wallhack)", VisualsTab, function(state)
    getgenv().EspEnabled = state
    if not state then
        for _, highlight in pairs(EspHighlights) do highlight:Destroy() end
        EspHighlights = {}
    end
end)

createToggle("Fullbright (Anti Gelap)", VisualsTab, function(state)
    getgenv().FullbrightEnabled = state
    if state then
        game:GetService("Lighting").Brightness = 2
        game:GetService("Lighting").ClockTime = 14
        game:GetService("Lighting").FogEnd = 100000
        game:GetService("Lighting").GlobalShadows = false
    end
end)

createSlider("Camera FOV", 70, 120, 70, VisualsTab, function(val)
    workspace.CurrentCamera.FieldOfView = val
end)

-- === PLAYER TAB ===
createSectionHeader("Player Modifications", PlayerTab)
createToggle("Invisible Avatar", PlayerTab, function(state)
    local char = LocalPlayer.Character
    if char then
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then part.Transparency = state and 1 or 0
            elseif part:IsA("Decal") then part.Transparency = state and 1 or 0 end
        end
    end
end)

createToggle("Walk on Water (Jesus)", PlayerTab, function(state)
    getgenv().WalkOnWaterEnabled = state
    if state then
        workspace.Terrain.WaterWaveSize = 0; workspace.Terrain.WaterWaveSpeed = 0
    end
end)

createToggle("Anti Sit (Anti Duduk)", PlayerTab, function(state)
    getgenv().AntiSitEnabled = state
end)

-- [UPDATE BARU]: Fitur Combat & Otomatisasi
createSectionHeader("Combat & Automation", PlayerTab)
createToggle("Auto Aim (Head Lock)", PlayerTab, function(state)
    getgenv().AutoAimEnabled = state
end)

createToggle("Auto Shot (Gunakan Tool)", PlayerTab, function(state)
    getgenv().AutoShotEnabled = state
end)

createToggle("Auto Run (Cari Musuh)", PlayerTab, function(state)
    getgenv().AutoRunEnabled = state
end)

createSectionHeader("Misc Tools", PlayerTab)
createButton("Get BTools (Client Build)", PlayerTab, function()
    local b1 = Instance.new("HopperBin", LocalPlayer.Backpack); b1.BinType = Enum.BinType.Clone
    local b2 = Instance.new("HopperBin", LocalPlayer.Backpack); b2.BinType = Enum.BinType.Hammer
    local b3 = Instance.new("HopperBin", LocalPlayer.Backpack); b3.BinType = Enum.BinType.Grab
end)

createButton("Kill Diri Sendiri (Reset)", PlayerTab, function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.Health = 0
    end
end)


-- === PREMIUM TAB (PIN SYSTEM) ===
local PinContainer = Instance.new("Frame", PremiumTab)
PinContainer.Size = UDim2.new(1, -5, 0, 200)
PinContainer.BackgroundColor3 = Palette.Header
PinContainer.LayoutOrder = 1
Instance.new("UICorner", PinContainer).CornerRadius = UDim.new(0, 8)
addStroke(PinContainer)

local PremiumFeatures = Instance.new("Frame", PremiumTab)
PremiumFeatures.Size = UDim2.new(1, -5, 0, 0)
PremiumFeatures.BackgroundTransparency = 1
PremiumFeatures.LayoutOrder = 2
PremiumFeatures.Visible = false
local PFLayout = Instance.new("UIListLayout", PremiumFeatures)
PFLayout.Padding = UDim.new(0, 6)
PFLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Keypad UI
local PinDisplay = Instance.new("TextLabel", PinContainer)
PinDisplay.Size = UDim2.new(1, -20, 0, 30)
PinDisplay.Position = UDim2.new(0, 10, 0, 10)
PinDisplay.Text = "ENTER PIN"
PinDisplay.Font = Enum.Font.GothamBlack
PinDisplay.TextSize = 14
PinDisplay.TextColor3 = Palette.Text
PinDisplay.BackgroundColor3 = Palette.MainBG
Instance.new("UICorner", PinDisplay).CornerRadius = UDim.new(0, 6)

local KeypadGrid = Instance.new("Frame", PinContainer)
KeypadGrid.Size = UDim2.new(1, -40, 0, 140)
KeypadGrid.Position = UDim2.new(0, 20, 0, 50)
KeypadGrid.BackgroundTransparency = 1

local GridLayout = Instance.new("UIGridLayout", KeypadGrid)
GridLayout.CellSize = UDim2.new(0, 75, 0, 30)
GridLayout.CellPadding = UDim2.new(0, 5, 0, 5)
GridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local enteredPin = ""
local targetPin = "1111"

local function updatePinDisplay()
    local displayStr = ""
    for i = 1, #enteredPin do displayStr = displayStr .. "*" end
    if #enteredPin == 0 then displayStr = "ENTER PIN" end
    PinDisplay.Text = displayStr

    if enteredPin == targetPin then
        PinDisplay.Text = "UNLOCKED!"
        PinDisplay.TextColor3 = Color3.fromRGB(40, 200, 120)
        task.wait(0.5)
        PinContainer.Visible = false
        PremiumFeatures.Visible = true
        PremiumTab.CanvasSize = UDim2.new(0, 0, 0, PFLayout.AbsoluteContentSize.Y + 20)
    elseif #enteredPin == 4 then
        PinDisplay.Text = "WRONG PIN"
        PinDisplay.TextColor3 = Color3.fromRGB(255, 100, 100)
        task.wait(0.5)
        enteredPin = ""
        PinDisplay.TextColor3 = Palette.Text
        updatePinDisplay()
    end
end

local buttons = {"1","2","3","4","5","6","7","8","9","C","0","<"}
for _, btnText in ipairs(buttons) do
    local kBtn = Instance.new("TextButton", KeypadGrid)
    kBtn.Text = btnText
    kBtn.BackgroundColor3 = Palette.ButtonOff
    kBtn.TextColor3 = Palette.Text
    kBtn.Font = Enum.Font.GothamBold
    kBtn.TextSize = 14
    Instance.new("UICorner", kBtn).CornerRadius = UDim.new(0, 6)
    kBtn.MouseButton1Click:Connect(function()
        if btnText == "C" then enteredPin = ""
        elseif btnText == "<" then enteredPin = string.sub(enteredPin, 1, -2)
        elseif #enteredPin < 4 then enteredPin = enteredPin .. btnText end
        updatePinDisplay()
    end)
end

-- Premium Feature Contents
createSectionHeader("VIP Capabilities", PremiumFeatures)

createButton("Kill All Players", PremiumFeatures, function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Humanoid") then
            p.Character.Humanoid.Health = 0
        end
    end
end)

-- 🔴 PERBAIKAN: UI DROPDOWN TELEPORT YANG ELEGAN DAN BERFUNGSI
local TargetPlayerName = nil

local DropdownContainer = Instance.new("Frame", PremiumFeatures)
DropdownContainer.Size = UDim2.new(1, -5, 0, 35) 
DropdownContainer.BackgroundColor3 = Palette.Header
DropdownContainer.LayoutOrder = #PremiumFeatures:GetChildren()
DropdownContainer.ClipsDescendants = true
Instance.new("UICorner", DropdownContainer).CornerRadius = UDim.new(0, 8)
addStroke(DropdownContainer)

local DropdownBtn = Instance.new("TextButton", DropdownContainer)
DropdownBtn.Size = UDim2.new(1, 0, 0, 35)
DropdownBtn.BackgroundTransparency = 1
DropdownBtn.Text = "Select Target ▼"
DropdownBtn.Font = Enum.Font.GothamBold
DropdownBtn.TextSize = 11
DropdownBtn.TextColor3 = Palette.Text

local PlayerListScroll = Instance.new("ScrollingFrame", DropdownContainer)
PlayerListScroll.Size = UDim2.new(1, 0, 0, 100)
PlayerListScroll.Position = UDim2.new(0, 0, 0, 35)
PlayerListScroll.BackgroundTransparency = 1
PlayerListScroll.ScrollBarThickness = 2
PlayerListScroll.Visible = false
PlayerListScroll.BorderSizePixel = 0
local PListLayout = Instance.new("UIListLayout", PlayerListScroll)
PListLayout.SortOrder = Enum.SortOrder.Name

DropdownBtn.MouseButton1Click:Connect(function()
    PlayerListScroll.Visible = not PlayerListScroll.Visible
    if PlayerListScroll.Visible then
        DropdownContainer.Size = UDim2.new(1, -5, 0, 135)
        DropdownBtn.Text = "Select Target ▲"
    else
        DropdownContainer.Size = UDim2.new(1, -5, 0, 35)
        DropdownBtn.Text = TargetPlayerName and ("Target: " .. TargetPlayerName) or "Select Target ▼"
    end
    PremiumTab.CanvasSize = UDim2.new(0, 0, 0, PFLayout.AbsoluteContentSize.Y + 20)
end)

local function refreshPlayerList()
    for _, child in ipairs(PlayerListScroll:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    local ySize = 0
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local pBtn = Instance.new("TextButton", PlayerListScroll)
            pBtn.Size = UDim2.new(1, 0, 0, 25)
            pBtn.Text = "  " .. p.Name
            pBtn.TextXAlignment = Enum.TextXAlignment.Left
            pBtn.Font = Enum.Font.GothamMedium
            pBtn.TextSize = 11
            pBtn.BackgroundColor3 = Palette.Header
            pBtn.TextColor3 = Palette.Text
            pBtn.BorderSizePixel = 0
            ySize = ySize + 25
            
            pBtn.MouseButton1Click:Connect(function()
                TargetPlayerName = p.Name
                DropdownBtn.Text = "Target: " .. p.Name
                PlayerListScroll.Visible = false
                DropdownContainer.Size = UDim2.new(1, -5, 0, 35)
                PremiumTab.CanvasSize = UDim2.new(0, 0, 0, PFLayout.AbsoluteContentSize.Y + 20)
            end)
        end
    end
    PlayerListScroll.CanvasSize = UDim2.new(0, 0, 0, ySize)
end
refreshPlayerList()
Players.PlayerAdded:Connect(refreshPlayerList)
Players.PlayerRemoving:Connect(refreshPlayerList)

createButton("Teleport To Target", PremiumFeatures, function()
    if TargetPlayerName then
        local targetP = Players:FindFirstChild(TargetPlayerName)
        if targetP and targetP.Character and targetP.Character:GetPivot() and LocalPlayer.Character then
            -- PivotTo lebih aman dibandingkan mengatur CFrame part individual
            LocalPlayer.Character:PivotTo(targetP.Character:GetPivot() * CFrame.new(0, 0, 3))
        end
    end
end)

createButton("Rejoin Server", PremiumFeatures, function()
    if #Players:GetPlayers() <= 1 then
        LocalPlayer:Kick("\nRejoining..."); task.wait(); TeleportService:Teleport(game.PlaceId, LocalPlayer)
    else TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer) end
end)

createButton("Leave Server", PremiumFeatures, function() LocalPlayer:Kick("\nBerhasil keluar dari server (Fgz Script)") end)

PremiumTab:GetPropertyChangedSignal("Visible"):Connect(function()
    if PremiumFeatures.Visible then PremiumTab.CanvasSize = UDim2.new(0, 0, 0, PFLayout.AbsoluteContentSize.Y + 20) end
end)

-- Set Default Tab & Init Highlight Color
TabFrames["Main"].Visible = true
TabButtons["Main"].Btn.BackgroundColor3 = Palette.ButtonOff
TabButtons["Main"].Label.TextColor3 = Palette.Button
if TabButtons["Main"].Icon:IsA("ImageLabel") then TabButtons["Main"].Icon.ImageColor3 = Palette.Button else TabButtons["Main"].Icon.TextColor3 = Palette.Button end

-- [[ 4. LOGIKA & LOOPS ]]

-- [UPDATE BARU]: Fungsi Helper untuk menemukan player terdekat
local function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return nil end
    local myPos = LocalPlayer.Character.HumanoidRootPart.Position

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
            local dist = (p.Character.HumanoidRootPart.Position - myPos).Magnitude
            if dist < shortestDistance then
                shortestDistance = dist
                closestPlayer = p
            end
        end
    end
    return closestPlayer
end

table.insert(ActiveConnections, RunService.Stepped:Connect(function()
    if getgenv().NoclipEnabled and LocalPlayer.Character then
        for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") and v.CanCollide then v.CanCollide = false end
        end
    end
    if getgenv().WalkOnWaterEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local root = LocalPlayer.Character.HumanoidRootPart
        local ray = Ray.new(root.Position, Vector3.new(0, -3, 0))
        local hit, pos, material = workspace:FindPartOnRay(ray, LocalPlayer.Character)
        if material == Enum.Material.Water then
            root.Velocity = Vector3.new(root.Velocity.X, 0, root.Velocity.Z)
            root.CFrame = CFrame.new(root.Position.X, pos.Y + 3, root.Position.Z) * CFrame.Angles(0, math.rad(root.Orientation.Y), 0)
        end
    end
end))

table.insert(ActiveConnections, UIS.JumpRequest:Connect(function()
    if getgenv().InfJumpEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end))

table.insert(ActiveConnections, UIS.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.W or input.KeyCode == Enum.KeyCode.Up then Ctrl.F = 1
    elseif input.KeyCode == Enum.KeyCode.S or input.KeyCode == Enum.KeyCode.Down then Ctrl.B = -1
    elseif input.KeyCode == Enum.KeyCode.A or input.KeyCode == Enum.KeyCode.Left then Ctrl.L = -1
    elseif input.KeyCode == Enum.KeyCode.D or input.KeyCode == Enum.KeyCode.Right then Ctrl.R = 1
    end
end))

table.insert(ActiveConnections, UIS.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.W or input.KeyCode == Enum.KeyCode.Up then Ctrl.F = 0
    elseif input.KeyCode == Enum.KeyCode.S or input.KeyCode == Enum.KeyCode.Down then Ctrl.B = 0
    elseif input.KeyCode == Enum.KeyCode.A or input.KeyCode == Enum.KeyCode.Left then Ctrl.L = 0
    elseif input.KeyCode == Enum.KeyCode.D or input.KeyCode == Enum.KeyCode.Right then Ctrl.R = 0
    end
end))

table.insert(ActiveConnections, RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChild("Humanoid")
    
    if getgenv().FlyEnabled and root then
        local cam = workspace.CurrentCamera; local moveDir = Vector3.new(0,0,0)
        if hum and hum.MoveDirection.Magnitude > 0 then
            moveDir = cam.CFrame.LookVector * (Ctrl.F + Ctrl.B) + cam.CFrame.RightVector * (Ctrl.R + Ctrl.L)
            if moveDir.Magnitude == 0 then moveDir = hum.MoveDirection; moveDir = Vector3.new(moveDir.X, cam.CFrame.LookVector.Y, moveDir.Z) end
        end
        root.Velocity = Vector3.new(0, 0, 0)
        if moveDir.Magnitude > 0 then root.CFrame = root.CFrame + (moveDir.Unit * (getgenv().FlySpeed / 20)) end
    end
    
    if hum and not getgenv().FlyEnabled then
        if hum.WalkSpeed ~= getgenv().WalkSpeed then hum.WalkSpeed = getgenv().WalkSpeed end
        if hum.JumpPower ~= getgenv().JumpPower then hum.JumpPower = getgenv().JumpPower end
    end
    
    -- Logika Anti Sit
    if hum and getgenv().AntiSitEnabled and hum.Sit then
        hum.Sit = false
    end

    -- [UPDATE BARU]: Logika Auto Aim
    if getgenv().AutoAimEnabled then
        local target = getClosestPlayer()
        if target and target.Character and target.Character:FindFirstChild("Head") then
            local cam = workspace.CurrentCamera
            cam.CFrame = CFrame.new(cam.CFrame.Position, target.Character.Head.Position)
        end
    end

    -- [UPDATE BARU]: Logika Auto Shot (Klik otomatis jika memegang tool)
    if getgenv().AutoShotEnabled and char then
        local equippedTool = char:FindFirstChildOfClass("Tool")
        if equippedTool then
            equippedTool:Activate() -- Mensimulasikan klik kiri pada tool/senjata
        end
    end

    -- [UPDATE BARU]: Logika Auto Run (Mengejar target atau jalan acak)
    if getgenv().AutoRunEnabled and hum and root then
        local target = getClosestPlayer()
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            -- Berjalan menuju musuh
            hum:MoveTo(target.Character.HumanoidRootPart.Position)
        else
            -- Jika tidak ada musuh/target, karakter akan berjalan acak mencari musuh
            if hum.WalkToPoint == Vector3.new(0,0,0) or (root.Position - hum.WalkToPoint).Magnitude < 5 then
                local randomPos = root.Position + Vector3.new(math.random(-50, 50), 0, math.random(-50, 50))
                hum:MoveTo(randomPos)
            end
        end
    end
    
    -- Logika Fullbright persistence
    if getgenv().FullbrightEnabled then
        game:GetService("Lighting").Brightness = 2
        game:GetService("Lighting").ClockTime = 14
        game:GetService("Lighting").FogEnd = 100000
        game:GetService("Lighting").GlobalShadows = false
    end
    
    if getgenv().EspEnabled then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                if not EspHighlights[p] then
                    local hl = Instance.new("Highlight", CoreGui)
                    hl.FillColor = Color3.fromRGB(255, 0, 0); hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                    hl.FillTransparency = 0.5; hl.Adornee = p.Character
                    EspHighlights[p] = hl
                else EspHighlights[p].Adornee = p.Character end
            end
        end
    end
end))

table.insert(ActiveConnections, Players.PlayerRemoving:Connect(function(player)
    if EspHighlights[player] then EspHighlights[player]:Destroy(); EspHighlights[player] = nil end
end))
