-- ChatGPT'd, dont blame me. 😡

local NotificationLib = {}

function NotificationLib:MakeNotification(params)
    local name = params.Name or "Notification"
    local content = params.Content or ""
    local image = params.Image or "rbxassetid://4483345998"
    local duration = params.Time or 5

    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")
    local player = Players.LocalPlayer
    local camera = workspace.CurrentCamera

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "NotificationGUI"
    screenGui.Parent = player:WaitForChild("PlayerGui")

    local notificationFrame = Instance.new("Frame")
    notificationFrame.Name = "NotificationFrame"
    notificationFrame.Size = UDim2.new(0, 300, 0, 70)
    notificationFrame.AnchorPoint = Vector2.new(0, 1)
    notificationFrame.Position = UDim2.new(0, 10, 1, -10)
    notificationFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    notificationFrame.BackgroundTransparency = 1
    notificationFrame.BorderSizePixel = 0
    notificationFrame.Parent = screenGui
  
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 8)
    uiCorner.Parent = notificationFrame

    local notificationStroke = Instance.new("UIStroke")
    notificationStroke.Color = Color3.fromRGB(0, 0, 255)
    notificationStroke.Thickness = 2
    notificationStroke.Parent = notificationFrame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -40, 0, 19)
    titleLabel.Position = UDim2.new(0.001, 5, -0.02, 5)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextScaled = true
    titleLabel.Font = Enum.Font.SourceSans
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.RichText = true
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.TextYAlignment = Enum.TextYAlignment.Center
    titleLabel.Text = tostring(name)
    titleLabel.TextTransparency = 1
    titleLabel.Parent = notificationFrame

    local messageLabel = Instance.new("TextLabel")
    messageLabel.Size = UDim2.new(1, -40, 0, 40)
    messageLabel.Position = UDim2.new(0.01, 5, 0, 26)
    messageLabel.BackgroundTransparency = 1
    messageLabel.TextScaled = true
    messageLabel.TextWrapped = true
    messageLabel.ClipsDescendants = true
    messageLabel.Font = Enum.Font.SourceSans
    messageLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    messageLabel.RichText = true
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.TextYAlignment = Enum.TextYAlignment.Top
    messageLabel.Text = tostring(content)
    messageLabel.TextTransparency = 1
    messageLabel.Parent = notificationFrame

    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Size = UDim2.new(0, 24, 0, 24)
    imageLabel.Position = UDim2.new(1, -28, 0, 4)
    imageLabel.BackgroundTransparency = 1
    imageLabel.Image = image
    imageLabel.ImageTransparency = 1
    imageLabel.Parent = notificationFrame

    local function updateNotificationPosition()
        local screenSize = camera.ViewportSize
    end
    camera:GetPropertyChangedSignal("ViewportSize"):Connect(updateNotificationPosition)
    updateNotificationPosition()

    local tweenInfoIn = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local fadeInFrame = TweenService:Create(notificationFrame, tweenInfoIn, {BackgroundTransparency = 0.3})
    local fadeInTitle = TweenService:Create(titleLabel, tweenInfoIn, {TextTransparency = 0})
    local fadeInMessage = TweenService:Create(messageLabel, tweenInfoIn, {TextTransparency = 0})
    local fadeInImage = TweenService:Create(imageLabel, tweenInfoIn, {ImageTransparency = 0})

    fadeInFrame:Play()
    fadeInTitle:Play()
    fadeInMessage:Play()
    fadeInImage:Play()

    task.wait(duration)

    local tweenInfoOut = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    local fadeOutFrame = TweenService:Create(notificationFrame, tweenInfoOut, {BackgroundTransparency = 1})
    local fadeOutTitle = TweenService:Create(titleLabel, tweenInfoOut, {TextTransparency = 1})
    local fadeOutMessage = TweenService:Create(messageLabel, tweenInfoOut, {TextTransparency = 1})
    local fadeOutImage = TweenService:Create(imageLabel, tweenInfoOut, {ImageTransparency = 1})

    fadeOutFrame:Play()
    fadeOutTitle:Play()
    fadeOutMessage:Play()
    fadeOutImage:Play()
    task.wait(0.5)

    screenGui:Destroy()
end

return NotificationLib
