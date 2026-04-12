game:GetService('TweenService')

local _call9 = Instance.new('ScreenGui')

_call9.Name = 'HypershotSyrexHub'
_call9.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
_call9.Parent = game:GetService('CoreGui')

local _call15 = Instance.new('Frame')

_call15.Name = 'MainFrame'
_call15.Size = UDim2.new(0, 450, 0, 350)
_call15.Position = UDim2.new(0.5, -225, 0.5, -175)
_call15.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
_call15.BorderSizePixel = 0
_call15.ClipsDescendants = true
_call15.Parent = _call9

local _call23 = Instance.new('Frame')

_call23.Name = 'TopBar'
_call23.Size = UDim2.new(1, 0, 0, 30)
_call23.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
_call23.BorderSizePixel = 0
_call23.Parent = _call15

local _call29 = Instance.new('TextLabel')

_call29.Name = 'Title'
_call29.Size = UDim2.new(0, 200, 1, 0)
_call29.Position = UDim2.new(0, 10, 0, 0)
_call29.BackgroundTransparency = 1
_call29.Text = 'Hypershot - Syrex Hub'
_call29.TextColor3 = Color3.fromRGB(255, 255, 255)
_call29.TextXAlignment = Enum.TextXAlignment.Left
_call29.Font = Enum.Font.GothamBold
_call29.TextSize = 14
_call29.Parent = _call23

local _call41 = Instance.new('TextButton')

_call41.Name = 'CloseButton'
_call41.Size = UDim2.new(0, 30, 1, 0)
_call41.Position = UDim2.new(1, -30, 0, 0)
_call41.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
_call41.BorderSizePixel = 0
_call41.Text = 'X'
_call41.TextColor3 = Color3.fromRGB(255, 255, 255)
_call41.Font = Enum.Font.GothamBold
_call41.TextSize = 14
_call41.Parent = _call23

_call41.MouseButton1Click:Connect(function(_55, _55_2, _55_3, _55_4)
    _call9:Destroy()
end)
_call23.InputBegan:Connect(function(_61, _61_2, _61_3, _61_4, _61_5)
    local _ = _61.UserInputType == Enum.UserInputType.MouseButton1
    local _ = _61.UserInputType == Enum.UserInputType.Touch
end)
_call23.InputChanged:Connect(function(_73)
    local _ = _73.UserInputType == Enum.UserInputType.MouseMovement
    local _ = _73.UserInputType == Enum.UserInputType.Touch
end)
game:GetService('UserInputService').InputChanged:Connect(function(_85, _85_2, _85_3) end)

local _call87 = Instance.new('Frame')

_call87.Name = 'TabButtons'
_call87.Size = UDim2.new(0, 100, 1, -30)
_call87.Position = UDim2.new(0, 0, 0, 30)
_call87.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
_call87.BorderSizePixel = 0
_call87.Parent = _call15

local _call95 = Instance.new('Frame')

_call95.Name = 'TabContent'
_call95.Size = UDim2.new(1, -100, 1, -30)
_call95.Position = UDim2.new(0, 100, 0, 30)
_call95.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
_call95.BorderSizePixel = 0
_call95.Parent = _call15

local _call111 = Instance.new('TextButton')

_call111.Name = 'MovementTab'
_call111.Size = UDim2.new(1, 0, 0, 40)
_call111.Position = UDim2.new(0, 0, 0, 0)
_call111.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
_call111.BorderSizePixel = 0
_call111.Text = 'Movement'
_call111.TextColor3 = Color3.fromRGB(0, 200, 0)
_call111.Font = Enum.Font.GothamBold
_call111.TextSize = 14
_call111.Parent = _call87

local _call121 = Instance.new('ScrollingFrame')

_call121.Name = 'MovementContent'
_call121.Size = UDim2.new(1, 0, 1, 0)
_call121.Position = UDim2.new(0, 0, 0, 0)
_call121.BackgroundTransparency = 1
_call121.BorderSizePixel = 0
_call121.ScrollBarThickness = 5
_call121.Visible = false
_call121.Parent = _call95

local _call127 = Instance.new('UIListLayout')

_call127.Name = 'Layout'
_call127.Padding = UDim.new(0, 5)
_call127.Parent = _call121

_call111.MouseButton1Click:Connect(function()
    _call121.Visible = false
    _call121.Visible = true
end)

local _call135 = Instance.new('TextButton')

_call135.Name = 'MiscTab'
_call135.Size = UDim2.new(1, 0, 0, 40)
_call135.Position = UDim2.new(0, 0, 0, 40)
_call135.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
_call135.BorderSizePixel = 0
_call135.Text = 'Misc'
_call135.TextColor3 = Color3.fromRGB(200, 200, 0)
_call135.Font = Enum.Font.GothamBold
_call135.TextSize = 14
_call135.Parent = _call87

local _call145 = Instance.new('ScrollingFrame')

_call145.Name = 'MiscContent'
_call145.Size = UDim2.new(1, 0, 1, 0)
_call145.Position = UDim2.new(0, 0, 0, 0)
_call145.BackgroundTransparency = 1
_call145.BorderSizePixel = 0
_call145.ScrollBarThickness = 5
_call145.Visible = false
_call145.Parent = _call95

local _call151 = Instance.new('UIListLayout')

_call151.Name = 'Layout'
_call151.Padding = UDim.new(0, 5)
_call151.Parent = _call145

_call135.MouseButton1Click:Connect(function()
    _call121.Visible = false
    _call145.Visible = false
    _call145.Visible = true
end)

local _call159 = Instance.new('TextButton')

_call159.Name = 'MainTab'
_call159.Size = UDim2.new(1, 0, 0, 40)
_call159.Position = UDim2.new(0, 0, 0, 80)
_call159.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
_call159.BorderSizePixel = 0
_call159.Text = 'Main'
_call159.TextColor3 = Color3.fromRGB(200, 0, 0)
_call159.Font = Enum.Font.GothamBold
_call159.TextSize = 14
_call159.Parent = _call87

local _call169 = Instance.new('ScrollingFrame')

_call169.Name = 'MainContent'
_call169.Size = UDim2.new(1, 0, 1, 0)
_call169.Position = UDim2.new(0, 0, 0, 0)
_call169.BackgroundTransparency = 1
_call169.BorderSizePixel = 0
_call169.ScrollBarThickness = 5
_call169.Visible = false
_call169.Parent = _call95

local _call175 = Instance.new('UIListLayout')

_call175.Name = 'Layout'
_call175.Padding = UDim.new(0, 5)
_call175.Parent = _call169

_call159.MouseButton1Click:Connect(function()
    _call145.Visible = false
    _call121.Visible = false
    _call169.Visible = false
    _call169.Visible = true
end)

local _call183 = Instance.new('TextButton')

_call183.Name = 'CombatTab'
_call183.Size = UDim2.new(1, 0, 0, 40)
_call183.Position = UDim2.new(0, 0, 0, 120)
_call183.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
_call183.BorderSizePixel = 0
_call183.Text = 'Combat'
_call183.TextColor3 = Color3.fromRGB(0, 170, 255)
_call183.Font = Enum.Font.GothamBold
_call183.TextSize = 14
_call183.Parent = _call87

local _call193 = Instance.new('ScrollingFrame')

_call193.Name = 'CombatContent'
_call193.Size = UDim2.new(1, 0, 1, 0)
_call193.Position = UDim2.new(0, 0, 0, 0)
_call193.BackgroundTransparency = 1
_call193.BorderSizePixel = 0
_call193.ScrollBarThickness = 5
_call193.Visible = false
_call193.Parent = _call95

local _call199 = Instance.new('UIListLayout')

_call199.Name = 'Layout'
_call199.Padding = UDim.new(0, 5)
_call199.Parent = _call193

_call183.MouseButton1Click:Connect(function()
    _call193.Visible = false
    _call145.Visible = false
    _call121.Visible = false
    _call169.Visible = false
    _call193.Visible = true
end)

_call169.Visible = true

local _call207 = Instance.new('TextLabel')

_call207.Name = 'WelcomeLabel'
_call207.Size = UDim2.new(1, -20, 0, 60)
_call207.Position = UDim2.new(0, 10, 0, 10)
_call207.BackgroundTransparency = 1
_call207.Text = 'Hypershot - Syrex Hub\nVersion 1.0\nSelect a tab to view features'
_call207.TextColor3 = Color3.fromRGB(255, 255, 255)
_call207.TextXAlignment = Enum.TextXAlignment.Left
_call207.Font = Enum.Font.Gotham
_call207.TextSize = 14
_call207.TextYAlignment = Enum.TextYAlignment.Top
_call207.Parent = _call169

local _call221 = Instance.new('Frame')

_call221.Name = 'ESP & HitboxToggle'
_call221.Size = UDim2.new(1, -20, 0, 30)
_call221.BackgroundTransparency = 1
_call221.Parent = _call193

local _call225 = Instance.new('TextButton')

_call225.Name = 'Button'
_call225.Size = UDim2.new(0, 30, 0, 30)
_call225.Position = UDim2.new(1, -30, 0, 0)
_call225.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
_call225.BorderSizePixel = 0
_call225.Text = ''
_call225.Parent = _call221

local _call233 = Instance.new('TextLabel')

_call233.Name = 'Label'
_call233.Size = UDim2.new(1, -40, 1, 0)
_call233.BackgroundTransparency = 1
_call233.Text = 'ESP & Hitbox'
_call233.TextColor3 = Color3.fromRGB(255, 255, 255)
_call233.TextXAlignment = Enum.TextXAlignment.Left
_call233.Font = Enum.Font.Gotham
_call233.TextSize = 14
_call233.Parent = _call221

_call225.MouseButton1Click:Connect(function(_245, _245_2, _245_3)
    local _ = _call225.BackgroundColor3 == Color3.fromRGB(0, 200, 0)

    _call225.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    _G.ESP_Hitbox_Enabled = true
    _G.HeadSize = 25
    _G.Disabled = false

    local _call253 = game:GetService('Players')

    workspace:FindFirstChild('Mobs')

    local _call259 = game:GetService('RunService').RenderStepped:Connect(function()
        for _263, _263_2 in ipairs(_call253:GetPlayers())do
            local _ = _263_2 == _call253.LocalPlayer
            local _ = _263_2.Character

            error('internal 579: <25ms: infinitelooperror>')
        end
    end)

    _G.ESPLoop = _call259
end)

local _call268 = Instance.new('Frame')

_call268.Name = 'Auto Bring PlayersToggle'
_call268.Size = UDim2.new(1, -20, 0, 30)
_call268.BackgroundTransparency = 1
_call268.Parent = _call193

local _call272 = Instance.new('TextButton')

_call272.Name = 'Button'
_call272.Size = UDim2.new(0, 30, 0, 30)
_call272.Position = UDim2.new(1, -30, 0, 0)
_call272.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
_call272.BorderSizePixel = 0
_call272.Text = ''
_call272.Parent = _call268

local _call280 = Instance.new('TextLabel')

_call280.Name = 'Label'
_call280.Size = UDim2.new(1, -40, 1, 0)
_call280.BackgroundTransparency = 1
_call280.Text = 'Auto Bring Players'
_call280.TextColor3 = Color3.fromRGB(255, 255, 255)
_call280.TextXAlignment = Enum.TextXAlignment.Left
_call280.Font = Enum.Font.Gotham
_call280.TextSize = 14
_call280.Parent = _call268

_call272.MouseButton1Click:Connect(function(_292, _292_2, _292_3)
    local _ = _call272.BackgroundColor3 == Color3.fromRGB(0, 200, 0)

    _call272.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    _G.AutoBring = true

    local _call302 = game:GetService('Workspace')
    local _ = _call302.CurrentCamera
    local _call308 = _call302:FindFirstChild('Mobs')
    local _call311 = game:GetService('RunService').RenderStepped:Connect(function(_312, _312_2)
        _call308:GetChildren()(nil, nil)

        local _ = game:GetService('Players').LocalPlayer.Character

        error('internal 579: <25ms: infinitelooperror>')
    end)

    _G.BringLoop = _call311
end)

local _call319 = Instance.new('Frame')

_call319.Name = 'Gun ModsToggle'
_call319.Size = UDim2.new(1, -20, 0, 30)
_call319.BackgroundTransparency = 1
_call319.Parent = _call193

local _call323 = Instance.new('TextButton')

_call323.Name = 'Button'
_call323.Size = UDim2.new(0, 30, 0, 30)
_call323.Position = UDim2.new(1, -30, 0, 0)
_call323.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
_call323.BorderSizePixel = 0
_call323.Text = ''
_call323.Parent = _call319

local _call331 = Instance.new('TextLabel')

_call331.Name = 'Label'
_call331.Size = UDim2.new(1, -40, 1, 0)
_call331.BackgroundTransparency = 1
_call331.Text = 'Gun Mods'
_call331.TextColor3 = Color3.fromRGB(255, 255, 255)
_call331.TextXAlignment = Enum.TextXAlignment.Left
_call331.Font = Enum.Font.Gotham
_call331.TextSize = 14
_call331.Parent = _call319

_call323.MouseButton1Click:Connect(function(_343, _343_2, _343_3) end)

local _call345 = Instance.new('Frame')

_call345.Name = 'No Abilities CDToggle'
_call345.Size = UDim2.new(1, -20, 0, 30)
_call345.BackgroundTransparency = 1
_call345.Parent = _call193

local _call349 = Instance.new('TextButton')

_call349.Name = 'Button'
_call349.Size = UDim2.new(0, 30, 0, 30)
_call349.Position = UDim2.new(1, -30, 0, 0)
_call349.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
_call349.BorderSizePixel = 0
_call349.Text = ''
_call349.Parent = _call345

local _call357 = Instance.new('TextLabel')

_call357.Name = 'Label'
_call357.Size = UDim2.new(1, -40, 1, 0)
_call357.BackgroundTransparency = 1
_call357.Text = 'No Abilities CD'
_call357.TextColor3 = Color3.fromRGB(255, 255, 255)
_call357.TextXAlignment = Enum.TextXAlignment.Left
_call357.Font = Enum.Font.Gotham
_call357.TextSize = 14
_call357.Parent = _call345

_call349.MouseButton1Click:Connect(function(_369, _369_2, _369_3) end)

local _call371 = Instance.new('Frame')

_call371.Name = 'Infinite JumpToggle'
_call371.Size = UDim2.new(1, -20, 0, 30)
_call371.BackgroundTransparency = 1
_call371.Parent = _call121

local _call375 = Instance.new('TextButton')

_call375.Name = 'Button'
_call375.Size = UDim2.new(0, 30, 0, 30)
_call375.Position = UDim2.new(1, -30, 0, 0)
_call375.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
_call375.BorderSizePixel = 0
_call375.Text = ''
_call375.Parent = _call371

local _call383 = Instance.new('TextLabel')

_call383.Name = 'Label'
_call383.Size = UDim2.new(1, -40, 1, 0)
_call383.BackgroundTransparency = 1
_call383.Text = 'Infinite Jump'
_call383.TextColor3 = Color3.fromRGB(255, 255, 255)
_call383.TextXAlignment = Enum.TextXAlignment.Left
_call383.Font = Enum.Font.Gotham
_call383.TextSize = 14
_call383.Parent = _call371

_call375.MouseButton1Click:Connect(function(_395, _395_2, _395_3) end)

local _call397 = Instance.new('Frame')

_call397.Name = 'FlyToggle'
_call397.Size = UDim2.new(1, -20, 0, 30)
_call397.BackgroundTransparency = 1
_call397.Parent = _call121

local _call401 = Instance.new('TextButton')

_call401.Name = 'Button'
_call401.Size = UDim2.new(0, 30, 0, 30)
_call401.Position = UDim2.new(1, -30, 0, 0)
_call401.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
_call401.BorderSizePixel = 0
_call401.Text = ''
_call401.Parent = _call397

local _call409 = Instance.new('TextLabel')

_call409.Name = 'Label'
_call409.Size = UDim2.new(1, -40, 1, 0)
_call409.BackgroundTransparency = 1
_call409.Text = 'Fly'
_call409.TextColor3 = Color3.fromRGB(255, 255, 255)
_call409.TextXAlignment = Enum.TextXAlignment.Left
_call409.Font = Enum.Font.Gotham
_call409.TextSize = 14
_call409.Parent = _call397

_call401.MouseButton1Click:Connect(function(_421, _421_2, _421_3) end)

local _call423 = Instance.new('Frame')

_call423.Name = 'Inf YieldToggle'
_call423.Size = UDim2.new(1, -20, 0, 30)
_call423.BackgroundTransparency = 1
_call423.Parent = _call145

local _call427 = Instance.new('TextButton')

_call427.Name = 'Button'
_call427.Size = UDim2.new(0, 30, 0, 30)
_call427.Position = UDim2.new(1, -30, 0, 0)
_call427.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
_call427.BorderSizePixel = 0
_call427.Text = ''
_call427.Parent = _call423

local _call435 = Instance.new('TextLabel')

_call435.Name = 'Label'
_call435.Size = UDim2.new(1, -40, 1, 0)
_call435.BackgroundTransparency = 1
_call435.Text = 'Inf Yield'
_call435.TextColor3 = Color3.fromRGB(255, 255, 255)
_call435.TextXAlignment = Enum.TextXAlignment.Left
_call435.Font = Enum.Font.Gotham
_call435.TextSize = 14
_call435.Parent = _call423

_call427.MouseButton1Click:Connect(function(_447, _447_2, _447_3) end)

_call9.Enabled = true
