-- ChatGPT'd, dont blame me. 😡

local NotificationLib = {}
NotificationLib.ActiveNotifications = {}  -- Holds all active notifications

--// Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- Repositions notifications so the newest is at the bottom, pushing older ones upward.
function NotificationLib:RepositionNotifications()
    -- We anchor to bottom-left, so baseY is negative from the bottom edge.
    local baseX = 10
    local baseY = -10
    local gap = 5
    local notifHeight = 70

    -- The array is in order [1 = newest, 2 = older, etc.].
    -- i=1 => offset = -10 (lowest on the screen),
    -- i=2 => offset = -10 - (notifHeight + gap), etc.
    for i, notif in ipairs(self.ActiveNotifications) do
        local offset = baseY - ((i - 1) * (notifHeight + gap))
        notif.Position = UDim2.new(0, baseX, 1, offset)
    end
end

-- Removes a notification from the list, repositions the rest.
function NotificationLib:RemoveNotification(notificationFrame)
    for i, notif in ipairs(self.ActiveNotifications) do
        if notif == notificationFrame then
            table.remove(self.ActiveNotifications, i)
            break
        end
    end
    self:RepositionNotifications()
end

function NotificationLib:MakeNotification(params)
    local name = params.Name or "Notification"
    local content = params.Content or ""
    local image = params.Image or "rbxassetid://4483345998"
    local duration = params.Time  -- if nil, it's permanent

    -- If duration is nil, check if a permanent notification is already active.
    if duration == nil then
        for _, notif in ipairs(self.ActiveNotifications) do
            if notif:GetAttribute("Permanent") == true then
                -- A permanent notification is active; do not create another.
                return
            end
        end
    end

    -- Create a ScreenGui (one per notification for simplicity)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "NotificationGUI"
    screenGui.Parent = player:WaitForChild("PlayerGui")

    -- Create the main Frame
    local notificationFrame = Instance.new("Frame")
    notificationFrame.Name = "NotificationFrame"
    notificationFrame.Size = UDim2.new(0, 300, 0, 70)
    -- Bottom-left anchor
    notificationFrame.AnchorPoint = Vector2.new(0, 1)
    -- Temporary position; will be updated by RepositionNotifications
    notificationFrame.Position = UDim2.new(0, 10, 1, -10)
    notificationFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    notificationFrame.BackgroundTransparency = 1
    notificationFrame.BorderSizePixel = 0
    notificationFrame.Parent = screenGui

    -- Mark permanent if no duration
    if duration == nil then
        notificationFrame:SetAttribute("Permanent", true)
    end

    -- Rounded corners
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 8)
    uiCorner.Parent = notificationFrame

    -- Blue outline
    local notificationStroke = Instance.new("UIStroke")
    notificationStroke.Color = Color3.fromRGB(0, 0, 255)
    notificationStroke.Thickness = 2
    notificationStroke.Parent = notificationFrame

    -- Title Label
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

    -- Message Label
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

    -- Image (top-right corner)
    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Size = UDim2.new(0, 24, 0, 24)
    imageLabel.Position = UDim2.new(1, -28, 0, 4)
    imageLabel.BackgroundTransparency = 1
    imageLabel.Image = image
    imageLabel.ImageTransparency = 1
    imageLabel.Parent = notificationFrame

    -- Close Button (bottom-right corner, red "X")
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 20, 0, 20)
    closeButton.Position = UDim2.new(1, -25, 1, -25) -- bottom-right corner
    closeButton.BackgroundTransparency = 1
    closeButton.Text = "X"
    closeButton.TextColor3 = Color3.fromRGB(255, 0, 0)  -- red color
    closeButton.Font = Enum.Font.SourceSansBold
    closeButton.TextScaled = true
    closeButton.TextTransparency = 1
    closeButton.Parent = notificationFrame

    -- Close Button click event
    closeButton.MouseButton1Click:Connect(function()
        -- Manually remove this notification
        local tweenInfoOut = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        TweenService:Create(notificationFrame, tweenInfoOut, {BackgroundTransparency = 1}):Play()
        TweenService:Create(titleLabel, tweenInfoOut, {TextTransparency = 1}):Play()
        TweenService:Create(messageLabel, tweenInfoOut, {TextTransparency = 1}):Play()
        TweenService:Create(imageLabel, tweenInfoOut, {ImageTransparency = 1}):Play()
        TweenService:Create(closeButton, tweenInfoOut, {TextTransparency = 1}):Play()
        task.wait(0.5)
        screenGui:Destroy()
        self:RemoveNotification(notificationFrame)
    end)

    -- Insert the new notification at index 1 (the "bottom" in the array)
    table.insert(self.ActiveNotifications, 1, notificationFrame)
    self:RepositionNotifications()

    -- Tween In
    local tweenInfoIn = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(notificationFrame, tweenInfoIn, {BackgroundTransparency = 0.3}):Play()
    TweenService:Create(titleLabel, tweenInfoIn, {TextTransparency = 0}):Play()
    TweenService:Create(messageLabel, tweenInfoIn, {TextTransparency = 0}):Play()
    TweenService:Create(imageLabel, tweenInfoIn, {ImageTransparency = 0}):Play()
    TweenService:Create(closeButton, tweenInfoIn, {TextTransparency = 0}):Play()

    -- Auto-remove if duration is provided
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
            self:RemoveNotification(notificationFrame)
        end)
    end

    return notificationFrame
end

return NotificationLib
