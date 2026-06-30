--[[
:sob:
deobfuscated
reconstructed
renamed
-----------------
enjoy nigga
--]]

local CoreGui = game:GetService('CoreGui')
local TweenService = game:GetService('TweenService')
local UserService = game:GetService('UserService')
local UserInputService = game:GetService('UserInputService')
local RunService = game:GetService('RunService')
local MarketplaceService = game:GetService('MarketplaceService')
local StarterGui = game:GetService('StarterGui')
local StatsService = game:GetService('Stats')
local HttpService = game:GetService('HttpService')
local Players = game:GetService('Players')
local LocalPlayer = Players.LocalPlayer
local LocalPlayerName = LocalPlayer.Name
local LocalPlayerId = LocalPlayer.UserId
local GetHiddenGui = get_hidden_gui or gethui
local HttpRequest = request or http_request or http and http.request or syn and syn.request
local GetCustomAsset = getsynasset or getcustomasset
local SetClipboard = setclipboard or toclipboard or set_clipboard or Clipboard and Clipboard.set
local SetThreadIdentity = syn and syn.set_thread_identity or setidentity or setthreadcontext
local UncFunctionsList = {
    getfenv,
    sethiddenproperty and type(sethiddenproperty) == 'function',
    getsenv and type(getsenv) == 'function',
    GetCustomAsset and type(GetCustomAsset) == 'function',
    Drawing and type(Drawing.new) == 'function',
    syn and syn.websocket or Krnl and Krnl.WebSocket or WebSocket or websocket,
    GetHiddenGui and type(GetHiddenGui) == 'function',
    identifyexecutor and type(identifyexecutor) == 'function',
    getconnections and type(getconnections) == 'function',
    HttpRequest and type(HttpRequest) == 'function',
    require and type(require) == 'function',
    getrawmetatable and type(getrawmetatable) == 'function',
    setreadonly and type(setreadonly) == 'function',
    newcclosure and type(newcclosure) == 'function',
    hookfunction and type(hookfunction) == 'function',
    SetClipboard and type(SetClipboard) == 'function',
    firetouchinterest and type(firetouchinterest) == 'function',
    fireclickdetector and type(fireclickdetector) == 'function',
    getrenv and type(getrenv) == 'function',
    getgenv and type(getgenv) == 'function',
    SetThreadIdentity and type(SetThreadIdentity) == 'function',
    getgc and type(getgc) == 'function',
    debug and debug.getinfo and type(debug.getinfo) == 'function' and debug.getupvalues and type(debug.getupvalues) == 'function' and debug.getupvalue and type(debug.getupvalue) == 'function',
    readfile and type(readfile) == 'function',
    writefile and type(writefile) == 'function',
    isfile and type(isfile) == 'function',
    isfolder and type(isfolder) == 'function',
    makefolder and type(makefolder) == 'function',
    deletefile and type(deletefile) == 'function' or delfile and type(delfile) == 'function',
    deletefolder and type(deletefolder) == 'function' or delfolder and type(delfolder) == 'function',
    listfiles and type(listfiles) == 'function',
}
local ResourceBaseUrl = 'https://raw.githubusercontent.com/ItsJiDy/shwebsocket/main/resources'
local NotificationLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/xwel33/hud/main/Notification'))()
local DatastoreLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/ItsJiDy/SymphonyHubTeam/main/datastore.lua'))()
local SavedConfig = {
    Keybind = {},
    Toggle = {},
    Slider = {},
    Textbox = {},
    Dropdown = {},
}
local HubFolderName = 'SymphonyHub'
local ViewportHeight = workspace.CurrentCamera.ViewportSize.Y
local LocalPlayer = Players.LocalPlayer
local PlayerMouse = LocalPlayer:GetMouse()
local NewColorSequence = ColorSequence.new
local NewTweenInfo = TweenInfo.new
local NewColorKeypoint = ColorSequenceKeypoint.new
local NewRect = Rect.new
local Color3FromRGB = Color3.fromRGB
local NewUDim2 = UDim2.new
local NewUDim = UDim.new
local NewVector2 = Vector2.new
local IsFirstTab = true
local TabList = {}
local PlayerDropdownList = {}
local KeybindList = {}
local Library = {}
local GameCallbacks = {}
local PreloadCallbacks = {}
local OnLoadCallbacks = {}
local SoundRegistry = {}
local IsAnimatingUI = false
local IsContentCreator
local ContentCreatorList
local GameName
local HasPremium
local FolderReady
local SoundInstance = Instance.new('Sound')

SoundInstance.Name = 'SH SFX'
SoundInstance.Parent = workspace

local function PlaySound(soundName)
    if SoundRegistry[soundName] then
        SoundInstance.SoundId = SoundRegistry[soundName]

        SoundInstance:Play()
    end
end
local function GenerateRandomString(strLength)
    strLength = strLength or math.random(1, 10)

    local charArray = {}

    for idx = 1, strLength do
        charArray[idx] = string.char(math.random(32, 126))
    end

    return table.concat(charArray)
end
local function StripHtmlTags(inputText)
    inputText = inputText:gsub('<br%s*/>', '\n')

    return inputText:gsub('<[^<>]->', '')
end
local function HttpGetRequest(requestUrl)
    return HttpRequest({
        Url = requestUrl,
        Method = 'GET',
        Headers = {
            ['Content-Type'] = 'application/json',
        },
        Body = '',
    }).Body
end
local function PingServer()
    HttpGetRequest('https://symphonyhub.onrender.com/script/rendertest')
end
local function AuthorizedRequest(requestUrl, httpMethod)
    return HttpRequest({
        Url = requestUrl,
        Method = httpMethod,
        Headers = {
            Authorization = 'elf and tears',
        },
    }).Body
end
local function StringToHex(inputText)
    return string.gsub(inputText, '.', function(charByte)
        return string.format('%02x', string.byte(charByte))
    end)
end
local function HexToString(inputText)
    return string.gsub(inputText, '%x%x', function(hexPair)
        return string.char(tonumber(hexPair, 16))
    end)
end
local function EncryptString(inputText)
    local hexStr = StringToHex(inputText)
    local resultStr = ''

    for idx = 1, string.len(hexStr)do
        resultStr = resultStr .. string.char(string.byte(hexStr, idx) + 75)
    end

    return resultStr
end
local function DecryptString(inputText)
    local resultStr = ''

    for idx = 1, string.len(inputText)do
        resultStr = resultStr .. string.char(string.byte(inputText, idx) - 75)
    end

    return HexToString(resultStr)
end
local function CreateNotification(inputText, duration)
    local notifFrame = Instance.new('ImageLabel')
    local flashImage = Instance.new('ImageLabel')
    local glowImage = Instance.new('ImageLabel')
    local HubTitleLabel = Instance.new('TextLabel')
    local notifTextLabel = Instance.new('TextLabel')
    local hexStr = StripHtmlTags(inputText)

    inputText = tostring(inputText) or 'Hello World!'
    duration = tonumber(duration) or 5
    notifFrame.Name = 'Notification'
    notifFrame.Parent = Gui
    notifFrame.BackgroundTransparency = 1
    notifFrame.Size = UDim2.new(0, 0, 0, 60)
    notifFrame.Image = 'rbxassetid://5028857472'
    notifFrame.ImageColor3 = Color3.fromRGB(24, 24, 24)
    notifFrame.ScaleType = Enum.ScaleType.Slice
    notifFrame.SliceCenter = Rect.new(4, 4, 296, 296)
    notifFrame.ZIndex = 3
    notifFrame.Position = UDim2.new(0, 10, 1, -(notifFrame.AbsoluteSize.Y + 10))
    notifFrame.ClipsDescendants = true
    flashImage.Name = 'Flash'
    flashImage.Parent = notifFrame
    flashImage.Size = UDim2.new(1, 0, 1, 0)
    flashImage.BackgroundTransparency = 1
    flashImage.Image = 'rbxassetid://4641149554'
    flashImage.ImageColor3 = Color3.fromRGB(255, 255, 255)
    flashImage.ZIndex = 5
    glowImage.Name = 'Glow'
    glowImage.Parent = notifFrame
    glowImage.BackgroundTransparency = 1
    glowImage.Position = UDim2.new(0, -15, 0, -15)
    glowImage.Size = UDim2.new(1, 30, 1, 30)
    glowImage.ZIndex = 2
    glowImage.Image = 'rbxassetid://5028857084'
    glowImage.ImageColor3 = Color3.fromRGB(0, 0, 0)
    glowImage.ScaleType = Enum.ScaleType.Slice
    glowImage.SliceCenter = Rect.new(24, 24, 276, 276)
    HubTitleLabel.Name = 'Title'
    HubTitleLabel.Parent = notifFrame
    HubTitleLabel.BackgroundTransparency = 1
    HubTitleLabel.Position = UDim2.new(0, 10, 0, 8)
    HubTitleLabel.Size = UDim2.new(1, -40, 0, 16)
    HubTitleLabel.ZIndex = 4
    HubTitleLabel.Font = Enum.Font.GothamSemibold
    HubTitleLabel.Text = 'Symphony Hub Says:'
    HubTitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    HubTitleLabel.TextSize = 14
    HubTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    notifTextLabel.Name = 'Text'
    notifTextLabel.Parent = notifFrame
    notifTextLabel.BackgroundTransparency = 1
    notifTextLabel.Position = UDim2.new(0, 10, 1, -24)
    notifTextLabel.Size = UDim2.new(1, -40, 0, 16)
    notifTextLabel.ZIndex = 4
    notifTextLabel.Font = Enum.Font.Gotham
    notifTextLabel.Text = inputText
    notifTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    notifTextLabel.TextSize = 12
    notifTextLabel.RichText = true
    notifTextLabel.TextXAlignment = Enum.TextXAlignment.Left

    TweenService:Create(notifFrame, TweenInfo.new(0.2), {
        Size = UDim2.new(0, TextService:GetTextSize(hexStr, 12, Enum.Font.Gotham, Vector2.new(math.huge, 16)).X + 60, 0, 60),
    }):Play()
    task.wait(0.2)

    notifFrame.ClipsDescendants = false

    TweenService:Create(flashImage, TweenInfo.new(0.2), {
        Size = UDim2.new(0, 0, 0, 60),
        Position = UDim2.new(1, 0, 0, 0),
    }):Play()
    task.wait(duration)

    notifFrame.ClipsDescendants = true

    TweenService:Create(flashImage, TweenInfo.new(0.2), {
        Size = UDim2.new(1, 0, 1, 0),
    }):Play()
    task.wait(0.2)
    TweenService:Create(notifFrame, TweenInfo.new(0.2), {
        Size = UDim2.new(0, 0, 0, 60),
        Position = notifFrame.Position + UDim2.new(0, TextService:GetTextSize(hexStr, 12, Enum.Font.Gotham, Vector2.new(math.huge, 16)).X + 70, 0, 0),
    }):Play()
    task.wait(0.2)
    notifFrame:Destroy()
end
local function FormatLargeNumber(number, decimals)
    local suffixes = {
        'k',
        'M',
        'B',
        'T',
        'Qa',
        'Qn',
        'Sx',
        'Sp',
        'Oc',
        'N',
    }

    return math.floor((number < 1 and number or math.floor(number) / 10 ^ (math.log10(number) - math.log10(number) % 3)) * 10 ^ (decimals or 3)) / 10 ^ (decimals or 3) .. (suffixes[math.floor(math.log10(number) / 3)] or '')
end
local function SaveConfig()
    writefile(HubFolderName .. '/Configs/' .. game.PlaceId .. '.shf', EncryptString(HttpService:JSONEncode(SavedConfig)))
end
local function EnsureMainFolder()
    if isfolder(HubFolderName) then
        return true
    else
        makefolder(HubFolderName)

        if isfolder(HubFolderName) then
            return true
        else
            return false
        end
    end
end
local function EnsureFolder(aw)
    if not isfolder(aw) then
        makefolder(aw)
    end
end
local function EnsureFile(aw, resultStr)
    if not isfile(aw) then
        writefile(aw, resultStr)
    end
end
local function SafeReadFile(aw)
    if isfile(aw) then
        return readfile(aw)
    else
        return ''
    end
end
local function CreateInstance(aA, aB)
    local newInst = Instance.new(aA)

    for idx, propValue in pairs(aB)do
        newInst[idx] = propValue
    end

    return newInst
end
local function ApplyProperties(newInst, aB)
    for idx, propValue in pairs(aB)do
        newInst[idx] = propValue
    end
end
local function AddUICorner(newInst, cornerRadius)
    local uiCorner = CreateInstance('UICorner', {
        Name = 'UICorner',
        Parent = newInst,
        CornerRadius = NewUDim(0, cornerRadius or 10),
    })

    return uiCorner
end
local function TweenAndPlay(...)
    local tween = TweenService:Create(...)

    tween:Play()

    return tween
end
local function ParentToGui(guiObj)
    if GetHiddenGui then
        guiObj.Parent = GetHiddenGui()
    elseif not is_sirhurt_closure and (syn and syn.protect_gui) then
        syn.protect_gui(guiObj)

        guiObj.Parent = CoreGui
    else
        guiObj.Parent = CoreGui
    end
end
local function StripHtmlTags(inputText)
    inputText = inputText:gsub('<br%s*/>', '\n')

    return inputText:gsub('<[^<>]->', '')
end
local function ShowNotification(notifMessage, duration)
    coroutine.wrap(NotificationLib.prompt)('Symphony Hub Says:', notifMessage, duration or 5)
end
local function ValidateKey(inputObj)
    local keyCheckResult = HttpService:JSONDecode(HttpGetRequest('https://api-gateway.platoboost.com/v1/authenticators/15908/' .. StringToHex(LocalPlayerId)))

    return keyCheckResult.key == inputObj
end

local Gui = CreateInstance('ScreenGui', {
    Name = GenerateRandomString(),
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
})
local aR = CreateInstance('TextButton', {
    Name = 'Minimize Toggle',
    Parent = Gui,
    BackgroundColor3 = Color3FromRGB(0, 0, 255),
    BackgroundTransparency = 0.15,
    Position = NewUDim2(0, 0, 0.05, 0),
    Size = NewUDim2(0, 35, 0, 35),
    Font = Enum.Font.SourceSansBold,
    Text = 'SYH',
    TextColor3 = Color3FromRGB(255, 255, 255),
    Visible = false,
    TextSize = 20,
    TextWrapped = true,
    Draggable = false,
})
local aS = CreateInstance('CanvasGroup', {
    Name = 'Group MainFrame',
    Parent = Gui,
    BackgroundColor3 = Color3FromRGB(255, 255, 255),
    BackgroundTransparency = 1,
    GroupColor3 = Color3FromRGB(255, 255, 255),
    GroupTransparency = 0,
    Position = NewUDim2(0.5, 0, 0.5, 0),
    AnchorPoint = NewVector2(0.5, 0.5),
    Size = NewUDim2(0, 500, 0, 300),
    Draggable = true,
    Active = true,
    Visible = false,
})
local aT = CreateInstance('Frame', {
    Name = 'MainFrame',
    Parent = aS,
    BackgroundColor3 = Color3FromRGB(0, 0, 0),
    BackgroundTransparency = 0.35,
    Position = NewUDim2(0.5, 0, 0.5, 0),
    AnchorPoint = NewVector2(0.5, 0.5),
    Size = NewUDim2(0, 500, 0, 300),
})
local aU = CreateInstance('UIScale', {
    Name = 'UIScale',
    Parent = aT,
    Scale = 0.8 + ViewportHeight / 2000,
})
local aV = CreateInstance('Frame', {
    Name = 'TopFrame',
    Parent = aT,
    Active = true,
    BackgroundColor3 = Color3FromRGB(75, 0, 0),
    Position = NewUDim2(0.5, 0, 0.07, 0),
    AnchorPoint = NewVector2(0.5, 0.5),
    Size = NewUDim2(0, 475, 0, 20),
})
local HubTitleLabel = CreateInstance('TextLabel', {
    Name = 'Title',
    Parent = aV,
    BackgroundColor3 = Color3FromRGB(25, 25, 25),
    BackgroundTransparency = 1,
    Position = NewUDim2(0.15, 0, 0.5, 0),
    AnchorPoint = NewVector2(0.5, 0.5),
    Size = NewUDim2(0, 100, 0, 20),
    Font = Enum.Font.GothamBold,
    Text = 'Symphony Hub',
    TextSize = 13,
    TextColor3 = Color3FromRGB(255, 255, 255),
    TextXAlignment = Enum.TextXAlignment.Left,
})
local aW = CreateInstance('ScrollingFrame', {
    Name = 'TabFrame',
    Parent = aT,
    BackgroundColor3 = Color3FromRGB(25, 25, 25),
    BackgroundTransparency = 1,
    Position = NewUDim2(0.1685, 0, 0.55, 0),
    AnchorPoint = NewVector2(0.5, 0.5),
    Size = NewUDim2(0, 150, 0, 250),
    ScrollBarThickness = 0,
    CanvasSize = NewUDim2(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
})
local aX = CreateInstance('UIListLayout', {
    Name = 'UIListLayout',
    Parent = aW,
    HorizontalAlignment = Enum.HorizontalAlignment.Center,
    SortOrder = Enum.SortOrder.LayoutOrder,
    Padding = NewUDim(0.05, 2),
})

function Library:CreateTab(aY, aZ)
    local tabFrame = CreateInstance('Frame', {
        Name = aY,
        Parent = aW,
        BackgroundColor3 = Color3FromRGB(15, 15, 220),
        BackgroundTransparency = IsFirstTab and 0 or 0.8,
        Size = NewUDim2(0, 125, 0, 40),
    })
    local tabButton = CreateInstance('TextButton', {
        Name = 'Activator',
        Parent = tabFrame,
        BackgroundTransparency = 1,
        Position = NewUDim2(0.5, 0, 0.5, 0),
        Size = NewUDim2(0, 125, 0, 40),
        Text = '',
        AnchorPoint = NewVector2(0.5, 0.5),
    })
    local tabLogo = CreateInstance('ImageLabel', {
        Name = 'Logo',
        Parent = tabButton,
        BackgroundColor3 = Color3FromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Position = IsFirstTab and NewUDim2(0.18, 0, 0.5, 0) or NewUDim2(0.15, 0, 0.5, 0),
        Size = NewUDim2(0, 30, 0, 30),
        AnchorPoint = NewVector2(0.5, 0.5),
        Image = aZ or '',
    })
    local tabIndicator = CreateInstance('TextLabel', {
        Name = 'Indicator',
        Parent = tabButton,
        BackgroundColor3 = Color3FromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Position = IsFirstTab and NewUDim2(0.64, 0, 0.5, 0) or NewUDim2(0.615, 0, 0.5, 0),
        Size = NewUDim2(0, 70, 0, 30),
        Font = Enum.Font.GothamBold,
        Text = aY,
        TextColor3 = Color3FromRGB(255, 255, 255),
        TextSize = 12,
        AnchorPoint = NewVector2(0.5, 0.5),
    })
    local tabContentGroup = CreateInstance('CanvasGroup', {
        Name = 'Group ' .. aY,
        Parent = aT,
        BackgroundColor3 = Color3FromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Position = NewUDim2(0.655, 0, 0.55, 0),
        AnchorPoint = NewVector2(0.5, 0.5),
        Size = NewUDim2(0, 310, 0, 250),
        GroupColor3 = Color3FromRGB(255, 255, 255),
        GroupTransparency = 0,
    })
    local tabContent = CreateInstance('ScrollingFrame', {
        Name = 'Sleek',
        Parent = tabContentGroup,
        Visible = IsFirstTab,
        BackgroundColor3 = Color3FromRGB(25, 25, 25),
        BackgroundTransparency = 0.5,
        Position = NewUDim2(0.5, 0, 0.5, 0),
        AnchorPoint = NewVector2(0.5, 0.5),
        Size = NewUDim2(0, 310, 0, 250),
        CanvasSize = NewUDim2(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollBarThickness = 0,
    })
    local tabListLayout = CreateInstance('UIListLayout', {
        Name = 'UIListLayout',
        Parent = tabContent,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = NewUDim(0.025, 2),
    })
    local tabTitleLabel = CreateInstance('TextLabel', {
        Name = 'Title',
        Parent = tabContent,
        BackgroundColor3 = Color3FromRGB(10, 10, 200),
        BackgroundTransparency = 1,
        Size = NewUDim2(0, 300, 0, 35),
        Font = Enum.Font.GothamBold,
        Text = aY .. ':',
        TextSize = 13,
        TextColor3 = Color3FromRGB(255, 255, 255),
        TextXAlignment = Enum.TextXAlignment.Left,
        RichText = true,
    })

    tabButton.MouseButton1Click:Connect(function()
        PlaySound('UI_Click')

        if not tabContent.Visible then
            for idx = 1, #TabList do
                local tabEntry = TabList[idx]

                TweenAndPlay(tabEntry.Inst, NewTweenInfo(0.5), {BackgroundTransparency = 0.8})
                TweenAndPlay(tabEntry.Inst.Activator.Logo, NewTweenInfo(0.5), {
                    Position = NewUDim2(0.165, 0, 0.5, 0),
                })
                TweenAndPlay(tabEntry.Inst.Activator.Indicator, NewTweenInfo(0.5), {
                    Position = NewUDim2(0.615, 0, 0.5, 0),
                })

                tabEntry.Holder.Visible = false
                tabEntry.Holder.Parent.GroupTransparency = 1
            end

            TweenAndPlay(tabFrame, NewTweenInfo(0.5), {BackgroundTransparency = 0})
            TweenAndPlay(tabLogo, NewTweenInfo(0.5), {
                Position = NewUDim2(0.18, 0, 0.5, 0),
            })
            TweenAndPlay(tabIndicator, NewTweenInfo(0.5), {
                Position = NewUDim2(0.64, 0, 0.5, 0),
            })
            TweenAndPlay(tabContentGroup, NewTweenInfo(0.5), {GroupTransparency = 0})

            tabContent.Visible = true
        end
    end)
    AddUICorner(tabFrame)

    local tabObj = {}

    table.insert(TabList, {
        Name = aY,
        Inst = tabFrame,
        Holder = tabContent,
    })

    IsFirstTab = false

    function tabObj:CreateBigTextbox(aY, placeholder, callback)
        local bigTextboxFrame = CreateInstance('Frame', {
            Name = aY,
            Parent = tabContent,
            BackgroundColor3 = Color3FromRGB(10, 10, 200),
            Size = NewUDim2(0, 300, 0, 150),
        })
        local bigTextboxInput = CreateInstance('TextBox', {
            Name = 'Input',
            Parent = bigTextboxFrame,
            BackgroundColor3 = Color3FromRGB(10, 10, 200),
            BackgroundTransparency = 1,
            Position = NewUDim2(0.5, 0, 0.5, 0),
            Size = NewUDim2(0, 300, 0, 150),
            AnchorPoint = NewVector2(0.5, 0.5),
            Font = Enum.Font.GothamBold,
            PlaceholderText = placeholder or 'Put your text here!',
            PlaceholderColor3 = Color3FromRGB(0, 200, 0),
            ClearTextOnFocus = false,
            MultiLine = true,
            Text = '',
            TextColor3 = Color3FromRGB(255, 255, 255),
            TextSize = 10,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
        })

        callback = callback or function() end

        AddUICorner(bigTextboxFrame)
        bigTextboxInput.FocusLost:Connect(function()
            callback(bigTextboxInput.Text)
        end)
        task.wait()
    end
    function tabObj:CreateProfileMessage(profileIcon, msgTitle, msgText)
        local msgFrame = CreateInstance('Frame', {
            Name = msgTitle,
            Parent = tabContent,
            BackgroundColor3 = Color3FromRGB(10, 10, 200),
            Size = NewUDim2(0, 300, 0, 35),
            AutomaticSize = Enum.AutomaticSize.Y,
        })
        local msgIcon = CreateInstance('ImageLabel', {
            Name = 'Icon',
            Parent = msgFrame,
            BackgroundColor3 = Color3FromRGB(25, 25, 25),
            BackgroundTransparency = 1,
            Position = NewUDim2(0.025, 0, 0, 8),
            Size = NewUDim2(0, 25, 0, 25),
            Image = profileIcon or '',
        })
        local msgTitleLabel = CreateInstance('TextLabel', {
            Name = 'Title',
            Parent = msgFrame,
            BackgroundColor3 = Color3FromRGB(25, 25, 25),
            BackgroundTransparency = 1,
            Position = NewUDim2(0.135, 0, 0, 5),
            Size = NewUDim2(0, 100, 0, 20),
            Font = Enum.Font.GothamBold,
            Text = msgTitle or 'Title',
            TextSize = 12,
            TextColor3 = Color3FromRGB(255, 255, 255),
            TextXAlignment = Enum.TextXAlignment.Left,
            RichText = true,
        })
        local msgTextLabel = CreateInstance('TextLabel', {
            Name = 'Text',
            Parent = msgFrame,
            BackgroundColor3 = Color3FromRGB(35, 35, 35),
            BackgroundTransparency = 1,
            Position = NewUDim2(0.125, 0, 0, 30),
            Size = NewUDim2(0, 280, 0, 1),
            Font = Enum.Font.GothamBold,
            Text = (msgText or 'Text') .. '\n',
            TextSize = 11,
            TextColor3 = Color3FromRGB(255, 255, 255),
            TextXAlignment = Enum.TextXAlignment.Left,
            AutomaticSize = Enum.AutomaticSize.Y,
            RichText = true,
        })

        AddUICorner(msgFrame)
        AddUICorner(msgIcon, 30)
        task.wait()
    end
    function tabObj:CreateToggle(toggleName, callback)
        local toggleFrame = CreateInstance('Frame', {
            Name = toggleName,
            Parent = tabContent,
            BackgroundColor3 = Color3FromRGB(10, 10, 200),
            Size = NewUDim2(0, 300, 0, 35),
        })
        local toggleActivator = CreateInstance('ImageButton', {
            Name = 'Activator',
            Parent = toggleFrame,
            BackgroundColor3 = Color3FromRGB(75, 0, 0),
            BackgroundTransparency = 0,
            Position = NewUDim2(0.785, 0, 0.5, 0),
            Size = NewUDim2(0, 55, 0, 15),
            AnchorPoint = NewVector2(0.5, 0.5),
            Image = 'rbxassetid://3926311105',
            ImageTransparency = 1,
        })
        local toggleSlider = CreateInstance('ImageButton', {
            Name = 'Sleek',
            Parent = toggleActivator,
            BackgroundColor3 = Color3FromRGB(255, 0, 0),
            BackgroundTransparency = 0,
            Position = NewUDim2(0.2, 0, 0.5, 0),
            Size = NewUDim2(0, 20, 0, 10),
            AnchorPoint = NewVector2(0.5, 0.5),
            Image = 'rbxassetid://3926311105',
            ImageTransparency = 1,
        })
        local toggleTitleLabel = CreateInstance('TextLabel', {
            Name = 'Title',
            Parent = toggleFrame,
            BackgroundColor3 = Color3FromRGB(25, 25, 25),
            BackgroundTransparency = 1,
            Position = NewUDim2(0.2, 0, 0.5, 0),
            AnchorPoint = NewVector2(0.5, 0.5),
            Size = NewUDim2(0, 100, 0, 20),
            Font = Enum.Font.GothamBold,
            Text = toggleName or 'Toggle',
            TextSize = 10,
            TextColor3 = Color3FromRGB(255, 255, 255),
            TextXAlignment = Enum.TextXAlignment.Left,
            RichText = true,
        })
        local toggleState = false
        local controlObj = {}

        callback = callback or function() end

        AddUICorner(toggleFrame)
        AddUICorner(toggleActivator)
        AddUICorner(toggleSlider)

        function controlObj:Toggle()
            toggleState = not toggleState

            if toggleState then
                TweenService:Create(toggleSlider, TweenInfo.new(0.5), {
                    BackgroundColor3 = Color3FromRGB(0, 255, 0),
                }):Play()
                toggleSlider:TweenPosition(NewUDim2(0.8, 0, 0.5, 0), 'Out', 'Quad', 0.5, true)
            else
                TweenService:Create(toggleSlider, TweenInfo.new(0.5), {
                    BackgroundColor3 = Color3FromRGB(255, 0, 0),
                }):Play()
                toggleSlider:TweenPosition(NewUDim2(0.2, 0, 0.5, 0), 'Out', 'Quad', 0.5, true)
            end

            callback(toggleState)
            PlaySound('UI_Click')

            SavedConfig.Toggle[toggleName] = toggleState

            SaveConfig()
        end
        function controlObj:GetStatus()
            return toggleState
        end

        toggleActivator.MouseButton1Click:Connect(function()
            controlObj:Toggle()
        end)
        task.wait()

        if SavedConfig.Toggle[toggleName] and type(SavedConfig.Toggle[toggleName]) == 'boolean' then
            toggleSlider.BackgroundColor3 = Color3FromRGB(0, 255, 0)
            toggleSlider.Position = NewUDim2(0.8, 0, 0.5, 0)
            toggleState = true

            pcall(coroutine.wrap(callback), toggleState)
        else
            SavedConfig.Toggle[toggleName] = toggleState
        end

        return controlObj
    end
    function tabObj:CreateLabel(labelText)
        local labelInst = CreateInstance('TextLabel', {
            Name = 'Label',
            Parent = tabContent,
            BackgroundColor3 = Color3FromRGB(10, 10, 200),
            BackgroundTransparency = 1,
            Size = NewUDim2(0, 300, 0, 20),
            Font = Enum.Font.GothamBold,
            Text = (labelText or 'Label') .. '\n',
            TextSize = 11,
            TextColor3 = Color3FromRGB(255, 255, 255),
            TextXAlignment = Enum.TextXAlignment.Left,
            AutomaticSize = Enum.AutomaticSize.Y,
            RichText = true,
        })
        local labelMethods = {}

        function labelMethods:Update(newLabelText)
            labelInst.Text = (newLabelText or 'Label') .. '\n'
        end

        task.wait()

        return labelMethods
    end
    function tabObj:CreateButton(buttonName, callback)
        local buttonFrame = CreateInstance('ImageButton', {
            Name = buttonName,
            Parent = tabContent,
            BackgroundColor3 = Color3FromRGB(10, 10, 200),
            Size = NewUDim2(0, 300, 0, 35),
        })
        local buttonTitleLabel = CreateInstance('TextLabel', {
            Name = 'Title',
            Parent = buttonFrame,
            BackgroundColor3 = Color3FromRGB(25, 25, 25),
            BackgroundTransparency = 1,
            Position = NewUDim2(0.2, 0, 0.5, 0),
            AnchorPoint = NewVector2(0.5, 0.5),
            Size = NewUDim2(0, 100, 0, 20),
            Font = Enum.Font.GothamBold,
            Text = buttonName or 'Button',
            TextSize = 10,
            TextColor3 = Color3FromRGB(255, 255, 255),
            TextXAlignment = Enum.TextXAlignment.Left,
            RichText = true,
        })
        local buttonIcon = CreateInstance('ImageLabel', {
            Name = 'Icon',
            Parent = buttonFrame,
            BackgroundColor3 = Color3FromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            Position = NewUDim2(0.8, 0, 0.5, 0),
            AnchorPoint = NewVector2(0.5, 0.5),
            Size = NewUDim2(0, 15, 0, 20),
            Image = 'rbxassetid://8284791761',
            ScaleType = Enum.ScaleType.Stretch,
        })

        callback = callback or function() end

        AddUICorner(buttonFrame)
        buttonFrame.MouseButton1Click:Connect(function()
            PlaySound('UI_Click')
            callback()
        end)
        task.wait()
    end
    function tabObj:CreateTextbox(textboxName, callback)
        local textboxFrame = CreateInstance('Frame', {
            Name = textboxName,
            Parent = tabContent,
            BackgroundColor3 = Color3FromRGB(10, 10, 200),
            Size = NewUDim2(0, 300, 0, 35),
        })
        local textboxTitleLabel = CreateInstance('TextLabel', {
            Name = 'Title',
            Parent = textboxFrame,
            BackgroundColor3 = Color3FromRGB(25, 25, 25),
            BackgroundTransparency = 1,
            Position = NewUDim2(0.2, 0, 0.5, 0),
            AnchorPoint = NewVector2(0.5, 0.5),
            Size = NewUDim2(0, 100, 0, 20),
            Font = Enum.Font.GothamBold,
            Text = textboxName or 'TextBox',
            TextSize = 10,
            TextColor3 = Color3FromRGB(255, 255, 255),
            TextXAlignment = Enum.TextXAlignment.Left,
            RichText = true,
        })
        local textboxCover = CreateInstance('Frame', {
            Name = 'Cover',
            Parent = textboxFrame,
            BackgroundColor3 = Color3FromRGB(200, 10, 10),
            Position = NewUDim2(0.78, 0, 0.5, 0),
            Size = NewUDim2(0, 75, 0, 20),
            AnchorPoint = NewVector2(0.5, 0.5),
        })
        local textboxInput = CreateInstance('TextBox', {
            Name = 'Input',
            Parent = textboxCover,
            BackgroundColor3 = Color3FromRGB(10, 200, 10),
            BackgroundTransparency = 1,
            Position = NewUDim2(0.5, 0, 0.5, 0),
            AnchorPoint = NewVector2(0.5, 0.5),
            Size = NewUDim2(0, 75, 0, 20),
            ClipsDescendants = true,
            Font = Enum.Font.GothamBold,
            PlaceholderText = 'Any text!',
            PlaceholderColor3 = Color3FromRGB(255, 255, 255),
            Text = '',
            TextSize = 10,
            TextColor3 = Color3FromRGB(255, 255, 255),
            RichText = true,
        })

        callback = callback or function() end

        textboxInput.FocusLost:Connect(function()
            callback(textboxInput.Text)

            SavedConfig.Textbox[textboxName] = textboxInput.Text

            SaveConfig()
        end)
        AddUICorner(textboxFrame)
        AddUICorner(textboxCover)
        task.wait()

        if SavedConfig.Textbox[textboxName] and type(SavedConfig.Textbox[textboxName]) == 'string' then
            textboxInput.Text = SavedConfig.Textbox[textboxName]

            callback(textboxInput.Text)
        else
            SavedConfig.Textbox[textboxName] = textboxInput.Text
        end
    end
    function tabObj:CreateKeybind(KeybindName, defaultKey, callback)
        local keybindFrame = CreateInstance('Frame', {
            Name = KeybindName,
            Parent = tabContent,
            BackgroundColor3 = Color3FromRGB(10, 10, 200),
            Size = NewUDim2(0, 300, 0, 35),
        })
        local keybindTitleLabel = CreateInstance('TextLabel', {
            Name = 'Title',
            Parent = keybindFrame,
            BackgroundColor3 = Color3FromRGB(25, 25, 25),
            BackgroundTransparency = 1,
            Position = NewUDim2(0.2, 0, 0.5, 0),
            AnchorPoint = NewVector2(0.5, 0.5),
            Size = NewUDim2(0, 100, 0, 20),
            Font = Enum.Font.GothamBold,
            Text = KeybindName or 'Keybind',
            TextSize = 10,
            TextColor3 = Color3FromRGB(255, 255, 255),
            TextXAlignment = Enum.TextXAlignment.Left,
            RichText = true,
        })
        local keybindCover = CreateInstance('Frame', {
            Name = 'Cover',
            Parent = keybindFrame,
            BackgroundColor3 = Color3FromRGB(200, 10, 10),
            Position = NewUDim2(0.785, 0, 0.5, 0),
            Size = NewUDim2(0, 60, 0, 20),
            AnchorPoint = NewVector2(0.5, 0.5),
        })
        local keybindButton = CreateInstance('TextButton', {
            Name = 'Input',
            Parent = keybindCover,
            BackgroundColor3 = Color3FromRGB(10, 200, 10),
            BackgroundTransparency = 1,
            Position = NewUDim2(0.5, 0, 0.5, 0),
            AnchorPoint = NewVector2(0.5, 0.5),
            Size = NewUDim2(0, 100, 0, 20),
            Font = Enum.Font.GothamBold,
            Text = UserInputService:GetStringForKeyCode(defaultKey) or 'Press any Key!',
            TextSize = 11,
            TextColor3 = Color3FromRGB(255, 255, 255),
            RichText = true,
        })

        callback = callback or function() end

        AddUICorner(keybindFrame)
        AddUICorner(keybindCover)

        KeybindList[#KeybindList + 1] = {keybindButton, callback}

        keybindButton.MouseButton1Click:Connect(function()
            PlaySound('UI_Click')

            keybindButton.Text = 'Press any key!'
        end)
        task.wait()

        if SavedConfig.Keybind[KeybindName] and type(SavedConfig.Keybind[KeybindName]) == 'string' then
            keybindButton.Text = SavedConfig.Keybind[KeybindName]
        else
            SavedConfig.Keybind[KeybindName] = UserInputService:GetStringForKeyCode(defaultKey)
        end
    end
    function tabObj:CreateParagraph(paragraphTitle, paragraphText)
        local paragraphFrame = CreateInstance('Frame', {
            Name = paragraphTitle,
            Parent = tabContent,
            BackgroundColor3 = Color3FromRGB(10, 10, 200),
            Size = NewUDim2(0, 300, 0, 35),
            AutomaticSize = Enum.AutomaticSize.Y,
        })
        local paragraphTitleLabel = CreateInstance('TextLabel', {
            Name = 'Title',
            Parent = paragraphFrame,
            BackgroundColor3 = Color3FromRGB(25, 25, 25),
            BackgroundTransparency = 1,
            Position = NewUDim2(0.035, 0, 0, 5),
            Size = NewUDim2(0, 100, 0, 20),
            Font = Enum.Font.GothamBold,
            Text = paragraphTitle or 'Title',
            TextSize = 12,
            TextColor3 = Color3FromRGB(255, 255, 255),
            TextXAlignment = Enum.TextXAlignment.Left,
            RichText = true,
        })
        local paragraphTextLabel = CreateInstance('TextLabel', {
            Name = 'Fill',
            Parent = paragraphFrame,
            BackgroundColor3 = Color3FromRGB(35, 35, 35),
            BackgroundTransparency = 1,
            Position = NewUDim2(0.035, 0, 0, 30),
            Size = NewUDim2(0, 280, 0, 1),
            Font = Enum.Font.GothamBold,
            Text = (paragraphText or 'Text') .. '\n',
            TextSize = 11,
            TextWrapped = true,
            TextColor3 = Color3FromRGB(255, 255, 255),
            TextXAlignment = Enum.TextXAlignment.Left,
            AutomaticSize = Enum.AutomaticSize.Y,
            RichText = true,
        })

        AddUICorner(paragraphFrame)

        local paragraphMethods = {}

        function paragraphMethods:Update(newTitle, newText)
            paragraphTitleLabel.Text = newTitle
            paragraphTextLabel.Text = newText .. '\n'
        end

        task.wait()

        return paragraphMethods
    end
    function tabObj:CreateSection(sectionName)
        local sectionFrame = CreateInstance('Frame', {
            Name = sectionName,
            Parent = tabContent,
            BackgroundColor3 = Color3FromRGB(10, 10, 200),
            BackgroundTransparency = 1,
            Size = NewUDim2(0, 300, 0, 35),
        })
        local sectionTitleLabel = CreateInstance('TextLabel', {
            Name = 'Title',
            Parent = sectionFrame,
            BackgroundColor3 = Color3FromRGB(25, 25, 25),
            BackgroundTransparency = 1,
            Position = NewUDim2(0.0285, 0, 0, 5),
            Size = NewUDim2(0, 280, 0, 20),
            Font = Enum.Font.GothamBold,
            Text = '\u{300c} ' .. sectionName .. ' \u{300d}' or '\u{300c} Section \u{300d}',
            TextSize = 10,
            TextColor3 = Color3FromRGB(255, 255, 255),
            TextXAlignment = Enum.TextXAlignment.Center,
            RichText = true,
        })
        local sectionFill = CreateInstance('Frame', {
            Name = 'Fill',
            Parent = sectionFrame,
            BackgroundColor3 = Color3FromRGB(10, 225, 10),
            Position = NewUDim2(0.035, 0, 0, 30),
            Size = NewUDim2(0, 280, 0, 1),
        })

        AddUICorner(sectionFill)
        AddUICorner(sectionFill)
        task.wait()
    end
    function tabObj:CreateSlider(sliderName, minValue, maxValue, defaultKey, callback)
        local sliderFrame = CreateInstance('Frame', {
            Name = sliderName,
            Parent = tabContent,
            BackgroundColor3 = Color3FromRGB(10, 10, 200),
            Size = NewUDim2(0, 300, 0, 35),
        })
        local sliderTitleLabel = CreateInstance('TextLabel', {
            Name = 'Title',
            Parent = sliderFrame,
            BackgroundColor3 = Color3FromRGB(25, 25, 25),
            BackgroundTransparency = 1,
            Position = NewUDim2(0.035, 0, 0, 5),
            Size = NewUDim2(0, 100, 0, 20),
            Font = Enum.Font.GothamBold,
            Text = sliderName,
            TextSize = 10,
            TextColor3 = Color3FromRGB(255, 255, 255),
            TextXAlignment = Enum.TextXAlignment.Left,
            RichText = true,
        })
        local sliderValueLabel = CreateInstance('TextLabel', {
            Name = 'Value',
            Parent = sliderFrame,
            BackgroundColor3 = Color3FromRGB(220, 135, 65),
            BackgroundTransparency = 0,
            Position = NewUDim2(0.75, 0, 0, 5),
            Size = NewUDim2(0, 20, 0, 15),
            Font = Enum.Font.GothamBold,
            Text = ' 0 ',
            TextSize = 13,
            TextColor3 = Color3FromRGB(255, 255, 255),
            AutomaticSize = Enum.AutomaticSize.X,
            BorderColor3 = Color3FromRGB(10, 255, 10),
            BorderSizePixel = 1,
            RichText = true,
        })
        local sliderFill = CreateInstance('Frame', {
            Name = 'Fill',
            Parent = sliderFrame,
            BackgroundColor3 = Color3FromRGB(35, 35, 35),
            Position = NewUDim2(0.035, 0, 0, 30),
            Size = NewUDim2(0, 280, 0, 1),
        })
        local sliderButton = CreateInstance('ImageButton', {
            Name = 'Button',
            Parent = sliderFill,
            BackgroundColor3 = Color3FromRGB(255, 255, 255),
            AnchorPoint = NewVector2(0.5, 0.5),
            Position = NewUDim2(0.5, 0, 0.5, 0),
            Size = NewUDim2(0, 10, 0, 10),
        })
        local sliderMethods = {}

        AddUICorner(sliderButton, 20)
        AddUICorner(sliderFrame)
        AddUICorner(sliderValueLabel, 15)

        function sliderMethods:SetValue(sliderValue)
            sliderButton.Position = NewUDim2(0, (math.clamp(sliderValue, minValue, maxValue) - minValue) / maxValue * sliderFill.Size.X.Offset, 0.5, 0)
            sliderValueLabel.Text = ' ' .. sliderValue .. ' '

            callback(sliderValue)

            SavedConfig.Slider[sliderName] = sliderValue

            SaveConfig()
        end

        sliderButton.InputBegan:Connect(function(inputEvent)
            if inputEvent.UserInputType == Enum.UserInputType.MouseButton1 or inputEvent.UserInputType == Enum.UserInputType.Touch then
                local isDragging = true
                local startX = inputEvent.Position.X
                local startOffset = sliderButton.Position.X.Offset
                local absBaseX = sliderButton.AbsolutePosition.X - startOffset
                local steppedConn
                local changedConn

                steppedConn = RunService.Stepped:Connect(function()
                    if isDragging then
                        local clampedX = math.clamp(PlayerMouse.X - absBaseX - 3, 0, 280)
                        local sliderValue = math.round(minValue + (maxValue - minValue) * sliderButton.Position.X.Offset / (sliderFill.Size.X.Offset - 5))

                        if sliderValue > maxValue then
                            sliderValue = maxValue
                        end

                        sliderButton.Position = NewUDim2(0, clampedX, 0.5, 0)
                        sliderValueLabel.Text = ' ' .. sliderValue .. ' '

                        callback(sliderValue)

                        SavedConfig.Slider[sliderName] = sliderValue
                    else
                        steppedConn:Disconnect()
                    end
                end)
                changedConn = inputEvent.Changed:Connect(function()
                    if inputEvent.UserInputState == Enum.UserInputState.End then
                        isDragging = false

                        changedConn:Disconnect()
                        steppedConn:Disconnect()
                        SaveConfig()
                    end
                end)
            end
        end)

        if defaultKey < minValue then
            defaultKey = minValue
        elseif defaultKey > maxValue then
            defaultKey = maxValue
        end

        task.wait()

        if SavedConfig.Slider[sliderName] and type(tonumber(SavedConfig.Slider[sliderName])) == 'number' then
            sliderMethods:SetValue(tonumber(SavedConfig.Slider[sliderName]))
        else
            SavedConfig.Slider[sliderName] = defaultKey

            sliderMethods:SetValue(defaultKey)
        end

        return sliderMethods
    end
    function tabObj:CreateDropdown(dropdownName, options, callback)
        local dropdownFrame = CreateInstance('ImageButton', {
            Name = dropdownName,
            Parent = tabContent,
            BackgroundColor3 = Color3FromRGB(10, 10, 200),
            Size = NewUDim2(0, 300, 0, 35),
            AutomaticSize = Enum.AutomaticSize.Y,
        })
        local dropdownTitleLabel = CreateInstance('TextLabel', {
            Name = 'Title',
            Parent = dropdownFrame,
            BackgroundColor3 = Color3FromRGB(25, 25, 25),
            BackgroundTransparency = 1,
            Position = NewUDim2(0.035, 0, 0, 6),
            Size = NewUDim2(0, 35, 0, 20),
            Font = Enum.Font.GothamBold,
            Text = dropdownName or 'Dropdown',
            TextSize = 10,
            TextColor3 = Color3FromRGB(255, 255, 255),
            TextXAlignment = Enum.TextXAlignment.Left,
            AutomaticSize = Enum.AutomaticSize.XY,
            RichText = true,
        })
        local dropdownCurrent = CreateInstance('TextLabel', {
            Name = 'Input',
            Parent = dropdownFrame,
            BackgroundColor3 = Color3FromRGB(220, 135, 65),
            BackgroundTransparency = 1,
            Position = NewUDim2(0.65, 0, 0, 6),
            Size = NewUDim2(0, 85, 0, 20),
            Font = Enum.Font.GothamBold,
            Text = ' > ' .. options[1] .. ' ',
            TextSize = 10,
            TextWrapped = true,
            TextColor3 = Color3FromRGB(255, 255, 255),
            AutomaticSize = Enum.AutomaticSize.Y,
            BorderColor3 = Color3FromRGB(10, 255, 10),
            BorderSizePixel = 1,
            RichText = true,
        })
        local dropdownMenu = CreateInstance('ScrollingFrame', {
            Name = 'Menu',
            Parent = dropdownFrame,
            BackgroundColor3 = Color3FromRGB(35, 35, 35),
            Position = NewUDim2(0.035, 0, 0, 35),
            Size = NewUDim2(0, 280, 0, 0),
            Visible = false,
            ScrollBarThickness = 0,
            CanvasSize = NewUDim2(0, 0, 0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
        })
        local menuListLayout = CreateInstance('UIListLayout', {
            Name = 'UIListLayout',
            Parent = dropdownMenu,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = NewUDim(0.05, 0),
        })
        local Selected = options[1]
        local controlObj = false
        local dropdownAnimating = false
        local dropdownMethods = {}
        local tabObj = {}
        local menuHeight = 0

        callback = callback or function() end

        AddUICorner(dropdownFrame)
        AddUICorner(dropdownMenu)

        function dropdownMethods:Change(newOptions)
            menuHeight = 0

            for idx = 1, #tabObj do
                tabObj[idx]:Destroy()
            end

            tabObj = {}

            for idx = 1, #newOptions do
                local listItem = CreateInstance('TextButton', {
                    Name = 'List ' .. idx,
                    Parent = dropdownMenu,
                    BackgroundColor3 = Color3FromRGB(255, 255, 255),
                    BackgroundTransparency = 1,
                    Size = NewUDim2(0, 275, 0, 15),
                    Font = Enum.Font.GothamBold,
                    Text = newOptions[idx],
                    TextSize = 12,
                    TextColor3 = Selected == newOptions[idx] and Color3FromRGB(255, 255, 255) or Color3FromRGB(200, 200, 200),
                    TextXAlignment = Enum.TextXAlignment.Center,
                    RichText = true,
                })

                listItem.MouseButton1Click:Connect(function()
                    if not dropdownAnimating then
                        dropdownAnimating = true
                        controlObj = false
                        Selected = newOptions[idx]
                        dropdownCurrent.Text = ' > ' .. Selected .. ' '

                        callback(Selected)
                        PlaySound('UI_Click')

                        for jdx = 1, #tabObj do
                            tabObj[jdx].TextColor3 = Color3FromRGB(200, 200, 200)
                        end

                        listItem.TextColor3 = Color3FromRGB(255, 255, 255)

                        TweenAndPlay(dropdownMenu, NewTweenInfo(0.5), {
                            Size = NewUDim2(0, 280, 0, 0),
                        })
                        task.wait(0.5)

                        dropdownAnimating = false
                        dropdownMenu.Visible = false
                        SavedConfig.Dropdown[dropdownName] = Selected

                        SaveConfig()
                    end
                end)
                table.insert(tabObj, listItem)

                menuHeight = menuHeight + 21
            end
        end

        dropdownFrame.MouseButton1Click:Connect(function()
            PlaySound('UI_Click')

            if not dropdownAnimating then
                dropdownAnimating = true
                controlObj = not controlObj

                if controlObj then
                    dropdownMenu.Visible = true

                    TweenAndPlay(dropdownMenu, NewTweenInfo(0.5), {
                        Size = NewUDim2(0, 280, 0, menuHeight),
                    })
                    task.wait(0.5)

                    dropdownAnimating = false
                else
                    TweenAndPlay(dropdownMenu, NewTweenInfo(0.5), {
                        Size = NewUDim2(0, 280, 0, 0),
                    })
                    task.wait(0.5)

                    dropdownMenu.Visible = false
                    dropdownAnimating = false
                end
            end
        end)

        function dropdownMethods:Select(charArray)
            dropdownCurrent.Text = ' > ' .. charArray .. ' '
            Selected = charArray

            callback(charArray)
        end

        dropdownMethods:Change(options)
        task.wait()

        if SavedConfig.Dropdown[dropdownName] and type(SavedConfig.Dropdown[dropdownName]) == 'string' then
            dropdownCurrent.Text = ' > ' .. SavedConfig.Dropdown[dropdownName] .. ' '
            Selected = SavedConfig.Dropdown[dropdownName]

            callback(SavedConfig.Dropdown[dropdownName])
        else
            SavedConfig.Dropdown[dropdownName] = options[1]
        end

        return dropdownMethods
    end
    function tabObj:CreatePlayerDropdown(dropdownName, callback)
        local dropdownFrame = CreateInstance('ImageButton', {
            Name = dropdownName,
            Parent = tabContent,
            BackgroundColor3 = Color3FromRGB(10, 10, 200),
            Size = NewUDim2(0, 300, 0, 35),
            AutomaticSize = Enum.AutomaticSize.Y,
        })
        local dropdownTitleLabel = CreateInstance('TextLabel', {
            Name = 'Title',
            Parent = dropdownFrame,
            BackgroundColor3 = Color3FromRGB(25, 25, 25),
            BackgroundTransparency = 1,
            Position = NewUDim2(0.035, 0, 0, 6),
            Size = NewUDim2(0, 35, 0, 20),
            Font = Enum.Font.GothamBold,
            Text = dropdownName or 'Dropdown',
            TextSize = 10,
            TextColor3 = Color3FromRGB(255, 255, 255),
            TextXAlignment = Enum.TextXAlignment.Left,
            AutomaticSize = Enum.AutomaticSize.XY,
            RichText = true,
        })
        local dropdownCurrent = CreateInstance('TextLabel', {
            Name = 'Input',
            Parent = dropdownFrame,
            BackgroundColor3 = Color3FromRGB(220, 135, 65),
            BackgroundTransparency = 1,
            Position = NewUDim2(0.65, 0, 0, 6),
            Size = NewUDim2(0, 85, 0, 20),
            Font = Enum.Font.GothamBold,
            Text = ' > ' .. LocalPlayerName .. ' ',
            TextSize = 10,
            TextWrapped = true,
            TextColor3 = Color3FromRGB(255, 255, 255),
            AutomaticSize = Enum.AutomaticSize.Y,
            BorderColor3 = Color3FromRGB(10, 255, 10),
            BorderSizePixel = 1,
            RichText = true,
        })
        local dropdownMenu = CreateInstance('ScrollingFrame', {
            Name = 'Menu',
            Parent = dropdownFrame,
            BackgroundColor3 = Color3FromRGB(35, 35, 35),
            Position = NewUDim2(0.035, 0, 0, 35),
            Size = NewUDim2(0, 280, 0, 0),
            Visible = false,
            ScrollBarThickness = 0,
            CanvasSize = NewUDim2(0, 0, 0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
        })
        local menuListLayout = CreateInstance('UIListLayout', {
            Name = 'UIListLayout',
            Parent = dropdownMenu,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = NewUDim(0.05, 2),
        })
        local controlObj = false
        local dropdownAnimating = false
        local dropdownMethods = {}
        local tabObj = {}
        local menuHeight = 0

        callback = callback or function() end

        AddUICorner(dropdownFrame)
        AddUICorner(dropdownMenu)

        function dropdownMethods:Change(newOptions)
            menuHeight = 0

            for idx = 1, #tabObj do
                tabObj[idx]:Destroy()
            end

            tabObj = {}

            for idx = 1, #newOptions do
                local listItem = CreateInstance('TextButton', {
                    Name = 'List ' .. idx,
                    Parent = dropdownMenu,
                    BackgroundColor3 = Color3FromRGB(255, 255, 255),
                    BackgroundTransparency = 1,
                    Size = NewUDim2(0, 275, 0, 15),
                    Font = Enum.Font.GothamBold,
                    Text = newOptions[idx].Name,
                    TextSize = 12,
                    TextColor3 = Selected == newOptions[idx] and Color3FromRGB(255, 255, 255) or Color3FromRGB(200, 200, 200),
                    TextXAlignment = Enum.TextXAlignment.Center,
                })

                listItem.MouseButton1Click:Connect(function()
                    if not dropdownAnimating then
                        dropdownAnimating = true
                        controlObj = false
                        dropdownCurrent.Text = ' > ' .. newOptions[idx].Name .. ' '

                        callback(newOptions[idx])
                        PlaySound('UI_Click')

                        for jdx = 1, #tabObj do
                            tabObj[jdx].TextColor3 = Color3FromRGB(200, 200, 200)
                        end

                        listItem.TextColor3 = Color3FromRGB(255, 255, 255)

                        TweenAndPlay(dropdownMenu, NewTweenInfo(0.5), {
                            Size = NewUDim2(0, 280, 0, 0),
                        })
                        task.wait(0.5)

                        dropdownAnimating = false
                        dropdownMenu.Visible = false
                    end
                end)
                table.insert(tabObj, listItem)

                menuHeight = menuHeight + 21
            end
        end

        dropdownFrame.MouseButton1Click:Connect(function()
            PlaySound('UI_Click')

            if not dropdownAnimating then
                dropdownAnimating = true
                controlObj = not controlObj

                if controlObj then
                    dropdownMenu.Visible = true

                    TweenAndPlay(dropdownMenu, NewTweenInfo(0.5), {
                        Size = NewUDim2(0, 280, 0, menuHeight),
                    })
                    task.wait(0.5)

                    dropdownAnimating = false
                else
                    TweenAndPlay(dropdownMenu, NewTweenInfo(0.5), {
                        Size = NewUDim2(0, 280, 0, 0),
                    })
                    task.wait(0.5)

                    dropdownMenu.Visible = false
                    dropdownAnimating = false
                end
            end
        end)
        dropdownMethods:Change(Players:GetPlayers())

        PlayerDropdownList[#PlayerDropdownList + 1] = dropdownMethods

        task.wait()
    end

    return tabObj
end
function Library:Init()
    local introFrame = CreateInstance('Frame', {
        Name = 'Intro',
        Parent = Gui,
        BackgroundColor3 = Color3FromRGB(0, 0, 0),
        Position = NewUDim2(0.5, 0, -0.5, 0),
        Size = NewUDim2(0, 400, 0, 250),
        AnchorPoint = NewVector2(0.5, 0.5),
    })
    local introLogo = CreateInstance('ImageLabel', {
        Name = 'Logo',
        Parent = introFrame,
        BackgroundColor3 = Color3FromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Position = NewUDim2(0.5, 0, 0.35, 0),
        Size = NewUDim2(0, 175, 0, 175),
        Image = 'rbxassetid://17415725290',
        ImageTransparency = 1,
        AnchorPoint = NewVector2(0.5, 0.5),
    })
    local statusText = CreateInstance('TextLabel', {
        Name = 'Text',
        Parent = introFrame,
        BackgroundColor3 = Color3FromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Position = NewUDim2(0.5, 0, 0.9, 0),
        Size = NewUDim2(0, 385, 0, 20),
        Font = Enum.Font.Code,
        Text = 'Processing UNC <font color="rgb(255, 0, 0)">(0/100)</font>',
        TextSize = 14,
        TextColor3 = Color3FromRGB(255, 255, 255),
        TextTransparency = 1,
        TextWrapped = true,
        TextYAlignment = Enum.TextYAlignment.Top,
        RichText = true,
        AnchorPoint = NewVector2(0.5, 0.5),
    })
    local copyrightLabel = CreateInstance('TextLabel', {
        Name = 'Copyright',
        Parent = introFrame,
        BackgroundColor3 = Color3FromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Position = NewUDim2(0.15, 0, 0.85, 0),
        Size = NewUDim2(0, 75, 0, 20),
        Font = Enum.Font.Gotham,
        Text = '\u{a9} Symphony Hub',
        TextSize = 14,
        TextColor3 = Color3FromRGB(255, 255, 255),
        TextTransparency = 1,
        AnchorPoint = NewVector2(0.5, 0.5),
    })
    local blurEffect = CreateInstance('BlurEffect', {
        Name = 'SH Blur Effect',
        Parent = workspace.CurrentCamera,
        Size = 18,
    })

    DatastoreLib:Authorize('76e26f63-e422-420f-9e6a-8cb58e56b8c8')
    AddUICorner(introFrame)
    ParentToGui(Gui)

    aU.Parent = introFrame

    task.wait(1)
    TweenAndPlay(introFrame, NewTweenInfo(0.75, Enum.EasingStyle.Elastic, Enum.EasingDirection.InOut), {
        Position = NewUDim2(0.5, 0, 0.5, 0),
    })
    task.wait(1)
    TweenAndPlay(introLogo, NewTweenInfo(0.5), {
        ImageTransparency = 0.25,
        Position = NewUDim2(0.5, 0, 0.45, 0),
        Size = NewUDim2(0, 225, 0, 225),
    })
    TweenAndPlay(copyrightLabel, NewTweenInfo(0.5), {
        TextTransparency = 0,
        Position = NewUDim2(0.15, 0, 0.95, 0),
    })
    TweenAndPlay(statusText, NewTweenInfo(0.5), {
        TextTransparency = 0,
        Position = NewUDim2(0.5, 0, 0.8, 0),
    })

    for idx = 1, #UncFunctionsList do
        task.wait(0.1)

        if UncFunctionsList[idx] then
            local progressPercent = idx / #UncFunctionsList * 100

            if progressPercent ~= 100 then
                statusText.Text = 'Processing UNC <font color="rgb(255, 0, 0)">(' .. math.floor(progressPercent) .. '/100)</font>'
            else
                statusText.Text = 'Processing UNC <font color="rgb(0, 255, 0)">(' .. math.floor(progressPercent) .. '/100)</font>'
            end
        else
            statusText.Text = 'UNC Process Failed!\nPlease switch your executor that are capable.'

            return
        end
    end

    PingServer()
    task.wait()

    local totalSteps = 7
    local progressPercent = 0 / totalSteps * 100

    statusText.Text = 'Processing Data Resources <font color="rgb(255, 0, 0)">(' .. math.floor(progressPercent) .. '/100)</font>'

    local retryCount = 0

    repeat
        task.wait()

        local pcallOk, pcallErr = pcall(function()
            if Players:GetNameFromUserIdAsync(LocalPlayerId) == LocalPlayerName then
                local passCheckResult = HttpService:JSONDecode(AuthorizedRequest('https://symphonyhub.onrender.com/script/checkpass/' .. LocalPlayerId .. '/22739804', 'POST'))

                HasPremium = passCheckResult.owned
            else
                statusText.Text = 'Data Process Failed!\nBypassing Premium can leads into a permanent ban.'

                return
            end
        end)

        if pcallErr then
            retryCount = retryCount + 1

            if retryCount >= 50 then
                HasPremium = false
            end
        end
    until HasPremium ~= nil

    task.wait()

    progressPercent = 1 / totalSteps * 100
    statusText.Text = 'Processing Data Resources <font color="rgb(255, 0, 0)">(' .. math.floor(progressPercent) .. '/100)</font>'
    retryCount = 0

    repeat
        task.wait(0.15)

        local pcallOk, pcallErr = pcall(function()
            GameName = MarketplaceService:GetProductInfo(game.PlaceId).Name
        end)

        if pcallErr then
            retryCount = retryCount + 1

            if retryCount >= 50 then
                GameName = 'Not Found'
            end
        end
    until GameName ~= nil

    task.wait()

    progressPercent = 2 / totalSteps * 100
    statusText.Text = 'Processing Data Resources <font color="rgb(255, 0, 0)">(' .. math.floor(progressPercent) .. '/100)</font>'

    local banCheckPassed

    retryCount = 0

    repeat
        task.wait()

        local pcallOk, pcallErr = pcall(function()
            if Players:GetNameFromUserIdAsync(LocalPlayerId) == LocalPlayerName then
                local banReason = DatastoreLib and DatastoreLib:GetStore(tostring(LocalPlayerId), '/bans')

                if banReason then
                    statusText.Text = 'You have been Permanently Banned in <font color="rgb(0, 255, 0)">Symphony Hub</font>\nReason: ' .. banReason

                    return
                else
                    banCheckPassed = true
                end
            else
                statusText.Text = 'Data Process Failed!\nBypassing Premium can leads into a permanent ban.'

                return
            end
        end)

        if pcallErr then
            retryCount = retryCount + 1

            if retryCount >= 50 then
                statusText.Text = 'Data Process Failed!\nFailed to find your HWID.'

                return
            end
        end
    until banCheckPassed

    task.wait()

    progressPercent = 3 / totalSteps * 100
    statusText.Text = 'Processing Data Resources <font color="rgb(255, 0, 0)">(' .. math.floor(progressPercent) .. '/100)</font>'
    retryCount = 0

    repeat
        task.wait()

        local pcallOk, pcallErr = pcall(function()
            if Players:GetNameFromUserIdAsync(LocalPlayerId) == LocalPlayerName then
                IsContentCreator = DatastoreLib and DatastoreLib:GetStore(tostring(LocalPlayerId), '/contentcreator') or false
            else
                statusText.Text = 'Data Process Failed!\nBypassing Premium can leads into a permanent ban.'

                return
            end
        end)

        if pcallErr then
            retryCount = retryCount + 1

            if retryCount >= 50 then
                statusText.Text = 'Data Process Failed!\nFailed to find your HWID.'

                return
            end
        end
    until IsContentCreator ~= nil

    task.wait()

    progressPercent = 4 / totalSteps * 100
    statusText.Text = 'Processing Data Resources <font color="rgb(255, 0, 0)">(' .. math.floor(progressPercent) .. '/100)</font>'
    retryCount = 0

    repeat
        task.wait()

        local pcallOk, pcallErr = pcall(function()
            if Players:GetNameFromUserIdAsync(LocalPlayerId) == LocalPlayerName then
                local creatorData = DatastoreLib and DatastoreLib:GetStore('contentcreator', '/')

                if creatorData then
                    local userIdList = {}

                    for idx, propValue in pairs(creatorData)do
                        userIdList[#userIdList + 1] = tonumber(idx)
                    end

                    ContentCreatorList = UserService:GetUserInfosByUserIdsAsync(userIdList)
                else
                    ContentCreatorList = {}
                end
            else
                statusText.Text = 'Data Process Failed!\nBypassing Premium can leads into a permanent ban.'

                return
            end
        end)

        if pcallErr then
            retryCount = retryCount + 1

            if retryCount >= 50 then
                statusText.Text = 'Data Process Failed!\nFailed to find your HWID.'

                return
            end
        end
    until ContentCreatorList ~= nil

    task.wait()

    progressPercent = 5 / totalSteps * 100
    statusText.Text = 'Processing Data Resources <font color="rgb(255, 0, 0)">(' .. math.floor(progressPercent) .. '/100)</font>'

    task.wait(0.5)

    if EnsureMainFolder() then
        progressPercent = 6 / totalSteps * 100
        statusText.Text = 'Processing Data Resources <font color="rgb(255, 0, 0)">(' .. math.floor(progressPercent) .. '/100)</font>'

        PingServer()
    else
        statusText.Text = 'Data Process Failed!\nYour executor occured an unexpected errors.'

        return
    end

    task.wait()

    local webhookResult = false

    retryCount = 0

    repeat
        task.wait()

        local pcallOk, pcallErr = pcall(function()
            if Players:GetNameFromUserIdAsync(LocalPlayerId) == LocalPlayerName then
                webhookResult = HttpRequest({
                    Url = 'https://discord.com/api/webhooks/1242307963364835349/_Cm1vW6WTKZS2xMxQORljItcm08QSRQzWLDw3-Zc8PFjz_PAo5JotODPuSnMB0MlSfu6',
                    Method = 'POST',
                    Headers = {
                        ['Content-Type'] = 'application/json',
                    },
                    Body = HttpService:JSONEncode({
                        content = '',
                        embeds = {
                            {
                                title = 'Software API',
                                description = 'Game: **' .. GameName .. '**\nPlace Id: **' .. game.PlaceId .. '**\nServer Id: **' .. game.JobId .. '**\nExecutor: **' .. identifyexecutor() .. '**\nPremium: **' .. (HasPremium and 'Yes' or 'No') .. '**\nContent Creator: **' .. (IsContentCreator and 'Yes' or 'No') .. '**',
                                type = 'rich',
                                color = 0xff,
                            },
                        },
                        avatar_url = HttpService:JSONDecode(HttpGetRequest('https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds=' .. LocalPlayerId .. '&size=420x420&format=Png&isCircular=false')).data[1].imageUrl,
                        username = LocalPlayerName,
                    }),
                }).Body
            else
                statusText.Text = 'Data Process Failed!\nBypassing Premium can leads into a permanent ban.'

                return
            end
        end)

        if pcallErr then
            retryCount = retryCount + 1

            if retryCount >= 50 then
                statusText.Text = 'Data Process Failed!\nThere is a problem in our API endpoint, the owner will\nfix this soon.'

                return
            end
        end
    until webhookResult

    progressPercent = 7 / totalSteps * 100
    statusText.Text = 'Processing Data Resources <font color="rgb(0, 255, 0)">(' .. math.floor(progressPercent) .. '/100)</font>'

    task.wait(0.5)

    if not HasPremium then
        statusText.Text = 'Checking Key System...'

        task.wait(0.5)
        EnsureFile(HubFolderName .. '/authenticate.shf', 'symphony hub key goes here')

        if isfile(HubFolderName .. '/authenticate.shf') and ValidateKey(SafeReadFile(HubFolderName .. '/authenticate.shf')) then
            PingServer()
        else
            local keyInput = CreateInstance('TextBox', {
                Name = 'KeyInput',
                Parent = introFrame,
                BackgroundColor3 = Color3FromRGB(0, 0, 225),
                BackgroundTransparency = 1,
                Position = NewUDim2(0.5, 0, 0.4, 0),
                Size = NewUDim2(0, 225, 0, 25),
                ClearTextOnFocus = false,
                PlaceholderText = ' Enter Key...',
                PlaceholderColor3 = Color3FromRGB(255, 255, 255),
                Font = Enum.Font.SourceSans,
                Text = '',
                TextSize = 14,
                TextColor3 = Color3FromRGB(255, 255, 255),
                TextTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                AnchorPoint = NewVector2(0.5, 0.5),
            })
            local getKeyButton = CreateInstance('TextButton', {
                Name = 'GetKey',
                Parent = introFrame,
                BackgroundColor3 = Color3FromRGB(0, 0, 225),
                BackgroundTransparency = 1,
                Position = NewUDim2(0.3, 0, 0.8, 0),
                Size = NewUDim2(0, 55, 0, 30),
                Font = Enum.Font.SourceSans,
                Text = 'Get Key',
                TextSize = 17,
                TextColor3 = Color3FromRGB(255, 255, 255),
                TextTransparency = 1,
                AnchorPoint = NewVector2(0.5, 0.5),
            })
            local loginButton = CreateInstance('TextButton', {
                Name = 'Login',
                Parent = introFrame,
                BackgroundColor3 = Color3FromRGB(0, 0, 225),
                BackgroundTransparency = 1,
                Position = NewUDim2(0.7, 0, 0.8, 0),
                Size = NewUDim2(0, 55, 0, 30),
                Font = Enum.Font.SourceSans,
                Text = 'Login',
                TextSize = 17,
                TextColor3 = Color3FromRGB(255, 255, 255),
                TextTransparency = 1,
                AnchorPoint = NewVector2(0.5, 0.5),
            })
            local keyAccepted = false
            local loginCooldown = false

            AddUICorner(keyInput)
            AddUICorner(loginButton)
            AddUICorner(getKeyButton)
            loginButton.MouseButton1Click:Connect(function()
                if not loginCooldown then
                    loginCooldown = true

                    local isValidKey = ValidateKey(keyInput.Text)

                    if isValidKey then
                        writefile(HubFolderName .. '/authenticate.shf', keyInput.Text)
                        TweenAndPlay(keyInput, NewTweenInfo(0.5), {
                            TextTransparency = 1,
                            BackgroundTransparency = 1,
                            Position = NewUDim2(0.5, 0, 0.4, 0),
                        })
                        TweenAndPlay(getKeyButton, NewTweenInfo(0.5), {
                            TextTransparency = 1,
                            BackgroundTransparency = 1,
                            Position = NewUDim2(0.3, 0, 0.8, 0),
                        })
                        TweenAndPlay(loginButton, NewTweenInfo(0.5), {
                            TextTransparency = 1,
                            BackgroundTransparency = 1,
                            Position = NewUDim2(0.7, 0, 0.8, 0),
                        })
                        TweenAndPlay(statusText, NewTweenInfo(0.5), {
                            TextTransparency = 0,
                            Position = NewUDim2(0.5, 0, 0.8, 0),
                        })
                        TweenAndPlay(introLogo, NewTweenInfo(0.5), {
                            ImageTransparency = 0,
                            Position = NewUDim2(0.5, 0, 0.45, 0),
                            Size = NewUDim2(0, 225, 0, 225),
                        })
                        task.wait(0.5)

                        keyInput.Visible = false
                        getKeyButton.Visible = false
                        loginButton.Visible = false

                        PingServer()

                        keyAccepted = true
                    else
                        loginButton.BackgroundColor3 = Color3FromRGB(255, 0, 0)

                        task.wait(0.5)

                        loginButton.BackgroundColor3 = Color3FromRGB(0, 0, 225)
                    end

                    loginCooldown = false
                end
            end)
            getKeyButton.MouseButton1Click:Connect(function()
                SetClipboard('https://gateway.platoboost.com/a/15908?id=' .. StringToHex(LocalPlayerId))
            end)
            TweenAndPlay(statusText, NewTweenInfo(0.5), {
                TextTransparency = 1,
                Position = NewUDim2(0.5, 0, 0.9, 0),
            })
            TweenAndPlay(introLogo, NewTweenInfo(0.5), {
                Position = NewUDim2(0.5, 0, 0.25, 0),
                Size = NewUDim2(0, 75, 0, 75),
            })
            TweenAndPlay(keyInput, NewTweenInfo(0.5), {
                TextTransparency = 0,
                BackgroundTransparency = 0.75,
                Position = NewUDim2(0.5, 0, 0.5, 0),
            })
            TweenAndPlay(getKeyButton, NewTweenInfo(0.5), {
                TextTransparency = 0,
                BackgroundTransparency = 0,
                Position = NewUDim2(0.3, 0, 0.7, 0),
            })
            TweenAndPlay(loginButton, NewTweenInfo(0.5), {
                TextTransparency = 0,
                BackgroundTransparency = 0,
                Position = NewUDim2(0.7, 0, 0.7, 0),
            })

            while not keyAccepted do
                task.wait()
            end
        end
    else
        PingServer()
    end

    task.wait(0.5)

    statusText.Text = 'Initializing Gui...'

    task.wait(2)
    TweenAndPlay(introLogo, NewTweenInfo(0.5), {
        ImageTransparency = 1,
        BackgroundTransparency = 1,
        Position = NewUDim2(0.5, 0, 0.35, 0),
        Size = NewUDim2(0, 175, 0, 175),
    })
    TweenAndPlay(copyrightLabel, NewTweenInfo(0.5), {
        TextTransparency = 1,
        Position = NewUDim2(0.15, 0, 0.85, 0),
    })
    TweenAndPlay(statusText, NewTweenInfo(0.5), {
        TextTransparency = 1,
        Position = NewUDim2(0.5, 0, 0.9, 0),
    })
    task.wait(0.5)
    TweenAndPlay(introFrame, NewTweenInfo(0.75, Enum.EasingStyle.Elastic, Enum.EasingDirection.InOut), {
        Position = NewUDim2(0.5, 0, -0.5, 0),
    })
    task.wait(1)

    aU.Parent = aS

    blurEffect:Destroy()
    introFrame:Destroy()
    PingServer()

    for idx = 1, #PreloadCallbacks do
        task.spawn(PreloadCallbacks[idx], Gui, GameName, DatastoreLib)
    end

    for idx, propValue in pairs(GameCallbacks)do
        if game.PlaceId == idx then
            AddUICorner(aT)
            AddUICorner(aV)
            AddUICorner(aW)
            AddUICorner(aR, 20)

            aS.Visible = true
            aR.Visible = true
            HubTitleLabel.Text = 'Symphony Hub - ' .. GameName

            aR.MouseButton1Click:Connect(function()
                PlaySound('UI_Click')

                if not IsAnimatingUI then
                    IsAnimatingUI = true

                    if aS.Visible then
                        TweenAndPlay(aS, NewTweenInfo(0.5), {GroupTransparency = 1}).Completed:Wait()

                        aS.Visible = false
                    else
                        aS.Visible = true

                        TweenAndPlay(aS, NewTweenInfo(0.5), {GroupTransparency = 0}).Completed:Wait()
                    end

                    IsAnimatingUI = false
                end
            end)
            Players.PlayerAdded:Connect(function()
                for idx = 1, #PlayerDropdownList do
                    PlayerDropdownList[idx]:Change(Players:GetPlayers())
                end
            end)
            Players.PlayerRemoving:Connect(function()
                for idx = 1, #PlayerDropdownList do
                    PlayerDropdownList[idx]:Change(Players:GetPlayers())
                end
            end)
            UserInputService.InputBegan:Connect(function(inputObj, gameProcessedFlag)
                if inputObj.KeyCode ~= Enum.KeyCode.Unknown and not gameProcessedFlag then
                    if inputObj.KeyCode == Enum.KeyCode.M then
                        PlaySound('UI_Click')

                        if not IsAnimatingUI then
                            IsAnimatingUI = true

                            if aS.Visible then
                                TweenAndPlay(aS, NewTweenInfo(0.5), {GroupTransparency = 1}).Completed:Wait()

                                aS.Visible = false
                            else
                                aS.Visible = true

                                TweenAndPlay(aS, NewTweenInfo(0.5), {GroupTransparency = 0}).Completed:Wait()
                            end

                            IsAnimatingUI = false
                        end
                    else
                        for idx = 1, #KeybindList do
                            if KeybindList[idx][1].Text == 'Press any key!' then
                                KeybindList[idx][1].Text = UserInputService:GetStringForKeyCode(inputObj.KeyCode)
                                SavedConfig.Keybind[KeybindName] = UserInputService:GetStringForKeyCode(inputObj.KeyCode)

                                SaveConfig()
                            else
                                if KeybindList[idx][1].Text == UserInputService:GetStringForKeyCode(inputObj.KeyCode) then
                                    KeybindList[idx][2]()
                                end
                            end
                        end
                    end
                end
            end)

            FolderReady = EnsureMainFolder()

            if FolderReady then
                EnsureFolder(HubFolderName .. '/Configs')
                EnsureFolder(HubFolderName .. '/Modules')
                EnsureFolder(HubFolderName .. '/SFX')
                EnsureFolder(HubFolderName .. '/Images')
                EnsureFolder(HubFolderName .. '/Logs')
                EnsureFile(HubFolderName .. '/Configs/' .. game.PlaceId .. '.shf', EncryptString(HttpService:JSONEncode(SavedConfig)))
                EnsureFile(HubFolderName .. '/SFX/notice.txt', 'in here you could edit any sound by just deleting the original one and put the new one then rename it with the original file name.')
                EnsureFile(HubFolderName .. '/Modules/debug.lua', 'if not debug then\n\terror("Unsupported Exploit!")\nend\n\nreturn debug -- Crazy ahh just quit skidding lmao.')
                EnsureFile(HubFolderName .. '/Configs/notice.txt', 'Hello User!\n\nIf you want to edit your Configs sorry but all of those files are encrypted :( but you can Direct Message the owner for Config Decompile, if you get no response in time that means the owner is busy nor sleeping.\n\n-- Symphony Hub Team')

                local parsedConfig
                local pcallOk, pcallErr = pcall(function()
                    parsedConfig = HttpService:JSONDecode(DecryptString(readfile(HubFolderName .. '/Configs/' .. game.PlaceId .. '.shf')))
                end)

                if pcallOk then
                    SavedConfig = parsedConfig
                else
                    SaveConfig()
                end

                local resourceList = HttpService:JSONDecode(HttpGetRequest(ResourceBaseUrl .. '/properties.json'))

                for jdx = 1, #resourceList do
                    EnsureFile(HubFolderName .. resourceList[jdx], HttpGetRequest(ResourceBaseUrl .. resourceList[jdx]))
                end

                local monthNames = {
                    'January',
                    'February',
                    'March',
                    'April',
                    'May',
                    'June',
                    'July',
                    'August',
                    'September',
                    'October',
                    'November',
                    'December',
                }
                local currentDate = os.date('*t')
                local logFileName = string.format('%s_%s_%s.log', currentDate.month, currentDate.day, currentDate.year)

                EnsureFile(HubFolderName .. '/Logs/' .. logFileName, '[SH] Log created since ' .. monthNames[currentDate.month] .. ' ' .. currentDate.day .. ', ' .. currentDate.year .. ' at Time ' .. currentDate.hour .. ':' .. currentDate.min .. ':' .. currentDate.sec .. ' using ' .. identifyexecutor() .. '!')

                if isfile(HubFolderName .. '/Logs/' .. logFileName) then
                    writefile(HubFolderName .. '/Logs/' .. logFileName, readfile(HubFolderName .. '/Logs/' .. logFileName) .. '\n[SH] Script Executed at Time ' .. currentDate.hour .. ':' .. currentDate.min .. ':' .. currentDate.sec .. '!')
                end

                local sfxFiles = isfolder(HubFolderName .. '/SFX') and listfiles(HubFolderName .. '/SFX') or {}

                for jdx = 1, #sfxFiles do
                    local normalizedPath = sfxFiles[jdx]:gsub('\\', '/')
                    local pathParts = normalizedPath:split('/')

                    pathParts = pathParts[#pathParts]

                    if string.sub(pathParts, string.len(pathParts) - 3, string.len(pathParts)) == '.mp3' then
                        local soundFileName = string.sub(pathParts, 1, string.len(pathParts) - 4)

                        for kdx = 1, 3 do
                            SoundRegistry[soundFileName] = GetCustomAsset(normalizedPath)
                        end
                    end
                end
            else
                ShowNotification('Symphony Hub are currently unstable due to ' .. (type(identifyexecutor) == 'function' and identifyexecutor() or 'your executor') .. "'s environment function errors, therefore we cannot save/load your configs for now.", 10)
            end

            PingServer()

            local mainTab = Library:CreateTab('Main', 'rbxassetid://13669672334')
            local changelogs = HttpService:JSONDecode(AuthorizedRequest('https://symphonyhub.onrender.com/script/getchangelogs', 'POST'))

            if DatastoreLib then
                local currentPing = math.floor(StatsService.Network.ServerStatsItem['Data Ping']:GetValue())
                local loginCount = DatastoreLib:GetStore('scriptlogins', '/')

                loginCount = loginCount and tonumber(loginCount) and tonumber(loginCount) + 1 or 1

                DatastoreLib:SetStore('scriptlogins', loginCount, '/')

                local contentCreatorCount = 0

                for jdx, unused in pairs(DatastoreLib:GetStore('contentcreator', '/'))do
                    contentCreatorCount = contentCreatorCount + 1
                end

                loginCount = FormatLargeNumber(loginCount)
                contentCreatorCount = FormatLargeNumber(contentCreatorCount)

                local scriptInfoLabel = mainTab:CreateParagraph('Script Info', 'Premium: ' .. (HasPremium and '<font color="rgb(0, 255, 0)">Yes</font>' or '<font color="rgb(255, 0, 0)">No</font>') .. '\nPing: ' .. (currentPing >= 30 and '<font color="rgb(0, 255, 0)">' or '<font color="rgb(255, 0, 0)">') .. currentPing .. '</font>\n\nTotal Global User Logins: <font color="rgb(0, 255, 0)">' .. loginCount .. '</font>\nTotal Content Creators: <font color="rgb(0, 255, 0)">' .. contentCreatorCount .. '</font>')

                RunService.RenderStepped:Connect(function()
                    currentPing = math.floor(StatsService.Network.ServerStatsItem['Data Ping']:GetValue())

                    scriptInfoLabel:Update('Script Info', 'Premium: ' .. (HasPremium and '<font color="rgb(0, 255, 0)">Yes</font>' or '<font color="rgb(255, 0, 0)">No</font>') .. '\nPing: ' .. (currentPing >= 30 and '<font color="rgb(0, 255, 0)">' or '<font color="rgb(255, 0, 0)">') .. currentPing .. '</font>\n\nTotal Global User Logins: <font color="rgb(0, 255, 0)">' .. loginCount .. '</font>\nTotal Content Creators: <font color="rgb(0, 255, 0)">' .. contentCreatorCount .. '</font>')
                end)
            end

            for jdx = 1, #changelogs do
                local changelogText = 'Changelog - <font color="rgb(0, 225, 0)">' .. changelogs[jdx].version .. '</font>:'

                for changelogCategory, propValue in pairs(changelogs[jdx].description)do
                    changelogText = changelogText .. '\n\n<font color="rgb(255, 0, 0)">[+]</font> <font color="rgb(0, 200, 0)">' .. changelogCategory .. '</font>'

                    for kdx = 1, #propValue do
                        changelogText = changelogText .. '\n    <font color="rgb(0, 255, 0)">(+)</font> ' .. propValue[kdx]
                    end
                end

                mainTab:CreateParagraph('Patch Note', changelogText)
            end
            for jdx = 1, #OnLoadCallbacks do
                task.spawn(OnLoadCallbacks[jdx], LocalPlayerName, LocalPlayerId, HasPremium, IsContentCreator, ContentCreatorList, StringToHex(LocalPlayerId))
            end

            task.wait(1)
            coroutine.wrap(function()
                while true do
                    task.wait(45)
                    PingServer()
                end
            end)()

            aR.Draggable = true

            task.spawn(propValue)
            task.wait(3)
            SaveConfig()

            return
        end
    end

    ShowNotification('Game not supported.')
end
function Library:Compile(inputText)
    return EncryptString(inputText)
end
function Library:Decompile(inputText)
    return DecryptString(inputText)
end
function Library:OnGameInvoke(placeId, callback)
    GameCallbacks[placeId or 1] = callback or function() end
end
function Library:OnPreload(callback)
    PreloadCallbacks[#PreloadCallbacks + 1] = callback or function() end
end
function Library:OnLoad(callback)
    OnLoadCallbacks[#OnLoadCallbacks + 1] = callback or function() end
end

return Library
