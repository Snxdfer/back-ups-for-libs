--[[
Orion Library - made by: shlexware/jensonhirst
Modified by: 00Fazee (elrandom#1311) | discord.gg/jB4yJgn3pE
Last Modified: 19/10/2026 | dd/mm/yy
]]--

local function missing(ExpectedType, Candidate, Fallback)
    if type(Candidate) == ExpectedType then
        return Candidate
    end
    return Fallback
end

local function FirstFunction(...)
    for Index = 1, select("#", ...) do
        local Candidate = select(Index, ...)
        if type(Candidate) == "function" then
            return Candidate
        end
    end
    return nil
end

local ExecutorAPIs = {
    cloneref = missing("function", cloneref, function(Value) return Value end),
    gethui = FirstFunction(gethui, get_hidden_gui),
    protectGui = FirstFunction(
        type(syn) == "table" and syn.protect_gui or nil,
        protect_gui,
        protectgui
    ),
    request = FirstFunction(
        request,
        http_request,
        type(syn) == "table" and syn.request or nil,
        type(http) == "table" and http.request or nil,
        type(fluxus) == "table" and fluxus.request or nil
    ),
    getCustomAsset = FirstFunction(getcustomasset, getsynasset),
    readfile = FirstFunction(readfile),
    writefile = FirstFunction(writefile),
    isfile = FirstFunction(isfile),
    isfolder = FirstFunction(isfolder),
    makefolder = FirstFunction(makefolder)
}



local Services = {}
local function GetService(ServiceName)
    if Services[ServiceName] then
        return Services[ServiceName]
    end

    local Success, Service = pcall(function()
        return game:GetService(ServiceName)
    end)
    if not Success or not Service then
        error("Orion Library: Could not resolve Roblox service '" .. tostring(ServiceName) .. "'.")
    end

    local ReferenceSuccess, Reference = pcall(ExecutorAPIs.cloneref, Service)
    if ReferenceSuccess and Reference then
        Service = Reference
    end

    Services[ServiceName] = Service
    return Service
end

local UserInputService = GetService("UserInputService")
local TweenService = GetService("TweenService")
local RunService = GetService("RunService")
local Players = GetService("Players")
local HttpService = GetService("HttpService")
local GuiService
pcall(function() GuiService = GetService("GuiService") end)
local CoreGui
pcall(function() CoreGui = GetService("CoreGui") end)
local LocalPlayer = Players.LocalPlayer

if not LocalPlayer then
    error("Orion Library: LocalPlayer is unavailable in this execution context.")
end

local Mouse
pcall(function()
    Mouse = LocalPlayer:GetMouse()
end)

local function ResolvePlayerGui()
    local Success, PlayerGui = pcall(function()
        return LocalPlayer:FindFirstChildWhichIsA("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui", 5)
    end)
    if Success then
        return PlayerGui
    end
    return nil
end

local PlayerGui = ResolvePlayerGui()



local function DetectMobile()
    local Success, Platform = pcall(function()
        return UserInputService:GetPlatform()
    end)
    if Success then
        return Platform == Enum.Platform.Android or Platform == Enum.Platform.IOS
    end
    return UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
end

local IsOnMobile = DetectMobile()

local function SafeReadFile(Path)
    if not ExecutorAPIs.readfile then
        return false, "readfile is unavailable"
    end
    local Success, Content = pcall(ExecutorAPIs.readfile, Path)
    return Success, Content
end

local function SafeIsFile(Path)
    if ExecutorAPIs.isfile then
        local Success, Exists = pcall(ExecutorAPIs.isfile, Path)
        if Success then
            return Exists == true
        end
    end



    local Success, Content = SafeReadFile(Path)
    return Success and Content ~= nil and Content ~= ""
end

local function SafeIsFolder(Path)
    if not ExecutorAPIs.isfolder then
        return nil
    end
    local Success, Exists = pcall(ExecutorAPIs.isfolder, Path)
    if not Success then
        return nil
    end
    return Exists == true
end

local function SafeMakeFolder(Path)
    if not ExecutorAPIs.makefolder then
        return false, "makefolder is unavailable"
    end
    return pcall(ExecutorAPIs.makefolder, Path)
end

local function SafeWriteFile(Path, Content)
    if not ExecutorAPIs.writefile then
        return false, "writefile is unavailable"
    end
    return pcall(ExecutorAPIs.writefile, Path, Content)
end

local OrionLib = {
	Elements = {},
	ThemeObjects = {},
	Connections = {},
	Flags = {},
    Compatibility = {
        IsMobile = IsOnMobile,
        HasCloneref = type(cloneref) == "function",
        HasHiddenGui = ExecutorAPIs.gethui ~= nil,
        HasGuiProtection = ExecutorAPIs.protectGui ~= nil,
        HasFileRead = ExecutorAPIs.readfile ~= nil,
        HasFileWrite = ExecutorAPIs.writefile ~= nil,
        HasHttpRequest = ExecutorAPIs.request ~= nil,
        HasCustomAsset = ExecutorAPIs.getCustomAsset ~= nil
    },
	Themes = {
		DefaultDark = {
			Main = Color3.fromRGB(25, 25, 25),
			Second = Color3.fromRGB(32, 32, 32),
			Stroke = Color3.fromRGB(60, 60, 60),
			Divider = Color3.fromRGB(60, 60, 60),
			Text = Color3.fromRGB(240, 240, 240),
			TextDark = Color3.fromRGB(150, 150, 150)
		},
		Darker = {
			Main = Color3.fromRGB(25, 25, 25),
			Second = Color3.fromRGB(32, 32, 32),
			Stroke = Color3.fromRGB(60, 60, 60),
			Divider = Color3.fromRGB(60, 60, 60),
			Text = Color3.fromRGB(240, 240, 240),
			TextDark = Color3.fromRGB(150, 150, 150)
		},
		AMOLED = {
			Main = Color3.fromRGB(0, 0, 0),
			Second = Color3.fromRGB(10, 10, 10),
			Stroke = Color3.fromRGB(240, 240, 240),
			Divider = Color3.fromRGB(60, 60, 60),
			Text = Color3.fromRGB(255, 255, 255),
			TextDark = Color3.fromRGB(155, 155, 155)
		}
	},
	SelectedTheme = "AMOLED",
	Folder = nil,
	SaveCfg = false
}

local Icons = {}
local IconUrl = "https://raw.githubusercontent.com/frappedevs/lucideblox/refs/heads/master/src/modules/util/icons.json"

local function FetchText(Url)
    local HttpGetCandidates = {"HttpGetAsync", "HttpGet"}
    for _, MethodName in ipairs(HttpGetCandidates) do
        local Success, Response = pcall(function()
            local Method = game[MethodName]
            if type(Method) ~= "function" then
                error(MethodName .. " is unavailable")
            end
            return Method(game, Url)
        end)
        if Success and type(Response) == "string" and Response ~= "" then
            return Response
        end
    end



    if ExecutorAPIs.request then
        local Success, Response = pcall(ExecutorAPIs.request, {
            Url = Url,
            Method = "GET"
        })
        if Success and type(Response) == "table" then
            local StatusCode = tonumber(Response.StatusCode or Response.Status or 200)
            local Body = Response.Body or Response.body or Response.ResponseBody
            if (not StatusCode or (StatusCode >= 200 and StatusCode < 400)) and type(Body) == "string" and Body ~= "" then
                return Body
            end
        end
    end
    return nil
end

local IconLoadSuccess, IconLoadError = pcall(function()
    local IconJson = FetchText(IconUrl)
    if type(IconJson) ~= "string" then
        error("No compatible HTTP method returned the icon JSON")
    end

    local Decoded = HttpService:JSONDecode(IconJson)
    if type(Decoded) ~= "table" or type(Decoded.icons) ~= "table" then
        error("The icon JSON has an unexpected format")
    end
    Icons = Decoded.icons
end)

if not IconLoadSuccess then
    warn("Orion Library - Icons could not be loaded; asset-id icons will still work. " .. tostring(IconLoadError))
end

local function GetIcon(IconName)
    if type(IconName) == "string" and Icons[IconName] ~= nil then
        return Icons[IconName]
    end
    return nil
end



local function ResolveImageSource(ImageSource)
    if type(ImageSource) ~= "string" then
        return ImageSource
    end

    local NamedIcon = GetIcon(ImageSource)
    if NamedIcon ~= nil then
        return NamedIcon
    end

    local LowerSource = string.lower(ImageSource)
    local IsRemoteOrRobloxAsset = string.sub(LowerSource, 1, 4) == "http"
        or string.sub(LowerSource, 1, 11) == "rbxassetid:"
        or string.sub(LowerSource, 1, 9) == "rbxasset:"
        or string.sub(LowerSource, 1, 9) == "rbxthumb:"
        or string.sub(LowerSource, 1, 12) == "rbxgameasset"

    if IsRemoteOrRobloxAsset or not ExecutorAPIs.getCustomAsset then
        return ImageSource
    end

    local Success, AssetUri = pcall(ExecutorAPIs.getCustomAsset, ImageSource)
    if Success and type(AssetUri) == "string" and AssetUri ~= "" then
        return AssetUri
    end
    return ImageSource
end

local function ResolveGuiParents()
    local Candidates = {}
    local Seen = {}

    local function AddCandidate(Parent, ShouldProtect, Mode)
        if not Parent then
            return
        end
        local IsInstance = false
        pcall(function()
            IsInstance = typeof(Parent) == "Instance"
        end)
        if not IsInstance or Seen[Parent] then
            return
        end
        Seen[Parent] = true
        table.insert(Candidates, {
            Parent = Parent,
            ShouldProtect = ShouldProtect == true,
            Mode = Mode
        })
    end



    if ExecutorAPIs.gethui then
        local Success, Parent = pcall(ExecutorAPIs.gethui)
        if Success then
            AddCandidate(Parent, false, "gethui/get_hidden_gui")
        end
    end


    if CoreGui and ExecutorAPIs.protectGui then
        AddCandidate(CoreGui, true, "protected CoreGui")
    end
    AddCandidate(CoreGui, false, "CoreGui")
    AddCandidate(PlayerGui, false, "PlayerGui")
    return Candidates
end

local GuiParentCandidates = ResolveGuiParents()

local function AddMarkers(Gui)
    if not Gui then
        return
    end

    local MarkerExists = false
    pcall(function()
        MarkerExists = Gui:FindFirstChild("isNyreliajs") ~= nil
    end)

    if not MarkerExists then
        local Marker = Instance.new("BoolValue")
        Marker.Name = "isNyreliajs"
        Marker.Value = true
        Marker.Parent = Gui
    end

    pcall(function()
        Gui:SetAttribute("NyreliajsUI", true)
    end)
end

local function IsManagedGui(Gui)
    if not Gui or not Gui:IsA("ScreenGui") then
        return false
    end

    local Marked = false
    pcall(function()
        Marked = Gui:FindFirstChild("isNyreliajs") ~= nil or Gui:GetAttribute("NyreliajsUI") == true
    end)

    return Marked or Gui.Name == "Orion"
end

local function ScanAndDestroy(Parent, DebrisService)
    if not Parent then
        return
    end

    local Success, Children = pcall(function()
        return Parent:GetChildren()
    end)
    if not Success or type(Children) ~= "table" then
        return
    end

    for _, Gui in ipairs(Children) do
        if IsManagedGui(Gui) then
            local ScheduledForRemoval = false
            if DebrisService then
                local DebrisSuccess = pcall(function()
                    DebrisService:AddItem(Gui, 0)
                end)
                ScheduledForRemoval = DebrisSuccess
            end
            if not ScheduledForRemoval then
                pcall(function()
                    Gui:Destroy()
                end)
            end
        end
    end
end

local function RemoveOldGUIs()
    local DebrisService
    pcall(function()
        DebrisService = GetService("Debris")
    end)

    local Parents = {}
    local SeenParents = {}
    local function AddParent(Parent)
        if Parent and not SeenParents[Parent] then
            SeenParents[Parent] = true
            table.insert(Parents, Parent)
        end
    end

    AddParent(CoreGui)
    if CoreGui then
        pcall(function()
            AddParent(CoreGui:FindFirstChild("RobloxGui"))
        end)
    end
    AddParent(PlayerGui)

    for _, Candidate in ipairs(GuiParentCandidates) do
        AddParent(Candidate.Parent)
    end

    for _, Parent in ipairs(Parents) do
        ScanAndDestroy(Parent, DebrisService)
    end
end

RemoveOldGUIs()

local GuiParent = nil
local GuiParentMode = nil
local LibraryDestroyed = false
local Orion = Instance.new("ScreenGui")
Orion.Name = "Orion"
Orion.ResetOnSpawn = false
Orion.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Orion.DisplayOrder = 10000

for _, Candidate in ipairs(GuiParentCandidates) do
    if Candidate.ShouldProtect and ExecutorAPIs.protectGui then
        pcall(ExecutorAPIs.protectGui, Orion)
    end

    local ParentSuccess = pcall(function()
        Orion.Parent = Candidate.Parent
    end)
    if ParentSuccess and Orion.Parent == Candidate.Parent then
        GuiParent = Candidate.Parent
        GuiParentMode = Candidate.Mode
        break
    end
end

if not GuiParent then
    pcall(function() Orion:Destroy() end)
    error("Orion Library: Could not attach ScreenGui to gethui, CoreGui, or PlayerGui.")
end

AddMarkers(Orion)

OrionLib.Compatibility.GuiParentMode = GuiParentMode
OrionLib.Compatibility.IsMobile = IsOnMobile

function OrionLib:IsMobile()
    return IsOnMobile
end

function OrionLib:GetCompatibilityInfo()
    local Info = {}
    for Key, Value in pairs(self.Compatibility or {}) do
        Info[Key] = Value
    end
    Info.CanSaveConfig = ExecutorAPIs.writefile ~= nil
    Info.CanLoadConfig = ExecutorAPIs.readfile ~= nil
    Info.CanCreateConfigFolder = ExecutorAPIs.makefolder ~= nil
    return Info
end


local ChildSuccess, ExistingChildren = pcall(function()
    return GuiParent:GetChildren()
end)

if ChildSuccess then
    for _, Interface in ipairs(ExistingChildren) do
        if Interface ~= Orion and Interface.Name == Orion.Name then
            pcall(function()
                Interface:Destroy()
            end)
        end
    end
end

function OrionLib:IsRunning()
    return not LibraryDestroyed and Orion.Parent == GuiParent
end

function OrionLib:DisconnectConnections()
    for Index = #OrionLib.Connections, 1, -1 do
        local Connection = OrionLib.Connections[Index]
        if Connection then
            pcall(function()
                Connection:Disconnect()
            end)
        end
        OrionLib.Connections[Index] = nil
    end
end

local function DisconnectConnection(Connection)
    if not Connection then
        return
    end

    pcall(function()
        Connection:Disconnect()
    end)

    for Index = #OrionLib.Connections, 1, -1 do
        if OrionLib.Connections[Index] == Connection then
            table.remove(OrionLib.Connections, Index)
            break
        end
    end
end

local function AddConnection(Signal, Function)
    if LibraryDestroyed or Orion.Parent ~= GuiParent or not Signal then
        return nil
    end

    local Success, Connection = pcall(function()
        return Signal:Connect(Function)
    end)

    if Success and Connection then
        table.insert(OrionLib.Connections, Connection)
        return Connection
    end

    if not Success then
        warn("Orion Library - Failed to connect an event: " .. tostring(Connection))
    end
    return nil
end

task.spawn(function()
    while OrionLib:IsRunning() do
        task.wait(1)
    end
    OrionLib:DisconnectConnections()
end)

local function LerpUDim2(Start, Goal, Alpha)


    return UDim2.new(
        Start.X.Scale + (Goal.X.Scale - Start.X.Scale) * Alpha,
        Start.X.Offset + (Goal.X.Offset - Start.X.Offset) * Alpha,
        Start.Y.Scale + (Goal.Y.Scale - Start.Y.Scale) * Alpha,
        Start.Y.Offset + (Goal.Y.Offset - Start.Y.Offset) * Alpha
    )
end

local function AddDraggingFunctionality(DragPoint, Main)
    local Dragging = false
    local Settling = false
    local DragStartPosition = nil
    local MainStartPosition = nil
    local StartAbsolutePosition = nil
    local TargetPosition = nil
    local ActiveTouchInput = nil
    local DragReleaseConnection = nil
    local SmoothDragConnection = nil
    local BoundsViewportConnection = nil
    local BoundsCameraConnection = nil
    local BoundsSizeConnection = nil
    local Smoothness = 24



    local function GetViewportAndInset()
        local Camera = workspace.CurrentCamera
        if not Camera then
            return nil, 0
        end

        local Viewport
        local CameraSuccess = pcall(function()
            Viewport = Camera.ViewportSize
        end)
        if not CameraSuccess or not Viewport then
            return nil, 0
        end

        local TopInsetY = 0
        if GuiService then
            pcall(function()
                local TopLeftInset = GuiService:GetGuiInset()
                if TopLeftInset then
                    TopInsetY = TopLeftInset.Y
                end
            end)
        end

        return Viewport, TopInsetY
    end

    local function ClampAbsolutePosition(Position, Size)
        local Viewport, TopInsetY = GetViewportAndInset()
        if not Viewport then
            return Position
        end



        local MaxX = math.max(0, Viewport.X - Size.X)
        local MaxY = math.max(0, Viewport.Y - Size.Y - TopInsetY)

        return Vector2.new(
            math.clamp(Position.X, 0, MaxX),
            math.clamp(Position.Y, 0, MaxY)
        )
    end

    local function ApplyAbsoluteCorrection(Correction)
        if not Main or not Main.Parent then
            return
        end

        if math.abs(Correction.X) < 0.01 and math.abs(Correction.Y) < 0.01 then
            return
        end

        local CurrentPosition = Main.Position
        Main.Position = UDim2.new(
            CurrentPosition.X.Scale,
            CurrentPosition.X.Offset + Correction.X,
            CurrentPosition.Y.Scale,
            CurrentPosition.Y.Offset + Correction.Y
        )



        if MainStartPosition then
            MainStartPosition = UDim2.new(
                MainStartPosition.X.Scale,
                MainStartPosition.X.Offset + Correction.X,
                MainStartPosition.Y.Scale,
                MainStartPosition.Y.Offset + Correction.Y
            )
        end
        if StartAbsolutePosition then
            StartAbsolutePosition = StartAbsolutePosition + Correction
        end
        if TargetPosition then
            TargetPosition = UDim2.new(
                TargetPosition.X.Scale,
                TargetPosition.X.Offset + Correction.X,
                TargetPosition.Y.Scale,
                TargetPosition.Y.Offset + Correction.Y
            )
        end
    end

    local function KeepWindowOnScreen()
        if not Main or not Main.Parent then
            return
        end
        local CurrentAbsolutePosition = Main.AbsolutePosition
        local ClampedPosition = ClampAbsolutePosition(CurrentAbsolutePosition, Main.AbsoluteSize)
        ApplyAbsoluteCorrection(ClampedPosition - CurrentAbsolutePosition)
    end

    local function StopDrag(Input)
        if not Dragging then
            return
        end

        local MouseReleased = ActiveTouchInput == nil
            and Input ~= nil
            and Input.UserInputType == Enum.UserInputType.MouseButton1
        local TouchReleased = ActiveTouchInput ~= nil and Input == ActiveTouchInput
        if not MouseReleased and not TouchReleased then
            return
        end

        Dragging = false
        ActiveTouchInput = nil
        DragStartPosition = nil
        MainStartPosition = nil
        StartAbsolutePosition = nil
        Settling = TargetPosition ~= nil

        if DragReleaseConnection then
            DisconnectConnection(DragReleaseConnection)
            DragReleaseConnection = nil
        end
    end

    local function BeginDrag(Input, IsTouch)
        if DragReleaseConnection then
            DisconnectConnection(DragReleaseConnection)
            DragReleaseConnection = nil
        end


        KeepWindowOnScreen()

        Dragging = true
        Settling = false
        ActiveTouchInput = IsTouch and Input or nil
        DragStartPosition = Input.Position
        MainStartPosition = Main.Position
        StartAbsolutePosition = Main.AbsolutePosition
        TargetPosition = Main.Position



        local ChangedSuccess, ChangedSignal = pcall(function()
            return Input.Changed
        end)
        if ChangedSuccess and ChangedSignal then
            DragReleaseConnection = AddConnection(ChangedSignal, function()
                if Input.UserInputState == Enum.UserInputState.End then
                    StopDrag(Input)
                end
            end)
        end
    end

    AddConnection(DragPoint.InputBegan, function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
            BeginDrag(Input, false)
        elseif Input.UserInputType == Enum.UserInputType.Touch then
            BeginDrag(Input, true)
        end
    end)

    AddConnection(UserInputService.InputChanged, function(Input)
        if not Dragging or not DragStartPosition or not MainStartPosition or not StartAbsolutePosition then
            return
        end

        local CurrentPosition
        if ActiveTouchInput then

            if Input ~= ActiveTouchInput then
                return
            end
            CurrentPosition = Input.Position
        elseif Input.UserInputType == Enum.UserInputType.MouseMovement then
            CurrentPosition = Input.Position
        else
            return
        end




        local Delta = Vector2.new(
            CurrentPosition.X - DragStartPosition.X,
            CurrentPosition.Y - DragStartPosition.Y
        )
        local ProposedAbsolutePosition = StartAbsolutePosition + Delta
        local ClampedAbsolutePosition = ClampAbsolutePosition(ProposedAbsolutePosition, Main.AbsoluteSize)
        local ClampedDelta = ClampedAbsolutePosition - StartAbsolutePosition



        TargetPosition = UDim2.new(
            MainStartPosition.X.Scale,
            MainStartPosition.X.Offset + ClampedDelta.X,
            MainStartPosition.Y.Scale,
            MainStartPosition.Y.Offset + ClampedDelta.Y
        )


        if not SmoothDragConnection then
            Main.Position = TargetPosition
            KeepWindowOnScreen()
        end
    end)

    AddConnection(UserInputService.InputEnded, function(Input)
        StopDrag(Input)
    end)

    local function UpdateDrag(DeltaTime)
        if not Dragging and not Settling then
            return
        end

        if not Main or not Main.Parent or not TargetPosition then
            Dragging = false
            Settling = false
            TargetPosition = nil
            return
        end



        local SafeDelta = math.clamp(tonumber(DeltaTime) or (1 / 60), 0, 0.1)
        local Alpha = 1 - math.exp(-Smoothness * SafeDelta)
        local CurrentPosition = Main.Position
        local NextPosition = LerpUDim2(CurrentPosition, TargetPosition, Alpha)
        Main.Position = NextPosition

        if not Dragging then
            local XScaleClose = math.abs(NextPosition.X.Scale - TargetPosition.X.Scale) < 0.0001
            local YScaleClose = math.abs(NextPosition.Y.Scale - TargetPosition.Y.Scale) < 0.0001
            local XOffsetClose = math.abs(NextPosition.X.Offset - TargetPosition.X.Offset) < 0.5
            local YOffsetClose = math.abs(NextPosition.Y.Offset - TargetPosition.Y.Offset) < 0.5

            if XScaleClose and YScaleClose and XOffsetClose and YOffsetClose then
                Main.Position = TargetPosition
                Settling = false
                TargetPosition = nil
            end
        end
    end


    SmoothDragConnection = AddConnection(RunService.RenderStepped, UpdateDrag)



    local function BindBoundsToCurrentCamera()
        if BoundsViewportConnection then
            DisconnectConnection(BoundsViewportConnection)
            BoundsViewportConnection = nil
        end

        local Camera = workspace.CurrentCamera
        if Camera then
            local SignalSuccess, ViewportSignal = pcall(function()
                return Camera:GetPropertyChangedSignal("ViewportSize")
            end)
            if SignalSuccess and ViewportSignal then
                BoundsViewportConnection = AddConnection(ViewportSignal, KeepWindowOnScreen)
            end
        end
        KeepWindowOnScreen()
    end

    BoundsCameraConnection = AddConnection(workspace:GetPropertyChangedSignal("CurrentCamera"), BindBoundsToCurrentCamera)
    BoundsSizeConnection = AddConnection(Main:GetPropertyChangedSignal("AbsoluteSize"), KeepWindowOnScreen)
    BindBoundsToCurrentCamera()
end

local function Create(Name, Properties, Children)
	local Object = Instance.new(Name)
	for i, v in next, Properties or {} do
		Object[i] = v
	end
	for i, v in next, Children or {} do
		v.Parent = Object
	end
	return Object
end

local function CreateElement(ElementName, ElementFunction)
	OrionLib.Elements[ElementName] = function(...)
		return ElementFunction(...)
	end
end

local function MakeElement(ElementName, ...)
	local NewElement = OrionLib.Elements[ElementName](...)
	return NewElement
end

local function AddItemTable(Table, Item, Value)
	local Item = tostring(Item)
	local Count = 1

	while Table[Item] do
		Count = Count + 1
		Item = string.format('%s-%d', Item, Count)
	end

	Table[Item] = Value
end

local function SetProps(Element, Props)
    for Property, Value in pairs(Props or {}) do
        Element[Property] = Value
    end
    return Element
end

local function SetChildren(Element, Children)
    for _, Child in pairs(Children or {}) do
        Child.Parent = Element
    end
    return Element
end

local function Round(Number, Factor)
    if type(Number) ~= "number" then
        return 0
    end
    if type(Factor) ~= "number" or Factor <= 0 then
        return Number
    end

    local Scaled = Number / Factor
    if Scaled >= 0 then
        return math.floor(Scaled + 0.5) * Factor
    end
    return math.ceil(Scaled - 0.5) * Factor
end

local function ReturnProperty(Object)
	if Object:IsA("Frame") or Object:IsA("TextButton") then
		return "BackgroundColor3"
	end
	if Object:IsA("ScrollingFrame") then
		return "ScrollBarImageColor3"
	end
	if Object:IsA("UIStroke") then
		return "Color"
	end
	if Object:IsA("TextLabel") or Object:IsA("TextBox") then
		return "TextColor3"
	end
	if Object:IsA("ImageLabel") or Object:IsA("ImageButton") then
		return "ImageColor3"
	end
end

local function AddThemeObject(Object, Type)
    if not OrionLib.ThemeObjects[Type] then
        OrionLib.ThemeObjects[Type] = {}
    end
    table.insert(OrionLib.ThemeObjects[Type], Object)

    local Property = ReturnProperty(Object)
    local Theme = OrionLib.Themes[OrionLib.SelectedTheme]
    if Property and Theme and Theme[Type] then
        Object[Property] = Theme[Type]
    end
    return Object
end

local function RemoveThemeObjectReferences(Root)
    local RemovedObjects = {[Root] = true}
    local Success, Descendants = pcall(function()
        return Root:GetDescendants()
    end)
    if Success then
        for _, Object in ipairs(Descendants) do
            RemovedObjects[Object] = true
        end
    end

    for _, Objects in pairs(OrionLib.ThemeObjects) do
        for Index = #Objects, 1, -1 do
            if RemovedObjects[Objects[Index]] then
                table.remove(Objects, Index)
            end
        end
    end
end

local function SetTheme()
    local Theme = OrionLib.Themes[OrionLib.SelectedTheme]
    if not Theme then
        return false
    end

    for ThemeType, Objects in pairs(OrionLib.ThemeObjects) do
        for _, Object in pairs(Objects) do
            if Object and Object.Parent then
                local Property = ReturnProperty(Object)
                if Property and Theme[ThemeType] then
                    pcall(function()
                        Object[Property] = Theme[ThemeType]
                    end)
                end
            end
        end
    end
    return true
end

function OrionLib:SetTheme(ThemeName)
    if type(ThemeName) ~= "string" or not OrionLib.Themes[ThemeName] then
        return false
    end
    OrionLib.SelectedTheme = ThemeName
    return SetTheme()
end

local function PackColor(Color)
	return {R = Color.R * 255, G = Color.G * 255, B = Color.B * 255}
end

local function UnpackColor(Color)
	return Color3.fromRGB(Color.R, Color.G, Color.B)
end

local function LoadCfg(Config)
    local DecodeSuccess, Data = pcall(function()
        return HttpService:JSONDecode(Config)
    end)

    if not DecodeSuccess or type(Data) ~= "table" then
        warn("Orion Library - Could not decode the saved configuration: " .. tostring(Data))
        return false
    end

    for FlagName, Value in pairs(Data) do
        local Flag = OrionLib.Flags[FlagName]
        if Flag and type(Flag.Set) == "function" then
            task.spawn(function()
                local ApplySuccess, ApplyError = pcall(function()
                    if Flag.Type == "Colorpicker" then
                        Flag:Set(UnpackColor(Value))
                    else
                        Flag:Set(Value)
                    end
                end)
                if not ApplySuccess then
                    warn("Orion Library - Could not apply config flag '" .. tostring(FlagName) .. "': " .. tostring(ApplyError))
                end
            end)
        else
            warn("Orion Library Config Loader - Could not find a compatible flag: " .. tostring(FlagName))
        end
    end
    return true
end

local function SaveCfg(Name)
    if not OrionLib.SaveCfg then
        return false
    end

    if not ExecutorAPIs.writefile then
        return false
    end

    local Folder = OrionLib.Folder
    if type(Folder) ~= "string" or Folder == "" then
        return false
    end

    local Data = {}
    for FlagName, Flag in pairs(OrionLib.Flags) do
        if Flag and Flag.Save then
            if Flag.Type == "Colorpicker" and typeof(Flag.Value) == "Color3" then
                Data[FlagName] = PackColor(Flag.Value)
            else
                Data[FlagName] = Flag.Value
            end
        end
    end

    local FolderStatus = SafeIsFolder(Folder)
    local FolderReady = FolderStatus == true

    if FolderStatus ~= true then
        local MakeSuccess = false
        if ExecutorAPIs.makefolder then
            MakeSuccess = select(1, SafeMakeFolder(Folder))
        end

        local FolderStatusAfterCreate = SafeIsFolder(Folder)
        if FolderStatusAfterCreate == true then
            FolderReady = true
        elseif FolderStatusAfterCreate == nil then


            FolderReady = true
        elseif MakeSuccess then
            FolderReady = true
        else
            FolderReady = false
        end
    end

    if not FolderReady then
        return false
    end

    local EncodeSuccess, Encoded = pcall(function()
        return HttpService:JSONEncode(Data)
    end)
    if not EncodeSuccess then
        warn("Orion Library - Could not encode the configuration: " .. tostring(Encoded))
        return false
    end

    local Path = Folder .. "/" .. tostring(Name or game.GameId) .. ".txt"
    local WriteSuccess, WriteError = SafeWriteFile(Path, Encoded)
    if not WriteSuccess then
        warn("Orion Library - Could not save configuration: " .. tostring(WriteError))
        return false
    end
    return true
end

local WhitelistedMouse = {Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2,Enum.UserInputType.MouseButton3}
local BlacklistedKeys = {Enum.KeyCode.Unknown,Enum.KeyCode.W,Enum.KeyCode.A,Enum.KeyCode.S,Enum.KeyCode.D,Enum.KeyCode.Up,Enum.KeyCode.Left,Enum.KeyCode.Down,Enum.KeyCode.Right,Enum.KeyCode.Slash,Enum.KeyCode.Tab,Enum.KeyCode.Backspace,Enum.KeyCode.Escape}

local function CheckKey(Table, Key)
	for _, v in next, Table do
		if v == Key then
			return true
		end
	end
end

CreateElement("Corner", function(Scale, Offset)
	local Corner = Create("UICorner", {
		CornerRadius = UDim.new(Scale or 0, Offset or 10)
	})
	return Corner
end)

CreateElement("Stroke", function(Color, Thickness)
	local Stroke = Create("UIStroke", {
		Color = Color or Color3.fromRGB(255, 255, 255),
		Thickness = Thickness or 1
	})
	return Stroke
end)

CreateElement("List", function(Scale, Offset)
	local List = Create("UIListLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(Scale or 0, Offset or 0)
	})
	return List
end)

CreateElement("Padding", function(Bottom, Left, Right, Top)
	local Padding = Create("UIPadding", {
		PaddingBottom = UDim.new(0, Bottom or 4),
		PaddingLeft = UDim.new(0, Left or 4),
		PaddingRight = UDim.new(0, Right or 4),
		PaddingTop = UDim.new(0, Top or 4)
	})
	return Padding
end)

CreateElement("TFrame", function()
	local TFrame = Create("Frame", {
		BackgroundTransparency = 1
	})
	return TFrame
end)

CreateElement("Frame", function(Color)
	local Frame = Create("Frame", {
		BackgroundColor3 = Color or Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0
	})
	return Frame
end)

CreateElement("RoundFrame", function(Color, Scale, Offset)
	local Frame = Create("Frame", {
		BackgroundColor3 = Color or Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0
	}, {
		Create("UICorner", {
			CornerRadius = UDim.new(Scale, Offset)
		})
	})
	return Frame
end)

CreateElement("Button", function()
	local Button = Create("TextButton", {
		Text = "",
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		BorderSizePixel = 0
	})
	return Button
end)

CreateElement("ScrollFrame", function(Color, Width)
	local ScrollFrame = Create("ScrollingFrame", {
		BackgroundTransparency = 1,
		MidImage = "rbxassetid://7445543667",
		BottomImage = "rbxassetid://7445543667",
		TopImage = "rbxassetid://7445543667",
		ScrollBarImageColor3 = Color,
		BorderSizePixel = 0,
		ScrollBarThickness = Width,
		CanvasSize = UDim2.new(0, 0, 0, 0)
	})
	return ScrollFrame
end)

CreateElement("Image", function(ImageID)
    local ImageNew = Create("ImageLabel", {
        Image = ResolveImageSource(ImageID),
        BackgroundTransparency = 1
    })
    return ImageNew
end)

CreateElement("ImageButton", function(ImageID)
    local Image = Create("ImageButton", {
        Image = ResolveImageSource(ImageID),
        BackgroundTransparency = 1
    })
    return Image
end)

CreateElement("Label", function(Text, TextSize, Transparency)
	local Label = Create("TextLabel", {
		Text = Text or "",
		TextColor3 = Color3.fromRGB(240, 240, 240),
		TextTransparency = Transparency or 0,
		TextSize = TextSize or 15,
		Font = Enum.Font.Gotham,
		RichText = true,
		BackgroundTransparency = 1,
		TextXAlignment = Enum.TextXAlignment.Left
	})
	return Label
end)

local NotificationHolder = SetProps(SetChildren(MakeElement("TFrame"), {
	SetProps(MakeElement("List"), {
		HorizontalAlignment = Enum.HorizontalAlignment.Center,
		SortOrder = Enum.SortOrder.LayoutOrder,
		VerticalAlignment = Enum.VerticalAlignment.Bottom,
		Padding = UDim.new(0, 5)
	})
}), {
	Position = UDim2.new(1, -25, 1, -25),
	Size = UDim2.new(0, 300, 1, -25),
	AnchorPoint = Vector2.new(1, 1),
	Parent = Orion
})

function OrionLib:MakeNotification(NotificationConfig)
	spawn(function()
		NotificationConfig.Name = NotificationConfig.Name or "Notification"
		NotificationConfig.Content = NotificationConfig.Content or "Test"
		NotificationConfig.Image = NotificationConfig.Image or "rbxassetid://4384403532"
		NotificationConfig.Time = NotificationConfig.Time or 15

		local NotificationParent = SetProps(MakeElement("TFrame"), {
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			Parent = NotificationHolder
		})

		local NotificationFrame = SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(25, 25, 25), 0, 10), {
			Parent = NotificationParent,
			Size = UDim2.new(1, 0, 0, 0),
			Position = UDim2.new(1, -55, 0, 0),
			BackgroundTransparency = 0,
			AutomaticSize = Enum.AutomaticSize.Y
		}), {
			MakeElement("Stroke", Color3.fromRGB(93, 93, 93), 1.2),
			MakeElement("Padding", 12, 12, 12, 12),
			SetProps(MakeElement("Image", NotificationConfig.Image), {
				Size = UDim2.new(0, 20, 0, 20),
				ImageColor3 = Color3.fromRGB(240, 240, 240),
				Name = "Icon"
			}),
			SetProps(MakeElement("Label", NotificationConfig.Name, 15), {
				Size = UDim2.new(1, -30, 0, 20),
				Position = UDim2.new(0, 30, 0, 0),
				Font = Enum.Font.GothamBold,
				Name = "Title"
			}),
			SetProps(MakeElement("Label", NotificationConfig.Content, 14), {
				Size = UDim2.new(1, 0, 0, 0),
				Position = UDim2.new(0, 0, 0, 25),
				Font = Enum.Font.GothamSemibold,
				Name = "Content",
				AutomaticSize = Enum.AutomaticSize.Y,
				TextColor3 = Color3.fromRGB(200, 200, 200),
				TextWrapped = true
			})
		})

		TweenService:Create(NotificationFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Position = UDim2.new(0, 0, 0, 0)}):Play()

		wait(NotificationConfig.Time - 0.88)
		TweenService:Create(NotificationFrame.Icon, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
		TweenService:Create(NotificationFrame, TweenInfo.new(0.8, Enum.EasingStyle.Quint), {BackgroundTransparency = 0.6}):Play()
		wait(0.3)
		TweenService:Create(NotificationFrame.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 0.9}):Play()
		TweenService:Create(NotificationFrame.Title, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {TextTransparency = 0.4}):Play()
		TweenService:Create(NotificationFrame.Content, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {TextTransparency = 0.5}):Play()
		wait(0.05)

		NotificationFrame:TweenPosition(UDim2.new(1, 20, 0, 0),'In','Quint',0.8,true)
		wait(1.35)
		NotificationFrame:Destroy()
	end)
end

function OrionLib:Init()
    if not OrionLib.SaveCfg then
        return false
    end

    local Path = tostring(OrionLib.Folder or "") .. "/" .. tostring(game.GameId) .. ".txt"
    if not SafeIsFile(Path) then
        return false
    end

    local ReadSuccess, Config = SafeReadFile(Path)
    if not ReadSuccess or type(Config) ~= "string" then
        warn("Orion Library - Configuration exists, but could not be read: " .. tostring(Config))
        return false
    end

    local Loaded = LoadCfg(Config)
    if Loaded then
        OrionLib:MakeNotification({
            Name = "Configuration",
            Content = "Auto-loaded configuration for the game " .. tostring(game.GameId) .. ".",
            Time = 5
        })
    end
    return Loaded
end

function OrionLib:MakeWindow(WindowConfig)
	local FirstTab = true
	local Minimized = false
	local Loaded = false
	local UIHidden = false

	WindowConfig = WindowConfig or {}
	WindowConfig.Name = WindowConfig.Name or "Orion Library"
	WindowConfig.ConfigFolder = WindowConfig.ConfigFolder or WindowConfig.Name
	WindowConfig.SaveConfig = WindowConfig.SaveConfig or false
	WindowConfig.HidePremium = WindowConfig.HidePremium or false
	if WindowConfig.IntroEnabled == nil then
		WindowConfig.IntroEnabled = true
	end
	WindowConfig.IntroText = WindowConfig.IntroText or "Orion Library (Modified by 00Fazee)"
	WindowConfig.CloseCallback = WindowConfig.CloseCallback or function() end
	WindowConfig.ShowIcon = WindowConfig.ShowIcon or false
	WindowConfig.Icon = WindowConfig.Icon or "rbxassetid://76607437080421"
	WindowConfig.IntroIcon = WindowConfig.IntroIcon or "rbxassetid://76607437080421"
	WindowConfig.SearchBar = WindowConfig.SearchBar == true
	OrionLib.Folder = WindowConfig.ConfigFolder
	OrionLib.SaveCfg = WindowConfig.SaveConfig

    if WindowConfig.SaveConfig then
        local FolderStatus = SafeIsFolder(WindowConfig.ConfigFolder)
        local FolderReady = FolderStatus == true

        if FolderStatus ~= true and ExecutorAPIs.makefolder then
            local MakeSuccess = select(1, SafeMakeFolder(WindowConfig.ConfigFolder))
            local FolderStatusAfterCreate = SafeIsFolder(WindowConfig.ConfigFolder)
            FolderReady = FolderStatusAfterCreate == true or FolderStatusAfterCreate == nil or MakeSuccess
        elseif FolderStatus == nil then

            FolderReady = true
        end

        if not FolderReady or not ExecutorAPIs.writefile then
            warn("Orion Library - SaveConfig is enabled, but file APIs or a usable config folder are unavailable. The UI will continue without saving.")
        end
    end

	local TabHolder = AddThemeObject(SetChildren(SetProps(MakeElement("ScrollFrame", Color3.fromRGB(255, 255, 255), 4),
		WindowConfig.SearchBar and {
			Size = UDim2.new(1, 0, 1, -90),
			Position = UDim2.new(0, 0, 0, 40)
		} or {
			Size = UDim2.new(1, 0, 1, -50)
		}),
		{
			MakeElement("List"),
			MakeElement("Padding", 8, 0, 0, 8)
		}), "Divider")

	AddConnection(TabHolder.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
		TabHolder.CanvasSize = UDim2.new(0, 0, 0, TabHolder.UIListLayout.AbsoluteContentSize.Y + 16)
	end)

	local CloseBtn = SetChildren(SetProps(MakeElement("Button"), {
		Size = UDim2.new(0.5, 0, 1, 0),
		Position = UDim2.new(0.5, 0, 0, 0),
		BackgroundTransparency = 1
	}), {
		AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://7072725342"), {
			Position = UDim2.new(0, 9, 0, 6),
			Size = UDim2.new(0, 18, 0, 18)
		}), "Text")
	})

	local MinimizeBtn = SetChildren(SetProps(MakeElement("Button"), {
		Size = UDim2.new(0.5, 0, 1, 0),
		BackgroundTransparency = 1
	}), {
		AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://7072719338"), {
			Position = UDim2.new(0, 9, 0, 6),
			Size = UDim2.new(0, 18, 0, 18),
			Name = "Ico"
		}), "Text")
	})

	local DragPoint = SetProps(MakeElement("TFrame"), {
		Size = UDim2.new(1, 0, 0, 50)
	})

	local WindowStuff = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 10), {
		Size = UDim2.new(0, 150, 1, -50),
		Position = UDim2.new(0, 0, 0, 50)
	}), {
		AddThemeObject(SetProps(MakeElement("Frame"), {
			Size = UDim2.new(1, 0, 0, 10),
			Position = UDim2.new(0, 0, 0, 0)
		}), "Second"),
		AddThemeObject(SetProps(MakeElement("Frame"), {
			Size = UDim2.new(0, 10, 1, 0),
			Position = UDim2.new(1, -10, 0, 0)
		}), "Second"),
		AddThemeObject(SetProps(MakeElement("Frame"), {
			Size = UDim2.new(0, 1, 1, 0),
			Position = UDim2.new(1, -1, 0, 0)
		}), "Stroke"),
		TabHolder,
		SetChildren(SetProps(MakeElement("TFrame"), {
			Size = UDim2.new(1, 0, 0, 50),
			Position = UDim2.new(0, 0, 1, -50)
		}), {
			AddThemeObject(SetProps(MakeElement("Frame"), {
				Size = UDim2.new(1, 0, 0, 1)
			}), "Stroke"),
			AddThemeObject(SetChildren(SetProps(MakeElement("Frame"), {
				AnchorPoint = Vector2.new(0, 0.5),
				Size = UDim2.new(0, 32, 0, 32),
				Position = UDim2.new(0, 10, 0.5, 0)
			}), {
				SetProps(MakeElement("Image", "https://www.roblox.com/headshot-thumbnail/image?userId=".. LocalPlayer.UserId .."&width=420&height=420&format=png"), {
					Size = UDim2.new(1, 0, 1, 0)
				}),
				AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://4031889928"), {
					Size = UDim2.new(1, 0, 1, 0),
				}), "Second"),
				MakeElement("Corner", 1)
			}), "Divider"),
			SetChildren(SetProps(MakeElement("TFrame"), {
				AnchorPoint = Vector2.new(0, 0.5),
				Size = UDim2.new(0, 32, 0, 32),
				Position = UDim2.new(0, 10, 0.5, 0)
			}), {
				AddThemeObject(MakeElement("Stroke"), "Stroke"),
				MakeElement("Corner", 1)
			}),
			AddThemeObject(SetProps(MakeElement("Label", LocalPlayer.DisplayName, WindowConfig.HidePremium and 14 or 13), {
				Size = UDim2.new(1, -60, 0, 13),
				Position = WindowConfig.HidePremium and UDim2.new(0, 50, 0, 19) or UDim2.new(0, 50, 0, 12),
				Font = Enum.Font.GothamBold,
				ClipsDescendants = true
			}), "Text"),
			AddThemeObject(SetProps(MakeElement("Label", "User", 12), {
				Size = UDim2.new(1, -60, 0, 12),
				Position = UDim2.new(0, 50, 1, -24),
				Visible = not WindowConfig.HidePremium
			}), "TextDark")
		}),
	}), "Second")


	local Tabs = {};

	if WindowConfig.SearchBar then
		local SearchBox = Create("TextBox", {
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			PlaceholderColor3 = Color3.fromRGB(210,210,210),
			PlaceholderText = "Search",
			Font = Enum.Font.GothamSemibold,
			TextWrapped = true,
			Text = '',
			TextXAlignment = Enum.TextXAlignment.Center,
			TextSize = 14,
			ClearTextOnFocus = false
		})

		local TextboxActual = AddThemeObject(SearchBox, "Text")

		local SearchBar = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 1, 6), {
			Parent = WindowStuff,
			Size = UDim2.new(0, 130, 0, 24),
			Position = UDim2.new(1.013, -12, 0.075, 0),
			AnchorPoint = Vector2.new(1, 0.5)
		}), {
			AddThemeObject(MakeElement("Stroke"), "Stroke"),
			TextboxActual
		}), "Main")

		local function SearchHandle()
			local Text = string.lower(SearchBox.Text);

			for i,v in pairs(Tabs) do
				if v:IsA('TextButton') then
					if string.find(string.lower(i), Text, 1, true) then
						v.Visible = true
					else
						v.Visible = false
					end
				end
			end
		end

		AddConnection(TextboxActual:GetPropertyChangedSignal("Text"), SearchHandle);
	end

	local WindowName = AddThemeObject(SetProps(MakeElement("Label", WindowConfig.Name, 14), {
		Size = UDim2.new(1, -30, 2, 0),
		Position = UDim2.new(0, 25, 0, -24),
		Font = Enum.Font.GothamBlack,
		TextSize = 20
	}), "Text")

	local WindowTopBarLine = AddThemeObject(SetProps(MakeElement("Frame"), {
		Size = UDim2.new(1, 0, 0, 1),
		Position = UDim2.new(0, 0, 1, -1)
	}), "Stroke")

	local MainWindow = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 10), {
		Parent = Orion,
        AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0, 615, 0, 344),
		ClipsDescendants = true
	}), {







		SetChildren(SetProps(MakeElement("TFrame"), {
			Size = UDim2.new(1, 0, 0, 50),
			Name = "TopBar"
		}), {
			WindowName,
			WindowTopBarLine,
			AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 7), {
				Size = UDim2.new(0, 70, 0, 30),
				Position = UDim2.new(1, -90, 0, 10)
			}), {
				AddThemeObject(MakeElement("Stroke"), "Stroke"),
				AddThemeObject(SetProps(MakeElement("Frame"), {
					Size = UDim2.new(0, 1, 1, 0),
					Position = UDim2.new(0.5, 0, 0, 0)
				}), "Stroke"),
				CloseBtn,
				MinimizeBtn
			}), "Second"),
		}),
		DragPoint,
		WindowStuff
	}), "Main")


    local MainWindowScale = Instance.new("UIScale")
    MainWindowScale.Name = "ResponsiveScale"
    MainWindowScale.Parent = MainWindow

    local function UpdateResponsiveScale()
        local Camera = workspace.CurrentCamera
        if not Camera then
            return
        end

        local Viewport = Camera.ViewportSize
        local ScaleX = (Viewport.X - 24) / 615
        local ScaleY = (Viewport.Y - 24) / 344
        MainWindowScale.Scale = math.clamp(math.min(1, ScaleX, ScaleY), 0.35, 1)
    end

    local ViewportConnection
    local function BindCurrentCamera()
        if ViewportConnection then
            DisconnectConnection(ViewportConnection)
            ViewportConnection = nil
        end

        local Camera = workspace.CurrentCamera
        if Camera then
            local SignalSuccess, ViewportSignal = pcall(function()
                return Camera:GetPropertyChangedSignal("ViewportSize")
            end)
            if SignalSuccess and ViewportSignal then
                ViewportConnection = AddConnection(ViewportSignal, UpdateResponsiveScale)
            end
        end
        UpdateResponsiveScale()
    end

    AddConnection(workspace:GetPropertyChangedSignal("CurrentCamera"), BindCurrentCamera)
    BindCurrentCamera()

	if WindowConfig.ShowIcon then
		WindowName.Position = UDim2.new(0, 50, 0, -24)
		local WindowIcon = SetProps(MakeElement("Image", WindowConfig.Icon), {
			Size = UDim2.new(0, 20, 0, 20),
			Position = UDim2.new(0, 20, 0, 15)
		})
		WindowIcon.Parent = MainWindow.TopBar
	end

	AddDraggingFunctionality(DragPoint, MainWindow)

	AddConnection(CloseBtn.MouseButton1Up, function()
		MainWindow.Visible = false
		UIHidden = true
		OrionLib:MakeNotification({
			Name = "Interface Hidden",
			Content = "Tap RightShift to reopen the interface",
			Image = "rbxassetid://10723346871",
			Time = 5
		})
		WindowConfig.CloseCallback()
	end)

	AddConnection(UserInputService.InputBegan, function(Input)
		if Input.KeyCode == Enum.KeyCode.RightShift and UIHidden then
			MainWindow.Visible = true
		end
	end)

	AddConnection(MinimizeBtn.MouseButton1Up, function()
		if Minimized then
			TweenService:Create(MainWindow, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, 615, 0, 344)}):Play()
			MinimizeBtn.Ico.Image = "rbxassetid://7072719338"
			wait(.02)
			MainWindow.ClipsDescendants = false
			WindowStuff.Visible = true
			WindowTopBarLine.Visible = true
		else
			MainWindow.ClipsDescendants = true
			WindowTopBarLine.Visible = false
			MinimizeBtn.Ico.Image = "rbxassetid://7072720870"

			TweenService:Create(MainWindow, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, WindowName.TextBounds.X + 140, 0, 50)}):Play()
			wait(0.1)
			WindowStuff.Visible = false
		end
		Minimized = not Minimized
	end)

	local function LoadSequence()
		MainWindow.Visible = false
		local LoadSequenceLogo = SetProps(MakeElement("Image", WindowConfig.IntroIcon), {
			Parent = Orion,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0.4, 0),
			Size = UDim2.new(0, 28, 0, 28),
			ImageColor3 = Color3.fromRGB(255, 255, 255),
			ImageTransparency = 1
		})

		local LoadSequenceText = SetProps(MakeElement("Label", WindowConfig.IntroText, 14), {
			Parent = Orion,
			Size = UDim2.new(1, 0, 1, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 19, 0.5, 0),
			TextXAlignment = Enum.TextXAlignment.Center,
			Font = Enum.Font.GothamBold,
			TextTransparency = 1
		})

		TweenService:Create(LoadSequenceLogo, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0, Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
		wait(0.8)
		TweenService:Create(LoadSequenceLogo, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -(LoadSequenceText.TextBounds.X/2), 0.5, 0)}):Play()
		wait(0.3)
		TweenService:Create(LoadSequenceText, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
		wait(2)
		TweenService:Create(LoadSequenceText, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
		MainWindow.Visible = true
		LoadSequenceLogo:Destroy()
		LoadSequenceText:Destroy()
	end

	if WindowConfig.IntroEnabled then
		LoadSequence()
	end




    local TabAnimationStates = {}
    local TAB_ENTRY_DURATION = 0.30
    local TAB_ENTRY_STAGGER = 0.05

    local function UpdateTabCanvas(Container)
        if not Container or not Container.Parent then
            return
        end

        local Layout = Container:FindFirstChildOfClass("UIListLayout")
        if Layout then
            Container.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 30)
        end
    end

    local function RestoreTabEntryAnimation(Container, State)
        if not State then
            return
        end

        State.Cancelled = true

        for _, Tween in ipairs(State.Tweens or {}) do
            pcall(function()
                Tween:Cancel()
            end)
        end

        for _, Entry in ipairs(State.Items or {}) do
            if Entry.SizeConnection then
                pcall(function()
                    Entry.SizeConnection:Disconnect()
                end)
                Entry.SizeConnection = nil
            end

            local Object = Entry.Object
            local Wrapper = Entry.Wrapper
            if Object and Wrapper and Object.Parent == Wrapper then
                pcall(function()
                    Object.Position = Entry.OriginalPosition
                    Object.Size = Entry.OriginalSize
                    Object.AnchorPoint = Entry.OriginalAnchorPoint
                    Object.Parent = Container
                end)
            elseif Object and Object.Parent == Container then
                pcall(function()
                    Object.Position = Entry.OriginalPosition
                    Object.Size = Entry.OriginalSize
                    Object.AnchorPoint = Entry.OriginalAnchorPoint
                end)
            end

            if Wrapper then
                pcall(function()
                    Wrapper:Destroy()
                end)
                Entry.Wrapper = nil
            end
        end

        if TabAnimationStates[Container] == State then
            TabAnimationStates[Container] = nil
        end

        task.defer(function()
            UpdateTabCanvas(Container)
        end)
    end

    local function StopTabEntryAnimation(Container)
        local State = TabAnimationStates[Container]
        if State then
            RestoreTabEntryAnimation(Container, State)
        end
    end

    local function AnimateTabEntry(Container)
        if not Container or not Container.Parent then
            return
        end

        StopTabEntryAnimation(Container)

        local State = {
            Items = {},
            Tweens = {},
            Cancelled = false,
            Completed = 0,
            Pending = true
        }
        TabAnimationStates[Container] = State


        task.defer(function()
            if TabAnimationStates[Container] ~= State or State.Cancelled then
                return
            end
            if not Container.Parent or not Container.Visible then
                RestoreTabEntryAnimation(Container, State)
                return
            end

            for _, Child in ipairs(Container:GetChildren()) do
                if Child:IsA("GuiObject") and Child.Visible then
                    table.insert(State.Items, {
                        Object = Child,
                        OriginalParent = Container,
                        OriginalPosition = Child.Position,
                        OriginalSize = Child.Size,
                        OriginalAnchorPoint = Child.AnchorPoint,
                        OriginalLayoutOrder = Child.LayoutOrder,
                        SortY = Child.AbsolutePosition.Y,
                        SortX = Child.AbsolutePosition.X,
                        InitialWidth = Child.AbsoluteSize.X
                    })
                end
            end

            table.sort(State.Items, function(A, B)
                if A.SortY == B.SortY then
                    return A.SortX < B.SortX
                end
                return A.SortY < B.SortY
            end)

            if #State.Items == 0 then
                if TabAnimationStates[Container] == State then
                    TabAnimationStates[Container] = nil
                end
                UpdateTabCanvas(Container)
                return
            end

            State.Pending = false
            local EntryStagger = math.min(TAB_ENTRY_STAGGER, 0.65 / math.max(#State.Items - 1, 1))



            for Index, Entry in ipairs(State.Items) do
                local Object = Entry.Object
                local Wrapper = Instance.new("Frame")
                Wrapper.Name = "__OrionTabEntryClip"
                Wrapper.BackgroundTransparency = 1
                Wrapper.BorderSizePixel = 0
                Wrapper.ClipsDescendants = true
                Wrapper.Size = Entry.OriginalSize
                Wrapper.LayoutOrder = Index
                Wrapper.ZIndex = Object.ZIndex
                Wrapper.Active = false
                Wrapper.Selectable = false
                Entry.Wrapper = Wrapper

                Object.Parent = Wrapper
                Object.AnchorPoint = Entry.OriginalAnchorPoint
                Object.Size = UDim2.new(1, 0, 1, 0)
                Object.Position = UDim2.fromOffset(math.max(Entry.InitialWidth, 46), 0)
                Wrapper.Parent = Container


                Entry.SizeConnection = Object:GetPropertyChangedSignal("Size"):Connect(function()
                    if not State.Cancelled and Entry.Wrapper and Entry.Wrapper.Parent == Container then
                        Entry.OriginalSize = Object.Size
                        Entry.Wrapper.Size = Object.Size
                    end
                end)
            end

            local function FinishAnimation()
                if TabAnimationStates[Container] ~= State then
                    return
                end
                RestoreTabEntryAnimation(Container, State)
            end

            for Index, Entry in ipairs(State.Items) do
                task.delay((Index - 1) * EntryStagger, function()
                    if TabAnimationStates[Container] ~= State or State.Cancelled then
                        return
                    end
                    if not Container.Parent or not Container.Visible then
                        RestoreTabEntryAnimation(Container, State)
                        return
                    end

                    local Object = Entry.Object
                    local Wrapper = Entry.Wrapper
                    if not Object or not Wrapper or Object.Parent ~= Wrapper or Wrapper.Parent ~= Container then
                        State.Completed = State.Completed + 1
                        if State.Completed >= #State.Items then
                            FinishAnimation()
                        end
                        return
                    end

                    local Tween = TweenService:Create(
                        Object,
                        TweenInfo.new(TAB_ENTRY_DURATION, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut),
                        {Position = UDim2.new(0, 0, 0, 0)}
                    )
                    table.insert(State.Tweens, Tween)

                    local CompletionConnection
                    CompletionConnection = Tween.Completed:Connect(function(PlaybackState)
                        if CompletionConnection then
                            CompletionConnection:Disconnect()
                            CompletionConnection = nil
                        end

                        if PlaybackState ~= Enum.PlaybackState.Completed or TabAnimationStates[Container] ~= State then
                            return
                        end

                        State.Completed = State.Completed + 1
                        if State.Completed >= #State.Items then
                            FinishAnimation()
                        end
                    end)

                    Tween:Play()
                end)
            end
        end)
    end

	local ActiveTabContainer = nil
	local TabFunction = {}
	function TabFunction:MakeTab(TabConfig)
		TabConfig = TabConfig or {}
		TabConfig.Name = TabConfig.Name or "Tab"
		TabConfig.Icon = TabConfig.Icon or ""
		TabConfig.PremiumOnly = TabConfig.PremiumOnly or false

		local TabFrame = SetChildren(SetProps(MakeElement("Button"), {
			Size = UDim2.new(1, 0, 0, 30),
			Parent = TabHolder
		}), {
			AddThemeObject(SetProps(MakeElement("Image", TabConfig.Icon), {
				AnchorPoint = Vector2.new(0, 0.5),
				Size = UDim2.new(0, 18, 0, 18),
				Position = UDim2.new(0, 10, 0.5, 0),
				ImageTransparency = 0.4,
				Name = "Ico"
			}), "Text"),
			AddThemeObject(SetProps(MakeElement("Label", TabConfig.Name, 14), {
				Size = UDim2.new(1, -35, 1, 0),
				Position = UDim2.new(0, 35, 0, 0),
				Font = Enum.Font.GothamSemibold,
				TextTransparency = 0.4,
				Name = "Title"
			}), "Text")
		})

		if GetIcon(TabConfig.Icon) ~= nil then
			TabFrame.Ico.Image = GetIcon(TabConfig.Icon)
		end

		AddItemTable(Tabs, TabConfig.Name, TabFrame)

		local Container = AddThemeObject(SetChildren(SetProps(MakeElement("ScrollFrame", Color3.fromRGB(255, 255, 255), 5), {
			Size = UDim2.new(1, -150, 1, -50),
			Position = UDim2.new(0, 150, 0, 50),
			Parent = MainWindow,
			Visible = false,
			Name = "ItemContainer"
		}), {
			MakeElement("List", 0, 6),
			MakeElement("Padding", 15, 10, 10, 15)
		}), "Divider")

		local ContainerLayout = Container:FindFirstChildOfClass("UIListLayout")
		if ContainerLayout then
			AddConnection(ContainerLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
				if not TabAnimationStates[Container] and Container.Parent then
					Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y + 30)
				end
			end)
		end

		if FirstTab then
			FirstTab = false
			TabFrame.Ico.ImageTransparency = 0
			TabFrame.Title.TextTransparency = 0
			TabFrame.Title.Font = Enum.Font.GothamBlack
			Container.Visible = true
			ActiveTabContainer = Container


			task.delay(0.2, function()
				if Container.Parent and Container.Visible then
					AnimateTabEntry(Container)
				end
			end)
		end

		AddConnection(TabFrame.MouseButton1Click, function()
			if ActiveTabContainer == Container then
				return
			end
			ActiveTabContainer = Container
			for _, Tab in next, TabHolder:GetChildren() do
				if Tab:IsA("TextButton") then
					Tab.Title.Font = Enum.Font.GothamSemibold
					TweenService:Create(Tab.Ico, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 0.4}):Play()
					TweenService:Create(Tab.Title, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 0.4}):Play()
				end
			end
			for _, ItemContainer in next, MainWindow:GetChildren() do
				if ItemContainer.Name == "ItemContainer" then
					StopTabEntryAnimation(ItemContainer)
					ItemContainer.Visible = false
				end
			end
			TweenService:Create(TabFrame.Ico, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
			TweenService:Create(TabFrame.Title, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
			TabFrame.Title.Font = Enum.Font.GothamBlack
			Container.Visible = true
			AnimateTabEntry(Container)
		end)

		local function GetElements(ItemParent)
			local ElementFunction = {}
			function ElementFunction:AddLabel(Text)
    local ContentLabel = AddThemeObject(SetProps(MakeElement("Label", Text, 15), {
        Size = UDim2.new(1, -12, 1, 0),
        Position = UDim2.new(0, 12, 0, 0),
        Font = Enum.Font.GothamBold,
        Name = "Content"
    }), "Text")

    local LabelFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
        Size = UDim2.new(1, 0, 0, 30),
        BackgroundTransparency = 0.7,
        Parent = ItemParent
    }), {
        ContentLabel,
        AddThemeObject(MakeElement("Stroke"), "Stroke")
    }), "Second")

    local LabelFunction = {}
    function LabelFunction:Set(ToChange)
        ContentLabel.Text = ToChange
    end
    return LabelFunction
end
			function ElementFunction:AddParagraph(Text, Content)
				Text = Text or "Text"
				Content = Content or "Content"

				local ParagraphFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
					Size = UDim2.new(1, 0, 0, 30),
					BackgroundTransparency = 0.7,
					Parent = ItemParent
				}), {
					AddThemeObject(SetProps(MakeElement("Label", Text, 15), {
						Size = UDim2.new(1, -12, 0, 14),
						Position = UDim2.new(0, 12, 0, 10),
						Font = Enum.Font.GothamBold,
						Name = "Title"
					}), "Text"),
					AddThemeObject(SetProps(MakeElement("Label", "", 13), {
						Size = UDim2.new(1, -24, 0, 0),
						Position = UDim2.new(0, 12, 0, 26),
						Font = Enum.Font.GothamSemibold,
						Name = "Content",
						TextWrapped = true
					}), "TextDark"),
					AddThemeObject(MakeElement("Stroke"), "Stroke")
				}), "Second")

				AddConnection(ParagraphFrame.Content:GetPropertyChangedSignal("Text"), function()
					ParagraphFrame.Content.Size = UDim2.new(1, -24, 0, ParagraphFrame.Content.TextBounds.Y)
					ParagraphFrame.Size = UDim2.new(1, 0, 0, ParagraphFrame.Content.TextBounds.Y + 35)
				end)

				ParagraphFrame.Content.Text = Content

				local ParagraphFunction = {}
				function ParagraphFunction:Set(ToChange)
					ParagraphFrame.Content.Text = ToChange
				end
				return ParagraphFunction
			end
			function ElementFunction:AddButton(ButtonConfig)
				ButtonConfig = ButtonConfig or {}
				ButtonConfig.Name = ButtonConfig.Name or "Button"
				ButtonConfig.Callback = ButtonConfig.Callback or function() end
				ButtonConfig.Icon = ButtonConfig.Icon or "rbxassetid://3944703587"

				local Button = {}

				local Click = SetProps(MakeElement("Button"), {
					Size = UDim2.new(1, 0, 1, 0)
				})

				local ButtonFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
					Size = UDim2.new(1, 0, 0, 33),
					Parent = ItemParent
				}), {
					AddThemeObject(SetProps(MakeElement("Label", ButtonConfig.Name, 15), {
						Size = UDim2.new(1, -12, 1, 0),
						Position = UDim2.new(0, 12, 0, 0),
						Font = Enum.Font.GothamBold,
						Name = "Content"
					}), "Text"),
					AddThemeObject(SetProps(MakeElement("Image", ButtonConfig.Icon), {
						Size = UDim2.new(0, 20, 0, 20),
						Position = UDim2.new(1, -30, 0, 7),
					}), "TextDark"),
					AddThemeObject(MakeElement("Stroke"), "Stroke"),
					Click
				}), "Second")

				AddConnection(Click.MouseEnter, function()
					TweenService:Create(ButtonFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 3)}):Play()
				end)

				AddConnection(Click.MouseLeave, function()
					TweenService:Create(ButtonFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Second}):Play()
				end)

				AddConnection(Click.MouseButton1Up, function()
					TweenService:Create(ButtonFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 3)}):Play()
					task.spawn(function()
						ButtonConfig.Callback()
					end)
				end)

				AddConnection(Click.MouseButton1Down, function()
					TweenService:Create(ButtonFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 6, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 6, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 6)}):Play()
				end)

				function Button:Set(ButtonText)
					ButtonFrame.Content.Text = ButtonText
				end

				return Button
			end
			function ElementFunction:AddToggle(ToggleConfig)
				ToggleConfig = ToggleConfig or {}
				ToggleConfig.Name = ToggleConfig.Name or "Toggle"
				ToggleConfig.Default = ToggleConfig.Default or false
				ToggleConfig.Callback = ToggleConfig.Callback or function() end
				ToggleConfig.Color = ToggleConfig.Color or Color3.fromRGB(9, 99, 195)
				ToggleConfig.Flag = ToggleConfig.Flag or nil
				ToggleConfig.Save = ToggleConfig.Save or false

				local Toggle = {Value = ToggleConfig.Default, Save = ToggleConfig.Save}

				local Click = SetProps(MakeElement("Button"), {
					Size = UDim2.new(1, 0, 1, 0)
				})

				local ToggleBox = SetChildren(SetProps(MakeElement("RoundFrame", ToggleConfig.Color, 0, 4), {
					Size = UDim2.new(0, 24, 0, 24),
					Position = UDim2.new(1, -24, 0.5, 0),
					AnchorPoint = Vector2.new(0.5, 0.5)
				}), {
					SetProps(MakeElement("Stroke"), {
						Color = ToggleConfig.Color,
						Name = "Stroke",
						Transparency = 0.5
					}),
					SetProps(MakeElement("Image", "rbxassetid://3944680095"), {
						Size = UDim2.new(0, 20, 0, 20),
						AnchorPoint = Vector2.new(0.5, 0.5),
						Position = UDim2.new(0.5, 0, 0.5, 0),
						ImageColor3 = Color3.fromRGB(255, 255, 255),
						Name = "Ico"
					}),
				})

				local ToggleFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
					Size = UDim2.new(1, 0, 0, 38),
					Parent = ItemParent
				}), {
					AddThemeObject(SetProps(MakeElement("Label", ToggleConfig.Name, 15), {
						Size = UDim2.new(1, -12, 1, 0),
						Position = UDim2.new(0, 12, 0, 0),
						Font = Enum.Font.GothamBold,
						Name = "Content"
					}), "Text"),
					AddThemeObject(MakeElement("Stroke"), "Stroke"),
					ToggleBox,
					Click
				}), "Second")

				function Toggle:Set(Value)
					Toggle.Value = Value
					TweenService:Create(ToggleBox, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Toggle.Value and ToggleConfig.Color or OrionLib.Themes[OrionLib.SelectedTheme].Divider}):Play()
					TweenService:Create(ToggleBox.Stroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Color = Toggle.Value and ToggleConfig.Color or OrionLib.Themes[OrionLib.SelectedTheme].Stroke}):Play()
					TweenService:Create(ToggleBox.Ico, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = Toggle.Value and 0 or 1, Size = Toggle.Value and UDim2.new(0, 20, 0, 20) or UDim2.new(0, 8, 0, 8)}):Play()
					ToggleConfig.Callback(Toggle.Value)
				end

				Toggle:Set(Toggle.Value)

				AddConnection(Click.MouseEnter, function()
					TweenService:Create(ToggleFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 3)}):Play()
				end)

				AddConnection(Click.MouseLeave, function()
					TweenService:Create(ToggleFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Second}):Play()
				end)

				AddConnection(Click.MouseButton1Up, function()
					TweenService:Create(ToggleFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 3)}):Play()
					Toggle:Set(not Toggle.Value)
					SaveCfg(game.GameId)
				end)

				AddConnection(Click.MouseButton1Down, function()
					TweenService:Create(ToggleFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 6, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 6, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 6)}):Play()
				end)

				if ToggleConfig.Flag then
					OrionLib.Flags[ToggleConfig.Flag] = Toggle
				end
				return Toggle
			end
			function ElementFunction:AddSlider(SliderConfig)
				SliderConfig = SliderConfig or {}
				SliderConfig.Name = SliderConfig.Name or "Slider"
				SliderConfig.Min = type(SliderConfig.Min) == "number" and SliderConfig.Min or 0
				SliderConfig.Max = type(SliderConfig.Max) == "number" and SliderConfig.Max or 100
				SliderConfig.Increment = type(SliderConfig.Increment) == "number" and SliderConfig.Increment or 1
				if SliderConfig.Increment <= 0 then
					SliderConfig.Increment = 1
				end
				if SliderConfig.Max <= SliderConfig.Min then
					SliderConfig.Max = SliderConfig.Min + SliderConfig.Increment
				end
				SliderConfig.Default = type(SliderConfig.Default) == "number" and SliderConfig.Default or 50
				SliderConfig.Default = math.clamp(SliderConfig.Default, SliderConfig.Min, SliderConfig.Max)
				SliderConfig.Callback = SliderConfig.Callback or function() end
				SliderConfig.ValueName = SliderConfig.ValueName or ""
				SliderConfig.Color = SliderConfig.Color or Color3.fromRGB(9, 149, 98)
				SliderConfig.Flag = SliderConfig.Flag or nil
				SliderConfig.Save = SliderConfig.Save or false

				local Slider = {Value = SliderConfig.Default, Save = SliderConfig.Save}
				local Dragging = false
                local ActiveSliderTouch = nil

				local SliderDrag = SetChildren(SetProps(MakeElement("RoundFrame", SliderConfig.Color, 0, 5), {
					Size = UDim2.new(0, 0, 1, 0),
					BackgroundTransparency = 0.3,
					ClipsDescendants = true
				}), {
					AddThemeObject(SetProps(MakeElement("Label", "value", 13), {
						Size = UDim2.new(1, -12, 0, 14),
						Position = UDim2.new(0, 12, 0, 6),
						Font = Enum.Font.GothamBold,
						Name = "Value",
						TextTransparency = 0
					}), "Text")
				})

				local SliderBar = SetChildren(SetProps(MakeElement("RoundFrame", SliderConfig.Color, 0, 5), {
					Size = UDim2.new(1, -24, 0, 26),
					Position = UDim2.new(0, 12, 0, 30),
					BackgroundTransparency = 0.9
				}), {
					SetProps(MakeElement("Stroke"), {
						Color = SliderConfig.Color
					}),
					AddThemeObject(SetProps(MakeElement("Label", "value", 13), {
						Size = UDim2.new(1, -12, 0, 14),
						Position = UDim2.new(0, 12, 0, 6),
						Font = Enum.Font.GothamBold,
						Name = "Value",
						TextTransparency = 0.8
					}), "Text"),
					SliderDrag
				})

				local SliderFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 4), {
					Size = UDim2.new(1, 0, 0, 65),
					Parent = ItemParent
				}), {
					AddThemeObject(SetProps(MakeElement("Label", SliderConfig.Name, 15), {
						Size = UDim2.new(1, -12, 0, 14),
						Position = UDim2.new(0, 12, 0, 10),
						Font = Enum.Font.GothamBold,
						Name = "Content"
					}), "Text"),
					AddThemeObject(MakeElement("Stroke"), "Stroke"),
					SliderBar
				}), "Second")

                local function SetSliderFromX(PositionX)
                    local BarWidth = SliderBar.AbsoluteSize.X
                    if BarWidth <= 0 then
                        return
                    end
                    local SizeScale = math.clamp((PositionX - SliderBar.AbsolutePosition.X) / BarWidth, 0, 1)
                    Slider:Set(SliderConfig.Min + ((SliderConfig.Max - SliderConfig.Min) * SizeScale))
                end

                AddConnection(SliderBar.InputBegan, function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                        Dragging = true
                        ActiveSliderTouch = nil
                        SetSliderFromX(Input.Position.X)
                    elseif Input.UserInputType == Enum.UserInputType.Touch then
                        Dragging = true
                        ActiveSliderTouch = Input
                        SetSliderFromX(Input.Position.X)
                    end
                end)

                AddConnection(UserInputService.InputChanged, function(Input)
                    if not Dragging then
                        return
                    end
                    if ActiveSliderTouch then
                        if Input ~= ActiveSliderTouch then
                            return
                        end
                        SetSliderFromX(Input.Position.X)
                    elseif Input.UserInputType == Enum.UserInputType.MouseMovement then
                        SetSliderFromX(Input.Position.X)
                    end
                end)

                AddConnection(UserInputService.InputEnded, function(Input)
                    local MouseReleased = ActiveSliderTouch == nil and Input.UserInputType == Enum.UserInputType.MouseButton1
                    local TouchReleased = ActiveSliderTouch ~= nil and Input == ActiveSliderTouch
                    if Dragging and (MouseReleased or TouchReleased) then
                        Dragging = false
                        ActiveSliderTouch = nil
                        SaveCfg(game.GameId)
                    end
                end)

                local SliderFillTween = nil

                function Slider:Set(Value)
                    if type(Value) ~= "number" then
                        return self.Value
                    end

                    self.Value = math.clamp(Round(Value, SliderConfig.Increment), SliderConfig.Min, SliderConfig.Max)
                    local Range = SliderConfig.Max - SliderConfig.Min
                    local FillScale = Range ~= 0 and ((self.Value - SliderConfig.Min) / Range) or 0
                    local TargetSize = UDim2.fromScale(math.clamp(FillScale, 0, 1), 1)



                    if SliderFillTween then
                        pcall(function()
                            SliderFillTween:Cancel()
                        end)
                        SliderFillTween = nil
                    end

                    local TweenSuccess, NewTween = pcall(function()
                        return TweenService:Create(
                            SliderDrag,
                            TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Size = TargetSize}
                        )
                    end)

                    if TweenSuccess and NewTween then
                        SliderFillTween = NewTween
                        NewTween:Play()
                    else

                        SliderDrag.Size = TargetSize
                    end

                    SliderBar.Value.Text = tostring(self.Value) .. " " .. SliderConfig.ValueName
                    SliderDrag.Value.Text = tostring(self.Value) .. " " .. SliderConfig.ValueName
                    SliderConfig.Callback(self.Value)
                    return self.Value
                end

				Slider:Set(Slider.Value)
				if SliderConfig.Flag then
					OrionLib.Flags[SliderConfig.Flag] = Slider
				end
				return Slider
			end
			function ElementFunction:AddDropdown(DropdownConfig)
				DropdownConfig = DropdownConfig or {}
				DropdownConfig.Name = DropdownConfig.Name or "Dropdown"
				DropdownConfig.Options = DropdownConfig.Options or {}
				DropdownConfig.Default = DropdownConfig.Default or ""
				DropdownConfig.Callback = DropdownConfig.Callback or function() end
				DropdownConfig.Flag = DropdownConfig.Flag or nil
				DropdownConfig.Save = DropdownConfig.Save or false

				local Dropdown = {Value = DropdownConfig.Default, Options = DropdownConfig.Options, Buttons = {}, ButtonConnections = {}, Toggled = false, Type = "Dropdown", Save = DropdownConfig.Save}
				local MaxElements = 5

				if not table.find(Dropdown.Options, Dropdown.Value) then
					Dropdown.Value = "..."
				end

				local DropdownList = MakeElement("List")

				local DropdownContainer = AddThemeObject(SetProps(SetChildren(MakeElement("ScrollFrame", Color3.fromRGB(40, 40, 40), 4), {
					DropdownList
				}), {
					Parent = ItemParent,
					Position = UDim2.new(0, 0, 0, 38),
					Size = UDim2.new(1, 0, 1, -38),
					ClipsDescendants = true
				}), "Divider")

				local Click = SetProps(MakeElement("Button"), {
					Size = UDim2.new(1, 0, 1, 0)
				})

				local DropdownFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
					Size = UDim2.new(1, 0, 0, 38),
					Parent = ItemParent,
					ClipsDescendants = true
				}), {
					DropdownContainer,
					SetProps(SetChildren(MakeElement("TFrame"), {
						AddThemeObject(SetProps(MakeElement("Label", DropdownConfig.Name, 15), {
							Size = UDim2.new(1, -12, 1, 0),
							Position = UDim2.new(0, 12, 0, 0),
							Font = Enum.Font.GothamBold,
							Name = "Content"
						}), "Text"),
						AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://7072706796"), {
							Size = UDim2.new(0, 20, 0, 20),
							AnchorPoint = Vector2.new(0, 0.5),
							Position = UDim2.new(1, -30, 0.5, 0),
							ImageColor3 = Color3.fromRGB(240, 240, 240),
							Name = "Ico"
						}), "TextDark"),
						AddThemeObject(SetProps(MakeElement("Label", "Selected", 13), {
							Size = UDim2.new(1, -40, 1, 0),
							Font = Enum.Font.Gotham,
							Name = "Selected",
							TextXAlignment = Enum.TextXAlignment.Right
						}), "TextDark"),
						AddThemeObject(SetProps(MakeElement("Frame"), {
							Size = UDim2.new(1, 0, 0, 1),
							Position = UDim2.new(0, 0, 1, -1),
							Name = "Line",
							Visible = false
						}), "Stroke"),
						Click
					}), {
						Size = UDim2.new(1, 0, 0, 38),
						ClipsDescendants = true,
						Name = "F"
					}),
					AddThemeObject(MakeElement("Stroke"), "Stroke"),
					MakeElement("Corner")
				}), "Second")

				AddConnection(DropdownList:GetPropertyChangedSignal("AbsoluteContentSize"), function()
					DropdownContainer.CanvasSize = UDim2.new(0, 0, 0, DropdownList.AbsoluteContentSize.Y)
				end)

				local function AddOptions(Options)
					for _, Option in pairs(Options) do
						local OptionBtn = AddThemeObject(SetProps(SetChildren(MakeElement("Button", Color3.fromRGB(40, 40, 40)), {
							MakeElement("Corner", 0, 6),
							AddThemeObject(SetProps(MakeElement("Label", Option, 13, 0.4), {
								Position = UDim2.new(0, 8, 0, 0),
								Size = UDim2.new(1, -8, 1, 0),
								Name = "Title"
							}), "Text")
						}), {
							Parent = DropdownContainer,
							Size = UDim2.new(1, 0, 0, 28),
							BackgroundTransparency = 1,
							ClipsDescendants = true
						}), "Divider")

                        local OptionConnection = AddConnection(OptionBtn.MouseButton1Click, function()
                            Dropdown:Set(Option)
                            SaveCfg(game.GameId)
                        end)

                        Dropdown.Buttons[Option] = OptionBtn
                        Dropdown.ButtonConnections[OptionBtn] = OptionConnection
					end
				end

                function Dropdown:Refresh(Options, Delete)

                    local IncomingOptions = {}
                    local IncomingSeen = {}
                    if type(Options) == "table" then
                        for _, Option in ipairs(Options) do
                            if Option ~= nil and not IncomingSeen[Option] then
                                IncomingSeen[Option] = true
                                table.insert(IncomingOptions, Option)
                            end
                        end
                    end



                    if Delete == true then
                        for ButtonObject, Connection in pairs(Dropdown.ButtonConnections) do
                            DisconnectConnection(Connection)
                            Dropdown.ButtonConnections[ButtonObject] = nil
                        end
                        for _, ButtonObject in pairs(Dropdown.Buttons) do
                            if ButtonObject then
                                RemoveThemeObjectReferences(ButtonObject)
                                ButtonObject:Destroy()
                            end
                        end
                        table.clear(Dropdown.Buttons)
                        table.clear(Dropdown.Options)
                    end

                    local ExistingOptions = {}
                    for _, Option in ipairs(Dropdown.Options) do
                        ExistingOptions[Option] = true
                    end

                    local OptionsToAdd = {}
                    for _, Option in ipairs(IncomingOptions) do
                        if not ExistingOptions[Option] then
                            ExistingOptions[Option] = true
                            table.insert(Dropdown.Options, Option)
                            table.insert(OptionsToAdd, Option)
                        end
                    end

                    AddOptions(OptionsToAdd)
                    DropdownContainer.CanvasSize = UDim2.new(0, 0, 0, DropdownList.AbsoluteContentSize.Y)

                    if not table.find(Dropdown.Options, Dropdown.Value) then
                        Dropdown.Value = "..."
                        DropdownFrame.F.Selected.Text = Dropdown.Value

                        for _, ButtonObject in pairs(Dropdown.Buttons) do
                            pcall(function()
                                TweenService:Create(
                                    ButtonObject,
                                    TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                    {BackgroundTransparency = 1}
                                ):Play()
                            end)

                            local Title = ButtonObject:FindFirstChild("Title")
                            if Title then
                                pcall(function()
                                    TweenService:Create(
                                        Title,
                                        TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                        {TextTransparency = 0.4}
                                    ):Play()
                                end)
                            end
                        end
                    else
                        DropdownFrame.F.Selected.Text = Dropdown.Value



                        for _, ButtonObject in pairs(Dropdown.Buttons) do
                            pcall(function()
                                TweenService:Create(
                                    ButtonObject,
                                    TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                    {BackgroundTransparency = 1}
                                ):Play()
                            end)

                            local Title = ButtonObject:FindFirstChild("Title")
                            if Title then
                                pcall(function()
                                    TweenService:Create(
                                        Title,
                                        TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                        {TextTransparency = 0.4}
                                    ):Play()
                                end)
                            end
                        end

                        local SelectedButton = Dropdown.Buttons[Dropdown.Value]
                        if SelectedButton then
                            pcall(function()
                                TweenService:Create(
                                    SelectedButton,
                                    TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                    {BackgroundTransparency = 0}
                                ):Play()
                            end)

                            local SelectedTitle = SelectedButton:FindFirstChild("Title")
                            if SelectedTitle then
                                pcall(function()
                                    TweenService:Create(
                                        SelectedTitle,
                                        TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                        {TextTransparency = 0}
                                    ):Play()
                                end)
                            end
                        end
                    end
                end

				function Dropdown:Set(Value)
					if not table.find(Dropdown.Options, Value) then
						Dropdown.Value = "..."
						DropdownFrame.F.Selected.Text = Dropdown.Value
						for _, v in pairs(Dropdown.Buttons) do
							TweenService:Create(v,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{BackgroundTransparency = 1}):Play()
							TweenService:Create(v.Title,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{TextTransparency = 0.4}):Play()
						end
						return
					end

					Dropdown.Value = Value
					DropdownFrame.F.Selected.Text = Dropdown.Value

					for _, v in pairs(Dropdown.Buttons) do
						TweenService:Create(v,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{BackgroundTransparency = 1}):Play()
						TweenService:Create(v.Title,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{TextTransparency = 0.4}):Play()
					end
                    local SelectedButton = Dropdown.Buttons[Value]
                    if SelectedButton then
                        TweenService:Create(SelectedButton, TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
                        TweenService:Create(SelectedButton.Title, TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
                    end
                    return DropdownConfig.Callback(Dropdown.Value)
				end

				AddConnection(Click.MouseButton1Click, function()
					Dropdown.Toggled = not Dropdown.Toggled
					DropdownFrame.F.Line.Visible = Dropdown.Toggled
					TweenService:Create(DropdownFrame.F.Ico,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{Rotation = Dropdown.Toggled and 180 or 0}):Play()
					if #Dropdown.Options > MaxElements then
						TweenService:Create(DropdownFrame,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{Size = Dropdown.Toggled and UDim2.new(1, 0, 0, 38 + (MaxElements * 28)) or UDim2.new(1, 0, 0, 38)}):Play()
					else
						TweenService:Create(DropdownFrame,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{Size = Dropdown.Toggled and UDim2.new(1, 0, 0, DropdownList.AbsoluteContentSize.Y + 38) or UDim2.new(1, 0, 0, 38)}):Play()
					end
				end)

				Dropdown:Refresh(Dropdown.Options, true)
				Dropdown:Set(Dropdown.Value)
				if DropdownConfig.Flag then
					OrionLib.Flags[DropdownConfig.Flag] = Dropdown
				end
				return Dropdown
			end
			function ElementFunction:AddBind(BindConfig)
				BindConfig.Name = BindConfig.Name or "Bind"
				BindConfig.Default = BindConfig.Default or Enum.KeyCode.Unknown
				BindConfig.Hold = BindConfig.Hold or false
				BindConfig.Callback = BindConfig.Callback or function() end
				BindConfig.Flag = BindConfig.Flag or nil
				BindConfig.Save = BindConfig.Save or false

				local Bind = {Value = BindConfig.Default, Binding = false, Type = "Bind", Save = BindConfig.Save}
				local Holding = false

				local Click = SetProps(MakeElement("Button"), {
					Size = UDim2.new(1, 0, 1, 0)
				})

				local BindBox = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 4), {
					Size = UDim2.new(0, 24, 0, 24),
					Position = UDim2.new(1, -12, 0.5, 0),
					AnchorPoint = Vector2.new(1, 0.5)
				}), {
					AddThemeObject(MakeElement("Stroke"), "Stroke"),
					AddThemeObject(SetProps(MakeElement("Label", BindConfig.Name, 14), {
						Size = UDim2.new(1, 0, 1, 0),
						Font = Enum.Font.GothamBold,
						TextXAlignment = Enum.TextXAlignment.Center,
						Name = "Value"
					}), "Text")
				}), "Main")

				local BindFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
					Size = UDim2.new(1, 0, 0, 38),
					Parent = ItemParent
				}), {
					AddThemeObject(SetProps(MakeElement("Label", BindConfig.Name, 15), {
						Size = UDim2.new(1, -12, 1, 0),
						Position = UDim2.new(0, 12, 0, 0),
						Font = Enum.Font.GothamBold,
						Name = "Content"
					}), "Text"),
					AddThemeObject(MakeElement("Stroke"), "Stroke"),
					BindBox,
					Click
				}), "Second")

				AddConnection(BindBox.Value:GetPropertyChangedSignal("Text"), function()

					TweenService:Create(BindBox, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, BindBox.Value.TextBounds.X + 16, 0, 24)}):Play()
				end)

				AddConnection(Click.InputEnded, function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 then
						if Bind.Binding then return end
						Bind.Binding = true
						BindBox.Value.Text = ""
					end
				end)

				AddConnection(UserInputService.InputBegan, function(Input)
					if UserInputService:GetFocusedTextBox() then return end
					if (Input.KeyCode.Name == Bind.Value or Input.UserInputType.Name == Bind.Value) and not Bind.Binding then
						if BindConfig.Hold then
							Holding = true
							BindConfig.Callback(Holding)
						else
							BindConfig.Callback()
						end
					elseif Bind.Binding then
						local Key
						pcall(function()
							if not CheckKey(BlacklistedKeys, Input.KeyCode) then
								Key = Input.KeyCode
							end
						end)
						pcall(function()
							if CheckKey(WhitelistedMouse, Input.UserInputType) and not Key then
								Key = Input.UserInputType
							end
						end)
						Key = Key or Bind.Value
						Bind:Set(Key)
						SaveCfg(game.GameId)
					end
				end)

				AddConnection(UserInputService.InputEnded, function(Input)
					if Input.KeyCode.Name == Bind.Value or Input.UserInputType.Name == Bind.Value then
						if BindConfig.Hold and Holding then
							Holding = false
							BindConfig.Callback(Holding)
						end
					end
				end)

				AddConnection(Click.MouseEnter, function()
					TweenService:Create(BindFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 3)}):Play()
				end)

				AddConnection(Click.MouseLeave, function()
					TweenService:Create(BindFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Second}):Play()
				end)

				AddConnection(Click.MouseButton1Up, function()
					TweenService:Create(BindFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 3)}):Play()
				end)

				AddConnection(Click.MouseButton1Down, function()
					TweenService:Create(BindFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 6, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 6, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 6)}):Play()
				end)

                function Bind:Set(Key)
                    Bind.Binding = false
                    local NewValue = Key or Bind.Value or BindConfig.Default
                    if typeof(NewValue) == "EnumItem" then
                        NewValue = NewValue.Name
                    end
                    Bind.Value = tostring(NewValue)
                    BindBox.Value.Text = Bind.Value
                    return Bind.Value
                end

				Bind:Set(BindConfig.Default)
				if BindConfig.Flag then
					OrionLib.Flags[BindConfig.Flag] = Bind
				end
				return Bind
			end
			function ElementFunction:AddTextbox(TextboxConfig)
				TextboxConfig = TextboxConfig or {}
				TextboxConfig.Name = TextboxConfig.Name or "Textbox"
				TextboxConfig.Default = TextboxConfig.Default or ""
				TextboxConfig.TextDisappear = TextboxConfig.TextDisappear or false
				TextboxConfig.Callback = TextboxConfig.Callback or function() end

				local Click = SetProps(MakeElement("Button"), {
					Size = UDim2.new(1, 0, 1, 0)
				})

				local TextboxActual = AddThemeObject(Create("TextBox", {
					Size = UDim2.new(1, 0, 1, 0),
					BackgroundTransparency = 1,
					TextColor3 = Color3.fromRGB(255, 255, 255),
					PlaceholderColor3 = Color3.fromRGB(210,210,210),
					PlaceholderText = "Input",
					Font = Enum.Font.GothamSemibold,
					TextXAlignment = Enum.TextXAlignment.Center,
					TextSize = 14,
					ClearTextOnFocus = false
				}), "Text")

				local TextContainer = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 4), {
					Size = UDim2.new(0, 24, 0, 24),
					Position = UDim2.new(1, -12, 0.5, 0),
					AnchorPoint = Vector2.new(1, 0.5)
				}), {
					AddThemeObject(MakeElement("Stroke"), "Stroke"),
					TextboxActual
				}), "Main")


				local TextboxFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
					Size = UDim2.new(1, 0, 0, 38),
					Parent = ItemParent
				}), {
					AddThemeObject(SetProps(MakeElement("Label", TextboxConfig.Name, 15), {
						Size = UDim2.new(1, -12, 1, 0),
						Position = UDim2.new(0, 12, 0, 0),
						Font = Enum.Font.GothamBold,
						Name = "Content"
					}), "Text"),
					AddThemeObject(MakeElement("Stroke"), "Stroke"),
					TextContainer,
					Click
				}), "Second")

				AddConnection(TextboxActual:GetPropertyChangedSignal("Text"), function()

					TweenService:Create(TextContainer, TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, TextboxActual.TextBounds.X + 16, 0, 24)}):Play()
				end)

				AddConnection(TextboxActual.FocusLost, function()
					TextboxConfig.Callback(TextboxActual.Text)
					if TextboxConfig.TextDisappear then
						TextboxActual.Text = ""
					end
				end)

				TextboxActual.Text = TextboxConfig.Default

				AddConnection(Click.MouseEnter, function()
					TweenService:Create(TextboxFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 3)}):Play()
				end)

				AddConnection(Click.MouseLeave, function()
					TweenService:Create(TextboxFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Second}):Play()
				end)

				AddConnection(Click.MouseButton1Up, function()
					TweenService:Create(TextboxFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 3)}):Play()
					TextboxActual:CaptureFocus()
				end)

				AddConnection(Click.MouseButton1Down, function()
					TweenService:Create(TextboxFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 6, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 6, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 6)}):Play()
				end)
			end
			function ElementFunction:AddColorpicker(ColorpickerConfig)
				ColorpickerConfig = ColorpickerConfig or {}
				ColorpickerConfig.Name = ColorpickerConfig.Name or "Colorpicker"
				ColorpickerConfig.Default = ColorpickerConfig.Default or Color3.fromRGB(255,255,255)
				ColorpickerConfig.Callback = ColorpickerConfig.Callback or function() end
				ColorpickerConfig.Flag = ColorpickerConfig.Flag or nil
				ColorpickerConfig.Save = ColorpickerConfig.Save or false

                local ColorH, ColorS, ColorV = Color3.toHSV(ColorpickerConfig.Default)
                local Colorpicker = {Value = ColorpickerConfig.Default, Toggled = false, Type = "Colorpicker", Save = ColorpickerConfig.Save}
                local ColorInput, HueInput
                local ActiveTouchInput
                local ColorDragging, HueDragging = false, false
                local ColorChangedDuringDrag = false

				local ColorSelection = Create("ImageLabel", {
					Size = UDim2.new(0, 18, 0, 18),
                    Position = UDim2.new(ColorS, 0, 1 - ColorV, 0),
					ScaleType = Enum.ScaleType.Fit,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundTransparency = 1,
					Image = "http://www.roblox.com/asset/?id=4805639000"
				})

				local HueSelection = Create("ImageLabel", {
					Size = UDim2.new(0, 18, 0, 18),
                    Position = UDim2.new(0.5, 0, 1 - ColorH, 0),
					ScaleType = Enum.ScaleType.Fit,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundTransparency = 1,
					Image = "http://www.roblox.com/asset/?id=4805639000"
				})

				local Color = Create("ImageLabel", {
					Size = UDim2.new(1, -25, 1, 0),
					Visible = false,
					Image = "rbxassetid://4155801252"
				}, {
					Create("UICorner", {CornerRadius = UDim.new(0, 5)}),
					ColorSelection
				})

				local Hue = Create("Frame", {
					Size = UDim2.new(0, 20, 1, 0),
					Position = UDim2.new(1, -20, 0, 0),
					Visible = false
				}, {
					Create("UIGradient", {Rotation = 270, Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(0.20, Color3.fromRGB(234, 255, 0)), ColorSequenceKeypoint.new(0.40, Color3.fromRGB(21, 255, 0)), ColorSequenceKeypoint.new(0.60, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(0.80, Color3.fromRGB(0, 17, 255)), ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 0, 251)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 4))},}),
					Create("UICorner", {CornerRadius = UDim.new(0, 5)}),
					HueSelection
				})

				local ColorpickerContainer = Create("Frame", {
					Position = UDim2.new(0, 0, 0, 32),
					Size = UDim2.new(1, 0, 1, -32),
					BackgroundTransparency = 1,
					ClipsDescendants = true
				}, {
					Hue,
					Color,
					Create("UIPadding", {
						PaddingLeft = UDim.new(0, 35),
						PaddingRight = UDim.new(0, 35),
						PaddingBottom = UDim.new(0, 10),
						PaddingTop = UDim.new(0, 17)
					})
				})

				local Click = SetProps(MakeElement("Button"), {
					Size = UDim2.new(1, 0, 1, 0)
				})

				local ColorpickerBox = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 4), {
					Size = UDim2.new(0, 24, 0, 24),
					Position = UDim2.new(1, -12, 0.5, 0),
					AnchorPoint = Vector2.new(1, 0.5)
				}), {
					AddThemeObject(MakeElement("Stroke"), "Stroke")
				}), "Main")

				local ColorpickerFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
					Size = UDim2.new(1, 0, 0, 38),
					Parent = ItemParent
				}), {
					SetProps(SetChildren(MakeElement("TFrame"), {
						AddThemeObject(SetProps(MakeElement("Label", ColorpickerConfig.Name, 15), {
							Size = UDim2.new(1, -12, 1, 0),
							Position = UDim2.new(0, 12, 0, 0),
							Font = Enum.Font.GothamBold,
							Name = "Content"
						}), "Text"),
						ColorpickerBox,
						Click,
						AddThemeObject(SetProps(MakeElement("Frame"), {
							Size = UDim2.new(1, 0, 0, 1),
							Position = UDim2.new(0, 0, 1, -1),
							Name = "Line",
							Visible = false
						}), "Stroke"),
					}), {
						Size = UDim2.new(1, 0, 0, 38),
						ClipsDescendants = true,
						Name = "F"
					}),
					ColorpickerContainer,
					AddThemeObject(MakeElement("Stroke"), "Stroke"),
				}), "Second")

				AddConnection(Click.MouseButton1Click, function()
					Colorpicker.Toggled = not Colorpicker.Toggled
					TweenService:Create(ColorpickerFrame,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{Size = Colorpicker.Toggled and UDim2.new(1, 0, 0, 148) or UDim2.new(1, 0, 0, 38)}):Play()
					Color.Visible = Colorpicker.Toggled
					Hue.Visible = Colorpicker.Toggled
					ColorpickerFrame.F.Line.Visible = Colorpicker.Toggled
				end)

                local function StopColorDrag()
                    ColorDragging = false
                    HueDragging = false
                    ActiveTouchInput = nil

                    if ColorInput then
                        DisconnectConnection(ColorInput)
                        ColorInput = nil
                    end
                    if HueInput then
                        DisconnectConnection(HueInput)
                        HueInput = nil
                    end

                    if ColorChangedDuringDrag then
                        ColorChangedDuringDrag = false
                        SaveCfg(game.GameId)
                    end
                end

                local function GetPointerPosition()
                    if ActiveTouchInput then
                        return ActiveTouchInput.Position.X, ActiveTouchInput.Position.Y
                    end

                    if Mouse then
                        local MouseSuccess, MouseX, MouseY = pcall(function()
                            return Mouse.X, Mouse.Y
                        end)
                        if MouseSuccess and type(MouseX) == "number" and type(MouseY) == "number" then
                            return MouseX, MouseY
                        end
                    end

                    local LocationSuccess, MouseLocation = pcall(function()
                        return UserInputService:GetMouseLocation()
                    end)
                    if LocationSuccess and MouseLocation then
                        return MouseLocation.X, MouseLocation.Y
                    end
                    return 0, 0
                end

                local function UpdateColorPicker()
                    local NewColor = Color3.fromHSV(ColorH, ColorS, ColorV)
                    Color.BackgroundColor3 = Color3.fromHSV(ColorH, 1, 1)

                    if Colorpicker.Value ~= NewColor then
                        Colorpicker:Set(NewColor)
                        ColorChangedDuringDrag = true
                    else
                        ColorpickerBox.BackgroundColor3 = NewColor
                    end
                end


                AddConnection(Color.InputBegan, function(Input)
                    if Input.UserInputType ~= Enum.UserInputType.MouseButton1 and Input.UserInputType ~= Enum.UserInputType.Touch then
                        return
                    end
                    HueDragging = false
                    ColorDragging = true
                    ActiveTouchInput = Input.UserInputType == Enum.UserInputType.Touch and Input or nil
                    if ColorInput then
                        DisconnectConnection(ColorInput)
                    end
                    ColorInput = AddConnection(RunService.RenderStepped, function()
                        if not ColorDragging or not OrionLib:IsRunning() then
                            StopColorDrag()
                            return
                        end
                        local PointerX, PointerY = GetPointerPosition()
                        local Width, Height = Color.AbsoluteSize.X, Color.AbsoluteSize.Y
                        if Width <= 0 or Height <= 0 then
                            return
                        end
                        local ColorX = math.clamp((PointerX - Color.AbsolutePosition.X) / Width, 0, 1)
                        local ColorY = math.clamp((PointerY - Color.AbsolutePosition.Y) / Height, 0, 1)
                        ColorSelection.Position = UDim2.new(ColorX, 0, ColorY, 0)
                        ColorS = ColorX
                        ColorV = 1 - ColorY
                        UpdateColorPicker()
                    end)
                end)

                AddConnection(Hue.InputBegan, function(Input)
                    if Input.UserInputType ~= Enum.UserInputType.MouseButton1 and Input.UserInputType ~= Enum.UserInputType.Touch then
                        return
                    end
                    ColorDragging = false
                    HueDragging = true
                    ActiveTouchInput = Input.UserInputType == Enum.UserInputType.Touch and Input or nil
                    if HueInput then
                        DisconnectConnection(HueInput)
                    end
                    HueInput = AddConnection(RunService.RenderStepped, function()
                        if not HueDragging or not OrionLib:IsRunning() then
                            StopColorDrag()
                            return
                        end
                        local _, PointerY = GetPointerPosition()
                        local Height = Hue.AbsoluteSize.Y
                        if Height <= 0 then
                            return
                        end
                        local HueY = math.clamp((PointerY - Hue.AbsolutePosition.Y) / Height, 0, 1)
                        HueSelection.Position = UDim2.new(0.5, 0, HueY, 0)
                        ColorH = 1 - HueY
                        UpdateColorPicker()
                    end)
                end)

                AddConnection(UserInputService.InputEnded, function(Input)
                    local MouseReleased = ActiveTouchInput == nil and Input.UserInputType == Enum.UserInputType.MouseButton1
                    local TouchReleased = ActiveTouchInput ~= nil and Input == ActiveTouchInput
                    if MouseReleased or TouchReleased then
                        StopColorDrag()
                    end
                end)

                function Colorpicker:Set(Value)
                    if typeof(Value) ~= "Color3" then
                        return self.Value
                    end

                    Colorpicker.Value = Value
                    ColorpickerBox.BackgroundColor3 = Value
                    ColorH, ColorS, ColorV = Color3.toHSV(Value)
                    ColorSelection.Position = UDim2.new(ColorS, 0, 1 - ColorV, 0)
                    HueSelection.Position = UDim2.new(0.5, 0, 1 - ColorH, 0)
                    Color.BackgroundColor3 = Color3.fromHSV(ColorH, 1, 1)
                    ColorpickerConfig.Callback(Value)
                    return Value
                end

                Colorpicker:Set(Colorpicker.Value)
				if ColorpickerConfig.Flag then
					OrionLib.Flags[ColorpickerConfig.Flag] = Colorpicker
				end
				return Colorpicker
			end
			return ElementFunction
		end

		local ElementFunction = {}

		function ElementFunction:AddSection(SectionConfig)
			SectionConfig.Name = SectionConfig.Name or "Section"

			local SectionFrame = SetChildren(SetProps(MakeElement("TFrame"), {
				Size = UDim2.new(1, 0, 0, 26),
				Parent = Container
			}), {
				AddThemeObject(SetProps(MakeElement("Label", SectionConfig.Name, 14), {
					Size = UDim2.new(1, -12, 0, 16),
					Position = UDim2.new(0, 0, 0, 3),
					Font = Enum.Font.GothamSemibold
				}), "TextDark"),
				SetChildren(SetProps(MakeElement("TFrame"), {
					AnchorPoint = Vector2.new(0, 0),
					Size = UDim2.new(1, 0, 1, -24),
					Position = UDim2.new(0, 0, 0, 23),
					Name = "Holder"
				}), {
					MakeElement("List", 0, 6)
				}),
			})

			AddConnection(SectionFrame.Holder.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
				SectionFrame.Size = UDim2.new(1, 0, 0, SectionFrame.Holder.UIListLayout.AbsoluteContentSize.Y + 31)
				SectionFrame.Holder.Size = UDim2.new(1, 0, 0, SectionFrame.Holder.UIListLayout.AbsoluteContentSize.Y)
			end)

			local SectionFunction = {}
			for i, v in next, GetElements(SectionFrame.Holder) do
				SectionFunction[i] = v
			end
			return SectionFunction
		end

		for i, v in next, GetElements(Container) do
			ElementFunction[i] = v
		end

		if TabConfig.PremiumOnly then
			for i, v in next, ElementFunction do
				ElementFunction[i] = function() end
			end
			Container:FindFirstChild("UIListLayout"):Destroy()
			Container:FindFirstChild("UIPadding"):Destroy()
			SetChildren(SetProps(MakeElement("TFrame"), {
				Size = UDim2.new(1, 0, 1, 0),
				Parent = ItemParent
			}), {
				AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://3610239960"), {
					Size = UDim2.new(0, 18, 0, 18),
					Position = UDim2.new(0, 15, 0, 15),
					ImageTransparency = 0.4
				}), "Text"),
				AddThemeObject(SetProps(MakeElement("Label", "Unauthorised Access", 14), {
					Size = UDim2.new(1, -38, 0, 14),
					Position = UDim2.new(0, 38, 0, 18),
					TextTransparency = 0.4
				}), "Text"),
				AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://4483345875"), {
					Size = UDim2.new(0, 56, 0, 56),
					Position = UDim2.new(0, 84, 0, 110),
				}), "Text"),
				AddThemeObject(SetProps(MakeElement("Label", "Premium Features", 14), {
					Size = UDim2.new(1, -150, 0, 14),
					Position = UDim2.new(0, 150, 0, 112),
					Font = Enum.Font.GothamBold
				}), "Text"),
				AddThemeObject(SetProps(MakeElement("Label", "This part of the script is locked to Premium users. Purchase Premium in the Discord server (discord.gg/jB4yJgn3pE)", 12), {
					Size = UDim2.new(1, -200, 0, 14),
					Position = UDim2.new(0, 150, 0, 138),
					TextWrapped = true,
					TextTransparency = 0.4
				}), "Text")
			})
		end
		return ElementFunction
	end

	return TabFunction
end

function OrionLib:Destroy()
    if LibraryDestroyed then
        return
    end
    LibraryDestroyed = true
    self:DisconnectConnections()
    pcall(function()
        Orion:Destroy()
    end)
    table.clear(self.ThemeObjects)
end

return OrionLib
