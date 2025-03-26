-- ChatGPT'd, dont blame me. 😡 waw

local NotificationLib = {}
NotificationLib.ActiveNotifications = {}  -- Holds all active notifications

--// Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- Repositions notifications so that the newest is at the bottom and older ones are pushed upward.
function NotificationLib:RepositionNotifications()
    local baseX = 10
    local baseY = -10       -- Offset from the bottom of the screen
    local gap = 5
    local notifHeight = 70

    -- ActiveNotifications is ordered with index 1 as the newest.
    for i, notif in ipairs(self.ActiveNotifications) do
        -- The newest (i = 1) gets the base offset; each subsequent one is pushed upward.
        local offset = baseY - ((i - 1) * (notifHeight + gap))
        notif.Position = UDim2.new(0, baseX, 1, offset)
    end
end

-- Removes a notification from the active list and repositions the rest.
function NotificationLib:RemoveNotification(notificationFrame)
    for i, notif in ipairs(self.ActiveNotifications) do
        if notif == notificationFrame then
            table.remove(self.ActiveNotifications, i)
            break
        end
    end
    self:RepositionNotifications()
end

-- Creates a smooth notification.
function NotificationLib:MakeNotification(params)
    local name = params.Name or "Notification"
    local content = params.Content or ""
    local image = params.Image or "rbxassetid://4483345998"
    local duration = params.Time  -- if nil, notification is permanent

    -- If duration is nil, check if a permanent notification is already active.
    if duration == nil then
        for _, notif in ipairs(self.ActiveNotifications) do
            if notif:GetAttribute("Permanent") == true then
                -- A permanent notification is active; do not create another.
                return
            end
        end
    end

    -- Create a new ScreenGui for this notification.
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "NotificationGUI"
    screenGui.Parent = player:WaitForChild("PlayerGui")

    -- Create the main notification frame.
    local notificationFrame = Instance.new("Frame")
    notificationFrame.Name = "NotificationFrame"
    notificationFrame.Size = UDim2.new(0, 300, 0, 70)
    notificationFrame.AnchorPoint = Vector2.new(0, 1)  -- anchored at bottom-left
    notificationFrame.Position = UDim2.new(0, 10, 1, -10)  -- initial position; will be updated
    notificationFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    notificationFrame.BackgroundTransparency = 1
    notificationFrame.BorderSizePixel = 0
    notificationFrame.Parent = screenGui

    if duration == nil then
        notificationFrame:SetAttribute("Permanent", true)
    end

    -- Rounded corners.
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 8)
    uiCorner.Parent = notificationFrame

    -- Blue outline.
    local notificationStroke = Instance.new("UIStroke")
    notificationStroke.Color = Color3.fromRGB(0, 0, 255)
    notificationStroke.Thickness = 2
    notificationStroke.Parent = notificationFrame

    -- Title label.
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -40, 0, 19)
    titleLabel.Position = UDim2.new(0, 5, 0, 5)
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

    -- Message label.
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Size = UDim2.new(1, -40, 0, 40)
    messageLabel.Position = UDim2.new(0, 5, 0, 26)
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

    -- Image in the top-right corner.
    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Size = UDim2.new(0, 24, 0, 24)
    imageLabel.Position = UDim2.new(1, -28, 0, 4)
    imageLabel.BackgroundTransparency = 1
    imageLabel.Image = image
    imageLabel.ImageTransparency = 1
    imageLabel.Parent = notificationFrame

    -- Dismiss ("X") button in the bottom-right corner (red).
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 20, 0, 20)
    closeButton.Position = UDim2.new(1, -25, 1, -25)
    closeButton.BackgroundTransparency = 1
    closeButton.Text = "X"
    closeButton.TextColor3 = Color3.fromRGB(255, 0, 0)  -- red color
    closeButton.Font = Enum.Font.SourceSansBold
    closeButton.TextScaled = true
    closeButton.TextTransparency = 1
    closeButton.Parent = notificationFrame

    closeButton.MouseButton1Click:Connect(function()
        local tweenInfoOut = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        TweenService:Create(notificationFrame, tweenInfoOut, {BackgroundTransparency = 1}):Play()
        TweenService:Create(titleLabel, tweenInfoOut, {TextTransparency = 1}):Play()
        TweenService:Create(messageLabel, tweenInfoOut, {TextTransparency = 1}):Play()
        TweenService:Create(imageLabel, tweenInfoOut, {ImageTransparency = 1}):Play()
        TweenService:Create(closeButton, tweenInfoOut, {TextTransparency = 1}):Play()
        task.wait(0.5)
        screenGui:Destroy()
        NotificationLib:RemoveNotification(notificationFrame)
    end)

    -- Insert the new notification at the beginning of the ActiveNotifications table.
    table.insert(self.ActiveNotifications, 1, notificationFrame)
    self:RepositionNotifications()

    -- Tween In.
    local tweenInfoIn = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(notificationFrame, tweenInfoIn, {BackgroundTransparency = 0.3}):Play()
    TweenService:Create(titleLabel, tweenInfoIn, {TextTransparency = 0}):Play()
    TweenService:Create(messageLabel, tweenInfoIn, {TextTransparency = 0}):Play()
    TweenService:Create(imageLabel, tweenInfoIn, {ImageTransparency = 0}):Play()
    TweenService:Create(closeButton, tweenInfoIn, {TextTransparency = 0}):Play()

    -- Auto-remove if duration is provided.
    if duration ~= nil then
        task.delay(duration, function()
            local tweenInfoOut = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            TweenService:Create(notificationFrame, tweenInfoOut, {BackgroundTransparency = 1}):Play()
            TweenService:Create(titleLabel, tweenInfoOut, {TextTransparency = 1}):Play()
            TweenService:Create(messageLabel, tweenInfoOut, {TextTransparency = 1}):Play()
            TweenService:Create(imageLabel, tweenInfoOut, {ImageTransparency = 1}):Play()
            TweenService:Create(closeButton, tweenInfoOut, {TextTransparency = 1}):Play()
            task.wait(0.5)
            screenGui:Destroy()
            NotificationLib:RemoveNotification(notificationFrame)
        end)
    end

    return notificationFrame
end

return NotificationLib
