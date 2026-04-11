-- =========================================================
-- FGZ UNIVERSAL SCRIPT V1.5 - COMPACT MOBILE THEME
-- =========================================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

-- Konfigurasi
getgenv().FgzConfig = {
    Title = "FGZ UNIVERSAL SCRIPT",
    Icon = "🕹️",
    MovementIcon = "rbxassetid://6031082533", 
    InfoIcon = "rbxassetid://6031082807"
}

-- Palet Warna Premium
local Palette = {
    MainBG = Color3.fromRGB(235, 245, 255),
    Header = Color3.fromRGB(255, 255, 255),
    Sidebar = Color3.fromRGB(220, 235, 250),
    Button = Color3.fromRGB(85, 170, 255),
    ButtonOff = Color3.fromRGB(200, 220, 240),
    Text = Color3.fromRGB(30, 50, 70),
    SubText = Color3.fromRGB(100, 120, 140),
    White = Color3.fromRGB(255, 255, 255),
    Accent = Color3.fromRGB(180, 210, 255)
}

-- Global States & Connections
getgenv().FlyEnabled = false
getgenv().NoclipEnabled = false
getgenv().FlySpeed = 50
getgenv().WalkSpeed = 16
local Ctrl = {F = 0, B = 0, L = 0, R = 0}
local ActiveConnections = {}

if CoreGui:FindFirstChild("FgzPremiumUI") then
    CoreGui.FgzPremiumUI:Destroy()
end

-- [[ 1. PEMBUATAN UI STRUCTURE (MOBILE FRIENDLY) ]]
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

-- Ukuran MainFrame diperkecil agar pas di HP
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 450, 0, 260)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -130)
MainFrame.BackgroundColor3 = Palette.MainBG
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
addStroke(MainFrame, Palette.Button, 2)

-- Header
local Header = Instance.new("Frame", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Palette.Header
Header.BorderSizePixel = 0
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 10)
addStroke(Header)

local TopIcon = Instance.new("TextLabel", Header)
TopIcon.Size = UDim2.new(0, 25, 0, 25)
TopIcon.Position = UDim2.new(0, 10, 0.5, -12)
TopIcon.Text = getgenv().FgzConfig.Icon
TopIcon.BackgroundTransparency = 1
TopIcon.TextSize = 16

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1, -120, 1, 0)
Title.Position = UDim2.new(0, 40, 0, 0)
Title.Text = getgenv().FgzConfig.Title
Title.TextColor3 = Palette.Text
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1

-- Kontrol Jendela (- dan X)
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

-- Logo Melayang
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

MinimizeBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    FloatingLogo.Visible = true
end)

FloatingLogo.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    FloatingLogo.Visible = false
end)

CloseBtn.MouseButton1Click:Connect(function()
    getgenv().FlyEnabled = false
    getgenv().NoclipEnabled = false
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
    for _, conn in ipairs(ActiveConnections) do conn:Disconnect() end
    ScreenGui:Destroy()
end)

-- Sidebar & Content
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 120, 1, -45)
Sidebar.Position = UDim2.new(0, 8, 0, 48)
Sidebar.BackgroundColor3 = Palette.Sidebar
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 8)

local TabContainer = Instance.new("ScrollingFrame", Sidebar)
TabContainer.Size = UDim2.new(1, 0, 1, 0)
TabContainer.BackgroundTransparency = 1
TabContainer.ScrollBarThickness = 0
local TabListLayout = Instance.new("UIListLayout", TabContainer)
TabListLayout.Padding = UDim.new(0, 6)
TabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder

Instance.new("Frame", TabContainer).Size = UDim2.new(1,0,0,3)

local ContentContainer = Instance.new("Frame", MainFrame)
ContentContainer.Size = UDim2.new(1, -145, 1, -55)
ContentContainer.Position = UDim2.new(0, 135, 0, 48)
ContentContainer.BackgroundTransparency = 1

-- [[ 2. FUNGSI PEMBUATAN UI ]]
local TabFrames = {}
local TabButtons = {}

local function createTab(name, iconID, order)
    local TabBtn = Instance.new("TextButton", TabContainer)
    TabBtn.Size = UDim2.new(0, 105, 0, 32)
    TabBtn.LayoutOrder = order
    TabBtn.BackgroundColor3 = Palette.MainBG
    TabBtn.Text = ""
    TabBtn.AutoButtonColor = false
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)
    addStroke(TabBtn, Palette.ButtonOff, 1)

    local Icon = Instance.new("ImageLabel", TabBtn)
    Icon.Size = UDim2.new(0, 16, 0, 16)
    Icon.Position = UDim2.new(0, 8, 0.5, -8)
    Icon.Image = iconID
    Icon.BackgroundTransparency = 1
    Icon.ImageColor3 = Palette.SubText

    local Label = Instance.new("TextLabel", TabBtn)
    Label.Size = UDim2.new(1, -30, 1, 0)
    Label.Position = UDim2.new(0, 30, 0, 0)
    Label.Text = name
    Label.TextColor3 = Palette.SubText
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 11
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
    ContentLayout.Padding = UDim.new(0, 8)
    ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
    TabFrames[name] = ContentFrame
    TabButtons[name] = {Btn = TabBtn, Label = Label, Icon = Icon}

    TabBtn.MouseButton1Click:Connect(function()
        for tName, frame in pairs(TabFrames) do
            frame.Visible = (tName == name)
            TabButtons[tName].Btn.BackgroundColor3 = Palette.MainBG
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
    HeaderSec.Size = UDim2.new(1, -5, 0, 22)
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
    Row.Size = UDim2.new(1, -5, 0, 38)
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
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1

    local ToggleBtn = Instance.new("TextButton", Row)
    ToggleBtn.Size = UDim2.new(0, 42, 0, 22)
    ToggleBtn.Position = UDim2.new(1, -52, 0.5, -11)
    ToggleBtn.Text = ""
    ToggleBtn.BackgroundColor3 = Palette.ButtonOff
    Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

    local Circle = Instance.new("Frame", ToggleBtn)
    Circle.Size = UDim2.new(0, 18, 0, 18)
    Circle.Position = UDim2.new(0, 2, 0.5, -9)
    Circle.BackgroundColor3 = Palette.White
    Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)

    local state = false
    ToggleBtn.MouseButton1Click:Connect(function()
        state = not state
        callback(state)
        local goalPos = state and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
        local goalColor = state and Color3.fromRGB(40, 200, 120) or Palette.ButtonOff
        TweenService:Create(Circle, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Position = goalPos}):Play()
        TweenService:Create(ToggleBtn, TweenInfo.new(0.3), {BackgroundColor3 = goalColor}):Play()
    end)
end

local function createSlider(title, min, max, default, parent, callback)
    local Row = Instance.new("Frame", parent)
    Row.Size = UDim2.new(1, -5, 0, 50)
    Row.BackgroundColor3 = Palette.Header
    Row.LayoutOrder = #parent:GetChildren()
    Instance.new("UICorner", Row).CornerRadius = UDim.new(0, 8)
    addStroke(Row)

    local Label = Instance.new("TextLabel", Row)
    Label.Size = UDim2.new(1, -20, 0, 22)
    Label.Position = UDim2.new(0, 10, 0, 3)
    Label.Text = title .. " : " .. default
    Label.TextColor3 = Palette.Text
    Label.Font = Enum.Font.GothamMedium
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1

    local SliderBG = Instance.new("Frame", Row)
    SliderBG.Size = UDim2.new(1, -20, 0, 6)
    SliderBG.Position = UDim2.new(0, 10, 0, 32)
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

local function createCopyRow(title, content, parent)
    local Row = Instance.new("Frame", parent)
    Row.Size = UDim2.new(1, -5, 0, 48)
    Row.BackgroundColor3 = Palette.Header
    Row.LayoutOrder = #parent:GetChildren()
    Instance.new("UICorner", Row).CornerRadius = UDim.new(0, 8)
    addStroke(Row)

    local TxtTitle = Instance.new("TextLabel", Row)
    TxtTitle.Size = UDim2.new(1, -65, 0, 16)
    TxtTitle.Position = UDim2.new(0, 10, 0, 6)
    TxtTitle.Text = title
    TxtTitle.TextColor3 = Palette.Text
    TxtTitle.Font = Enum.Font.GothamBold
    TxtTitle.TextSize = 11
    TxtTitle.TextXAlignment = Enum.TextXAlignment.Left
    TxtTitle.BackgroundTransparency = 1

    local TxtContent = Instance.new("TextLabel", Row)
    TxtContent.Size = UDim2.new(1, -65, 0, 16)
    TxtContent.Position = UDim2.new(0, 10, 0, 24)
    TxtContent.Text = content
    TxtContent.TextColor3 = Palette.SubText
    TxtContent.Font = Enum.Font.Gotham
    TxtContent.TextSize = 10
    TxtContent.TextXAlignment = Enum.TextXAlignment.Left
    TxtContent.TextTruncate = Enum.TextTruncate.AtEnd
    TxtContent.BackgroundTransparency = 1

    local CopyBtn = Instance.new("TextButton", Row)
    CopyBtn.Size = UDim2.new(0, 45, 0, 24)
    CopyBtn.Position = UDim2.new(1, -55, 0.5, -12)
    CopyBtn.BackgroundColor3 = Palette.Button
    CopyBtn.Text = "COPY"
    CopyBtn.TextColor3 = Palette.White
    CopyBtn.Font = Enum.Font.GothamBold
    CopyBtn.TextSize = 10
    Instance.new("UICorner", CopyBtn).CornerRadius = UDim.new(0, 6)
    
    CopyBtn.MouseButton1Click:Connect(function()
        if setclipboard then
            setclipboard(content)
            CopyBtn.Text = "OK!"
            CopyBtn.BackgroundColor3 = Color3.fromRGB(40, 200, 120)
            task.wait(1.5)
            CopyBtn.Text = "COPY"
            CopyBtn.BackgroundColor3 = Palette.Button
        end
    end)
end

-- [[ 3. MENGISI TABS ]]
local MovementTab = createTab("Movement", getgenv().FgzConfig.MovementIcon, 1)
local FaqTab      = createTab("Information", getgenv().FgzConfig.InfoIcon, 2)

-- === MOVEMENT TAB ===
createSectionHeader("Movement Tools", MovementTab)
createToggle("Fly Mode", MovementTab, function(state) getgenv().FlyEnabled = state end)
createToggle("Noclip", MovementTab, function(state) getgenv().NoclipEnabled = state end)
createSlider("Walk Speed", 0, 500, 16, MovementTab, function(val)
    getgenv().WalkSpeed = val
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = val
    end
end)

-- === FAQ / INFO TAB ===
createSectionHeader("About Developer", FaqTab)

local InfoBG = Instance.new("Frame", FaqTab)
InfoBG.Size = UDim2.new(1, -5, 0, 85)
InfoBG.BackgroundColor3 = Palette.Header
InfoBG.LayoutOrder = #FaqTab:GetChildren()
Instance.new("UICorner", InfoBG).CornerRadius = UDim.new(0, 8)
addStroke(InfoBG)

local InfoTxt = Instance.new("TextLabel", InfoBG)
InfoTxt.Size = UDim2.new(1, -16, 1, -16)
InfoTxt.Position = UDim2.new(0, 8, 0, 8)
InfoTxt.Text = "Developer: Fawzxz\n\nMengapa script ini dibuat? Script ini dibuat secara khusus untuk memberikan kenyamanan, kemudahan, dan pengalaman bermain yang lebih seru untuk para pemain."
InfoTxt.TextColor3 = Palette.Text
InfoTxt.Font = Enum.Font.GothamMedium
InfoTxt.TextSize = 11
InfoTxt.TextWrapped = true
InfoTxt.TextYAlignment = Enum.TextYAlignment.Top
InfoTxt.BackgroundTransparency = 1

createSectionHeader("Support & Community", FaqTab)
createCopyRow("BTC Wallet (Donation)", "12Txz1Wx8NcTzE7hhjZHBxTDBYspAahr5Q", FaqTab)
createCopyRow("WhatsApp Community", "https://whatsapp.com/channel/0029VaoMEFPDTkK17znQLC2t", FaqTab)

-- Set Default Tab
TabFrames["Movement"].Visible = true
TabButtons["Movement"].Btn.BackgroundColor3 = Palette.Button
TabButtons["Movement"].Label.TextColor3 = Palette.White
TabButtons["Movement"].Icon.ImageColor3 = Palette.White

-- [[ 4. LOGIKA NOCLIP & SUPER FLY 3D ]]
table.insert(ActiveConnections, RunService.Stepped:Connect(function()
    if getgenv().NoclipEnabled and LocalPlayer.Character then
        for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") and v.CanCollide then v.CanCollide = false end
        end
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
    
    if getgenv().FlyEnabled and root then
        local cam = workspace.CurrentCamera
        local moveDir = Vector3.new(0,0,0)
        
        if char:FindFirstChild("Humanoid") and char.Humanoid.MoveDirection.Magnitude > 0 then
            moveDir = cam.CFrame.LookVector * (Ctrl.F + Ctrl.B) + cam.CFrame.RightVector * (Ctrl.R + Ctrl.L)
            if moveDir.Magnitude == 0 then
                moveDir = char.Humanoid.MoveDirection
                moveDir = Vector3.new(moveDir.X, cam.CFrame.LookVector.Y, moveDir.Z)
            end
        end

        root.Velocity = Vector3.new(0, 0, 0)
        if moveDir.Magnitude > 0 then
            root.CFrame = root.CFrame + (moveDir.Unit * (getgenv().FlySpeed / 20))
        end
    end
    
    if char and char:FindFirstChild("Humanoid") and not getgenv().FlyEnabled then
        if char.Humanoid.WalkSpeed ~= getgenv().WalkSpeed then
            char.Humanoid.WalkSpeed = getgenv().WalkSpeed
        end
    end
end))
