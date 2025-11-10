local NotificationLib = {}
local TweenService = game:GetService("TweenService")
local Players      = game:GetService("Players")
local player       = Players.LocalPlayer
local playerGui    = player:WaitForChild("PlayerGui")

local SCREEN_GUI_NAME = "ExecutorNotificationSystem"

local screenGui = playerGui:FindFirstChild(SCREEN_GUI_NAME)
if not screenGui then
    screenGui = Instance.new("ScreenGui")
    screenGui.Name = SCREEN_GUI_NAME
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui
end

local template = screenGui:FindFirstChild("Template")
if not template then
    template = Instance.new("Frame")
    template.Name = "Template"
    template.Size = UDim2.new(0, 310, 0, 80)
    template.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    template.BorderSizePixel = 0
    template.Visible = false
    template.Parent = screenGui

    local corner = Instance.new("UICorner", template)
    corner.CornerRadius = UDim.new(0, 8)

    local icon = Instance.new("ImageLabel", template)
    icon.Name = "Icon"
    icon.Size = UDim2.new(0, 48, 0, 48)
    icon.Position = UDim2.new(0, 12, 0.5, -24)
    icon.BackgroundTransparency = 1
    icon.Image = ""

    local title = Instance.new("TextLabel", template)
    title.Name = "Title"
    title.Size = UDim2.new(1, -70, 0, 24)
    title.Position = UDim2.new(0, 70, 0, 10)
    title.BackgroundTransparency = 1
    title.TextColor3 = Color3.new(1,1,1)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Text = ""

    local desc = Instance.new("TextLabel", template)
    desc.Name = "Description"
    desc.Size = UDim2.new(1, -70, 0, 36)
    desc.Position = UDim2.new(0, 70, 0, 34)
    desc.BackgroundTransparency = 1
    desc.TextColor3 = Color3.new(0.8,0.8,0.8)
    desc.Font = Enum.Font.Gotham
    desc.TextSize = 14
    desc.TextWrapped = true
    desc.TextXAlignment = Enum.TextXAlignment.Left
    desc.Text = ""
end

local notifications = {}
local notificationSpacing = 10
local NOTIF_WIDTH = 310
local NOTIF_HEIGHT = 80

local function repositionAll()
    for i, notif in ipairs(notifications) do
        local yOffset = (i - 1) * (NOTIF_HEIGHT + notificationSpacing) + 50
        local target = UDim2.new(1, -NOTIF_WIDTH-10, 1, -yOffset)
        TweenService:Create(notif, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {Position = target}):Play()
    end
end

function NotificationLib:MakeNotification(data)
    task.spawn(function()
        data = {
            Name    = data.Name    or "Notification",
            Content = data.Content or "No content",
            Image   = data.Image   or "",
            Time    = data.Time    or 3,
        }

        local notif = template:Clone()
        notif.Parent = screenGui
        notif.Name   = data.Name
        notif.Title.Text = data.Name
        notif.Description.Text = data.Content
        notif.Icon.Image = data.Image

        notif.BackgroundTransparency = 1
        notif.Title.TextTransparency = 1
        notif.Description.TextTransparency = 1
        notif.Icon.ImageTransparency = 1

        table.insert(notifications, 1, notif)

        notif.Position = UDim2.new(1, -NOTIF_WIDTH-10, 1, 100)
        notif.Visible = true

        TweenService:Create(notif, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0.45}):Play()
        TweenService:Create(notif.Title, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {TextTransparency = 0}):Play()
        TweenService:Create(notif.Description, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {TextTransparency = 0}):Play()
        TweenService:Create(notif.Icon, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {ImageTransparency = 0}):Play()

        repositionAll()

        task.wait(data.Time)

        TweenService:Create(notif, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {BackgroundTransparency = 1}):Play()
        TweenService:Create(notif.Title, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
        TweenService:Create(notif.Description, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
        TweenService:Create(notif.Icon, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {ImageTransparency = 1}):Play()

        task.wait(0.4)

        for i, n in ipairs(notifications) do
            if n == notif then
                table.remove(notifications, i)
                break
            end
        end
        notif:Destroy()

        repositionAll()
    end)
end

NotificationLib.Parent = screenGui

return NotificationLib
