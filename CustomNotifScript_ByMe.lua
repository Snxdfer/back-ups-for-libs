-- ChatGPT'd, dont blame me. 😡 au

local NotificationLib = {}
local TweenService = game:GetService("TweenService")

local notifications = {} -- Table to store active notifications
local notificationSpacing = 10 -- Space between notifications

function NotificationLib:MakeNotification(data)
    task.spawn(function()
        data = {
            Name = data.Name or "Notification",
            Content = data.Content or "No Content",
            Image = data.Image or "",
            Time = data.Time or 3
        }

        local newNotification = script.Template:Clone()
        newNotification.Parent = script.Parent
        newNotification.Visible = false
        newNotification.Name = data.Name
        newNotification.Title.Text = data.Name
        newNotification.Description.Text = data.Content
        newNotification.Icon.Image = data.Image
        
        -- Set initial transparency
        newNotification.BackgroundTransparency = 1
        newNotification.Title.TextTransparency = 1
        newNotification.Description.TextTransparency = 1
        newNotification.Icon.ImageTransparency = 1

        -- Insert into notifications table
        table.insert(notifications, 1, newNotification)

        -- Reposition notifications smoothly
        for i, notification in ipairs(notifications) do
            local targetPosition = UDim2.new(1, -320, 1, -((i - 1) * (newNotification.Size.Y.Offset + notificationSpacing) + 50))
            TweenService:Create(notification, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {Position = targetPosition}):Play()
        end

        -- Show animation
        newNotification.Position = UDim2.new(1, -320, 1, 100) -- Start from offscreen
        newNotification.Visible = true
        TweenService:Create(newNotification, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0.45}):Play()
        TweenService:Create(newNotification.Title, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {TextTransparency = 0}):Play()
        TweenService:Create(newNotification.Description, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {TextTransparency = 0}):Play()
        TweenService:Create(newNotification.Icon, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {ImageTransparency = 0}):Play()

        -- Wait for the specified duration
        task.wait(data.Time)

        -- Hide animation
        TweenService:Create(newNotification, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {BackgroundTransparency = 1}):Play()
        TweenService:Create(newNotification.Title, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
        TweenService:Create(newNotification.Description, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
        TweenService:Create(newNotification.Icon, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {ImageTransparency = 1}):Play()

        task.wait(0.4)

        -- Remove from table and destroy
        for i, notification in ipairs(notifications) do
            if notification == newNotification then
                table.remove(notifications, i)
                break
            end
        end

        newNotification:Destroy()

        -- Reposition remaining notifications
        for i, notification in ipairs(notifications) do
            local targetPosition = UDim2.new(1, -320, 1, -((i - 1) * (newNotification.Size.Y.Offset + notificationSpacing) + 50))
            TweenService:Create(notification, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {Position = targetPosition}):Play()
        end
    end)
end

return NotificationLib
