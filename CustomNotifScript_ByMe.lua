local NotificationLib = {}
NotificationLib.ActiveNotifications = {}

local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ExecutorNotifications"
screenGui.ResetOnSpawn = false
screenGui.Parent = game:GetService("CoreGui")

function NotificationLib:RepositionNotifications()
    local padding = 10
    local gap = 8
    local height = 70

    for i, data in ipairs(self.ActiveNotifications) do
        local frame = data.Frame
        local targetY = -(padding + (i - 1) * (height + gap))

        local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        local tween = TweenService:Create(frame, tweenInfo, {
            Position = UDim2.new(1, 20, 1, targetY)
        })
        data.Tween = tween
        tween:Play()
    end
end

function NotificationLib:RemoveNotification(frame)
    for i, data in ipairs(self.ActiveNotifications) do
        if data.Frame == frame then
            table.remove(self.ActiveNotifications, i)

            local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            local slideOut = TweenService:Create(frame, tweenInfo, {
                Position = UDim2.new(1, 120, frame.Position.Y.Scale, frame.Position.Y.Offset),
                BackgroundTransparency = 1
            })

            for _, child in ipairs(frame:GetChildren()) do
                if child:IsA("GuiObject") then
                    TweenService:Create(child, tweenInfo, {
                        TextTransparency = 1,
                        ImageTransparency = 1,
                        BackgroundTransparency = 1
                    }):Play()
                end
            end

            slideOut:Play()
            slideOut.Completed:Connect(function()
                frame:Destroy()
                self:RepositionNotifications()
            end)
            break
        end
    end
end

function NotificationLib:MakeNotification(config)
    config = config or {}

    local name     = config.Name or "Notification"
    local content  = config.Content or "No message."
    local image    = config.Image or "rbxassetid://4483345998"
    local duration = config.Time or config.Duration
    local soundId  = config.SoundId
    local volume   = config.Volume or 0.5

    if soundId then
        task.spawn(function()
            local sound = Instance.new("Sound")
            sound.SoundId = soundId
            sound.Volume = math.clamp(volume, 0, 10)
            sound.Parent = SoundService
            sound:Play()
            sound.Ended:Connect(function() sound:Destroy() end)
        end)
    end

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 340, 0, 70)
    frame.AnchorPoint = Vector2.new(1, 1)
    frame.Position = UDim2.new(1, 120, 1, -10)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    frame.BackgroundTransparency = 1
    frame.ClipsDescendants = true
    frame.Parent = screenGui

    local corner = Instance.new("UICorner", frame)
    corner.CornerRadius = UDim.new(0, 12)

    local stroke = Instance.new("UIStroke", frame)
    stroke.Color = Color3.fromRGB(0, 120, 255)
    stroke.Thickness = 2
    stroke.Transparency = 0.5

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, -70, 0, 22)
    title.Position = UDim2.new(0, 12, 0, 8)
    title.BackgroundTransparency = 1
    title.Text = name
    title.TextColor3 = Color3.new(1, 1, 1)
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    title.TextTransparency = 1

    local msg = Instance.new("TextLabel", frame)
    msg.Size = UDim2.new(1, -70, 0, 34)
    msg.Position = UDim2.new(0, 12, 0, 30)
    msg.BackgroundTransparency = 1
    msg.Text = content
    msg.TextColor3 = Color3.fromRGB(200, 200, 200)
    msg.TextXAlignment = Enum.TextXAlignment.Left
    msg.TextYAlignment = Enum.TextYAlignment.Top
    msg.TextWrapped = true
    msg.Font = Enum.Font.Gotham
    msg.TextSize = 14
    msg.TextTransparency = 1

    local icon = Instance.new("ImageLabel", frame)
    icon.Size = UDim2.new(0, 36, 0, 36)
    icon.Position = UDim2.new(1, -50, 0.5, 0)
    icon.AnchorPoint = Vector2.new(0.5, 0.5)
    icon.BackgroundTransparency = 1
    icon.Image = image
    icon.ImageTransparency = 1

    if duration then
        local close = Instance.new("TextButton", frame)
        close.Size = UDim2.new(0, 24, 0, 24)
        close.Position = UDim2.new(1, -34, 0, 8)
        close.BackgroundTransparency = 1
        close.Text = "×"
        close.TextColor3 = Color3.fromRGB(255, 100, 100)
        close.Font = Enum.Font.GothamBold
        close.TextSize = 20
        close.TextTransparency = 1
        close.MouseButton1Click:Connect(function()
            self:RemoveNotification(frame)
        end)
    end

    local tweenIn = TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    TweenService:Create(frame, tweenIn, {BackgroundTransparency = 0.15}):Play()
    TweenService:Create(title, tweenIn, {TextTransparency = 0}):Play()
    TweenService:Create(msg, tweenIn, {TextTransparency = 0}):Play()
    TweenService:Create(icon, tweenIn, {ImageTransparency = 0}):Play()

    table.insert(self.ActiveNotifications, 1, {Frame = frame})
    self:RepositionNotifications()

    if duration then
        task.delay(duration + 0.4, function()
            if frame and frame.Parent then
                self:RemoveNotification(frame)
            end
        end)
    end

    return frame
end

return NotificationLib
