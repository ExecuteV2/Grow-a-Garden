-- Freeze Trade UI: Final v6.5 — Fire Blaze Alienware Tech Theme

-- SERVICES
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- MAIN GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FreezeTradeUI"
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = CoreGui

-- UTILITY
local function make(class, props)
    local inst = Instance.new(class)
    for k,v in pairs(props) do inst[k] = v end
    return inst
end

-- LOAD SCREEN (15–20s, techy fast text, with bar)
local loadingOverlay = make("Frame", {
    Parent = screenGui,
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundColor3 = Color3.fromRGB(10, 10, 30),
    BackgroundTransparency = 0,
    ZIndex = 9999
})
local loadingText = make("TextLabel", {
    Parent = loadingOverlay,
    Size = UDim2.new(1, 0, 0, 80),
    Position = UDim2.new(0, 0, 0.4, 0),
    Text = "",
    Font = Enum.Font.Arcade,
    TextSize = 42,
    TextColor3 = Color3.fromRGB(0, 255, 255),
    BackgroundTransparency = 1
})
local loadingBar = make("Frame", {
    Parent = loadingOverlay,
    Size = UDim2.new(0, 0, 0, 8),
    Position = UDim2.new(0.1, 0, 0.55, 0),
    BackgroundColor3 = Color3.fromRGB(0, 255, 150)
})
make("UICorner", {Parent = loadingBar, CornerRadius = UDim.new(0, 4)})

local function techCycle()
    local messages = {"INITIALIZING", "SCANNING MODULES", "LOADING UI", "RETRIEVING ASSETS", "CONNECTING TO CORE", "BOOTING TRADE CORE", "FINALIZING..."}
    for i = 1, 30 do
        local msg = messages[math.random(1, #messages)]
        loadingText.Text = msg
        wait(0.5)
    end
end
spawn(techCycle)
TweenService:Create(loadingBar, TweenInfo.new(18), {Size = UDim2.new(0.8, 0, 0, 8)}):Play()
task.wait(19)
TweenService:Create(loadingOverlay, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
TweenService:Create(loadingText, TweenInfo.new(1), {TextTransparency = 1}):Play()
TweenService:Create(loadingBar, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
task.delay(1.2, function() loadingOverlay:Destroy() end)

-- TOGGLE BUTTON
local toggleButton = make("TextButton", {
    Parent = screenGui,
    Size = UDim2.new(0, 120, 0, 40),
    Position = UDim2.new(0, 20, 0, 80),
    Text = "TOGGLE UI",
    Font = Enum.Font.GothamBold,
    TextSize = 16,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundColor3 = Color3.fromRGB(20, 255, 180),
    AutoButtonColor = false
})
make("UICorner", {Parent = toggleButton, CornerRadius = UDim.new(0, 8)})

-- MAIN FRAME
local mainFrame = make("Frame", {
    Parent = screenGui,
    Size = UDim2.new(0, 400, 0, 400),
    Position = UDim2.new(0.5, -200, 1, 0),
    BackgroundColor3 = Color3.fromRGB(20, 20, 40),
    BackgroundTransparency = 0.15,
    Visible = false,
    Active = true,
    Draggable = true
})
make("UICorner", {Parent = mainFrame, CornerRadius = UDim.new(0, 20)})
make("UIStroke", {Parent = mainFrame, Color = Color3.fromRGB(0, 255, 180), Thickness = 2})

-- CREDIT + AVATAR
local credit = make("TextLabel", {
    Parent = mainFrame,
    Text = "TRADE ENGINE by @YOUNGBRISEIS",
    Size = UDim2.new(1, 0, 0, 24),
    Position = UDim2.new(0, 0, 0, 8),
    Font = Enum.Font.GothamBlack,
    TextSize = 18,
    TextColor3 = Color3.fromRGB(0, 255, 200),
    BackgroundTransparency = 1
})
make("UIStroke", {Parent = credit, Color = Color3.fromRGB(0, 255, 200)})
make("Frame", {
    Parent = mainFrame,
    Size = UDim2.new(1, -40, 0, 1),
    Position = UDim2.new(0, 20, 0, 34),
    BackgroundColor3 = Color3.fromRGB(0, 255, 200),
    BorderSizePixel = 0
})

local avatar = make("ImageLabel", {
    Parent = mainFrame,
    Size = UDim2.new(0, 85, 0, 85),
    Position = UDim2.new(0.5, -42, 0, 40),
    Image = "rbxthumb://type=AvatarHeadShot&id=1&w=420&h=420",
    BackgroundTransparency = 1
})
make("UICorner", {Parent = avatar, CornerRadius = UDim.new(1, 0)})
make("UIStroke", {
    Parent = avatar,
    Color = Color3.fromRGB(0, 255, 200),
    Thickness = 2,
    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
})

-- ACCOUNT AGE + USERNAME FIELD + GO
local accountAge = make("TextLabel", {
    Parent = mainFrame,
    Size = UDim2.new(1, -20, 0, 20),
    Position = UDim2.new(0, 10, 0, 130),
    BackgroundTransparency = 1,
    Text = "Account Age: -",
    Font = Enum.Font.Code,
    TextColor3 = Color3.fromRGB(0, 255, 150),
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Center
})

local usernameBox = make("TextBox", {
    Parent = mainFrame,
    Size = UDim2.new(0, 260, 0, 36),
    Position = UDim2.new(0, 20, 0, 160),
    Text = "Target Player Username",
    Font = Enum.Font.Gotham,
    TextSize = 16,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundColor3 = Color3.fromRGB(30, 30, 50),
    ClearTextOnFocus = true
})
make("UICorner", {Parent = usernameBox, CornerRadius = UDim.new(0, 8)})

local goButton = make("TextButton", {
    Parent = mainFrame,
    Size = UDim2.new(0, 90, 0, 36),
    Position = UDim2.new(0, 290, 0, 160),
    Text = "GO",
    Font = Enum.Font.GothamBold,
    TextSize = 16,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundColor3 = Color3.fromRGB(0, 255, 150)
})
make("UICorner", {Parent = goButton, CornerRadius = UDim.new(0, 8)})

goButton.MouseButton1Click:Connect(function()
    local name = usernameBox.Text
    local success, uid = pcall(function()
        return Players:GetUserIdFromNameAsync(name)
    end)
    if success then
        avatar.Image = string.format("rbxthumb://type=AvatarHeadShot&id=%d&w=420&h=420", uid)
        local plr = Players:FindFirstChild(name)
        if plr then
            accountAge.Text = "Account Age: " .. plr.AccountAge .. " days"
        else
            accountAge.Text = "Account Age: N/A"
        end
    else
        accountAge.Text = "Invalid Username"
    end
end)

-- Slide UI
local function slideIn(frame)
    frame.Position = UDim2.new(0.5, -frame.Size.X.Offset/2, 1, 0)
    frame.Visible = true
    TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
        Position = UDim2.new(0.5, -frame.Size.X.Offset/2, 0.5, -frame.Size.Y.Offset/2)
    }):Play()
end

local function slideOut(frame)
    TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
        Position = UDim2.new(0.5, -frame.Size.X.Offset/2, 1, 0)
    }):Play()
    task.delay(0.4, function() frame.Visible = false end)
end

-- Toggle UI visibility
local isVisible = false
toggleButton.MouseButton1Click:Connect(function()
    isVisible = not isVisible
    if isVisible then
        slideIn(mainFrame)
    else
        slideOut(mainFrame)
    end
end)

-- Freeze Screen Function
local function freezeScreen(username)
    local overlay = make("Frame", {
        Parent = screenGui,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 1,
        ZIndex = 999
    })
    local freezeText = make("TextLabel", {
        Parent = overlay,
        Size = UDim2.new(1, 0, 1, 0),
        Text = "FREEZING TARGET'S SCREEN…",
        Font = Enum.Font.GothamBlack,
        TextSize = 46,
        TextColor3 = Color3.fromRGB(255, 100, 90),
        BackgroundTransparency = 1,
        TextTransparency = 1
    })
    TweenService:Create(overlay, TweenInfo.new(0.3), {BackgroundTransparency = 0.2}):Play()
    TweenService:Create(freezeText, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
    task.wait(2.5)
    TweenService:Create(freezeText, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
    TweenService:Create(overlay, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
    task.delay(0.3, function() overlay:Destroy() end)
end

-- Additional buttons to be added here (Freeze, Confirm, Logs) --
-- You can append them using the same structure as above

