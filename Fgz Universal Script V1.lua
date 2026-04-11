-- =========================================================
-- FGZ UNIVERSAL SCRIPT V1.4 - PREMIUM LIGHT BLUE THEME
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
    VisualsIcon = "rbxassetid://6031262846"
}

-- Palet Warna Premium (Lebih halus dengan aksen garis)
local Palette = {
    MainBG = Color3.fromRGB(235, 245, 255),    -- Putih Kebiruan Bersih
    Header = Color3.fromRGB(255, 255, 255),    -- Putih Murni (untuk Card/Header)
    Sidebar = Color3.fromRGB(220, 235, 250),   -- Biru Sangat Pucat
    Button = Color3.fromRGB(85, 170, 255),     -- Biru Terang Premium
    ButtonOff = Color3.fromRGB(200, 220, 240), -- Abu-abu kebiruan
    Text = Color3.fromRGB(30, 50, 70),         -- Teks Gelap Elegan
    SubText = Color3.fromRGB(100, 120, 140),   -- Teks Abu-abu
    White = Color3.fromRGB(255, 255, 255),
    Accent = Color3.fromRGB(180, 210, 255)     -- Garis Tepi (Stroke)
}

-- Global States & Connections Tracker
getgenv().FlyEnabled = false
getgenv().NoclipEnabled = false
getgenv().FlySpeed = 50
getgenv().WalkSpeed = 16
local Ctrl = {F = 0, B = 0, L = 0, R = 0}
local ActiveConnections = {}

-- Bersihkan UI lama
if CoreGui:FindFirstChild("FgzPremiumUI") then
    CoreGui.FgzPremiumUI:Destroy()
end

-- [[ 1. PEMBUATAN UI STRUCTURE ]]
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "FgzPremiumUI"
ScreenGui.IgnoreGuiInset = true

-- Fungsi untuk membuat UIStroke (Aksen Premium)
local function addStroke(parent, color, thickness)
    local stroke = Instance.new("UIStroke", parent)
    stroke.Color = color or Palette.Accent
    stroke.Thickness = thickness or 1.5
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    return stroke
end

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 600, 0, 420)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -210)
MainFrame.BackgroundColor3 = Palette.MainBG
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)
addStroke(MainFrame, Palette.Button, 2) -- Garis luar frame utama

-- Header Utama
local Header = Instance.new("Frame", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundColor3 = Palette.Header
Header.BorderSizePixel = 0
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 12)
addStroke(Header)

local TopIcon = Instance.new("TextLabel", Header)
TopIcon.Size = UDim2.new(0, 30, 0, 30)
TopIcon.Position = UDim2.new(0, 15, 0.5, -15)
TopIcon.Text = getgenv().FgzConfig.Icon
TopIcon.BackgroundTransparency = 1
TopIcon.TextSize = 22

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1, -150, 1, 0)
Title.Position = UDim2.new(0, 55, 0, 0)
Title.Text = getgenv().FgzConfig.Title
Title.TextColor3 = Palette.Text
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1

-- Kontrol Jendela (- dan X)
local WindowControls = Instance.new("Frame", Header)
WindowControls.Size = UDim2.new(0, 80, 1, 0)
WindowControls.Position = UDim2.new(1, -85, 0, 0)
WindowControls.BackgroundTransparency = 1

local MinimizeBtn = Instance.new("TextButton", WindowControls)
MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
MinimizeBtn.Position = UDim2.new(0, 5, 0.5, -15)
MinimizeBtn.BackgroundColor3 = Palette.ButtonOff
MinimizeBtn.Text = "-"
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 20
MinimizeBtn.TextColor3 = Palette.Text
Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(0, 6)

local CloseBtn = Instance.new("TextButton", WindowControls)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(0, 45, 0.5, -15)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
CloseBtn.Text = "X"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 16
CloseBtn.TextColor3 = Palette.White
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

-- Logo Melayang (Mode Minimize)
local FloatingLogo = Instance.new("TextButton", ScreenGui)
FloatingLogo.Size = UDim2.new(0, 50, 0, 50)
FloatingLogo.Position = UDim2.new(0, 50, 0, 50)
FloatingLogo.BackgroundColor3 = Palette.Button
FloatingLogo.Text = getgenv().FgzConfig.Icon
FloatingLogo.TextSize = 28
FloatingLogo.Visible = false
FloatingLogo.Active = true
FloatingLogo.Draggable = true
Instance.new("UICorner", FloatingLogo).CornerRadius = UDim.new(1, 0)
addStroke(FloatingLogo, Palette.White, 3)

MinimizeBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    FloatingLogo.Visible = true
end)

FloatingLogo.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    FloatingLogo.Visible = false
end)

CloseBtn.MouseButton1Click:Connect(function()
    -- Matikan semua fitur saat ditutup
    getgenv().FlyEnabled = false
    getgenv().NoclipEnabled = false
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
    -- Hapus koneksi script agar tidak lag
    for _, conn in ipairs(ActiveConnections) do
        conn:Disconnect()
    end
    ScreenGui:Destroy()
end)

-- Sidebar & Content
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 160, 1, -55)
Sidebar.Position = UDim2.new(0, 10, 0, 60)
Sidebar.BackgroundColor3 = Palette.Sidebar
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 10)

local TabContainer = Instance.new("ScrollingFrame", Sidebar)
TabContainer.Size = UDim2.new(1, 0, 1, 0)
TabContainer.BackgroundTransparency = 1
TabContainer.ScrollBarThickness = 0
local TabListLayout = Instance.new("UIListLayout", TabContainer)
TabListLayout.Padding = UDim.new(0, 8)
TabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder

Instance.new("Frame", TabContainer).Size = UDim2.new(1,0,0,5) -- Spacer atas

local ContentContainer = Instance.new("Frame", MainFrame)
ContentContainer.Size = UDim2.new(1, -190, 1, -65)
ContentContainer.Position = UDim2.new(0, 180, 0, 60)
ContentContainer.BackgroundTransparency = 1

-- [[ 2. FUNGSI PEMBUATAN UI ]]
local TabFrames = {}
local TabButtons = {}

local function createTab(name, iconID, order)
    local TabBtn = Instance.new("TextButton", TabContainer)
    TabBtn.Size = UDim2.new(0, 140, 0, 40)
    TabBtn.LayoutOrder = order
    TabBtn.BackgroundColor3 = Palette.MainBG
    TabBtn.Text = ""
    TabBtn.AutoButtonColor = false
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 8)
    addStroke(TabBtn, Palette.ButtonOff, 1)

    local Icon = Instance.new("ImageLabel", TabBtn)
    Icon.Size = UDim2.new(0, 20, 0, 20)
    Icon.Position = UDim2.new(0, 12, 0.5, -10)
    Icon.Image = iconID
    Icon.BackgroundTransparency = 1
    Icon.ImageColor3 = Palette.SubText

    local Label = Instance.new("TextLabel", TabBtn)
    Label.Size = UDim2.new(1, -40, 1, 0)
    Label.Position = UDim2.new(0, 40, 0, 0)
    Label.Text = name
    Label.TextColor3 = Palette.SubText
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 13
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
    ContentLayout.Padding = UDim.new(0, 12)
    ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder -- Pastikan menggunakan LayoutOrder!
    
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

-- Kunci rahasianya: LayoutOrder = #parent:GetChildren() agar berurutan otomatis
local function createSectionHeader(title, parent)
    local HeaderSec = Instance.new("TextLabel", parent)
    HeaderSec.Size = UDim2.new(1, -10, 0, 30)
    HeaderSec.Text = title
    HeaderSec.TextColor3 = Palette.Text
    HeaderSec.Font = Enum.Font.GothamBlack
    HeaderSec.TextSize = 15
    HeaderSec.TextXAlignment = Enum.TextXAlignment.Left
    HeaderSec.BackgroundTransparency = 1
    HeaderSec.LayoutOrder = #parent:GetChildren()
end

local function createToggle(title, parent, callback)
    local Row = Instance.new("Frame", parent)
    Row.Size = UDim2.new(1, -10, 0, 50)
    Row.BackgroundColor3 = Palette.Header
    Row.LayoutOrder = #parent:GetChildren()
    Instance.new("UICorner", Row).CornerRadius = UDim.new(0, 10)
    addStroke(Row)

    local Label = Instance.new("TextLabel", Row)
    Label.Size = UDim2.new(1, -80, 1, 0)
    Label.Position = UDim2.new(0, 15, 0, 0)
    Label.Text = title
    Label.TextColor3 = Palette.Text
    Label.Font = Enum.Font.GothamMedium
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1

    local ToggleBtn = Instance.new("TextButton", Row)
    ToggleBtn.Size = UDim2.new(0, 50, 0, 26)
    ToggleBtn.Position = UDim2.new(1, -65, 0.5, -13)
    ToggleBtn.Text = ""
    ToggleBtn.BackgroundColor3 = Palette.ButtonOff
    Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

    local Circle = Instance.new("Frame", ToggleBtn)
    Circle.Size = UDim2.new(0, 22, 0, 22)
    Circle.Position = UDim2.new(0, 2, 0.5, -11)
    Circle.BackgroundColor3 = Palette.White
    Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)

    local state = false
    ToggleBtn.MouseButton1Click:Connect(function()
        state = not state
        callback(state)
        local goalPos = state and UDim2.new(1, -24, 0.5, -11) or UDim2.new(0, 2, 0.5, -11)
        local goalColor = state and Color3.fromRGB(40, 200, 120) or Palette.ButtonOff
        TweenService:Create(Circle, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Position = goalPos}):Play()
        TweenService:Create(ToggleBtn, TweenInfo.new(0.3), {BackgroundColor3 = goalColor}):Play()
    end)
end

local function createSlider(title, min, max, default, parent, callback)
    local Row = Instance.new("Frame", parent)
    Row.Size = UDim2.new(1, -10, 0, 65)
    Row.BackgroundColor3 = Palette.Header
    Row.LayoutOrder = #parent:GetChildren()
    Instance.new("UICorner", Row).CornerRadius = UDim.new(0, 10)
    addStroke(Row)

    local Label = Instance.new("TextLabel", Row)
    Label.Size = UDim2.new(1, -20, 0, 30)
    Label.Position = UDim2.new(0, 15, 0, 5)
    Label.Text = title .. " : " .. default
    Label.TextColor3 = Palette.Text
    Label.Font = Enum.Font.GothamMedium
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1

    local SliderBG = Instance.new("Frame", Row)
    SliderBG.Size = UDim2.new(1, -30, 0, 8)
    SliderBG.Position = UDim2.new(0, 15, 0, 42)
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

-- === PERBAIKAN FUNGSI SUPPORT & COMMUNITY ===
local function createCopyRow(title, content, parent)
    local Row = Instance.new("Frame", parent)
    Row.Size = UDim2.new(1, -10, 0, 60)
    Row.BackgroundColor3 = Palette.Header
    Row.LayoutOrder = #parent:GetChildren()
    Instance.new("UICorner", Row).CornerRadius = UDim.new(0, 10)
    addStroke(Row)

    local TxtTitle = Instance.new("TextLabel", Row)
    TxtTitle.Size = UDim2.new(1, -80, 0, 20)
    TxtTitle.Position = UDim2.new(0, 15, 0, 10)
    TxtTitle.Text = title
    TxtTitle.TextColor3 = Palette.Text
    TxtTitle.Font = Enum.Font.GothamBold
    TxtTitle.TextSize = 13
    TxtTitle.TextXAlignment = Enum.TextXAlignment.Left
    TxtTitle.BackgroundTransparency = 1

    local TxtContent = Instance.new("TextLabel", Row)
    TxtContent.Size = UDim2.new(1, -80, 0, 20)
    TxtContent.Position = UDim2.new(0, 15, 0, 30)
    TxtContent.Text = content
    TxtContent.TextColor3 = Palette.SubText
    TxtContent.Font = Enum.Font.Gotham
    TxtContent.TextSize = 11
    TxtContent.TextXAlignment = Enum.TextXAlignment.Left
    TxtContent.TextTruncate = Enum.TextTruncate.AtEnd
    TxtContent.BackgroundTransparency = 1

    local CopyBtn = Instance.new("TextButton", Row)
    CopyBtn.Size = UDim2.new(0, 60, 0, 30)
    CopyBtn.Position = UDim2.new(1, -70, 0.5, -15)
    CopyBtn.BackgroundColor3 = Palette.Button
    CopyBtn.Text = "COPY"
    CopyBtn.TextColor3 = Palette.White
    CopyBtn.Font = Enum.Font.GothamBold
    CopyBtn.TextSize = 12
    Instance.new("UICorner", CopyBtn).CornerRadius = UDim.new(0, 6)
    
    CopyBtn.MouseButton1Click:Connect(function()
        if setclipboard then
            setclipboard(content)
            CopyBtn.Text = "COPIED!"
            CopyBtn.BackgroundColor3 = Color3.fromRGB(40, 200, 120)
            task.wait(1.5)
            CopyBtn.Text = "COPY"
            CopyBtn.BackgroundColor3 = Palette.Button
        end
    end)
end

-- [[ 3. MENGISI TABS ]]
local MovementTab = createTab("Movement", getgenv().FgzConfig.MovementIcon, 1)
local FaqTab      = createTab("Information", "rbxassetid://6031082807", 2)

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
createSectionHeader("About Script", FaqTab)

local InfoBG = Instance.new("Frame", FaqTab)
InfoBG.Size = UDim2.new(1, -10, 0, 70)
InfoBG.BackgroundColor3 = Palette.Header
InfoBG.LayoutOrder = #FaqTab:GetChildren()
Instance.new("UICorner", InfoBG).CornerRadius = UDim.new(0, 10)
addStroke(InfoBG)

local InfoTxt = Instance.new("TextLabel", InfoBG)
InfoTxt.Size = UDim2.new(1, -20, 1, -20)
InfoTxt.Position = UDim2.new(0, 10, 0, 10)
InfoTxt.Text = "Selamat datang di Fgz Universal Script.\nDibuat khusus untuk memberikan kenyamanan bermain dengan fitur premium."
InfoTxt.TextColor3 = Palette.Text
InfoTxt.Font = Enum.Font.GothamMedium
InfoTxt.TextSize = 12
InfoTxt.TextWrapped = true
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
-- Menyimpan koneksi agar bisa dihapus saat di-close
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
