--[[

  _  ___   _  _____ _______     _______ _______   _    _ _    _ ____  
 | |/ / \ | |/ ____|  __ \ \   / /  __ \__   __| | |  | | |  | |  _ \ 
 | ' /|  \| | |    | |__) \ \_/ /| |__) | | |    | |__| | |  | | |_) |
 |  < | . ` | |    |  _  / \   / |  ___/  | |    |  __  | |  | |  _ < 
 | . \| |\  | |____| | \ \  | |  | |      | |    | |  | | |__| | |_) |
 |_|\_\_| \_|\_____|_|  \_\ |_|  |_|      |_|    |_|  |_|\____/|____/ 
                                                                      
by 4lpaca
]]

local InterfaceManagerTable = {};

InterfaceManagerTable.Version = "0.1";
InterfaceManagerTable.LocalPlayer = game:GetService('Players').LocalPlayer;
InterfaceManagerTable.CoreGui = game:FindFirstChild('CoreGui') or InterfaceManagerTable.LocalPlayer.PlayerGui;
InterfaceManagerTable.ProcessId = math.random(100,1000);
InterfaceManagerTable.LuaVersion = "Luau";
InterfaceManagerTable.Hightlight = Color3.fromRGB(0, 134, 105);
InterfaceManagerTable.Font = Font.new("rbxasset://fonts/families/GothamSSm.json",Enum.FontWeight.Medium,Enum.FontStyle.Normal);
InterfaceManagerTable.InputService = game:GetService('UserInputService');
InterfaceManagerTable.TweenService = game:GetService('TweenService');
InterfaceManagerTable.Enum = {
	Tab = {
		Single = 'Single',
		Multiple = 'Multiple',
		Chat = 'Chat',
	};
};

InterfaceManagerTable.Another = {
	Progress = "5x30 5min/day"	
};

InterfaceManagerTable.TextEffect = {};

function InterfaceManagerTable.TextEffect:AddColor(text : string,color : Color3)
	return `<font color="rgb({math.round(color.R * 255)},{tostring(math.round(color.G * 255))},{math.round(color.B * 255)})">{text}</font>`
end;

function InterfaceManagerTable.TextEffect:Transparency(text : string,value : number)
	return `<font transparency="{value}">{text}</font>`
end;

function InterfaceManagerTable:InputButton(Frame :Frame)
	local Button = Instance.new("TextButton")

	Button.Name = "Button"
	Button.Parent = Frame
	Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Button.BackgroundTransparency = 1.000
	Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Button.BorderSizePixel = 0
	Button.Size = UDim2.new(1, 0, 1, 0)
	Button.ZIndex = Frame.ZIndex + 1
	Button.Font = Enum.Font.SourceSans
	Button.TextColor3 = Color3.fromRGB(0, 0, 0)
	Button.TextSize = 14.000
	Button.TextTransparency = 1.000	

	return Button;
end;

InterfaceManagerTable.Icons = {
	aperture = "rbxassetid://7733666258",
	bug = "rbxassetid://7733701545",
	["chevrons-down-up"] = "rbxassetid://7733720483",
	["clock-6"] = "rbxassetid://8997384977",
	egg = "rbxassetid://8997385940",
	["external-link"] = "rbxassetid://7743866903",
	["lightbulb-off"] = "rbxassetid://7733975123",
	["file-check-2"] = "rbxassetid://7733779610",
	['settings'] = "rbxassetid://7734053495",
	crown = "rbxassetid://7733765398",
	coins = "rbxassetid://7743866529",
	battery = "rbxassetid://7733674820",
	["flashlight-off"] = "rbxassetid://7733798799",
	["camera-off"] = "rbxassetid://7733919260",
	["function-square"] = "rbxassetid://7733799682",
	["mountain-snow"] = "rbxassetid://7743870286",
	gamepad = "rbxassetid://7733799901",
	gift = "rbxassetid://7733946818",
	globe = "rbxassetid://7733954760",
	option = "rbxassetid://7734021300",
	hand = "rbxassetid://7733955740",
	["hard-hat"] = "rbxassetid://7733955850",
	hash = "rbxassetid://7733955906",
	server = "rbxassetid://7734053426",
	["align-horizontal-space-around"] = "rbxassetid://8997381738",
	highlighter = "rbxassetid://7743868648",
	bike = "rbxassetid://7733678330",
	home = "rbxassetid://7733960981",
	image = "rbxassetid://7733964126",
	indent = "rbxassetid://7733964452",
	infinity = "rbxassetid://7733964640",
	inspect = "rbxassetid://7733964808",
	["alert-triangle"] = "rbxassetid://7733658504",
	["align-start-horizontal"] = "rbxassetid://8997381965",
	figma = "rbxassetid://7743867310",
	pin = "rbxassetid://8997386648",
	["corner-up-right"] = "rbxassetid://7733764915",
	["list-x"] = "rbxassetid://7743869517",
	["monitor-off"] = "rbxassetid://7734000184",
	["chevron-first"] = "rbxassetid://8997383275",
	["package-search"] = "rbxassetid://8997386448",
	pencil = "rbxassetid://7734022107",
	["cloud-fog"] = "rbxassetid://7733920317",
	["grip-horizontal"] = "rbxassetid://7733955302",
	["align-center-vertical"] = "rbxassetid://8997380737",
	outdent = "rbxassetid://7734021384",
	["more-vertical"] = "rbxassetid://7734006187",
	["package-plus"] = "rbxassetid://8997386355",
	bluetooth = "rbxassetid://7733687147",
	["pen-tool"] = "rbxassetid://7734022041",
	["person-standing"] = "rbxassetid://7743871002",
	tornado = "rbxassetid://7743873633",
	["phone-incoming"] = "rbxassetid://7743871120",
	["phone-off"] = "rbxassetid://7734029534",
	dribbble = "rbxassetid://7733770843",
	["at-sign"] = "rbxassetid://7733673907",
	["edit-2"] = "rbxassetid://7733771217",
	sheet = "rbxassetid://7743871876",
	tv = "rbxassetid://7743874674",
	headphones = "rbxassetid://7733956063",
	["qr-code"] = "rbxassetid://7743871575",
	reply = "rbxassetid://7734051594",
	rewind = "rbxassetid://7734051670",
	["bell-off"] = "rbxassetid://7733675107",
	["file-check"] = "rbxassetid://7733779668",
	quote = "rbxassetid://7734045100",
	["rotate-ccw"] = "rbxassetid://7734051861",
	library = "rbxassetid://7743869054",
	["clock-1"] = "rbxassetid://8997383694",
	["on-charge"] = "rbxassetid://7734021231",
	["video-off"] = "rbxassetid://7743876466",
	save = "rbxassetid://7734052335",
	["arrow-left-circle"] = "rbxassetid://7733673056",
	["screen-share"] = "rbxassetid://7734052814",
	["clock-3"] = "rbxassetid://8997384456",
	["help-circle"] = "rbxassetid://7733956210",
	["server-crash"] = "rbxassetid://7734053281",
	["bluetooth-searching"] = "rbxassetid://7733914320",
	equal = "rbxassetid://7733771811",
	["shield-close"] = "rbxassetid://7734056470",
	phone = "rbxassetid://7734032056",
	['type'] = "rbxassetid://7743874740",
	["file-x-2"] = "rbxassetid://7743867554",
	sidebar = "rbxassetid://7734058260",
	sigma = "rbxassetid://7734058345",
	["smartphone-charging"] = "rbxassetid://7734058894",
	["arrow-left"] = "rbxassetid://7733673136",
	framer = "rbxassetid://7733799486",
	currency = "rbxassetid://7733765592",
	star = "rbxassetid://7734068321",
	["stretch-horizontal"] = "rbxassetid://8997387754",
	smile = "rbxassetid://7734059095",
	subscript = "rbxassetid://8997387937",
	sun = "rbxassetid://7734068495",
	["switch-camera"] = "rbxassetid://7743872492",
	['table'] = "rbxassetid://7734073253",
	tag = "rbxassetid://7734075797",
	cross = "rbxassetid://7733765224",
	gem = "rbxassetid://7733942651",
	link = "rbxassetid://7733978098",
	terminal = "rbxassetid://7743872929",
	["thermometer-sun"] = "rbxassetid://7734084018",
	["share-2"] = "rbxassetid://7734053595",
	["timer-off"] = "rbxassetid://8997388325",
	megaphone = "rbxassetid://7733993049",
	["timer-reset"] = "rbxassetid://7743873336",
	["phone-forwarded"] = "rbxassetid://7734027345",
	unlock = "rbxassetid://7743875263",
	trello = "rbxassetid://7743873996",
	camera = "rbxassetid://7733708692",
	triangle = "rbxassetid://7743874367",
	truck = "rbxassetid://7743874482",
	["file-output"] = "rbxassetid://7733788742",
	["gamepad-2"] = "rbxassetid://7733799795",
	network = "rbxassetid://7734021047",
	users = "rbxassetid://7743876054",
	["electricity-off"] = "rbxassetid://7733771563",
	book = "rbxassetid://7733914390",
	["clock-9"] = "rbxassetid://8997385485",
	["corner-down-left"] = "rbxassetid://7733764327",
	["locate-fixed"] = "rbxassetid://7733992424",
	["bar-chart"] = "rbxassetid://7733674319",
	["shield-check"] = "rbxassetid://7734056411",
	["signal-low"] = "rbxassetid://8997387189",
	["reply-all"] = "rbxassetid://7734051524",
	["zoom-in"] = "rbxassetid://7743878977",
	["grip-vertical"] = "rbxassetid://7733955410",
	ticket = "rbxassetid://7734086558",
	smartphone = "rbxassetid://7734058979",
	["arrow-big-right"] = "rbxassetid://7733671493",
	["tv-2"] = "rbxassetid://7743874599",
	flashlight = "rbxassetid://7733798851",
	database = "rbxassetid://7743866778",
	["plus-square"] = "rbxassetid://7734040369",
	["align-justify"] = "rbxassetid://7733661326",
	["clipboard-list"] = "rbxassetid://7733920117",
	github = "rbxassetid://7733954058",
	columns = "rbxassetid://7733757178",
	["arrow-big-down"] = "rbxassetid://7733668653",
	["cloud-off"] = "rbxassetid://7733745572",
	target = "rbxassetid://7743872758",
	["skip-back"] = "rbxassetid://7734058404",
	["x-circle"] = "rbxassetid://7743878496",
	["clock-10"] = "rbxassetid://8997383876",
	["align-right"] = "rbxassetid://7733663582",
	["clock-5"] = "rbxassetid://8997384798",
	["bell-plus"] = "rbxassetid://7733675181",
	["battery-medium"] = "rbxassetid://7733674731",
	["arrow-down"] = "rbxassetid://7733672933",
	inbox = "rbxassetid://7733964370",
	cast = "rbxassetid://7733919326",
	["gift-card"] = "rbxassetid://7733945018",
	webcam = "rbxassetid://7743877896",
	["folder-minus"] = "rbxassetid://7733799022",
	["scan-line"] = "rbxassetid://8997386772",
	shovel = "rbxassetid://7734056878",
	["download-cloud"] = "rbxassetid://7733770689",
	["list-checks"] = "rbxassetid://7743869317",
	["file-text"] = "rbxassetid://7733789088",
	codesandbox = "rbxassetid://7733752575",
	["laptop-2"] = "rbxassetid://7733965313",
	podcast = "rbxassetid://7734042234",
	["log-out"] = "rbxassetid://7733992677",
	["thumbs-up"] = "rbxassetid://7743873212",
	timer = "rbxassetid://7743873443",
	["text-cursor"] = "rbxassetid://8997388195",
	["file-search"] = "rbxassetid://7733788966",
	thermometer = "rbxassetid://7734084149",
	["bluetooth-off"] = "rbxassetid://7733914252",
	["refresh-cw"] = "rbxassetid://7734051052",
	["clipboard-check"] = "rbxassetid://7733919947",
	languages = "rbxassetid://7733965249",
	asterisk = "rbxassetid://7733673800",
	superscript = "rbxassetid://8997388036",
	["user-check"] = "rbxassetid://7743875503",
	["move-diagonal"] = "rbxassetid://7743870505",
	copy = "rbxassetid://7733764083",
	bot = "rbxassetid://7733916988",
	["alarm-minus"] = "rbxassetid://7733656164",
	["log-in"] = "rbxassetid://7733992604",
	maximize = "rbxassetid://7733992982",
	["align-horizontal-space-between"] = "rbxassetid://8997381854",
	brush = "rbxassetid://7733701455",
	["equal-not"] = "rbxassetid://7733771726",
	upload = "rbxassetid://7743875428",
	["minus-circle"] = "rbxassetid://7733998053",
	["graduation-cap"] = "rbxassetid://7733955058",
	["edit-3"] = "rbxassetid://7733771361",
	check = "rbxassetid://7733715400",
	scissors = "rbxassetid://7734052570",
	info = "rbxassetid://7733964719",
	["align-horizonal-distribute-start"] = "rbxassetid://8997381290",
	["book-open"] = "rbxassetid://7733687281",
	["divide-circle"] = "rbxassetid://7733769152",
	file = "rbxassetid://7733793319",
	["clock-2"] = "rbxassetid://8997384295",
	["corner-right-up"] = "rbxassetid://7733764680",
	clover = "rbxassetid://7733747233",
	expand = "rbxassetid://7733771982",
	gauge = "rbxassetid://7733799969",
	["phone-outgoing"] = "rbxassetid://7743871253",
	["shield-alert"] = "rbxassetid://7734056326",
	paperclip = "rbxassetid://7734021680",
	["arrow-big-left"] = "rbxassetid://7733911731",
	album = "rbxassetid://7733658133",
	bookmark = "rbxassetid://7733692043",
	["check-circle-2"] = "rbxassetid://7733710700",
	["list-ordered"] = "rbxassetid://7743869411",
	delete = "rbxassetid://7733768142",
	axe = "rbxassetid://7733674079",
	radio = "rbxassetid://7743871662",
	octagon = "rbxassetid://7734021165",
	["git-commit"] = "rbxassetid://7743868360",
	shirt = "rbxassetid://7734056672",
	["corner-right-down"] = "rbxassetid://7733764605",
	["trending-down"] = "rbxassetid://7743874143",
	airplay = "rbxassetid://7733655834",
	['repeat'] = "rbxassetid://7734051454",
	layers = "rbxassetid://7743868936",
	["chevron-right"] = "rbxassetid://7733717755",
	["chevrons-right"] = "rbxassetid://7733919682",
	["folder-plus"] = "rbxassetid://7733799092",
	["alarm-check"] = "rbxassetid://7733655912",
	["arrow-up-right"] = "rbxassetid://7733673646",
	["user-plus"] = "rbxassetid://7743875759",
	["file-minus"] = "rbxassetid://7733936115",
	["cloud-drizzle"] = "rbxassetid://7733920226",
	["stretch-vertical"] = "rbxassetid://8997387862",
	["align-vertical-distribute-start"] = "rbxassetid://8997382428",
	unlink = "rbxassetid://7743875149",
	wand = "rbxassetid://8997388430",
	regex = "rbxassetid://7734051188",
	command = "rbxassetid://7733924046",
	haze = "rbxassetid://7733955969",
	trash = "rbxassetid://7743873871",
	["battery-full"] = "rbxassetid://7733674503",
	["flag-triangle-left"] = "rbxassetid://7733798509",
	["server-off"] = "rbxassetid://7734053361",
	["loader-2"] = "rbxassetid://7733989869",
	["monitor-speaker"] = "rbxassetid://7743869988",
	shuffle = "rbxassetid://7734057059",
	tablet = "rbxassetid://7743872620",
	["cloud-moon"] = "rbxassetid://7733920519",
	["clipboard-x"] = "rbxassetid://7733734668",
	pocket = "rbxassetid://7734042139",
	watch = "rbxassetid://7743877668",
	["file-plus"] = "rbxassetid://7733788885",
	locate = "rbxassetid://7733992469",
	share = "rbxassetid://7734053697",
	["thermometer-snowflake"] = "rbxassetid://7743873074",
	["volume-1"] = "rbxassetid://7743877081",
	["arrow-left-right"] = "rbxassetid://8997382869",
	coffee = "rbxassetid://7733752630",
	["chevron-last"] = "rbxassetid://8997383390",
	["cloud-hail"] = "rbxassetid://7733920444",
	["alarm-clock-off"] = "rbxassetid://7733656003",
	["pound-sterling"] = "rbxassetid://7734042354",
	tent = "rbxassetid://7734078943",
	["toggle-left"] = "rbxassetid://7734091286",
	["dollar-sign"] = "rbxassetid://7733770599",
	sunrise = "rbxassetid://7743872365",
	sunset = "rbxassetid://7734070982",
	code = "rbxassetid://7733749837",
	["thumbs-down"] = "rbxassetid://7734084236",
	["trending-up"] = "rbxassetid://7743874262",
	["clock-12"] = "rbxassetid://8997384150",
	["rocking-chair"] = "rbxassetid://7734051769",
	["check-square"] = "rbxassetid://7733919526",
	cpu = "rbxassetid://7733765045",
	palette = "rbxassetid://7734021595",
	["minimize-2"] = "rbxassetid://7733997870",
	["cloud-sun"] = "rbxassetid://7733746880",
	copyleft = "rbxassetid://7733764196",
	archive = "rbxassetid://7733911621",
	building = "rbxassetid://7733701625",
	["image-minus"] = "rbxassetid://7733963797",
	italic = "rbxassetid://7733964917",
	["link-2-off"] = "rbxassetid://7733975283",
	["sort-asc"] = "rbxassetid://7734060715",
	underline = "rbxassetid://7743874904",
	gitlab = "rbxassetid://7733954246",
	["file-minus-2"] = "rbxassetid://7733936010",
	["play-circle"] = "rbxassetid://7734037784",
	["clock-8"] = "rbxassetid://8997385352",
	["file-input"] = "rbxassetid://7733935917",
	beaker = "rbxassetid://7733674922",
	["shopping-bag"] = "rbxassetid://7734056747",
	navigation = "rbxassetid://7734020989",
	moon = "rbxassetid://7743870134",
	["align-vertical-space-between"] = "rbxassetid://8997382793",
	glasses = "rbxassetid://7733954403",
	["clipboard-copy"] = "rbxassetid://7733920037",
	feather = "rbxassetid://7733777166",
	["skip-forward"] = "rbxassetid://7734058495",
	wind = "rbxassetid://7743878264",
	frown = "rbxassetid://7733799591",
	["move-vertical"] = "rbxassetid://7743870608",
	umbrella = "rbxassetid://7743874820",
	package = "rbxassetid://7734021469",
	["chevrons-up"] = "rbxassetid://7733723433",
	download = "rbxassetid://7733770755",
	eye = "rbxassetid://7733774602",
	files = "rbxassetid://7743867811",
	["arrow-down-right"] = "rbxassetid://7733672831",
	["code-2"] = "rbxassetid://7733920644",
	["wrap-text"] = "rbxassetid://8997388548",
	["file-digit"] = "rbxassetid://7733935829",
	["x-square"] = "rbxassetid://7743878737",
	clipboard = "rbxassetid://7733734762",
	["maximize-2"] = "rbxassetid://7733992901",
	send = "rbxassetid://7734053039",
	["alarm-clock"] = "rbxassetid://7733656100",
	sliders = "rbxassetid://7734058803",
	["refresh-ccw"] = "rbxassetid://7734050715",
	music = "rbxassetid://7734020554",
	banknote = "rbxassetid://7733674153",
	["hard-drive"] = "rbxassetid://7733955793",
	search = "rbxassetid://7734052925",
	["layout-list"] = "rbxassetid://7733970442",
	edit = "rbxassetid://7733771472",
	contrast = "rbxassetid://7733764005",
	wifi = "rbxassetid://7743878148",
	["swiss-franc"] = "rbxassetid://7734071038",
	ghost = "rbxassetid://7743868000",
	laptop = "rbxassetid://7733965386",
	["clock-4"] = "rbxassetid://8997384603",
	["layout-dashboard"] = "rbxassetid://7733970318",
	["align-vertical-justify-end"] = "rbxassetid://8997382584",
	circle = "rbxassetid://7733919881",
	["file-x"] = "rbxassetid://7733938136",
	award = "rbxassetid://7733673987",
	["corner-left-down"] = "rbxassetid://7733764448",
	["arrow-up-left"] = "rbxassetid://7733673539",
	carrot = "rbxassetid://8997382987",
	["globe-2"] = "rbxassetid://7733954611",
	compass = "rbxassetid://7733924216",
	["git-branch"] = "rbxassetid://7733949149",
	vibrate = "rbxassetid://7743876302",
	["pause-circle"] = "rbxassetid://7734021767",
	["minus-square"] = "rbxassetid://7743869899",
	["mic-off"] = "rbxassetid://7743869714",
	["arrow-down-circle"] = "rbxassetid://7733671763",
	["move-horizontal"] = "rbxassetid://7734016210",
	chrome = "rbxassetid://7733919783",
	["radio-receiver"] = "rbxassetid://7734045155",
	shield = "rbxassetid://7734056608",
	["image-plus"] = "rbxassetid://7733964016",
	["more-horizontal"] = "rbxassetid://7734006080",
	slash = "rbxassetid://8997387644",
	divide = "rbxassetid://7733769365",
	view = "rbxassetid://7743876754",
	list = "rbxassetid://7743869612",
	printer = "rbxassetid://7734042580",
	["corner-left-up"] = "rbxassetid://7733764536",
	meh = "rbxassetid://7733993147",
	copyright = "rbxassetid://7733764275",
	["align-end-vertical"] = "rbxassetid://8997380907",
	heart = "rbxassetid://7733956134",
	lock = "rbxassetid://7733992528",
	["align-center"] = "rbxassetid://7733909776",
	["signal-high"] = "rbxassetid://8997387110",
	["upload-cloud"] = "rbxassetid://7743875358",
	["arrow-up-circle"] = "rbxassetid://7733673466",
	["git-branch-plus"] = "rbxassetid://7743868200",
	["align-vertical-justify-center"] = "rbxassetid://8997382502",
	["screen-share-off"] = "rbxassetid://7734052653",
	["git-pull-request"] = "rbxassetid://7733952287",
	flag = "rbxassetid://7733798691",
	["star-half"] = "rbxassetid://7734068258",
	minus = "rbxassetid://7734000129",
	mountain = "rbxassetid://7734008868",
	volume = "rbxassetid://7743877487",
	["mouse-pointer-2"] = "rbxassetid://7734010405",
	["package-x"] = "rbxassetid://8997386545",
	["indian-rupee"] = "rbxassetid://7733964536",
	speaker = "rbxassetid://7734063416",
	flame = "rbxassetid://7733798747",
	["circle-slashed"] = "rbxassetid://8997383530",
	crop = "rbxassetid://7733765140",
	["clock-11"] = "rbxassetid://8997384034",
	["stop-circle"] = "rbxassetid://7734068379",
	["align-horizontal-justify-end"] = "rbxassetid://8997381549",
	["power-off"] = "rbxassetid://7734042423",
	["bell-minus"] = "rbxassetid://7733675028",
	undo = "rbxassetid://7743874974",
	["link-2"] = "rbxassetid://7743869163",
	lightbulb = "rbxassetid://7733975185",
	shrink = "rbxassetid://7734056971",
	mail = "rbxassetid://7733992732",
	pause = "rbxassetid://7734021897",
	bold = "rbxassetid://7733687211",
	calendar = "rbxassetid://7733919198",
	["x-octagon"] = "rbxassetid://7743878618",
	["russian-ruble"] = "rbxassetid://7734052248",
	["file-code"] = "rbxassetid://7733779730",
	["life-buoy"] = "rbxassetid://7733973479",
	import = "rbxassetid://7733964240",
	video = "rbxassetid://7743876610",
	["clock-7"] = "rbxassetid://8997385147",
	["align-center-horizontal"] = "rbxassetid://8997380477",
	bell = "rbxassetid://7733911828",
	["move-diagonal-2"] = "rbxassetid://7734013178",
	["message-circle"] = "rbxassetid://7733993311",
	skull = "rbxassetid://7734058599",
	["battery-charging"] = "rbxassetid://7733674402",
	ruler = "rbxassetid://7734052157",
	binary = "rbxassetid://7733678388",
	["cloud-rain-wind"] = "rbxassetid://7733746456",
	briefcase = "rbxassetid://7733919017",
	["terminal-square"] = "rbxassetid://7734079055",
	scale = "rbxassetid://7734052454",
	lasso = "rbxassetid://7733967892",
	["piggy-bank"] = "rbxassetid://7734034513",
	["battery-low"] = "rbxassetid://7733674589",
	["arrow-up"] = "rbxassetid://7733673717",
	["list-plus"] = "rbxassetid://7733984995",
	["bookmark-plus"] = "rbxassetid://7734111084",
	["box-select"] = "rbxassetid://7733696665",
	filter = "rbxassetid://7733798407",
	play = "rbxassetid://7743871480",
	["align-vertical-space-around"] = "rbxassetid://8997382708",
	calculator = "rbxassetid://7733919105",
	["bell-ring"] = "rbxassetid://7733675275",
	plane = "rbxassetid://7734037723",
	["plus-circle"] = "rbxassetid://7734040271",
	power = "rbxassetid://7734042493",
	["phone-missed"] = "rbxassetid://7734029465",
	percent = "rbxassetid://7743870852",
	["jersey-pound"] = "rbxassetid://7733965029",
	["mouse-pointer"] = "rbxassetid://7743870392",
	box = "rbxassetid://7733917120",
	["separator-vertical"] = "rbxassetid://7734053213",
	snowflake = "rbxassetid://7734059180",
	["sort-desc"] = "rbxassetid://7743871973",
	["flag-triangle-right"] = "rbxassetid://7733798634",
	["bar-chart-2"] = "rbxassetid://7733674239",
	["hand-metal"] = "rbxassetid://7733955664",
	map = "rbxassetid://7733992829",
	["eye-off"] = "rbxassetid://7733774495",
	["align-end-horizontal"] = "rbxassetid://8997380820",
	["cloud-rain"] = "rbxassetid://7733746651",
	contact = "rbxassetid://7743866666",
	signal = "rbxassetid://8997387546",
	["mouse-pointer-click"] = "rbxassetid://7734010488",
	["settings-2"] = "rbxassetid://8997386997",
	["sidebar-open"] = "rbxassetid://7734058165",
	["unlink-2"] = "rbxassetid://7743875069",
	["pause-octagon"] = "rbxassetid://7734021827",
	["user-minus"] = "rbxassetid://7743875629",
	cloud = "rbxassetid://7733746980",
	["arrow-right-circle"] = "rbxassetid://7733673229",
	["align-horizonal-distribute-center"] = "rbxassetid://8997381028",
	["fast-forward"] = "rbxassetid://7743867090",
	["volume-2"] = "rbxassetid://7743877250",
	grab = "rbxassetid://7733954884",
	["arrow-right"] = "rbxassetid://7733673345",
	["chevron-down"] = "rbxassetid://7733717447",
	["volume-x"] = "rbxassetid://7743877381",
	["cloud-snow"] = "rbxassetid://7733746798",
	car = "rbxassetid://7733708835",
	["bluetooth-connected"] = "rbxassetid://7734110952",
	CD = "rbxassetid://7734110220",
	cookie = "rbxassetid://8997385628",
	["message-square"] = "rbxassetid://7733993369",
	["repeat-1"] = "rbxassetid://7734051342",
	codepen = "rbxassetid://7733920768",
	voicemail = "rbxassetid://7743876916",
	["text-cursor-input"] = "rbxassetid://8997388094",
	["package-check"] = "rbxassetid://8997386143",
	["shopping-cart"] = "rbxassetid://7734056813",
	["corner-down-right"] = "rbxassetid://7733764385",
	["folder-open"] = "rbxassetid://8997386062",
	charge = "rbxassetid://8997383136",
	["layout-grid"] = "rbxassetid://7733970390",
	clock = "rbxassetid://7733734848",
	["corner-up-left"] = "rbxassetid://7733764800",
	["align-horizontal-justify-start"] = "rbxassetid://8997381652",
	["git-merge"] = "rbxassetid://7733952195",
	verified = "rbxassetid://7743876142",
	redo = "rbxassetid://7743871739",
	hexagon = "rbxassetid://7743868527",
	square = "rbxassetid://7743872181",
	["align-horizontal-justify-center"] = "rbxassetid://8997381461",
	["chevrons-up-down"] = "rbxassetid://7733723321",
	bus = "rbxassetid://7733701715",
	["file-plus-2"] = "rbxassetid://7733788816",
	["alarm-plus"] = "rbxassetid://7733658066",
	["divide-square"] = "rbxassetid://7733769261",
	["pie-chart"] = "rbxassetid://7734034378",
	["signal-zero"] = "rbxassetid://8997387434",
	hammer = "rbxassetid://7733955511",
	history = "rbxassetid://7733960880",
	["align-vertical-justify-start"] = "rbxassetid://8997382639",
	["flask-round"] = "rbxassetid://7733798957",
	["wifi-off"] = "rbxassetid://7743878056",
	["zoom-out"] = "rbxassetid://7743879082",
	["toggle-right"] = "rbxassetid://7743873539",
	monitor = "rbxassetid://7734002839",
	["x"] = "rbxassetid://7743878857",
	["align-horizonal-distribute-end"] = "rbxassetid://8997381144",
	user = "rbxassetid://7743875962",
	sprout = "rbxassetid://7743872071",
	move = "rbxassetid://7743870731",
	gavel = "rbxassetid://7733800044",
	["package-minus"] = "rbxassetid://8997386266",
	drumstick = "rbxassetid://8997385789",
	forward = "rbxassetid://7733799371",
	["sidebar-close"] = "rbxassetid://7734058092",
	electricity = "rbxassetid://7733771628",
	plus = "rbxassetid://7734042071",
	pipette = "rbxassetid://7743871384",
	["cloud-lightning"] = "rbxassetid://7733741741",
	["lasso-select"] = "rbxassetid://7743868832",
	["phone-call"] = "rbxassetid://7734027264",
	droplet = "rbxassetid://7733770982",
	key = "rbxassetid://7733965118",
	["map-pin"] = "rbxassetid://7733992789",
	["navigation-2"] = "rbxassetid://7734020942",
	["list-minus"] = "rbxassetid://7733980795",
	["chevron-up"] = "rbxassetid://7733919605",
	["layout-template"] = "rbxassetid://7733970494",
	no_entry = "rbxassetid://7734021118",
	scan = "rbxassetid://8997386861",
	["arrow-big-up"] = "rbxassetid://7733671663",
	["bookmark-minus"] = "rbxassetid://7733689754",
	activity = "rbxassetid://7733655755",
	grid = "rbxassetid://7733955179",
	["user-x"] = "rbxassetid://7743875879",
	["alert-circle"] = "rbxassetid://7733658271",
	menu = "rbxassetid://7733993211",
	["form-input"] = "rbxassetid://7733799275",
	rss = "rbxassetid://7734052075",
	loader = "rbxassetid://7733992358",
	["align-vertical-distribute-end"] = "rbxassetid://8997382326",
	strikethrough = "rbxassetid://7734068425",
	mic = "rbxassetid://7743869805",
	landmark = "rbxassetid://7733965184",
	crosshair = "rbxassetid://7733765307",
	["alert-octagon"] = "rbxassetid://7733658335",
	anchor = "rbxassetid://7733911490",
	["separator-horizontal"] = "rbxassetid://7734053146",
	["chevron-left"] = "rbxassetid://7733717651",
	["flask-conical"] = "rbxassetid://7733798901",
	wallet = "rbxassetid://7743877573",
	euro = "rbxassetid://7733771891",
	["trash-2"] = "rbxassetid://7743873772",
	["check-circle"] = "rbxassetid://7733919427",
	layout = "rbxassetid://7733970543",
	droplets = "rbxassetid://7733771078",
	["align-start-vertical"] = "rbxassetid://8997382085",
	["rotate-cw"] = "rbxassetid://7734051957",
	minimize = "rbxassetid://7733997941",
	["arrow-down-left"] = "rbxassetid://7733672282",
	["signal-medium"] = "rbxassetid://8997387319",
	["align-vertical-distribute-center"] = "rbxassetid://8997382212",
	["image-off"] = "rbxassetid://7733963907",
	cloudy = "rbxassetid://7733747106",
	["align-left"] = "rbxassetid://7733911357",
	film = "rbxassetid://7733942579",
	["chevrons-down"] = "rbxassetid://7733720604",
	pointer = "rbxassetid://7734042307",
	folder = "rbxassetid://7733799185",
	["chevrons-left"] = "rbxassetid://7733720701",
	["shield-off"] = "rbxassetid://7734056540",
	wrench = "rbxassetid://7743878358"
};

InterfaceManagerTable.LucideIcon = {
	["lucide-accessibility"] = "rbxassetid://10709751939",
	["lucide-activity"] = "rbxassetid://10709752035",
	["lucide-air-vent"] = "rbxassetid://10709752131",
	["lucide-airplay"] = "rbxassetid://10709752254",
	["lucide-alarm-check"] = "rbxassetid://10709752405",
	["lucide-alarm-clock"] = "rbxassetid://10709752630",
	["lucide-alarm-clock-off"] = "rbxassetid://10709752508",
	["lucide-alarm-minus"] = "rbxassetid://10709752732",
	["lucide-alarm-plus"] = "rbxassetid://10709752825",
	["lucide-album"] = "rbxassetid://10709752906",
	["lucide-alert-circle"] = "rbxassetid://10709752996",
	["lucide-alert-octagon"] = "rbxassetid://10709753064",
	["lucide-alert-triangle"] = "rbxassetid://10709753149",
	["lucide-align-center"] = "rbxassetid://10709753570",
	["lucide-align-center-horizontal"] = "rbxassetid://10709753272",
	["lucide-align-center-vertical"] = "rbxassetid://10709753421",
	["lucide-align-end-horizontal"] = "rbxassetid://10709753692",
	["lucide-align-end-vertical"] = "rbxassetid://10709753808",
	["lucide-align-horizontal-distribute-center"] = "rbxassetid://10747779791",
	["lucide-align-horizontal-distribute-end"] = "rbxassetid://10747784534",
	["lucide-align-horizontal-distribute-start"] = "rbxassetid://10709754118",
	["lucide-align-horizontal-justify-center"] = "rbxassetid://10709754204",
	["lucide-align-horizontal-justify-end"] = "rbxassetid://10709754317",
	["lucide-align-horizontal-justify-start"] = "rbxassetid://10709754436",
	["lucide-align-horizontal-space-around"] = "rbxassetid://10709754590",
	["lucide-align-horizontal-space-between"] = "rbxassetid://10709754749",
	["lucide-align-justify"] = "rbxassetid://10709759610",
	["lucide-align-left"] = "rbxassetid://10709759764",
	["lucide-align-right"] = "rbxassetid://10709759895",
	["lucide-align-start-horizontal"] = "rbxassetid://10709760051",
	["lucide-align-start-vertical"] = "rbxassetid://10709760244",
	["lucide-align-vertical-distribute-center"] = "rbxassetid://10709760351",
	["lucide-align-vertical-distribute-end"] = "rbxassetid://10709760434",
	["lucide-align-vertical-distribute-start"] = "rbxassetid://10709760612",
	["lucide-align-vertical-justify-center"] = "rbxassetid://10709760814",
	["lucide-align-vertical-justify-end"] = "rbxassetid://10709761003",
	["lucide-align-vertical-justify-start"] = "rbxassetid://10709761176",
	["lucide-align-vertical-space-around"] = "rbxassetid://10709761324",
	["lucide-align-vertical-space-between"] = "rbxassetid://10709761434",
	["lucide-anchor"] = "rbxassetid://10709761530",
	["lucide-angry"] = "rbxassetid://10709761629",
	["lucide-annoyed"] = "rbxassetid://10709761722",
	["lucide-aperture"] = "rbxassetid://10709761813",
	["lucide-apple"] = "rbxassetid://10709761889",
	["lucide-archive"] = "rbxassetid://10709762233",
	["lucide-archive-restore"] = "rbxassetid://10709762058",
	["lucide-armchair"] = "rbxassetid://10709762327",
	["lucide-arrow-big-down"] = "rbxassetid://10747796644",
	["lucide-arrow-big-left"] = "rbxassetid://10709762574",
	["lucide-arrow-big-right"] = "rbxassetid://10709762727",
	["lucide-arrow-big-up"] = "rbxassetid://10709762879",
	["lucide-arrow-down"] = "rbxassetid://10709767827",
	["lucide-arrow-down-circle"] = "rbxassetid://10709763034",
	["lucide-arrow-down-left"] = "rbxassetid://10709767656",
	["lucide-arrow-down-right"] = "rbxassetid://10709767750",
	["lucide-arrow-left"] = "rbxassetid://10709768114",
	["lucide-arrow-left-circle"] = "rbxassetid://10709767936",
	["lucide-arrow-left-right"] = "rbxassetid://10709768019",
	["lucide-arrow-right"] = "rbxassetid://10709768347",
	["lucide-arrow-right-circle"] = "rbxassetid://10709768226",
	["lucide-arrow-up"] = "rbxassetid://10709768939",
	["lucide-arrow-up-circle"] = "rbxassetid://10709768432",
	["lucide-arrow-up-down"] = "rbxassetid://10709768538",
	["lucide-arrow-up-left"] = "rbxassetid://10709768661",
	["lucide-arrow-up-right"] = "rbxassetid://10709768787",
	["lucide-asterisk"] = "rbxassetid://10709769095",
	["lucide-at-sign"] = "rbxassetid://10709769286",
	["lucide-award"] = "rbxassetid://10709769406",
	["lucide-axe"] = "rbxassetid://10709769508",
	["lucide-axis-3d"] = "rbxassetid://10709769598",
	["lucide-baby"] = "rbxassetid://10709769732",
	["lucide-backpack"] = "rbxassetid://10709769841",
	["lucide-baggage-claim"] = "rbxassetid://10709769935",
	["lucide-banana"] = "rbxassetid://10709770005",
	["lucide-banknote"] = "rbxassetid://10709770178",
	["lucide-bar-chart"] = "rbxassetid://10709773755",
	["lucide-bar-chart-2"] = "rbxassetid://10709770317",
	["lucide-bar-chart-3"] = "rbxassetid://10709770431",
	["lucide-bar-chart-4"] = "rbxassetid://10709770560",
	["lucide-bar-chart-horizontal"] = "rbxassetid://10709773669",
	["lucide-barcode"] = "rbxassetid://10747360675",
	["lucide-baseline"] = "rbxassetid://10709773863",
	["lucide-bath"] = "rbxassetid://10709773963",
	["lucide-battery"] = "rbxassetid://10709774640",
	["lucide-battery-charging"] = "rbxassetid://10709774068",
	["lucide-battery-full"] = "rbxassetid://10709774206",
	["lucide-battery-low"] = "rbxassetid://10709774370",
	["lucide-battery-medium"] = "rbxassetid://10709774513",
	["lucide-beaker"] = "rbxassetid://10709774756",
	["lucide-bed"] = "rbxassetid://10709775036",
	["lucide-bed-double"] = "rbxassetid://10709774864",
	["lucide-bed-single"] = "rbxassetid://10709774968",
	["lucide-beer"] = "rbxassetid://10709775167",
	["lucide-bell"] = "rbxassetid://10709775704",
	["lucide-bell-minus"] = "rbxassetid://10709775241",
	["lucide-bell-off"] = "rbxassetid://10709775320",
	["lucide-bell-plus"] = "rbxassetid://10709775448",
	["lucide-bell-ring"] = "rbxassetid://10709775560",
	["lucide-bike"] = "rbxassetid://10709775894",
	["lucide-binary"] = "rbxassetid://10709776050",
	["lucide-bitcoin"] = "rbxassetid://10709776126",
	["lucide-bluetooth"] = "rbxassetid://10709776655",
	["lucide-bluetooth-connected"] = "rbxassetid://10709776240",
	["lucide-bluetooth-off"] = "rbxassetid://10709776344",
	["lucide-bluetooth-searching"] = "rbxassetid://10709776501",
	["lucide-bold"] = "rbxassetid://10747813908",
	["lucide-bomb"] = "rbxassetid://10709781460",
	["lucide-bone"] = "rbxassetid://10709781605",
	["lucide-book"] = "rbxassetid://10709781824",
	["lucide-book-open"] = "rbxassetid://10709781717",
	["lucide-bookmark"] = "rbxassetid://10709782154",
	["lucide-bookmark-minus"] = "rbxassetid://10709781919",
	["lucide-bookmark-plus"] = "rbxassetid://10709782044",
	["lucide-bot"] = "rbxassetid://10709782230",
	["lucide-box"] = "rbxassetid://10709782497",
	["lucide-box-select"] = "rbxassetid://10709782342",
	["lucide-boxes"] = "rbxassetid://10709782582",
	["lucide-briefcase"] = "rbxassetid://10709782662",
	["lucide-brush"] = "rbxassetid://10709782758",
	["lucide-bug"] = "rbxassetid://10709782845",
	["lucide-building"] = "rbxassetid://10709783051",
	["lucide-building-2"] = "rbxassetid://10709782939",
	["lucide-bus"] = "rbxassetid://10709783137",
	["lucide-cake"] = "rbxassetid://10709783217",
	["lucide-calculator"] = "rbxassetid://10709783311",
	["lucide-calendar"] = "rbxassetid://10709789505",
	["lucide-calendar-check"] = "rbxassetid://10709783474",
	["lucide-calendar-check-2"] = "rbxassetid://10709783392",
	["lucide-calendar-clock"] = "rbxassetid://10709783577",
	["lucide-calendar-days"] = "rbxassetid://10709783673",
	["lucide-calendar-heart"] = "rbxassetid://10709783835",
	["lucide-calendar-minus"] = "rbxassetid://10709783959",
	["lucide-calendar-off"] = "rbxassetid://10709788784",
	["lucide-calendar-plus"] = "rbxassetid://10709788937",
	["lucide-calendar-range"] = "rbxassetid://10709789053",
	["lucide-calendar-search"] = "rbxassetid://10709789200",
	["lucide-calendar-x"] = "rbxassetid://10709789407",
	["lucide-calendar-x-2"] = "rbxassetid://10709789329",
	["lucide-camera"] = "rbxassetid://10709789686",
	["lucide-camera-off"] = "rbxassetid://10747822677",
	["lucide-car"] = "rbxassetid://10709789810",
	["lucide-carrot"] = "rbxassetid://10709789960",
	["lucide-cast"] = "rbxassetid://10709790097",
	["lucide-charge"] = "rbxassetid://10709790202",
	["lucide-check"] = "rbxassetid://10709790644",
	["lucide-check-circle"] = "rbxassetid://10709790387",
	["lucide-check-circle-2"] = "rbxassetid://10709790298",
	["lucide-check-square"] = "rbxassetid://10709790537",
	["lucide-chef-hat"] = "rbxassetid://10709790757",
	["lucide-cherry"] = "rbxassetid://10709790875",
	["lucide-chevron-down"] = "rbxassetid://10709790948",
	["lucide-chevron-first"] = "rbxassetid://10709791015",
	["lucide-chevron-last"] = "rbxassetid://10709791130",
	["lucide-chevron-left"] = "rbxassetid://10709791281",
	["lucide-chevron-right"] = "rbxassetid://10709791437",
	["lucide-chevron-up"] = "rbxassetid://10709791523",
	["lucide-chevrons-down"] = "rbxassetid://10709796864",
	["lucide-chevrons-down-up"] = "rbxassetid://10709791632",
	["lucide-chevrons-left"] = "rbxassetid://10709797151",
	["lucide-chevrons-left-right"] = "rbxassetid://10709797006",
	["lucide-chevrons-right"] = "rbxassetid://10709797382",
	["lucide-chevrons-right-left"] = "rbxassetid://10709797274",
	["lucide-chevrons-up"] = "rbxassetid://10709797622",
	["lucide-chevrons-up-down"] = "rbxassetid://10709797508",
	["lucide-chrome"] = "rbxassetid://10709797725",
	["lucide-circle"] = "rbxassetid://10709798174",
	["lucide-circle-dot"] = "rbxassetid://10709797837",
	["lucide-circle-ellipsis"] = "rbxassetid://10709797985",
	["lucide-circle-slashed"] = "rbxassetid://10709798100",
	["lucide-citrus"] = "rbxassetid://10709798276",
	["lucide-clapperboard"] = "rbxassetid://10709798350",
	["lucide-clipboard"] = "rbxassetid://10709799288",
	["lucide-clipboard-check"] = "rbxassetid://10709798443",
	["lucide-clipboard-copy"] = "rbxassetid://10709798574",
	["lucide-clipboard-edit"] = "rbxassetid://10709798682",
	["lucide-clipboard-list"] = "rbxassetid://10709798792",
	["lucide-clipboard-signature"] = "rbxassetid://10709798890",
	["lucide-clipboard-type"] = "rbxassetid://10709798999",
	["lucide-clipboard-x"] = "rbxassetid://10709799124",
	["lucide-clock"] = "rbxassetid://10709805144",
	["lucide-clock-1"] = "rbxassetid://10709799535",
	["lucide-clock-10"] = "rbxassetid://10709799718",
	["lucide-clock-11"] = "rbxassetid://10709799818",
	["lucide-clock-12"] = "rbxassetid://10709799962",
	["lucide-clock-2"] = "rbxassetid://10709803876",
	["lucide-clock-3"] = "rbxassetid://10709803989",
	["lucide-clock-4"] = "rbxassetid://10709804164",
	["lucide-clock-5"] = "rbxassetid://10709804291",
	["lucide-clock-6"] = "rbxassetid://10709804435",
	["lucide-clock-7"] = "rbxassetid://10709804599",
	["lucide-clock-8"] = "rbxassetid://10709804784",
	["lucide-clock-9"] = "rbxassetid://10709804996",
	["lucide-cloud"] = "rbxassetid://10709806740",
	["lucide-cloud-cog"] = "rbxassetid://10709805262",
	["lucide-cloud-drizzle"] = "rbxassetid://10709805371",
	["lucide-cloud-fog"] = "rbxassetid://10709805477",
	["lucide-cloud-hail"] = "rbxassetid://10709805596",
	["lucide-cloud-lightning"] = "rbxassetid://10709805727",
	["lucide-cloud-moon"] = "rbxassetid://10709805942",
	["lucide-cloud-moon-rain"] = "rbxassetid://10709805838",
	["lucide-cloud-off"] = "rbxassetid://10709806060",
	["lucide-cloud-rain"] = "rbxassetid://10709806277",
	["lucide-cloud-rain-wind"] = "rbxassetid://10709806166",
	["lucide-cloud-snow"] = "rbxassetid://10709806374",
	["lucide-cloud-sun"] = "rbxassetid://10709806631",
	["lucide-cloud-sun-rain"] = "rbxassetid://10709806475",
	["lucide-cloudy"] = "rbxassetid://10709806859",
	["lucide-clover"] = "rbxassetid://10709806995",
	["lucide-code"] = "rbxassetid://10709810463",
	["lucide-code-2"] = "rbxassetid://10709807111",
	["lucide-codepen"] = "rbxassetid://10709810534",
	["lucide-codesandbox"] = "rbxassetid://10709810676",
	["lucide-coffee"] = "rbxassetid://10709810814",
	["lucide-cog"] = "rbxassetid://10709810948",
	["lucide-coins"] = "rbxassetid://10709811110",
	["lucide-columns"] = "rbxassetid://10709811261",
	["lucide-command"] = "rbxassetid://10709811365",
	["lucide-compass"] = "rbxassetid://10709811445",
	["lucide-component"] = "rbxassetid://10709811595",
	["lucide-concierge-bell"] = "rbxassetid://10709811706",
	["lucide-connection"] = "rbxassetid://10747361219",
	["lucide-contact"] = "rbxassetid://10709811834",
	["lucide-contrast"] = "rbxassetid://10709811939",
	["lucide-cookie"] = "rbxassetid://10709812067",
	["lucide-copy"] = "rbxassetid://10709812159",
	["lucide-copyleft"] = "rbxassetid://10709812251",
	["lucide-copyright"] = "rbxassetid://10709812311",
	["lucide-corner-down-left"] = "rbxassetid://10709812396",
	["lucide-corner-down-right"] = "rbxassetid://10709812485",
	["lucide-corner-left-down"] = "rbxassetid://10709812632",
	["lucide-corner-left-up"] = "rbxassetid://10709812784",
	["lucide-corner-right-down"] = "rbxassetid://10709812939",
	["lucide-corner-right-up"] = "rbxassetid://10709813094",
	["lucide-corner-up-left"] = "rbxassetid://10709813185",
	["lucide-corner-up-right"] = "rbxassetid://10709813281",
	["lucide-cpu"] = "rbxassetid://10709813383",
	["lucide-croissant"] = "rbxassetid://10709818125",
	["lucide-crop"] = "rbxassetid://10709818245",
	["lucide-cross"] = "rbxassetid://10709818399",
	["lucide-crosshair"] = "rbxassetid://10709818534",
	["lucide-crown"] = "rbxassetid://10709818626",
	["lucide-cup-soda"] = "rbxassetid://10709818763",
	["lucide-curly-braces"] = "rbxassetid://10709818847",
	["lucide-currency"] = "rbxassetid://10709818931",
	["lucide-database"] = "rbxassetid://10709818996",
	["lucide-delete"] = "rbxassetid://10709819059",
	["lucide-diamond"] = "rbxassetid://10709819149",
	["lucide-dice-1"] = "rbxassetid://10709819266",
	["lucide-dice-2"] = "rbxassetid://10709819361",
	["lucide-dice-3"] = "rbxassetid://10709819508",
	["lucide-dice-4"] = "rbxassetid://10709819670",
	["lucide-dice-5"] = "rbxassetid://10709819801",
	["lucide-dice-6"] = "rbxassetid://10709819896",
	["lucide-dices"] = "rbxassetid://10723343321",
	["lucide-diff"] = "rbxassetid://10723343416",
	["lucide-disc"] = "rbxassetid://10723343537",
	["lucide-divide"] = "rbxassetid://10723343805",
	["lucide-divide-circle"] = "rbxassetid://10723343636",
	["lucide-divide-square"] = "rbxassetid://10723343737",
	["lucide-dollar-sign"] = "rbxassetid://10723343958",
	["lucide-download"] = "rbxassetid://10723344270",
	["lucide-download-cloud"] = "rbxassetid://10723344088",
	["lucide-droplet"] = "rbxassetid://10723344432",
	["lucide-droplets"] = "rbxassetid://10734883356",
	["lucide-drumstick"] = "rbxassetid://10723344737",
	["lucide-edit"] = "rbxassetid://10734883598",
	["lucide-edit-2"] = "rbxassetid://10723344885",
	["lucide-edit-3"] = "rbxassetid://10723345088",
	["lucide-egg"] = "rbxassetid://10723345518",
	["lucide-egg-fried"] = "rbxassetid://10723345347",
	["lucide-electricity"] = "rbxassetid://10723345749",
	["lucide-electricity-off"] = "rbxassetid://10723345643",
	["lucide-equal"] = "rbxassetid://10723345990",
	["lucide-equal-not"] = "rbxassetid://10723345866",
	["lucide-eraser"] = "rbxassetid://10723346158",
	["lucide-euro"] = "rbxassetid://10723346372",
	["lucide-expand"] = "rbxassetid://10723346553",
	["lucide-external-link"] = "rbxassetid://10723346684",
	["lucide-eye"] = "rbxassetid://10723346959",
	["lucide-eye-off"] = "rbxassetid://10723346871",
	["lucide-factory"] = "rbxassetid://10723347051",
	["lucide-fan"] = "rbxassetid://10723354359",
	["lucide-fast-forward"] = "rbxassetid://10723354521",
	["lucide-feather"] = "rbxassetid://10723354671",
	["lucide-figma"] = "rbxassetid://10723354801",
	["lucide-file"] = "rbxassetid://10723374641",
	["lucide-file-archive"] = "rbxassetid://10723354921",
	["lucide-file-audio"] = "rbxassetid://10723355148",
	["lucide-file-audio-2"] = "rbxassetid://10723355026",
	["lucide-file-axis-3d"] = "rbxassetid://10723355272",
	["lucide-file-badge"] = "rbxassetid://10723355622",
	["lucide-file-badge-2"] = "rbxassetid://10723355451",
	["lucide-file-bar-chart"] = "rbxassetid://10723355887",
	["lucide-file-bar-chart-2"] = "rbxassetid://10723355746",
	["lucide-file-box"] = "rbxassetid://10723355989",
	["lucide-file-check"] = "rbxassetid://10723356210",
	["lucide-file-check-2"] = "rbxassetid://10723356100",
	["lucide-file-clock"] = "rbxassetid://10723356329",
	["lucide-file-code"] = "rbxassetid://10723356507",
	["lucide-file-cog"] = "rbxassetid://10723356830",
	["lucide-file-cog-2"] = "rbxassetid://10723356676",
	["lucide-file-diff"] = "rbxassetid://10723357039",
	["lucide-file-digit"] = "rbxassetid://10723357151",
	["lucide-file-down"] = "rbxassetid://10723357322",
	["lucide-file-edit"] = "rbxassetid://10723357495",
	["lucide-file-heart"] = "rbxassetid://10723357637",
	["lucide-file-image"] = "rbxassetid://10723357790",
	["lucide-file-input"] = "rbxassetid://10723357933",
	["lucide-file-json"] = "rbxassetid://10723364435",
	["lucide-file-json-2"] = "rbxassetid://10723364361",
	["lucide-file-key"] = "rbxassetid://10723364605",
	["lucide-file-key-2"] = "rbxassetid://10723364515",
	["lucide-file-line-chart"] = "rbxassetid://10723364725",
	["lucide-file-lock"] = "rbxassetid://10723364957",
	["lucide-file-lock-2"] = "rbxassetid://10723364861",
	["lucide-file-minus"] = "rbxassetid://10723365254",
	["lucide-file-minus-2"] = "rbxassetid://10723365086",
	["lucide-file-output"] = "rbxassetid://10723365457",
	["lucide-file-pie-chart"] = "rbxassetid://10723365598",
	["lucide-file-plus"] = "rbxassetid://10723365877",
	["lucide-file-plus-2"] = "rbxassetid://10723365766",
	["lucide-file-question"] = "rbxassetid://10723365987",
	["lucide-file-scan"] = "rbxassetid://10723366167",
	["lucide-file-search"] = "rbxassetid://10723366550",
	["lucide-file-search-2"] = "rbxassetid://10723366340",
	["lucide-file-signature"] = "rbxassetid://10723366741",
	["lucide-file-spreadsheet"] = "rbxassetid://10723366962",
	["lucide-file-symlink"] = "rbxassetid://10723367098",
	["lucide-file-terminal"] = "rbxassetid://10723367244",
	["lucide-file-text"] = "rbxassetid://10723367380",
	["lucide-file-type"] = "rbxassetid://10723367606",
	["lucide-file-type-2"] = "rbxassetid://10723367509",
	["lucide-file-up"] = "rbxassetid://10723367734",
	["lucide-file-video"] = "rbxassetid://10723373884",
	["lucide-file-video-2"] = "rbxassetid://10723367834",
	["lucide-file-volume"] = "rbxassetid://10723374172",
	["lucide-file-volume-2"] = "rbxassetid://10723374030",
	["lucide-file-warning"] = "rbxassetid://10723374276",
	["lucide-file-x"] = "rbxassetid://10723374544",
	["lucide-file-x-2"] = "rbxassetid://10723374378",
	["lucide-files"] = "rbxassetid://10723374759",
	["lucide-film"] = "rbxassetid://10723374981",
	["lucide-filter"] = "rbxassetid://10723375128",
	["lucide-fingerprint"] = "rbxassetid://10723375250",
	["lucide-flag"] = "rbxassetid://10723375890",
	["lucide-flag-off"] = "rbxassetid://10723375443",
	["lucide-flag-triangle-left"] = "rbxassetid://10723375608",
	["lucide-flag-triangle-right"] = "rbxassetid://10723375727",
	["lucide-flame"] = "rbxassetid://10723376114",
	["lucide-flashlight"] = "rbxassetid://10723376471",
	["lucide-flashlight-off"] = "rbxassetid://10723376365",
	["lucide-flask-conical"] = "rbxassetid://10734883986",
	["lucide-flask-round"] = "rbxassetid://10723376614",
	["lucide-flip-horizontal"] = "rbxassetid://10723376884",
	["lucide-flip-horizontal-2"] = "rbxassetid://10723376745",
	["lucide-flip-vertical"] = "rbxassetid://10723377138",
	["lucide-flip-vertical-2"] = "rbxassetid://10723377026",
	["lucide-flower"] = "rbxassetid://10747830374",
	["lucide-flower-2"] = "rbxassetid://10723377305",
	["lucide-focus"] = "rbxassetid://10723377537",
	["lucide-folder"] = "rbxassetid://10723387563",
	["lucide-folder-archive"] = "rbxassetid://10723384478",
	["lucide-folder-check"] = "rbxassetid://10723384605",
	["lucide-folder-clock"] = "rbxassetid://10723384731",
	["lucide-folder-closed"] = "rbxassetid://10723384893",
	["lucide-folder-cog"] = "rbxassetid://10723385213",
	["lucide-folder-cog-2"] = "rbxassetid://10723385036",
	["lucide-folder-down"] = "rbxassetid://10723385338",
	["lucide-folder-edit"] = "rbxassetid://10723385445",
	["lucide-folder-heart"] = "rbxassetid://10723385545",
	["lucide-folder-input"] = "rbxassetid://10723385721",
	["lucide-folder-key"] = "rbxassetid://10723385848",
	["lucide-folder-lock"] = "rbxassetid://10723386005",
	["lucide-folder-minus"] = "rbxassetid://10723386127",
	["lucide-folder-open"] = "rbxassetid://10723386277",
	["lucide-folder-output"] = "rbxassetid://10723386386",
	["lucide-folder-plus"] = "rbxassetid://10723386531",
	["lucide-folder-search"] = "rbxassetid://10723386787",
	["lucide-folder-search-2"] = "rbxassetid://10723386674",
	["lucide-folder-symlink"] = "rbxassetid://10723386930",
	["lucide-folder-tree"] = "rbxassetid://10723387085",
	["lucide-folder-up"] = "rbxassetid://10723387265",
	["lucide-folder-x"] = "rbxassetid://10723387448",
	["lucide-folders"] = "rbxassetid://10723387721",
	["lucide-form-input"] = "rbxassetid://10723387841",
	["lucide-forward"] = "rbxassetid://10723388016",
	["lucide-frame"] = "rbxassetid://10723394389",
	["lucide-framer"] = "rbxassetid://10723394565",
	["lucide-frown"] = "rbxassetid://10723394681",
	["lucide-fuel"] = "rbxassetid://10723394846",
	["lucide-function-square"] = "rbxassetid://10723395041",
	["lucide-gamepad"] = "rbxassetid://10723395457",
	["lucide-gamepad-2"] = "rbxassetid://10723395215",
	["lucide-gauge"] = "rbxassetid://10723395708",
	["lucide-gavel"] = "rbxassetid://10723395896",
	["lucide-gem"] = "rbxassetid://10723396000",
	["lucide-ghost"] = "rbxassetid://10723396107",
	["lucide-gift"] = "rbxassetid://10723396402",
	["lucide-gift-card"] = "rbxassetid://10723396225",
	["lucide-git-branch"] = "rbxassetid://10723396676",
	["lucide-git-branch-plus"] = "rbxassetid://10723396542",
	["lucide-git-commit"] = "rbxassetid://10723396812",
	["lucide-git-compare"] = "rbxassetid://10723396954",
	["lucide-git-fork"] = "rbxassetid://10723397049",
	["lucide-git-merge"] = "rbxassetid://10723397165",
	["lucide-git-pull-request"] = "rbxassetid://10723397431",
	["lucide-git-pull-request-closed"] = "rbxassetid://10723397268",
	["lucide-git-pull-request-draft"] = "rbxassetid://10734884302",
	["lucide-glass"] = "rbxassetid://10723397788",
	["lucide-glass-2"] = "rbxassetid://10723397529",
	["lucide-glass-water"] = "rbxassetid://10723397678",
	["lucide-glasses"] = "rbxassetid://10723397895",
	["lucide-globe"] = "rbxassetid://10723404337",
	["lucide-globe-2"] = "rbxassetid://10723398002",
	["lucide-grab"] = "rbxassetid://10723404472",
	["lucide-graduation-cap"] = "rbxassetid://10723404691",
	["lucide-grape"] = "rbxassetid://10723404822",
	["lucide-grid"] = "rbxassetid://10723404936",
	["lucide-grip-horizontal"] = "rbxassetid://10723405089",
	["lucide-grip-vertical"] = "rbxassetid://10723405236",
	["lucide-hammer"] = "rbxassetid://10723405360",
	["lucide-hand"] = "rbxassetid://10723405649",
	["lucide-hand-metal"] = "rbxassetid://10723405508",
	["lucide-hard-drive"] = "rbxassetid://10723405749",
	["lucide-hard-hat"] = "rbxassetid://10723405859",
	["lucide-hash"] = "rbxassetid://10723405975",
	["lucide-haze"] = "rbxassetid://10723406078",
	["lucide-headphones"] = "rbxassetid://10723406165",
	["lucide-heart"] = "rbxassetid://10723406885",
	["lucide-heart-crack"] = "rbxassetid://10723406299",
	["lucide-heart-handshake"] = "rbxassetid://10723406480",
	["lucide-heart-off"] = "rbxassetid://10723406662",
	["lucide-heart-pulse"] = "rbxassetid://10723406795",
	["lucide-help-circle"] = "rbxassetid://10723406988",
	["lucide-hexagon"] = "rbxassetid://10723407092",
	["lucide-highlighter"] = "rbxassetid://10723407192",
	["lucide-history"] = "rbxassetid://10723407335",
	["lucide-home"] = "rbxassetid://10723407389",
	["lucide-hourglass"] = "rbxassetid://10723407498",
	["lucide-ice-cream"] = "rbxassetid://10723414308",
	["lucide-image"] = "rbxassetid://10723415040",
	["lucide-image-minus"] = "rbxassetid://10723414487",
	["lucide-image-off"] = "rbxassetid://10723414677",
	["lucide-image-plus"] = "rbxassetid://10723414827",
	["lucide-import"] = "rbxassetid://10723415205",
	["lucide-inbox"] = "rbxassetid://10723415335",
	["lucide-indent"] = "rbxassetid://10723415494",
	["lucide-indian-rupee"] = "rbxassetid://10723415642",
	["lucide-infinity"] = "rbxassetid://10723415766",
	["lucide-info"] = "rbxassetid://10723415903",
	["lucide-inspect"] = "rbxassetid://10723416057",
	["lucide-italic"] = "rbxassetid://10723416195",
	["lucide-japanese-yen"] = "rbxassetid://10723416363",
	["lucide-joystick"] = "rbxassetid://10723416527",
	["lucide-key"] = "rbxassetid://10723416652",
	["lucide-keyboard"] = "rbxassetid://10723416765",
	["lucide-lamp"] = "rbxassetid://10723417513",
	["lucide-lamp-ceiling"] = "rbxassetid://10723416922",
	["lucide-lamp-desk"] = "rbxassetid://10723417016",
	["lucide-lamp-floor"] = "rbxassetid://10723417131",
	["lucide-lamp-wall-down"] = "rbxassetid://10723417240",
	["lucide-lamp-wall-up"] = "rbxassetid://10723417356",
	["lucide-landmark"] = "rbxassetid://10723417608",
	["lucide-languages"] = "rbxassetid://10723417703",
	["lucide-laptop"] = "rbxassetid://10723423881",
	["lucide-laptop-2"] = "rbxassetid://10723417797",
	["lucide-lasso"] = "rbxassetid://10723424235",
	["lucide-lasso-select"] = "rbxassetid://10723424058",
	["lucide-laugh"] = "rbxassetid://10723424372",
	["lucide-layers"] = "rbxassetid://10723424505",
	["lucide-layout"] = "rbxassetid://10723425376",
	["lucide-layout-dashboard"] = "rbxassetid://10723424646",
	["lucide-layout-grid"] = "rbxassetid://10723424838",
	["lucide-layout-list"] = "rbxassetid://10723424963",
	["lucide-layout-template"] = "rbxassetid://10723425187",
	["lucide-leaf"] = "rbxassetid://10723425539",
	["lucide-library"] = "rbxassetid://10723425615",
	["lucide-life-buoy"] = "rbxassetid://10723425685",
	["lucide-lightbulb"] = "rbxassetid://10723425852",
	["lucide-lightbulb-off"] = "rbxassetid://10723425762",
	["lucide-line-chart"] = "rbxassetid://10723426393",
	["lucide-link"] = "rbxassetid://10723426722",
	["lucide-link-2"] = "rbxassetid://10723426595",
	["lucide-link-2-off"] = "rbxassetid://10723426513",
	["lucide-list"] = "rbxassetid://10723433811",
	["lucide-list-checks"] = "rbxassetid://10734884548",
	["lucide-list-end"] = "rbxassetid://10723426886",
	["lucide-list-minus"] = "rbxassetid://10723426986",
	["lucide-list-music"] = "rbxassetid://10723427081",
	["lucide-list-ordered"] = "rbxassetid://10723427199",
	["lucide-list-plus"] = "rbxassetid://10723427334",
	["lucide-list-start"] = "rbxassetid://10723427494",
	["lucide-list-video"] = "rbxassetid://10723427619",
	["lucide-list-x"] = "rbxassetid://10723433655",
	["lucide-loader"] = "rbxassetid://10723434070",
	["lucide-loader-2"] = "rbxassetid://10723433935",
	["lucide-locate"] = "rbxassetid://10723434557",
	["lucide-locate-fixed"] = "rbxassetid://10723434236",
	["lucide-locate-off"] = "rbxassetid://10723434379",
	["lucide-lock"] = "rbxassetid://10723434711",
	["lucide-log-in"] = "rbxassetid://10723434830",
	["lucide-log-out"] = "rbxassetid://10723434906",
	["lucide-luggage"] = "rbxassetid://10723434993",
	["lucide-magnet"] = "rbxassetid://10723435069",
	["lucide-mail"] = "rbxassetid://10734885430",
	["lucide-mail-check"] = "rbxassetid://10723435182",
	["lucide-mail-minus"] = "rbxassetid://10723435261",
	["lucide-mail-open"] = "rbxassetid://10723435342",
	["lucide-mail-plus"] = "rbxassetid://10723435443",
	["lucide-mail-question"] = "rbxassetid://10723435515",
	["lucide-mail-search"] = "rbxassetid://10734884739",
	["lucide-mail-warning"] = "rbxassetid://10734885015",
	["lucide-mail-x"] = "rbxassetid://10734885247",
	["lucide-mails"] = "rbxassetid://10734885614",
	["lucide-map"] = "rbxassetid://10734886202",
	["lucide-map-pin"] = "rbxassetid://10734886004",
	["lucide-map-pin-off"] = "rbxassetid://10734885803",
	["lucide-maximize"] = "rbxassetid://10734886735",
	["lucide-maximize-2"] = "rbxassetid://10734886496",
	["lucide-medal"] = "rbxassetid://10734887072",
	["lucide-megaphone"] = "rbxassetid://10734887454",
	["lucide-megaphone-off"] = "rbxassetid://10734887311",
	["lucide-meh"] = "rbxassetid://10734887603",
	["lucide-menu"] = "rbxassetid://10734887784",
	["lucide-message-circle"] = "rbxassetid://10734888000",
	["lucide-message-square"] = "rbxassetid://10734888228",
	["lucide-mic"] = "rbxassetid://10734888864",
	["lucide-mic-2"] = "rbxassetid://10734888430",
	["lucide-mic-off"] = "rbxassetid://10734888646",
	["lucide-microscope"] = "rbxassetid://10734889106",
	["lucide-microwave"] = "rbxassetid://10734895076",
	["lucide-milestone"] = "rbxassetid://10734895310",
	["lucide-minimize"] = "rbxassetid://10734895698",
	["lucide-minimize-2"] = "rbxassetid://10734895530",
	["lucide-minus"] = "rbxassetid://10734896206",
	["lucide-minus-circle"] = "rbxassetid://10734895856",
	["lucide-minus-square"] = "rbxassetid://10734896029",
	["lucide-monitor"] = "rbxassetid://10734896881",
	["lucide-monitor-off"] = "rbxassetid://10734896360",
	["lucide-monitor-speaker"] = "rbxassetid://10734896512",
	["lucide-moon"] = "rbxassetid://10734897102",
	["lucide-more-horizontal"] = "rbxassetid://10734897250",
	["lucide-more-vertical"] = "rbxassetid://10734897387",
	["lucide-mountain"] = "rbxassetid://10734897956",
	["lucide-mountain-snow"] = "rbxassetid://10734897665",
	["lucide-mouse"] = "rbxassetid://10734898592",
	["lucide-mouse-pointer"] = "rbxassetid://10734898476",
	["lucide-mouse-pointer-2"] = "rbxassetid://10734898194",
	["lucide-mouse-pointer-click"] = "rbxassetid://10734898355",
	["lucide-move"] = "rbxassetid://10734900011",
	["lucide-move-3d"] = "rbxassetid://10734898756",
	["lucide-move-diagonal"] = "rbxassetid://10734899164",
	["lucide-move-diagonal-2"] = "rbxassetid://10734898934",
	["lucide-move-horizontal"] = "rbxassetid://10734899414",
	["lucide-move-vertical"] = "rbxassetid://10734899821",
	["lucide-music"] = "rbxassetid://10734905958",
	["lucide-music-2"] = "rbxassetid://10734900215",
	["lucide-music-3"] = "rbxassetid://10734905665",
	["lucide-music-4"] = "rbxassetid://10734905823",
	["lucide-navigation"] = "rbxassetid://10734906744",
	["lucide-navigation-2"] = "rbxassetid://10734906332",
	["lucide-navigation-2-off"] = "rbxassetid://10734906144",
	["lucide-navigation-off"] = "rbxassetid://10734906580",
	["lucide-network"] = "rbxassetid://10734906975",
	["lucide-newspaper"] = "rbxassetid://10734907168",
	["lucide-octagon"] = "rbxassetid://10734907361",
	["lucide-option"] = "rbxassetid://10734907649",
	["lucide-outdent"] = "rbxassetid://10734907933",
	["lucide-package"] = "rbxassetid://10734909540",
	["lucide-package-2"] = "rbxassetid://10734908151",
	["lucide-package-check"] = "rbxassetid://10734908384",
	["lucide-package-minus"] = "rbxassetid://10734908626",
	["lucide-package-open"] = "rbxassetid://10734908793",
	["lucide-package-plus"] = "rbxassetid://10734909016",
	["lucide-package-search"] = "rbxassetid://10734909196",
	["lucide-package-x"] = "rbxassetid://10734909375",
	["lucide-paint-bucket"] = "rbxassetid://10734909847",
	["lucide-paintbrush"] = "rbxassetid://10734910187",
	["lucide-paintbrush-2"] = "rbxassetid://10734910030",
	["lucide-palette"] = "rbxassetid://10734910430",
	["lucide-palmtree"] = "rbxassetid://10734910680",
	["lucide-paperclip"] = "rbxassetid://10734910927",
	["lucide-party-popper"] = "rbxassetid://10734918735",
	["lucide-pause"] = "rbxassetid://10734919336",
	["lucide-pause-circle"] = "rbxassetid://10735024209",
	["lucide-pause-octagon"] = "rbxassetid://10734919143",
	["lucide-pen-tool"] = "rbxassetid://10734919503",
	["lucide-pencil"] = "rbxassetid://10734919691",
	["lucide-percent"] = "rbxassetid://10734919919",
	["lucide-person-standing"] = "rbxassetid://10734920149",
	["lucide-phone"] = "rbxassetid://10734921524",
	["lucide-phone-call"] = "rbxassetid://10734920305",
	["lucide-phone-forwarded"] = "rbxassetid://10734920508",
	["lucide-phone-incoming"] = "rbxassetid://10734920694",
	["lucide-phone-missed"] = "rbxassetid://10734920845",
	["lucide-phone-off"] = "rbxassetid://10734921077",
	["lucide-phone-outgoing"] = "rbxassetid://10734921288",
	["lucide-pie-chart"] = "rbxassetid://10734921727",
	["lucide-piggy-bank"] = "rbxassetid://10734921935",
	["lucide-pin"] = "rbxassetid://10734922324",
	["lucide-pin-off"] = "rbxassetid://10734922180",
	["lucide-pipette"] = "rbxassetid://10734922497",
	["lucide-pizza"] = "rbxassetid://10734922774",
	["lucide-plane"] = "rbxassetid://10734922971",
	["lucide-play"] = "rbxassetid://10734923549",
	["lucide-play-circle"] = "rbxassetid://10734923214",
	["lucide-plus"] = "rbxassetid://10734924532",
	["lucide-plus-circle"] = "rbxassetid://10734923868",
	["lucide-plus-square"] = "rbxassetid://10734924219",
	["lucide-podcast"] = "rbxassetid://10734929553",
	["lucide-pointer"] = "rbxassetid://10734929723",
	["lucide-pound-sterling"] = "rbxassetid://10734929981",
	["lucide-power"] = "rbxassetid://10734930466",
	["lucide-power-off"] = "rbxassetid://10734930257",
	["lucide-printer"] = "rbxassetid://10734930632",
	["lucide-puzzle"] = "rbxassetid://10734930886",
	["lucide-quote"] = "rbxassetid://10734931234",
	["lucide-radio"] = "rbxassetid://10734931596",
	["lucide-radio-receiver"] = "rbxassetid://10734931402",
	["lucide-rectangle-horizontal"] = "rbxassetid://10734931777",
	["lucide-rectangle-vertical"] = "rbxassetid://10734932081",
	["lucide-recycle"] = "rbxassetid://10734932295",
	["lucide-redo"] = "rbxassetid://10734932822",
	["lucide-redo-2"] = "rbxassetid://10734932586",
	["lucide-refresh-ccw"] = "rbxassetid://10734933056",
	["lucide-refresh-cw"] = "rbxassetid://10734933222",
	["lucide-refrigerator"] = "rbxassetid://10734933465",
	["lucide-regex"] = "rbxassetid://10734933655",
	["lucide-repeat"] = "rbxassetid://10734933966",
	["lucide-repeat-1"] = "rbxassetid://10734933826",
	["lucide-reply"] = "rbxassetid://10734934252",
	["lucide-reply-all"] = "rbxassetid://10734934132",
	["lucide-rewind"] = "rbxassetid://10734934347",
	["lucide-rocket"] = "rbxassetid://10734934585",
	["lucide-rocking-chair"] = "rbxassetid://10734939942",
	["lucide-rotate-3d"] = "rbxassetid://10734940107",
	["lucide-rotate-ccw"] = "rbxassetid://10734940376",
	["lucide-rotate-cw"] = "rbxassetid://10734940654",
	["lucide-rss"] = "rbxassetid://10734940825",
	["lucide-ruler"] = "rbxassetid://10734941018",
	["lucide-russian-ruble"] = "rbxassetid://10734941199",
	["lucide-sailboat"] = "rbxassetid://10734941354",
	["lucide-save"] = "rbxassetid://10734941499",
	["lucide-scale"] = "rbxassetid://10734941912",
	["lucide-scale-3d"] = "rbxassetid://10734941739",
	["lucide-scaling"] = "rbxassetid://10734942072",
	["lucide-scan"] = "rbxassetid://10734942565",
	["lucide-scan-face"] = "rbxassetid://10734942198",
	["lucide-scan-line"] = "rbxassetid://10734942351",
	["lucide-scissors"] = "rbxassetid://10734942778",
	["lucide-screen-share"] = "rbxassetid://10734943193",
	["lucide-screen-share-off"] = "rbxassetid://10734942967",
	["lucide-scroll"] = "rbxassetid://10734943448",
	["lucide-search"] = "rbxassetid://10734943674",
	["lucide-send"] = "rbxassetid://10734943902",
	["lucide-separator-horizontal"] = "rbxassetid://10734944115",
	["lucide-separator-vertical"] = "rbxassetid://10734944326",
	["lucide-server"] = "rbxassetid://10734949856",
	["lucide-server-cog"] = "rbxassetid://10734944444",
	["lucide-server-crash"] = "rbxassetid://10734944554",
	["lucide-server-off"] = "rbxassetid://10734944668",
	["lucide-settings"] = "rbxassetid://10734950309",
	["lucide-settings-2"] = "rbxassetid://10734950020",
	["lucide-share"] = "rbxassetid://10734950813",
	["lucide-share-2"] = "rbxassetid://10734950553",
	["lucide-sheet"] = "rbxassetid://10734951038",
	["lucide-shield"] = "rbxassetid://10734951847",
	["lucide-shield-alert"] = "rbxassetid://10734951173",
	["lucide-shield-check"] = "rbxassetid://10734951367",
	["lucide-shield-close"] = "rbxassetid://10734951535",
	["lucide-shield-off"] = "rbxassetid://10734951684",
	["lucide-shirt"] = "rbxassetid://10734952036",
	["lucide-shopping-bag"] = "rbxassetid://10734952273",
	["lucide-shopping-cart"] = "rbxassetid://10734952479",
	["lucide-shovel"] = "rbxassetid://10734952773",
	["lucide-shower-head"] = "rbxassetid://10734952942",
	["lucide-shrink"] = "rbxassetid://10734953073",
	["lucide-shrub"] = "rbxassetid://10734953241",
	["lucide-shuffle"] = "rbxassetid://10734953451",
	["lucide-sidebar"] = "rbxassetid://10734954301",
	["lucide-sidebar-close"] = "rbxassetid://10734953715",
	["lucide-sidebar-open"] = "rbxassetid://10734954000",
	["lucide-sigma"] = "rbxassetid://10734954538",
	["lucide-signal"] = "rbxassetid://10734961133",
	["lucide-signal-high"] = "rbxassetid://10734954807",
	["lucide-signal-low"] = "rbxassetid://10734955080",
	["lucide-signal-medium"] = "rbxassetid://10734955336",
	["lucide-signal-zero"] = "rbxassetid://10734960878",
	["lucide-siren"] = "rbxassetid://10734961284",
	["lucide-skip-back"] = "rbxassetid://10734961526",
	["lucide-skip-forward"] = "rbxassetid://10734961809",
	["lucide-skull"] = "rbxassetid://10734962068",
	["lucide-slack"] = "rbxassetid://10734962339",
	["lucide-slash"] = "rbxassetid://10734962600",
	["lucide-slice"] = "rbxassetid://10734963024",
	["lucide-sliders"] = "rbxassetid://10734963400",
	["lucide-sliders-horizontal"] = "rbxassetid://10734963191",
	["lucide-smartphone"] = "rbxassetid://10734963940",
	["lucide-smartphone-charging"] = "rbxassetid://10734963671",
	["lucide-smile"] = "rbxassetid://10734964441",
	["lucide-smile-plus"] = "rbxassetid://10734964188",
	["lucide-snowflake"] = "rbxassetid://10734964600",
	["lucide-sofa"] = "rbxassetid://10734964852",
	["lucide-sort-asc"] = "rbxassetid://10734965115",
	["lucide-sort-desc"] = "rbxassetid://10734965287",
	["lucide-speaker"] = "rbxassetid://10734965419",
	["lucide-sprout"] = "rbxassetid://10734965572",
	["lucide-square"] = "rbxassetid://10734965702",
	["lucide-star"] = "rbxassetid://10734966248",
	["lucide-star-half"] = "rbxassetid://10734965897",
	["lucide-star-off"] = "rbxassetid://10734966097",
	["lucide-stethoscope"] = "rbxassetid://10734966384",
	["lucide-sticker"] = "rbxassetid://10734972234",
	["lucide-sticky-note"] = "rbxassetid://10734972463",
	["lucide-stop-circle"] = "rbxassetid://10734972621",
	["lucide-stretch-horizontal"] = "rbxassetid://10734972862",
	["lucide-stretch-vertical"] = "rbxassetid://10734973130",
	["lucide-strikethrough"] = "rbxassetid://10734973290",
	["lucide-subscript"] = "rbxassetid://10734973457",
	["lucide-sun"] = "rbxassetid://10734974297",
	["lucide-sun-dim"] = "rbxassetid://10734973645",
	["lucide-sun-medium"] = "rbxassetid://10734973778",
	["lucide-sun-moon"] = "rbxassetid://10734973999",
	["lucide-sun-snow"] = "rbxassetid://10734974130",
	["lucide-sunrise"] = "rbxassetid://10734974522",
	["lucide-sunset"] = "rbxassetid://10734974689",
	["lucide-superscript"] = "rbxassetid://10734974850",
	["lucide-swiss-franc"] = "rbxassetid://10734975024",
	["lucide-switch-camera"] = "rbxassetid://10734975214",
	["lucide-sword"] = "rbxassetid://10734975486",
	["lucide-swords"] = "rbxassetid://10734975692",
	["lucide-syringe"] = "rbxassetid://10734975932",
	["lucide-table"] = "rbxassetid://10734976230",
	["lucide-table-2"] = "rbxassetid://10734976097",
	["lucide-tablet"] = "rbxassetid://10734976394",
	["lucide-tag"] = "rbxassetid://10734976528",
	["lucide-tags"] = "rbxassetid://10734976739",
	["lucide-target"] = "rbxassetid://10734977012",
	["lucide-tent"] = "rbxassetid://10734981750",
	["lucide-terminal"] = "rbxassetid://10734982144",
	["lucide-terminal-square"] = "rbxassetid://10734981995",
	["lucide-text-cursor"] = "rbxassetid://10734982395",
	["lucide-text-cursor-input"] = "rbxassetid://10734982297",
	["lucide-thermometer"] = "rbxassetid://10734983134",
	["lucide-thermometer-snowflake"] = "rbxassetid://10734982571",
	["lucide-thermometer-sun"] = "rbxassetid://10734982771",
	["lucide-thumbs-down"] = "rbxassetid://10734983359",
	["lucide-thumbs-up"] = "rbxassetid://10734983629",
	["lucide-ticket"] = "rbxassetid://10734983868",
	["lucide-timer"] = "rbxassetid://10734984606",
	["lucide-timer-off"] = "rbxassetid://10734984138",
	["lucide-timer-reset"] = "rbxassetid://10734984355",
	["lucide-toggle-left"] = "rbxassetid://10734984834",
	["lucide-toggle-right"] = "rbxassetid://10734985040",
	["lucide-tornado"] = "rbxassetid://10734985247",
	["lucide-toy-brick"] = "rbxassetid://10747361919",
	["lucide-train"] = "rbxassetid://10747362105",
	["lucide-trash"] = "rbxassetid://10747362393",
	["lucide-trash-2"] = "rbxassetid://10747362241",
	["lucide-tree-deciduous"] = "rbxassetid://10747362534",
	["lucide-tree-pine"] = "rbxassetid://10747362748",
	["lucide-trees"] = "rbxassetid://10747363016",
	["lucide-trending-down"] = "rbxassetid://10747363205",
	["lucide-trending-up"] = "rbxassetid://10747363465",
	["lucide-triangle"] = "rbxassetid://10747363621",
	["lucide-trophy"] = "rbxassetid://10747363809",
	["lucide-truck"] = "rbxassetid://10747364031",
	["lucide-tv"] = "rbxassetid://10747364593",
	["lucide-tv-2"] = "rbxassetid://10747364302",
	["lucide-type"] = "rbxassetid://10747364761",
	["lucide-umbrella"] = "rbxassetid://10747364971",
	["lucide-underline"] = "rbxassetid://10747365191",
	["lucide-undo"] = "rbxassetid://10747365484",
	["lucide-undo-2"] = "rbxassetid://10747365359",
	["lucide-unlink"] = "rbxassetid://10747365771",
	["lucide-unlink-2"] = "rbxassetid://10747397871",
	["lucide-unlock"] = "rbxassetid://10747366027",
	["lucide-upload"] = "rbxassetid://10747366434",
	["lucide-upload-cloud"] = "rbxassetid://10747366266",
	["lucide-usb"] = "rbxassetid://10747366606",
	["lucide-user"] = "rbxassetid://10747373176",
	["lucide-user-check"] = "rbxassetid://10747371901",
	["lucide-user-cog"] = "rbxassetid://10747372167",
	["lucide-user-minus"] = "rbxassetid://10747372346",
	["lucide-user-plus"] = "rbxassetid://10747372702",
	["lucide-user-x"] = "rbxassetid://10747372992",
	["lucide-users"] = "rbxassetid://10747373426",
	["lucide-utensils"] = "rbxassetid://10747373821",
	["lucide-utensils-crossed"] = "rbxassetid://10747373629",
	["lucide-venetian-mask"] = "rbxassetid://10747374003",
	["lucide-verified"] = "rbxassetid://10747374131",
	["lucide-vibrate"] = "rbxassetid://10747374489",
	["lucide-vibrate-off"] = "rbxassetid://10747374269",
	["lucide-video"] = "rbxassetid://10747374938",
	["lucide-video-off"] = "rbxassetid://10747374721",
	["lucide-view"] = "rbxassetid://10747375132",
	["lucide-voicemail"] = "rbxassetid://10747375281",
	["lucide-volume"] = "rbxassetid://10747376008",
	["lucide-volume-1"] = "rbxassetid://10747375450",
	["lucide-volume-2"] = "rbxassetid://10747375679",
	["lucide-volume-x"] = "rbxassetid://10747375880",
	["lucide-wallet"] = "rbxassetid://10747376205",
	["lucide-wand"] = "rbxassetid://10747376565",
	["lucide-wand-2"] = "rbxassetid://10747376349",
	["lucide-watch"] = "rbxassetid://10747376722",
	["lucide-waves"] = "rbxassetid://10747376931",
	["lucide-webcam"] = "rbxassetid://10747381992",
	["lucide-wifi"] = "rbxassetid://10747382504",
	["lucide-wifi-off"] = "rbxassetid://10747382268",
	["lucide-wind"] = "rbxassetid://10747382750",
	["lucide-wrap-text"] = "rbxassetid://10747383065",
	["lucide-wrench"] = "rbxassetid://10747383470",
	["lucide-x"] = "rbxassetid://10747384394",
	["lucide-x-circle"] = "rbxassetid://10747383819",
	["lucide-x-octagon"] = "rbxassetid://10747384037",
	["lucide-x-square"] = "rbxassetid://10747384217",
	["lucide-zoom-in"] = "rbxassetid://10747384552",
	["lucide-zoom-out"] = "rbxassetid://10747384679",
};

local Mouse = InterfaceManagerTable.LocalPlayer:GetMouse();

function InterfaceManagerTable:FetchIcon(name)
	return InterfaceManagerTable.Icons[name] or InterfaceManagerTable.LucideIcon[name] or InterfaceManagerTable.LucideIcon['lucide-'..name];
end;

function InterfaceManagerTable:NewRipple(Parent)
	Parent.ClipsDescendants = true

	local ripple = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")

	ripple.Active = false
	ripple.Name = "ripple"
	ripple.Parent = Parent
	ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ripple.ZIndex = Parent.ZIndex or 7
	ripple.AnchorPoint = Vector2.new(0.5, 0.5)
	ripple.Size = UDim2.new(0,0,0,0)
	ripple.SizeConstraint = Enum.SizeConstraint.RelativeYY

	UICorner.CornerRadius = UDim.new(0.25, 0)
	UICorner.Parent = ripple

	local buttonAbsoluteSize = Parent.AbsoluteSize
	local buttonAbsolutePosition = Parent.AbsolutePosition

	local mouseAbsolutePosition = Vector2.new(Mouse.X, Mouse.Y)
	local mouseRelativePosition = (mouseAbsolutePosition - buttonAbsolutePosition)

	ripple.BackgroundTransparency = 0.98
	ripple.Position = UDim2.new(0, mouseRelativePosition.X, 0, mouseRelativePosition.Y)
	ripple.Parent = Parent

	local Size_UP = UDim2.new(50,0,50,0)

	InterfaceManagerTable:Tween(ripple,TweenInfo.new(1),{Size = Size_UP,BackgroundTransparency = 1}):Play()

	game:GetService('Debris'):AddItem(ripple,1.2)
end

function InterfaceManagerTable:Tween(Frame :GuiObject , TweenInfo: TweenInfo , Properties : {})
	local Instance = InterfaceManagerTable.TweenService:Create(Frame,TweenInfo,Properties);

	Instance:Play();

	return Instance
end;

function InterfaceManagerTable:CreateHover(ui :ImageButton , default :number)
	ui.MouseEnter:Connect(function()
		InterfaceManagerTable:Tween(ui,TweenInfo.new(0.1),{
			ImageTransparency = 0.1;
		})
	end)

	ui.MouseLeave:Connect(function()
		InterfaceManagerTable:Tween(ui,TweenInfo.new(0.1),{
			ImageTransparency = default;
		})
	end)

	ui.ImageTransparency = default;
end;

function InterfaceManagerTable:GetTextSize(text,fontSize,font,custom_w)
	return game:GetService('TextService'):GetTextSize(text:gsub("<.->", ""),fontSize,font,Vector2.new(custom_w or math.huge,math.huge))	
end;


function InterfaceManagerTable:CreateDropdown()
	local Dropdown = Instance.new("Frame")
	local UIStroke = Instance.new("UIStroke")
	local UICorner = Instance.new("UICorner")
	local ScrollingFrame = Instance.new("ScrollingFrame")
	local UIListLayout = Instance.new("UIListLayout")
	local DropShadow = Instance.new("ImageLabel")

	Dropdown.Name = "Dropdown"
	Dropdown.Parent = InterfaceManagerTable.ScreenGui;
	Dropdown.BackgroundColor3 = Color3.fromRGB(25, 25, 27)
	Dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Dropdown.BorderSizePixel = 0
	Dropdown.ClipsDescendants = true
	Dropdown.Position = UDim2.new(0.501175165, 0, 0.380695254, 0)
	Dropdown.Size = UDim2.new(0, 150, 0, 0)
	Dropdown.ZIndex = 100
	Dropdown.AnchorPoint = Vector2.new(0.5,0.5);

	UIStroke.Transparency = 0.500
	UIStroke.Color = Color3.fromRGB(30, 30, 30)
	UIStroke.Parent = Dropdown

	UICorner.CornerRadius = UDim.new(0, 3)
	UICorner.Parent = Dropdown

	ScrollingFrame.Parent = Dropdown
	ScrollingFrame.Active = true
	ScrollingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ScrollingFrame.BackgroundTransparency = 1.000
	ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ScrollingFrame.BorderSizePixel = 0
	ScrollingFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
	ScrollingFrame.Size = UDim2.new(1, -5, 1, -5)
	ScrollingFrame.ZIndex = 101
	ScrollingFrame.ScrollBarThickness = 0

	UIListLayout.Parent = ScrollingFrame
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 2)

	UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
		ScrollingFrame.CanvasSize = UDim2.fromOffset(0,UIListLayout.AbsoluteContentSize.Y)
	end)

	DropShadow.Name = "DropShadow"
	DropShadow.Parent = Dropdown
	DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
	DropShadow.BackgroundTransparency = 1.000
	DropShadow.BorderSizePixel = 0
	DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	DropShadow.Rotation = 0.001
	DropShadow.Size = UDim2.new(1, 40, 1, 40)
	DropShadow.ZIndex = 99
	DropShadow.Image = "rbxassetid://6015897843"
	DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	DropShadow.ImageTransparency = 1
	DropShadow.ScaleType = Enum.ScaleType.Slice
	DropShadow.SliceCenter = Rect.new(49, 49, 450, 450);

	local args = {};

	args.Enabled = false;
	args.ParentEnabled = nil;
	args.Hover = false;

	Dropdown.MouseEnter:Connect(function()
		args.Hover = true;
	end)

	Dropdown.MouseLeave:Connect(function()
		args.Hover = false;
	end)

	InterfaceManagerTable.InputService.InputBegan:Connect(function(a)
		if a.UserInputType == Enum.UserInputType.MouseButton1 or a.UserInputType == Enum.UserInputType.Touch then
			if not args.Hover and args.Enabled then
				args:Hide()
			end;
		end
	end)

	task.spawn(function()
		while true do task.wait()
			pcall(function()
				if args.Enabled then
					local FrameHolder = args.ParentEnabled;
					if FrameHolder then

						InterfaceManagerTable:Tween(Dropdown,TweenInfo.new(0.25),{
							Position = UDim2.fromOffset(FrameHolder.AbsolutePosition.X + (FrameHolder.AbsoluteSize.X / 2), FrameHolder.AbsolutePosition.Y)
						})
					end;
				end;
			end)
		end;
	end)

	function args:Show()
		args.Enabled = true;

		InterfaceManagerTable:Tween(Dropdown,TweenInfo.new(0.65 , Enum.EasingStyle.Quint),{
			Size = UDim2.new(0, 150, 0, math.clamp(UIListLayout.AbsoluteContentSize.Y + 2 , 22 , 200)),
			BackgroundTransparency = 0,
		})

		InterfaceManagerTable:Tween(UIStroke,TweenInfo.new(0.1),{
			Transparency = 0.500
		})

		InterfaceManagerTable:Tween(ScrollingFrame,TweenInfo.new(0.1 ,Enum.EasingStyle.Quint , Enum.EasingDirection.InOut),{
			Position = UDim2.new(0.5, 0, 0.5, 0)
		})

		InterfaceManagerTable:Tween(DropShadow,TweenInfo.new(0.5),{
			ImageTransparency = 0.750
		})
	end;

	function args:Hide()
		args.Enabled = false;

		InterfaceManagerTable:Tween(Dropdown,TweenInfo.new(0.65 , Enum.EasingStyle.Quint),{
			Size = UDim2.new(0, 50, 0, 0),
			BackgroundTransparency = 0,
		})

		InterfaceManagerTable:Tween(UIStroke,TweenInfo.new(0.2),{
			Transparency = 1
		})

		InterfaceManagerTable:Tween(ScrollingFrame,TweenInfo.new(0.5),{
			Position = UDim2.new(0.5, 0, 1.5, 0)
		})

		InterfaceManagerTable:Tween(DropShadow,TweenInfo.new(0.2),{
			ImageTransparency = 1
		})
	end;

	function args:CreateButton()
		local Frame = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local TextLabel = Instance.new("TextLabel")
		local UIGradient = Instance.new("UIGradient")

		Frame.BackgroundColor3 = Color3.fromRGB(26, 26, 28)
		Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Frame.BorderSizePixel = 0
		Frame.Size = UDim2.new(1, 0, 0, 20)
		Frame.ZIndex = 102

		UICorner.CornerRadius = UDim.new(0, 3)
		UICorner.Parent = Frame

		UIStroke.Transparency = 0.500
		UIStroke.Color = Color3.fromRGB(24, 24, 24)
		UIStroke.Parent = Frame

		TextLabel.Parent = Frame
		TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.BackgroundTransparency = 1.000
		TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextLabel.BorderSizePixel = 0
		TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
		TextLabel.Size = UDim2.new(1, -10, 0.5, 0)
		TextLabel.ZIndex = 103
		TextLabel.Font = Enum.Font.GothamMedium
		TextLabel.Text = "1"
		TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.TextSize = 13.000
		TextLabel.TextStrokeTransparency = 0.900
		TextLabel.RichText = true;

		UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(190, 190, 190))}
		UIGradient.Offset = Vector2.new(0, 1)
		UIGradient.Rotation = 90
		UIGradient.Parent = Frame

		return Frame , TextLabel , UIGradient;
	end;

	function args:Set(argss , Default , IsMulti , Callback)
		for i,v in next,ScrollingFrame:GetChildren() do
			if v:IsA('Frame') then
				v:Destroy()
			end;
		end;

		if IsMulti then
			local CallbackTable = {};
			local isarry = false;

			for is , mv in ipairs(Default) do
				isarry = true;
				CallbackTable[mv] = true;
			end;

			if not isarry then
				CallbackTable = Default
			end

			for i,v in next,argss do
				local Frame , TextLabel , UIGradient = args:CreateButton();

				Frame.Parent = ScrollingFrame;
				TextLabel.Text = tostring(v);

				if Default[v] or table.find(Default , v) then
					TextLabel.TextTransparency = 0;

					InterfaceManagerTable:Tween(Frame , TweenInfo.new(0.1),{
						BackgroundColor3 = InterfaceManagerTable.Hightlight
					})

					InterfaceManagerTable:Tween(UIGradient , TweenInfo.new(0.1),{
						Offset = Vector2.new(0, 0)
					})
				else
					TextLabel.TextTransparency = 0.5;

					InterfaceManagerTable:Tween(Frame , TweenInfo.new(0.1),{
						BackgroundColor3 = Color3.fromRGB(26, 26, 28)
					})

					InterfaceManagerTable:Tween(UIGradient , TweenInfo.new(0.1),{
						Offset = Vector2.new(0, 1)
					})
				end;

				local button = InterfaceManagerTable:InputButton(Frame);

				button.MouseButton1Click:Connect(function()
					CallbackTable[v] = not CallbackTable[v];

					if CallbackTable[v] then
						InterfaceManagerTable:Tween(TextLabel , TweenInfo.new(0.2),{
							TextTransparency = 0;
						})

						InterfaceManagerTable:Tween(Frame , TweenInfo.new(0.1),{
							BackgroundColor3 = InterfaceManagerTable.Hightlight
						})

						InterfaceManagerTable:Tween(UIGradient , TweenInfo.new(0.1),{
							Offset = Vector2.new(0, 0)
						})
					else
						InterfaceManagerTable:Tween(TextLabel, TweenInfo.new(0.1),{
							TextTransparency = 0.5;
						})

						InterfaceManagerTable:Tween(Frame , TweenInfo.new(0.1),{
							BackgroundColor3 = Color3.fromRGB(26, 26, 28)
						})

						InterfaceManagerTable:Tween(UIGradient , TweenInfo.new(0.1),{
							Offset = Vector2.new(0, 1)
						})
					end;

					Callback(CallbackTable)
				end)
			end;
		else
			local OldDB = nil;

			for i,v in next,argss do
				local Frame , TextLabel , UIGradient = args:CreateButton();
				Frame.Parent = ScrollingFrame;
				TextLabel.Text = tostring(v);

				if v == Default then
					TextLabel.TextTransparency = 0;

					OldDB = {Frame , UIGradient , TextLabel};

					InterfaceManagerTable:Tween(Frame , TweenInfo.new(0.1),{
						BackgroundColor3 = InterfaceManagerTable.Hightlight
					})

					InterfaceManagerTable:Tween(UIGradient , TweenInfo.new(0.1),{
						Offset = Vector2.new(0, 0)
					})
				else
					TextLabel.TextTransparency = 0.5;

					InterfaceManagerTable:Tween(Frame , TweenInfo.new(0.1),{
						BackgroundColor3 = Color3.fromRGB(26, 26, 28)
					})

					InterfaceManagerTable:Tween(UIGradient , TweenInfo.new(0.1),{
						Offset = Vector2.new(0, 1)
					})
				end;

				local button = InterfaceManagerTable:InputButton(Frame);

				button.MouseButton1Click:Connect(function()

					if OldDB then
						InterfaceManagerTable:Tween(OldDB[3] , TweenInfo.new(0.1),{
							TextTransparency = 0.5;
						})

						InterfaceManagerTable:Tween(OldDB[1] , TweenInfo.new(0.1),{
							BackgroundColor3 = Color3.fromRGB(26, 26, 28)
						})

						InterfaceManagerTable:Tween(OldDB[2] , TweenInfo.new(0.1),{
							Offset = Vector2.new(0, 1)
						})
					end;

					OldDB = {Frame , UIGradient , TextLabel};

					InterfaceManagerTable:Tween(TextLabel , TweenInfo.new(0.2),{
						TextTransparency = 0;
					})

					InterfaceManagerTable:Tween(Frame , TweenInfo.new(0.1),{
						BackgroundColor3 = InterfaceManagerTable.Hightlight
					})

					InterfaceManagerTable:Tween(UIGradient , TweenInfo.new(0.1),{
						Offset = Vector2.new(0, 0)
					})

					Callback(v)
				end)
			end;
		end;
	end;

	function args:SetInternal(frame)
		args.ParentEnabled = frame
	end;

	return args;
end;

function InterfaceManagerTable:Obfuscate(frame: Frame)
	task.spawn(function()
		for i,v in next , frame:GetDescendants() do task.wait(0.001)
			v.Name = tostring(string.char(math.random(60,110)))..tostring(string.char(math.random(60,110)))..tostring(string.char(math.random(60,110)))..tostring(string.char(math.random(60,110)))..tostring(string.char(math.random(60,110)));
		end;
	end)
end;

function InterfaceManagerTable:CreateInstances(main_frame : Frame , BoolValue : BoolValue)
	local Internal = {};
	local TweenInfoMain = TweenInfo.new(0.35,Enum.EasingStyle.Quint , Enum.EasingDirection.InOut);

	local function NewElement(call)
		call(BoolValue.Value)
		BoolValue:GetPropertyChangedSignal('Value'):Connect(function()
			call(BoolValue.Value)
		end)
	end;

	InterfaceManagerTable:Obfuscate(main_frame);

	function Internal:AddSection(args)
		args = args or {};
		args.Title = args.Title or "Section";

		local Section = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local UIListLayout = Instance.new("UIListLayout")
		local MID = Instance.new("Frame")
		local Title = Instance.new("TextLabel")
		local Line = Instance.new("Frame")
		Title.RichText = true;

		Section.Name = "Section"
		Section.Parent = main_frame
		Section.BackgroundColor3 = Color3.fromRGB(26, 26, 30)
		Section.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Section.BorderSizePixel = 0
		Section.ClipsDescendants = true
		Section.Size = UDim2.new(1, -2, 0, 0)
		Section.ZIndex = 7

		UICorner.CornerRadius = UDim.new(0, 3)
		UICorner.Parent = Section

		UIStroke.Color = Color3.fromRGB(24, 24, 24)
		UIStroke.Parent = Section

		UIListLayout.Parent = Section
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Padding = UDim.new(0, 3)

		MID.Name = "MID"
		MID.Parent = Section
		MID.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		MID.BorderColor3 = Color3.fromRGB(0, 0, 0)
		MID.BorderSizePixel = 0

		Title.Name = "Title"
		Title.Parent = Section
		Title.AnchorPoint = Vector2.new(0.5, 0)
		Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Title.BackgroundTransparency = 1.000
		Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Title.BorderSizePixel = 0
		Title.Position = UDim2.new(0.5, 0, 0, 0)
		Title.Size = UDim2.new(1, -10, 0, 13)
		Title.ZIndex = 7
		Title.Font = Enum.Font.GothamBold
		Title.Text = args.Title
		Title.TextColor3 = Color3.fromRGB(255, 255, 255)
		Title.TextScaled = true
		Title.TextSize = 14.000
		Title.TextStrokeTransparency = 0.900
		Title.TextTransparency = 0.100
		Title.TextWrapped = true
		Title.TextXAlignment = Enum.TextXAlignment.Left

		Line.Name = "Line"
		Line.Parent = Section
		Line.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		Line.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Line.BorderSizePixel = 0
		Line.Size = UDim2.new(1, -5, 0, 1)
		Line.ZIndex = 7

		task.delay(0.5,function()
			InterfaceManagerTable:Obfuscate(Section);
		end)

		NewElement(function(value)
			if value then
				InterfaceManagerTable:Tween(Section , TweenInfoMain,{
					BackgroundTransparency = 0
				})

				InterfaceManagerTable:Tween(Title , TweenInfoMain,{
					TextStrokeTransparency = 0.900,
					TextTransparency = 0.100
				})



				InterfaceManagerTable:Tween(UIStroke , TweenInfoMain,{
					Transparency = 0
				})
			else
				InterfaceManagerTable:Tween(Section , TweenInfoMain,{
					BackgroundTransparency = 1
				})



				InterfaceManagerTable:Tween(Title , TweenInfoMain,{
					TextStrokeTransparency = 1,
					TextTransparency =1
				})

				InterfaceManagerTable:Tween(UIStroke , TweenInfoMain,{
					Transparency = 1
				})
			end;
		end)

		local Update = function()
			task.wait();

			InterfaceManagerTable:Tween(Section , TweenInfo.new(0.1) , {
				Size = UDim2.new(1, -4, 0, UIListLayout.AbsoluteContentSize.Y + 3)
			})
		end;

		Update();

		UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(Update);

		return InterfaceManagerTable:CreateInstances(Section , BoolValue);
	end;

	function Internal:AddParagraph(args)
		args = args or {};
		args.Title = args.Title or "Content";
		args.Description = args.Description or nil

		local ParagraphFace = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local Content = Instance.new("TextLabel")
		local Description = Instance.new("TextLabel")
		Description.RichText = true;
		Content.RichText = true;

		ParagraphFace.Name = "ParagraphFace"
		ParagraphFace.Parent = main_frame
		ParagraphFace.BackgroundColor3 = Color3.fromRGB(26, 26, 28)
		ParagraphFace.BackgroundTransparency = 0.500
		ParagraphFace.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ParagraphFace.BorderSizePixel = 0
		ParagraphFace.Size = UDim2.new(1, -5, 0, 55)
		ParagraphFace.ZIndex = 8

		UICorner.CornerRadius = UDim.new(0, 3)
		UICorner.Parent = ParagraphFace

		UIStroke.Transparency = 0.500
		UIStroke.Color = Color3.fromRGB(24, 24, 24)
		UIStroke.Parent = ParagraphFace

		Content.Name = "Content"
		Content.Parent = ParagraphFace
		Content.AnchorPoint = Vector2.new(0.5, 0)
		Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Content.BackgroundTransparency = 1.000
		Content.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Content.BorderSizePixel = 0
		Content.Position = UDim2.new(0.5, 0, 0, 5)
		Content.Size = UDim2.new(1, -10, 0, 10)
		Content.ZIndex = 8
		Content.Font = Enum.Font.GothamMedium
		Content.Text = args.Title
		Content.TextColor3 = Color3.fromRGB(255, 255, 255)
		Content.TextSize = 14.000
		Content.TextStrokeTransparency = 0.900
		Content.TextTransparency = 0.200
		Content.TextXAlignment = Enum.TextXAlignment.Left

		Description.Name = "Description"
		Description.Parent = ParagraphFace
		Description.AnchorPoint = Vector2.new(0.5, 0)
		Description.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Description.BackgroundTransparency = 1.000
		Description.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Description.BorderSizePixel = 0
		Description.Position = UDim2.new(0.5, 0, 0, 20)
		Description.Size = UDim2.new(1, -10, 0, 10)
		Description.ZIndex = 8
		Description.Font = Enum.Font.GothamMedium
		Description.Text = args.Description or "";
		Description.TextColor3 = Color3.fromRGB(255, 255, 255)
		Description.TextSize = 13.000
		Description.TextStrokeTransparency = 0.900
		Description.TextTransparency = 0.400
		Description.TextXAlignment = Enum.TextXAlignment.Left
		Description.TextYAlignment = Enum.TextYAlignment.Top

		NewElement(function(value)
			if value then
				InterfaceManagerTable:Tween(ParagraphFace , TweenInfoMain,{
					BackgroundTransparency = 0.500
				})

				InterfaceManagerTable:Tween(Description , TweenInfoMain,{
					TextStrokeTransparency = 0.900,
					TextTransparency = 0.400
				})

				InterfaceManagerTable:Tween(Content , TweenInfoMain,{
					TextStrokeTransparency = 0.900,
					TextTransparency = 0.200
				})

				InterfaceManagerTable:Tween(UIStroke , TweenInfoMain,{
					Transparency = 0.5;
				})
			else
				InterfaceManagerTable:Tween(ParagraphFace ,TweenInfoMain,{
					BackgroundTransparency = 1
				})

				InterfaceManagerTable:Tween(Description , TweenInfoMain,{
					TextStrokeTransparency = 1,
					TextTransparency = 1
				})

				InterfaceManagerTable:Tween(Content ,TweenInfoMain,{
					TextStrokeTransparency =1,
					TextTransparency = 1
				})

				InterfaceManagerTable:Tween(UIStroke , TweenInfoMain,{
					Transparency = 1;
				})
			end;
		end)

		local UpdateParagraph = function()
			if Description.Text:byte() then
				local GTX = InterfaceManagerTable:GetTextSize(Description.Text , Description.TextSize , Description.Font);

				InterfaceManagerTable:Tween(ParagraphFace , TweenInfo.new(0.1),{
					Size = UDim2.new(1, -5, 0, GTX.Y + Content.Size.Y.Offset + 13)
				})

				InterfaceManagerTable:Tween(Description , TweenInfo.new(0.1),{
					Size = UDim2.new(1, -10, 0, GTX.Y)
				})
			else
				InterfaceManagerTable:Tween(ParagraphFace , TweenInfo.new(0.1),{
					Size = UDim2.new(1, -5, 0, 18)
				})
			end;
		end;

		UpdateParagraph();

		function args:Title(new)
			Content.Text = tostring(new);
			UpdateParagraph();
		end;

		function args:Visible(new)
			ParagraphFace.Visible = new;
		end;

		function args:Description(new)
			Description.Text = new;
			UpdateParagraph();
		end;

		return args;
	end;

	function Internal:AddDropdown(args)
		args = args or {};
		args.Title = args.Title or "Dropdown";
		args.Multiple = args.Multiple or false;
		args.Values = args.Values or {};
		args.Default = args.Default or nil;
		args.Callback = args.Callback or function() end;

		local function isArray(t)
			for i,v in ipairs(t) do
				return true
			end;

			return false
		end

		local InterfaceFile = function(data)
			if typeof(data) == 'table' then
				if isArray(data) then
					local cach = {};

					table.foreach(data,function(a,b)
						table.insert(cach,tostring(b))
					end)

					return table.concat(cach , ' , ')
				else
					local cach = {};

					table.foreach(data,function(a,b)
						if b then
							table.insert(cach,tostring(a))
						end
					end)

					return table.concat(cach , ' , ')
				end;
			end;

			return tostring(data)
		end;

		local DropdownFace = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local Content = Instance.new("TextLabel")
		local Main = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")
		local UIStroke_2 = Instance.new("UIStroke")
		local Upvalue = Instance.new("TextLabel")
		Upvalue.RichText = true;
		Content.RichText = true;

		DropdownFace.Name = "DropdownFace"
		DropdownFace.Parent = main_frame
		DropdownFace.BackgroundColor3 = Color3.fromRGB(26, 26, 28)
		DropdownFace.BackgroundTransparency = 0.500
		DropdownFace.BorderColor3 = Color3.fromRGB(0, 0, 0)
		DropdownFace.BorderSizePixel = 0
		DropdownFace.Size = UDim2.new(1, -5, 0, 30)
		DropdownFace.ZIndex = 8

		UICorner.CornerRadius = UDim.new(0, 3)
		UICorner.Parent = DropdownFace

		UIStroke.Transparency = 0.500
		UIStroke.Color = Color3.fromRGB(24, 24, 24)
		UIStroke.Parent = DropdownFace

		Content.Name = "Content"
		Content.Parent = DropdownFace
		Content.AnchorPoint = Vector2.new(0.5, 0.5)
		Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Content.BackgroundTransparency = 1.000
		Content.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Content.BorderSizePixel = 0
		Content.Position = UDim2.new(0.5, 0, 0.5, 0)
		Content.Size = UDim2.new(1, -10, 0, 10)
		Content.ZIndex = 8
		Content.Font = Enum.Font.GothamMedium
		Content.Text = args.Title
		Content.TextColor3 = Color3.fromRGB(255, 255, 255)
		Content.TextSize = 14.000
		Content.TextStrokeTransparency = 0.900
		Content.TextTransparency = 0.200
		Content.TextXAlignment = Enum.TextXAlignment.Left

		Main.Name = "Main"
		Main.Parent = DropdownFace
		Main.AnchorPoint = Vector2.new(1, 0.5)
		Main.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
		Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Main.BorderSizePixel = 0
		Main.ClipsDescendants = true
		Main.Position = UDim2.new(1, -5, 0.5, 0)
		Main.Size = UDim2.new(0, 65, 0.600000024, 0)
		Main.ZIndex = 8

		UICorner_2.CornerRadius = UDim.new(0, 2)
		UICorner_2.Parent = Main

		UIStroke_2.Transparency = 0.500
		UIStroke_2.Color = Color3.fromRGB(30, 30, 30)
		UIStroke_2.Parent = Main

		Upvalue.Name = "Upvalue"
		Upvalue.Parent = Main
		Upvalue.AnchorPoint = Vector2.new(0.5, 0.5)
		Upvalue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Upvalue.BackgroundTransparency = 1.000
		Upvalue.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Upvalue.BorderSizePixel = 0
		Upvalue.Position = UDim2.new(0.5, 0, 0.5, 0)
		Upvalue.Size = UDim2.new(1, -10, 0.5, 0)
		Upvalue.ZIndex = 9
		Upvalue.Font = Enum.Font.GothamMedium
		Upvalue.Text = InterfaceFile(args.Default or "NONE")
		Upvalue.TextColor3 = Color3.fromRGB(255, 255, 255)
		Upvalue.TextScaled = true
		Upvalue.TextSize = 12.000
		Upvalue.TextTransparency = 0.400
		Upvalue.TextWrapped = true

		NewElement(function(value)
			if value then
				InterfaceManagerTable:Tween(DropdownFace , TweenInfoMain,{
					BackgroundTransparency = 0.500
				})

				InterfaceManagerTable:Tween(Upvalue , TweenInfoMain,{
					TextStrokeTransparency = 0.900,
					TextTransparency = 0.400
				})

				InterfaceManagerTable:Tween(Content , TweenInfoMain,{
					TextStrokeTransparency = 0.900,
					TextTransparency = 0.200
				})

				InterfaceManagerTable:Tween(UIStroke , TweenInfoMain,{
					Transparency = 0.5;
				})
			else
				InterfaceManagerTable:Tween(DropdownFace ,TweenInfoMain,{
					BackgroundTransparency = 1
				})

				InterfaceManagerTable:Tween(Upvalue , TweenInfoMain,{
					TextStrokeTransparency = 1,
					TextTransparency = 1
				})

				InterfaceManagerTable:Tween(Content ,TweenInfoMain,{
					TextStrokeTransparency =1,
					TextTransparency = 1
				})

				InterfaceManagerTable:Tween(UIStroke , TweenInfoMain,{
					Transparency = 1;
				})
			end;
		end)

		local uibutton = InterfaceManagerTable:InputButton(DropdownFace);

		local UpdateID = function()
			local size = InterfaceManagerTable:GetTextSize(Upvalue.Text , Upvalue.TextSize , Upvalue.Font);

			InterfaceManagerTable:Tween(Main,TweenInfo.new(0.1),{
				Size = UDim2.new(0, math.clamp(size.X + 15 ,65, 450), 0.600000024, 0)
			})
		end;

		UpdateID();

		local MMC = function(acv)
			args.Default = acv;
			UpdateID();
			Upvalue.Text = InterfaceFile(args.Default or "NONE")

			task.spawn(function()
				args.Callback(args.Default)
			end)
		end;


		uibutton.MouseButton1Click:Connect(function()
			InterfaceManagerTable:NewRipple(uibutton);

			InterfaceManagerTable.Dropdown:Set(args.Values , args.Default , args.Multiple ,MMC )

			InterfaceManagerTable.Dropdown:SetInternal(Main)

			InterfaceManagerTable.Dropdown:Show()
		end)

		function args:Title(new)
			Content.Text = tostring(new);
		end;

		function args:Visible(new)
			DropdownFace.Visible = new;
		end;

		function args:SetValue(new)
			args.Default = new;

			UpdateID();

			Upvalue.Text = InterfaceFile(args.Default or "NONE")

			task.spawn(function()
				args.Callback(args.Default)
			end)
		end;

		function args:SetDefault(new)
			args.Values = new;
		end;

		return args;
	end;

	function Internal:AddTextbox(args)
		args = args or {};
		args.Title = args.Title or "Textbox";
		args.Default = args.Default or "";
		args.Placeholder = args.Placeholder or "";
		args.Numeric = args.Numeric or false;
		args.Finished = args.Finished or false;
		args.Callback = args.Callback or function() end;

		local TextboxFace = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local Content = Instance.new("TextLabel")
		local Main = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")
		local UIStroke_2 = Instance.new("UIStroke")
		local TextBox = Instance.new("TextBox")
		Content.RichText = true;

		TextboxFace.Name = "TextboxFace"
		TextboxFace.Parent = main_frame
		TextboxFace.BackgroundColor3 = Color3.fromRGB(26, 26, 28)
		TextboxFace.BackgroundTransparency = 0.500
		TextboxFace.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextboxFace.BorderSizePixel = 0
		TextboxFace.Size = UDim2.new(1, -5, 0, 30)
		TextboxFace.ZIndex = 8

		UICorner.CornerRadius = UDim.new(0, 3)
		UICorner.Parent = TextboxFace

		UIStroke.Transparency = 0.500
		UIStroke.Color = Color3.fromRGB(24, 24, 24)
		UIStroke.Parent = TextboxFace

		Content.Name = "Content"
		Content.Parent = TextboxFace
		Content.AnchorPoint = Vector2.new(0.5, 0.5)
		Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Content.BackgroundTransparency = 1.000
		Content.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Content.BorderSizePixel = 0
		Content.Position = UDim2.new(0.5, 0, 0.5, 0)
		Content.Size = UDim2.new(1, -10, 0, 10)
		Content.ZIndex = 8
		Content.Font = Enum.Font.GothamMedium
		Content.Text = args.Title
		Content.TextColor3 = Color3.fromRGB(255, 255, 255)
		Content.TextSize = 14.000
		Content.TextStrokeTransparency = 0.900
		Content.TextTransparency = 0.200
		Content.TextXAlignment = Enum.TextXAlignment.Left

		Main.Name = "Main"
		Main.Parent = TextboxFace
		Main.AnchorPoint = Vector2.new(1, 0.5)
		Main.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
		Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Main.BorderSizePixel = 0
		Main.ClipsDescendants = true
		Main.Position = UDim2.new(1, -5, 0.5, 0)
		Main.Size = UDim2.new(0, 100, 0.699999988, 0)
		Main.ZIndex = 8

		UICorner_2.CornerRadius = UDim.new(0, 2)
		UICorner_2.Parent = Main

		UIStroke_2.Transparency = 0.500
		UIStroke_2.Color = Color3.fromRGB(30, 30, 30)
		UIStroke_2.Parent = Main

		TextBox.Parent = Main
		TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextBox.BackgroundTransparency = 1.000
		TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextBox.BorderSizePixel = 0
		TextBox.Size = UDim2.new(1, 0, 1, 0)
		TextBox.ZIndex = 9
		TextBox.ClearTextOnFocus = false
		TextBox.Font = Enum.Font.GothamMedium
		TextBox.PlaceholderText = args.Placeholder
		TextBox.Text = args.Default
		TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextBox.TextSize = 10.000
		TextBox.TextTransparency = 0.500

		NewElement(function(value)
			if value then
				InterfaceManagerTable:Tween(TextboxFace , TweenInfoMain,{
					BackgroundTransparency = 0.500
				})

				InterfaceManagerTable:Tween(TextBox , TweenInfoMain,{
					TextStrokeTransparency = 0.900,
					TextTransparency = 0.5
				})

				InterfaceManagerTable:Tween(Content , TweenInfoMain,{
					TextStrokeTransparency = 0.900,
					TextTransparency = 0.200
				})

				InterfaceManagerTable:Tween(UIStroke , TweenInfoMain,{
					Transparency = 0.5;
				})
			else
				InterfaceManagerTable:Tween(TextboxFace ,TweenInfoMain,{
					BackgroundTransparency = 1
				})

				InterfaceManagerTable:Tween(TextBox , TweenInfoMain,{
					TextStrokeTransparency = 1,
					TextTransparency = 1
				})

				InterfaceManagerTable:Tween(Content ,TweenInfoMain,{
					TextStrokeTransparency =1,
					TextTransparency = 1
				})

				InterfaceManagerTable:Tween(UIStroke , TweenInfoMain,{
					Transparency = 1;
				})
			end;
		end)

		local PlaceHolder = InterfaceManagerTable:GetTextSize(TextBox.PlaceholderText,TextBox.TextSize,TextBox.Font);


		local Update = function()

			local size = InterfaceManagerTable:GetTextSize(TextBox.Text,TextBox.TextSize,TextBox.Font);

			pcall(function()
				InterfaceManagerTable:Tween(Main,TweenInfo.new(0.1),{
					Size = UDim2.new(0, math.clamp(size.X + 15 , PlaceHolder.X + 10, TextboxFace.AbsoluteSize.X / 1.25), 0.5, 0);
				});
			end)
		end;

		local UpdateText = function()
			if args.Numeric then
				TextBox.Text = string.gsub(TextBox.Text, '[^0-9.]', '')

				if not tonumber(TextBox.Text) then
					return;	
				end;

				Update();

				args.Callback(tonumber(TextBox.Text) or 0);
			else
				Update();
				args.Callback(TextBox.Text)
			end;
		end

		if args.Finished then
			TextBox.FocusLost:Connect(UpdateText)
		else
			TextBox:GetPropertyChangedSignal('Text'):Connect(UpdateText);
		end;

		TextBox:GetPropertyChangedSignal('Text'):Connect(Update);

		Update()

		function args:Title(new)
			Content.Text = tostring(new);
		end;

		function args:Visible(new)
			TextboxFace.Visible = new;
		end;

		function args:Value(new)
			TextBox.Text = new

			UpdateText();
		end;

		return args;
	end;

	function Internal:AddKeybind(args)
		args = args or {};
		args.Title = args.Title or "Keybind";
		args.Default = args.Default or "NONE";
		args.Callback = args.Callback or function() end;

		local GetKeyName = function(a)
			if typeof(a) == 'EnumItem' then
				return a.Name
			end;

			return tostring(a)
		end;

		local KeybindFace = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local Content = Instance.new("TextLabel")
		local Main = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")
		local UIStroke_2 = Instance.new("UIStroke")
		local Upvalue = Instance.new("TextLabel")
		Upvalue.RichText = true;
		Content.RichText = true;

		KeybindFace.Name = "KeybindFace"
		KeybindFace.Parent = main_frame
		KeybindFace.BackgroundColor3 = Color3.fromRGB(26, 26, 28)
		KeybindFace.BackgroundTransparency = 0.500
		KeybindFace.BorderColor3 = Color3.fromRGB(0, 0, 0)
		KeybindFace.BorderSizePixel = 0
		KeybindFace.Size = UDim2.new(1, -5, 0, 30)
		KeybindFace.ZIndex = 8

		UICorner.CornerRadius = UDim.new(0, 3)
		UICorner.Parent = KeybindFace

		UIStroke.Transparency = 0.500
		UIStroke.Color = Color3.fromRGB(24, 24, 24)
		UIStroke.Parent = KeybindFace

		Content.Name = "Content"
		Content.Parent = KeybindFace
		Content.AnchorPoint = Vector2.new(0.5, 0.5)
		Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Content.BackgroundTransparency = 1.000
		Content.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Content.BorderSizePixel = 0
		Content.Position = UDim2.new(0.5, 0, 0.5, 0)
		Content.Size = UDim2.new(1, -10, 0, 10)
		Content.ZIndex = 8
		Content.Font = Enum.Font.GothamMedium
		Content.Text = args.Title
		Content.TextColor3 = Color3.fromRGB(255, 255, 255)
		Content.TextSize = 14.000
		Content.TextStrokeTransparency = 0.900
		Content.TextTransparency = 0.200
		Content.TextXAlignment = Enum.TextXAlignment.Left

		Main.Name = "Main"
		Main.Parent = KeybindFace
		Main.AnchorPoint = Vector2.new(1, 0.5)
		Main.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
		Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Main.BorderSizePixel = 0
		Main.Position = UDim2.new(1, -5, 0.5, 0)
		Main.Size = UDim2.new(0, 75, 0.600000024, 0)
		Main.ZIndex = 8

		UICorner_2.CornerRadius = UDim.new(1, 0)
		UICorner_2.Parent = Main

		UIStroke_2.Transparency = 0.500
		UIStroke_2.Color = Color3.fromRGB(30, 30, 30)
		UIStroke_2.Parent = Main

		Upvalue.Name = "Upvalue"
		Upvalue.Parent = Main
		Upvalue.AnchorPoint = Vector2.new(0.5, 0.5)
		Upvalue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Upvalue.BackgroundTransparency = 1.000
		Upvalue.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Upvalue.BorderSizePixel = 0
		Upvalue.Position = UDim2.new(0.5, 0, 0.5, 0)
		Upvalue.Size = UDim2.new(1, -10, 0.600000024, 0)
		Upvalue.ZIndex = 9
		Upvalue.Font = Enum.Font.GothamMedium
		Upvalue.Text = GetKeyName(args.Default or "NONE");
		Upvalue.TextColor3 = Color3.fromRGB(255, 255, 255)
		Upvalue.TextScaled = true
		Upvalue.TextSize = 14.000
		Upvalue.TextTransparency = 0.400
		Upvalue.TextWrapped = true

		NewElement(function(value)
			if value then
				InterfaceManagerTable:Tween(KeybindFace , TweenInfoMain,{
					BackgroundTransparency = 0.500
				})

				InterfaceManagerTable:Tween(Upvalue , TweenInfoMain,{
					TextStrokeTransparency = 0.900,
					TextTransparency = 0.4
				})

				InterfaceManagerTable:Tween(Content , TweenInfoMain,{
					TextStrokeTransparency = 0.900,
					TextTransparency = 0.200
				})

				InterfaceManagerTable:Tween(UIStroke , TweenInfoMain,{
					Transparency = 0.5;
				})
			else
				InterfaceManagerTable:Tween(KeybindFace ,TweenInfoMain,{
					BackgroundTransparency = 1
				})

				InterfaceManagerTable:Tween(Upvalue , TweenInfoMain,{
					TextStrokeTransparency = 1,
					TextTransparency = 1
				})

				InterfaceManagerTable:Tween(Content ,TweenInfoMain,{
					TextStrokeTransparency =1,
					TextTransparency = 1
				})

				InterfaceManagerTable:Tween(UIStroke , TweenInfoMain,{
					Transparency = 1;
				})
			end;
		end)

		local Manager = InterfaceManagerTable:InputButton(KeybindFace);
		local IsBind = false;
		local Update = function(newkey)
			Upvalue.Text = GetKeyName(newkey or "NONE");

			local xA = InterfaceManagerTable:GetTextSize(Upvalue.Text , Upvalue.TextSize , Upvalue.Font);

			InterfaceManagerTable:Tween(Main,TweenInfo.new(0.1),{
				Size = UDim2.new(0, xA.X + 10, 0.600000024, 0)
			})
		end;

		Manager.Active = false;

		Update((args.Default))

		Manager.MouseButton1Click:Connect(function()
			if IsBind  then
				return
			end

			InterfaceManagerTable:NewRipple(Manager);

			IsBind = true;
			local Binded = nil;

			Update("...");

			while (not Binded) do
				local Keybind = InterfaceManagerTable.InputService.InputBegan:Wait();

				if Keybind.KeyCode ~= Enum.KeyCode.Unknown then
					Binded = Keybind.KeyCode;
				end;
			end;

			IsBind = false;

			Update(Binded);

			args.Callback(Binded)
		end)

		function args:Title(new)
			Content.Text = tostring(new);
		end;

		function args:Visible(new)
			KeybindFace.Visible = new;
		end;

		function args:Value(new)
			args.Default = new;

			Update(args.Default);

			args.Callback(new)
		end;

		return args
	end;

	function Internal:AddSlider(args)
		args = args or {};
		args.Title = args.Title or "Slider";
		args.Callback = args.Callback or function() end;
		args.Default =	args.Default or 50;
		args.Min = args.Min or 0;
		args.Max = args.Max or 100;
		args.Rounding = args.Rounding or 0;
		args.Type = args.Type or "%";

		local SliderFace = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local Content = Instance.new("TextLabel")
		local Main = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")
		local UIStroke_2 = Instance.new("UIStroke")
		local upvalue = Instance.new("Frame")
		local UICorner_3 = Instance.new("UICorner")
		local Value = Instance.new("TextLabel")
		Content.RichText = true;
		Value.RichText = true;

		SliderFace.Name = "SliderFace"
		SliderFace.Parent = main_frame
		SliderFace.BackgroundColor3 = Color3.fromRGB(26, 26, 28)
		SliderFace.BackgroundTransparency = 0.500
		SliderFace.BorderColor3 = Color3.fromRGB(0, 0, 0)
		SliderFace.BorderSizePixel = 0
		SliderFace.Size = UDim2.new(1, -5, 0, 35)
		SliderFace.ZIndex = 8

		UICorner.CornerRadius = UDim.new(0, 3)
		UICorner.Parent = SliderFace

		UIStroke.Transparency = 0.500
		UIStroke.Color = Color3.fromRGB(24, 24, 24)
		UIStroke.Parent = SliderFace

		Content.Name = "Content"
		Content.Parent = SliderFace
		Content.AnchorPoint = Vector2.new(0.5, 0.5)
		Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Content.BackgroundTransparency = 1.000
		Content.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Content.BorderSizePixel = 0
		Content.Position = UDim2.new(0.5, 0, 0.300000012, 0)
		Content.Size = UDim2.new(1, -10, 0, 10)
		Content.ZIndex = 8
		Content.Font = Enum.Font.GothamMedium
		Content.Text = args.Title
		Content.TextColor3 = Color3.fromRGB(255, 255, 255)
		Content.TextSize = 14.000
		Content.TextStrokeTransparency = 0.900
		Content.TextTransparency = 0.200
		Content.TextXAlignment = Enum.TextXAlignment.Left

		Main.Name = "Main"
		Main.Parent = SliderFace
		Main.AnchorPoint = Vector2.new(0.5, 1)
		Main.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
		Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Main.BorderSizePixel = 0
		Main.ClipsDescendants = true
		Main.Position = UDim2.new(0.5, 0, 1, -5)
		Main.Size = UDim2.new(1, -10, 0.200000003, 0)
		Main.ZIndex = 8

		UICorner_2.CornerRadius = UDim.new(0, 2)
		UICorner_2.Parent = Main

		UIStroke_2.Transparency = 0.500
		UIStroke_2.Color = Color3.fromRGB(30, 30, 30)
		UIStroke_2.Parent = Main

		upvalue.Name = "upvalue"
		upvalue.Parent = Main
		upvalue.AnchorPoint = Vector2.new(0, 0.5)
		upvalue.BackgroundColor3 = InterfaceManagerTable.Hightlight
		upvalue.BorderColor3 = Color3.fromRGB(0, 0, 0)
		upvalue.BorderSizePixel = 0
		upvalue.Position = UDim2.new(0, 0, 0.5, 0)
		upvalue.Size = UDim2.new(0.5, 0, 1, 0)
		upvalue.ZIndex = 9

		UICorner_3.CornerRadius = UDim.new(0, 2)
		UICorner_3.Parent = upvalue

		Value.Name = "Value"
		Value.Parent = SliderFace
		Value.AnchorPoint = Vector2.new(0.5, 0.5)
		Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Value.BackgroundTransparency = 1.000
		Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Value.BorderSizePixel = 0
		Value.Position = UDim2.new(0.5, 0, 0.300000012, 0)
		Value.Size = UDim2.new(1, -10, 0, 10)
		Value.ZIndex = 8
		Value.Font = Enum.Font.GothamMedium
		Value.Text = tostring(args.Default)..' / '..tostring(args.Max)..tostring(args.Type)
		Value.TextColor3 = Color3.fromRGB(255, 255, 255)
		Value.TextSize = 11.000
		Value.TextStrokeTransparency = 0.900
		Value.TextTransparency = 0.500
		Value.TextXAlignment = Enum.TextXAlignment.Right

		NewElement(function(value)
			if value then
				InterfaceManagerTable:Tween(SliderFace , TweenInfoMain,{
					BackgroundTransparency = 0.500
				})

				InterfaceManagerTable:Tween(Value , TweenInfoMain,{
					TextStrokeTransparency = 0.900,
					TextTransparency = 0.4
				})

				InterfaceManagerTable:Tween(upvalue , TweenInfoMain,{
					BackgroundTransparency = 0
				})


				InterfaceManagerTable:Tween(Content , TweenInfoMain,{
					TextStrokeTransparency = 0.900,
					TextTransparency = 0.200
				})

				InterfaceManagerTable:Tween(UIStroke , TweenInfoMain,{
					Transparency = 0.5;
				})
			else

				InterfaceManagerTable:Tween(upvalue , TweenInfoMain,{
					BackgroundTransparency = 1
				})

				InterfaceManagerTable:Tween(SliderFace ,TweenInfoMain,{
					BackgroundTransparency = 1
				})

				InterfaceManagerTable:Tween(Value , TweenInfoMain,{
					TextStrokeTransparency = 1,
					TextTransparency = 1
				})

				InterfaceManagerTable:Tween(Content ,TweenInfoMain,{
					TextStrokeTransparency =1,
					TextTransparency = 1
				})

				InterfaceManagerTable:Tween(UIStroke , TweenInfoMain,{
					Transparency = 1;
				})
			end;
		end)

		local function Rounding(num, numDecimalPlaces)
			local mult = 10^(numDecimalPlaces or 0)
			return math.floor(num * mult + 0.5) / mult
		end;

		local IsHold = false;

		InterfaceManagerTable:Tween(upvalue , TweenInfo.new(0.4),{
			Size = UDim2.new((args.Default - args.Min) / (args.Max - args.Min), 0, 1, 0)
		});

		local function update(Input)

			local SizeScale = math.clamp((((Input.Position.X) - Main.AbsolutePosition.X) / Main.AbsoluteSize.X), 0, 1)
			local Main = ((args.Max - args.Min) * SizeScale) + args.Min;
			local Values = Rounding(Main,args.Rounding)
			local PositionX = UDim2.fromScale(SizeScale, 1)
			local normalized = (Values - args.Min) / (args.Max - args.Min)

			InterfaceManagerTable:Tween(upvalue ,  TweenInfo.new(0.1),{
				Size = UDim2.new(normalized, 0, 1, 0)
			});

			Value.Text = tostring(Values)..' / '..tostring(args.Max)..tostring(args.Type)

			args.Callback(Values)
		end;

		Main.InputBegan:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				IsHold = true
				update(Input)
			end
		end)

		Main.InputEnded:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				IsHold = false
			end
		end)

		InterfaceManagerTable.InputService.InputChanged:Connect(function(Input)
			if IsHold then
				if (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch)  then
					update(Input)
				end
			end
		end)

		function args:Title(new)
			Content.Text = tostring(new);
		end;

		function args:Visible(new)
			SliderFace.Visible = new;
		end;

		function args:Value(new)
			args.Default = new;

			InterfaceManagerTable:Tween(upvalue , TweenInfo.new(0.4),{
				Size = UDim2.new((args.Default - args.Min) / (args.Max - args.Min), 0, 1, 0)
			});
			args.Callback(new)
		end;

		return args
	end;

	function Internal:AddToggle(args)
		args = args or {};
		args.Title = args.Title or "Button";
		args.Default =	args.Default or false;
		args.Callback = args.Callback or function() end;

		local ToggleFace = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local Content = Instance.new("TextLabel")
		local Main = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")
		local UIStroke_2 = Instance.new("UIStroke")
		local Block = Instance.new("Frame")
		local UICorner_3 = Instance.new("UICorner")
		Content.RichText = true;

		ToggleFace.Name = "ToggleFace"
		ToggleFace.Parent = main_frame
		ToggleFace.BackgroundColor3 = Color3.fromRGB(26, 26, 28)
		ToggleFace.BackgroundTransparency = 0.500
		ToggleFace.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ToggleFace.BorderSizePixel = 0
		ToggleFace.Size = UDim2.new(1, -5, 0, 30)
		ToggleFace.ZIndex = 8

		UICorner.CornerRadius = UDim.new(0, 3)
		UICorner.Parent = ToggleFace

		UIStroke.Transparency = 0.500
		UIStroke.Color = Color3.fromRGB(24, 24, 24)
		UIStroke.Parent = ToggleFace

		Content.Name = "Content"
		Content.Parent = ToggleFace
		Content.AnchorPoint = Vector2.new(0.5, 0.5)
		Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Content.BackgroundTransparency = 1.000
		Content.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Content.BorderSizePixel = 0
		Content.Position = UDim2.new(0.5, 0, 0.5, 0)
		Content.Size = UDim2.new(1, -10, 0, 10)
		Content.ZIndex = 8
		Content.Font = Enum.Font.GothamMedium
		Content.Text = args.Title
		Content.TextColor3 = Color3.fromRGB(255, 255, 255)
		Content.TextSize = 14.000
		Content.TextStrokeTransparency = 0.900
		Content.TextTransparency = 0.200
		Content.TextXAlignment = Enum.TextXAlignment.Left

		Main.Name = "Main"
		Main.Parent = ToggleFace
		Main.AnchorPoint = Vector2.new(1, 0.5)
		Main.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
		Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Main.BorderSizePixel = 0
		Main.Position = UDim2.new(1, -5, 0.5, 0)
		Main.Size = UDim2.new(0, 35, 0.600000024, 0)
		Main.ZIndex = 8

		UICorner_2.CornerRadius = UDim.new(1, 0)
		UICorner_2.Parent = Main

		UIStroke_2.Transparency = 0.500
		UIStroke_2.Color = Color3.fromRGB(30, 30, 30)
		UIStroke_2.Parent = Main

		Block.Name = "Block"
		Block.Parent = Main
		Block.BackgroundColor3 = InterfaceManagerTable.Hightlight
		Block.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Block.BorderSizePixel = 0
		Block.Size = UDim2.new(1, 0, 1, 0)
		Block.SizeConstraint = Enum.SizeConstraint.RelativeYY
		Block.ZIndex = 9
		Block.AnchorPoint = Vector2.new(0.5,0.5);
		Block.Position = UDim2.fromScale(0.25,0.5)

		UICorner_3.CornerRadius = UDim.new(1, 0)
		UICorner_3.Parent = Block

		NewElement(function(value)
			if value then
				InterfaceManagerTable:Tween(ToggleFace , TweenInfoMain,{
					BackgroundTransparency = 0.500
				})

				InterfaceManagerTable:Tween(Block , TweenInfoMain,{
					BackgroundTransparency = 0
				})


				InterfaceManagerTable:Tween(Content , TweenInfoMain,{
					TextStrokeTransparency = 0.900,
					TextTransparency = 0.200
				})

				InterfaceManagerTable:Tween(UIStroke , TweenInfoMain,{
					Transparency = 0.5;
				})
			else

				InterfaceManagerTable:Tween(Block , TweenInfoMain,{
					BackgroundTransparency = 1
				})

				InterfaceManagerTable:Tween(ToggleFace ,TweenInfoMain,{
					BackgroundTransparency = 1
				})

				InterfaceManagerTable:Tween(Content ,TweenInfoMain,{
					TextStrokeTransparency =1,
					TextTransparency = 1
				})

				InterfaceManagerTable:Tween(UIStroke , TweenInfoMain,{
					Transparency = 1;
				})
			end;
		end)

		local ToggleFunc = function(value)
			if value then
				InterfaceManagerTable:Tween(Block , TweenInfo.new(0.3),{
					Position = UDim2.fromScale(0.75,0.5),
					BackgroundColor3 = InterfaceManagerTable.Hightlight
				})
			else
				InterfaceManagerTable:Tween(Block , TweenInfo.new(0.3),{
					Position = UDim2.fromScale(0.25,0.5),
					BackgroundColor3 = Color3.fromRGB(36, 36, 36)
				})
			end;
		end;

		ToggleFunc(args.Default);

		local Manager = InterfaceManagerTable:InputButton(ToggleFace);

		Manager.Active = false;

		Manager.MouseButton1Click:Connect(function()
			InterfaceManagerTable:NewRipple(Manager);

			args.Default = not args.Default;
			ToggleFunc(args.Default);

			args.Callback(args.Default)
		end);

		function args:Title(new)
			Content.Text = tostring(new);
		end;

		function args:Visible(new)
			ToggleFace.Visible = new;
		end;

		function args:Value(new)
			args.Default = new;
			ToggleFunc(new);

			args.Callback(new)
		end;

		return args;
	end;

	function Internal:AddButton(args)
		args = args or {};
		args.Title = args.Title or "Button";
		args.Callback = args.Callback or function() end;

		local ButtonFace = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local Content = Instance.new("TextLabel")
		local Input = Instance.new("Frame")
		local Icon = Instance.new("ImageLabel")

		Content.RichText = true;

		ButtonFace.Name = "ButtonFace"
		ButtonFace.Parent = main_frame
		ButtonFace.BackgroundColor3 = Color3.fromRGB(26, 26, 28)
		ButtonFace.BackgroundTransparency = 0.500
		ButtonFace.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ButtonFace.BorderSizePixel = 0
		ButtonFace.Size = UDim2.new(1, -5, 0, 30)
		ButtonFace.ZIndex = 8

		UICorner.CornerRadius = UDim.new(0, 3)
		UICorner.Parent = ButtonFace

		UIStroke.Transparency = 0.500
		UIStroke.Color = Color3.fromRGB(24, 24, 24)
		UIStroke.Parent = ButtonFace

		Content.Name = "Content"
		Content.Parent = ButtonFace
		Content.AnchorPoint = Vector2.new(0.5, 0.5)
		Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Content.BackgroundTransparency = 1.000
		Content.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Content.BorderSizePixel = 0
		Content.Position = UDim2.new(0.5, 0, 0.5, 0)
		Content.Size = UDim2.new(1, -10, 0, 10)
		Content.ZIndex = 8
		Content.Font = Enum.Font.GothamMedium
		Content.Text = args.Title
		Content.TextColor3 = Color3.fromRGB(255, 255, 255)
		Content.TextSize = 14.000
		Content.TextStrokeTransparency = 0.900
		Content.TextTransparency = 0.200
		Content.TextXAlignment = Enum.TextXAlignment.Left

		Input.Name = "Input"
		Input.Parent = ButtonFace
		Input.AnchorPoint = Vector2.new(1, 0.5)
		Input.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
		Input.BackgroundTransparency = 1.000
		Input.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Input.BorderSizePixel = 0
		Input.Position = UDim2.new(1, -5, 0.5, 0)
		Input.Size = UDim2.new(0, 20, 0.600000024, 0)
		Input.ZIndex = 8

		Icon.Name = "Icon"
		Icon.Parent = Input
		Icon.AnchorPoint = Vector2.new(0.5, 0)
		Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Icon.BackgroundTransparency = 1.000
		Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Icon.BorderSizePixel = 0
		Icon.Position = UDim2.new(0.75, 0, 0, 0)
		Icon.Size = UDim2.new(1, 0, 1, 0)
		Icon.SizeConstraint = Enum.SizeConstraint.RelativeYY
		Icon.ZIndex = 9
		Icon.Image = "rbxassetid://10709791437"
		Icon.ImageTransparency = 0.500
		Icon.ScaleType = Enum.ScaleType.Fit

		NewElement(function(value)
			if value then
				InterfaceManagerTable:Tween(ButtonFace , TweenInfoMain,{
					BackgroundTransparency = 0.500
				})

				InterfaceManagerTable:Tween(Icon , TweenInfoMain,{
					ImageTransparency = 0.500
				})


				InterfaceManagerTable:Tween(Content , TweenInfoMain,{
					TextStrokeTransparency = 0.900,
					TextTransparency = 0.200
				})

				InterfaceManagerTable:Tween(UIStroke , TweenInfoMain,{
					Transparency = 0.5;
				})
			else

				InterfaceManagerTable:Tween(Icon , TweenInfoMain,{
					ImageTransparency = 1
				})

				InterfaceManagerTable:Tween(ButtonFace ,TweenInfoMain,{
					BackgroundTransparency = 1
				})

				InterfaceManagerTable:Tween(Content ,TweenInfoMain,{
					TextStrokeTransparency =1,
					TextTransparency = 1
				})

				InterfaceManagerTable:Tween(UIStroke , TweenInfoMain,{
					Transparency = 1;
				})
			end;
		end)

		ButtonFace.MouseEnter:Connect(function()
			InterfaceManagerTable:Tween(ButtonFace , TweenInfo.new(0.1) , {
				BackgroundColor3 = Color3.fromRGB(33, 33, 35)
			})
		end)

		ButtonFace.MouseLeave:Connect(function()
			InterfaceManagerTable:Tween(ButtonFace , TweenInfo.new(0.1) , {
				BackgroundColor3 = Color3.fromRGB(26, 26, 28)
			})
		end)

		local Manager = InterfaceManagerTable:InputButton(ButtonFace);

		Manager.Active = false;

		Manager.MouseButton1Down:Connect(function()
			InterfaceManagerTable:Tween(Icon , TweenInfo.new(0.1) , {
				Position = UDim2.new(0.99, 0, 0, 0),
			})
		end)

		Manager.MouseButton1Up:Connect(function()
			InterfaceManagerTable:Tween(Icon , TweenInfo.new(0.1) , {
				Position = UDim2.new(0.75, 0, 0, 0),
				Size = UDim2.new(1, 0, 1, 0)
			})
		end)

		Manager.MouseButton1Click:Connect(function()
			InterfaceManagerTable:NewRipple(Manager);

			args.Callback(ButtonFace)
		end)

		function args:Title(new)
			Content.Text = tostring(new);
		end;

		function args:Visible(new)
			ButtonFace.Visible = new;
		end;

		return args;
	end;

	return Internal
end;

do
	local Interface = Instance.new("ScreenGui");

	Interface.Name = "Interface"
	Interface.IgnoreGuiInset = false
	Interface.ZIndexBehavior = Enum.ZIndexBehavior.Global
	Interface.ResetOnSpawn = false
	Interface.Parent = InterfaceManagerTable.CoreGui
	Interface.Name = "\0";

	InterfaceManagerTable.ScreenGui = Interface;
end;

if not InterfaceManagerTable.Dropdown then
	do
		local Dbindex = InterfaceManagerTable:CreateDropdown();

		function InterfaceManagerTable:SetDropdown(args , Default , IsMulti , Callback)
			return Dbindex:Set(args , Default , IsMulti , Callback)
		end;

		InterfaceManagerTable.Dropdown = Dbindex;

		Dbindex:Hide()
	end;
end;

function InterfaceManagerTable.new(args)
	args = args or {};
	args.Title = args.Title or "Kncrypt Hub";
	args.Logo = args.Logo or "http://www.roblox.com/asset/?id=125085241530623";
	args.Keybind = args.Keybind or Enum.KeyCode.LeftControl;
	args.Size = args.Size or UDim2.new(0, 580, 0, 365);

	local KNC_Interface = {};

	KNC_Interface.FullScreen = false;
	KNC_Interface.Toggle = true;
	KNC_Interface.FirstTab = true;
	KNC_Interface.Tabs = {};
	KNC_Interface.TabSelected = nil;
	KNC_Interface.IsOpenTab = false;

	if InterfaceManagerTable.ScreenGui then
		InterfaceManagerTable.ScreenGui.Parent = nil;	
	end;

	local Interface = Instance.new("ScreenGui")
	local MainFrame = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local DropShadow = Instance.new("ImageLabel")
	local Headers = Instance.new("Frame")
	local DropShadow_2 = Instance.new("ImageLabel")
	local UICorner_2 = Instance.new("UICorner")
	local Logo = Instance.new("ImageLabel")
	local Title = Instance.new("TextLabel")
	local Frame = Instance.new("Frame")
	local Manager = Instance.new("Frame")
	local MinButton = Instance.new("ImageButton")
	local UIListLayout = Instance.new("UIListLayout")
	local MaxButton = Instance.new("ImageButton")
	local CloseButton = Instance.new("ImageButton")
	local buttonFrame = Instance.new("Frame")
	local UICorner_3 = Instance.new("UICorner")
	local buttonFrameMain = Instance.new("ScrollingFrame")
	local UIListLayout_2 = Instance.new("UIListLayout")
	local Hightlight = Instance.new("Frame")
	local UICorner_4 = Instance.new("UICorner")
	local ImageLabel = Instance.new("ImageLabel")
	local InterfaceManager = Instance.new("Frame")
	local UIListLayout_3 = Instance.new("UIListLayout")
	local TabButtonOpen = Instance.new("ImageButton")
	local UICorner_5 = Instance.new("UICorner")
	local TMFrame = Instance.new("Frame")
	local UIGradient = Instance.new("UIGradient")
	local BlackFrame = Instance.new("Frame")

	Title.RichText = true;

	Interface.Name = "Interface"
	Interface.IgnoreGuiInset = false
	Interface.ZIndexBehavior = Enum.ZIndexBehavior.Global
	Interface.ResetOnSpawn = false
	Interface.Parent = InterfaceManagerTable.CoreGui

	if InterfaceManagerTable.ScreenGui then
		InterfaceManagerTable.ScreenGui.Parent = InterfaceManagerTable.CoreGui;	
	end;

	task.delay(1,function()
		InterfaceManagerTable:Obfuscate(Interface);
	end)

	MainFrame.Name = "MainFrame"
	MainFrame.Parent = Interface
	MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
	MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	MainFrame.BorderSizePixel = 0
	MainFrame.ClipsDescendants = true
	MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
	MainFrame.Size = UDim2.fromOffset(5,5)
	MainFrame.Active = true

	InterfaceManagerTable:Tween(MainFrame,TweenInfo.new(1.5,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
		Size = args.Size
	})

	UICorner.CornerRadius = UDim.new(1,1)
	UICorner.Parent = MainFrame

	InterfaceManagerTable:Tween(UICorner,TweenInfo.new(1,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
		CornerRadius = UDim.new(0, 4)
	})

	DropShadow.Name = "DropShadow"
	DropShadow.Parent = MainFrame
	DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
	DropShadow.BackgroundTransparency = 1.000
	DropShadow.BorderSizePixel = 0
	DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	DropShadow.Rotation = 0.001
	DropShadow.Size = UDim2.new(1, 40, 1, 40)
	DropShadow.ZIndex = -1
	DropShadow.Image = "rbxassetid://6015897843"
	DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	DropShadow.ImageTransparency = 1
	DropShadow.ScaleType = Enum.ScaleType.Slice
	DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)

	InterfaceManagerTable:Tween(DropShadow,TweenInfo.new(2,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
		ImageTransparency = 0.500
	})

	Headers.Name = "Headers"
	Headers.Parent = MainFrame
	Headers.BackgroundColor3 = Color3.fromRGB(38, 38, 44)
	Headers.BackgroundTransparency = 0.100
	Headers.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Headers.BorderSizePixel = 0
	Headers.Size = UDim2.new(1, 0, 0, 25)
	Headers.ZIndex = 45

	DropShadow_2.Name = "DropShadow"
	DropShadow_2.Parent = Headers
	DropShadow_2.AnchorPoint = Vector2.new(0.5, 0.5)
	DropShadow_2.BackgroundTransparency = 1.000
	DropShadow_2.BorderSizePixel = 0
	DropShadow_2.Position = UDim2.new(0.5, 0, 0.5, 0)
	DropShadow_2.Size = UDim2.new(1, 35, 1, 35)
	DropShadow_2.ZIndex = 44
	DropShadow_2.Image = "rbxassetid://6015897843"
	DropShadow_2.ImageColor3 = Color3.fromRGB(0, 0, 0)
	DropShadow_2.ImageTransparency = 0.950
	DropShadow_2.ScaleType = Enum.ScaleType.Slice
	DropShadow_2.SliceCenter = Rect.new(49, 49, 450, 450)

	UICorner_2.CornerRadius = UDim.new(0, 1)
	UICorner_2.Parent = Headers

	Logo.Name = "Logo"
	Logo.Parent = Headers
	Logo.AnchorPoint = Vector2.new(0, 0.5)
	Logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Logo.BackgroundTransparency = 1.000
	Logo.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Logo.BorderSizePixel = 0
	Logo.Position = UDim2.new(0, 2, 0.5, 0)
	Logo.Size = UDim2.new(0.899999976, 0, 0.899999976, 0)
	Logo.SizeConstraint = Enum.SizeConstraint.RelativeYY
	Logo.ZIndex = 45
	Logo.Image = args.Logo

	Title.Name = "Title"
	Title.Parent = Headers
	Title.AnchorPoint = Vector2.new(0, 0.5)
	Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title.BackgroundTransparency = 1.000
	Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Title.BorderSizePixel = 0
	Title.Position = UDim2.new(-5.26165138e-08, 35, 0.5, 0)
	Title.Size = UDim2.new(0.927586198, 0, 0.550000012, 0)
	Title.ZIndex = 45
	Title.Font = Enum.Font.Gotham
	Title.Text = args.Title
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextSize = 14.000
	Title.TextStrokeTransparency = 0.900
	Title.TextWrapped = true
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.TextYAlignment = Enum.TextYAlignment.Top

	Frame.Parent = Headers
	Frame.AnchorPoint = Vector2.new(0, 0.5)
	Frame.BackgroundColor3 = Color3.fromRGB(78, 81, 86)
	Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame.BorderSizePixel = 0
	Frame.Position = UDim2.new(0, 26, 0.5, 0)
	Frame.Size = UDim2.new(0, 1, 0.800000012, 0)
	Frame.ZIndex = 45

	Manager.Name = "Manager"
	Manager.Parent = Headers
	Manager.AnchorPoint = Vector2.new(1, 0.5)
	Manager.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Manager.BackgroundTransparency = 1.000
	Manager.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Manager.BorderSizePixel = 0
	Manager.Position = UDim2.new(1, -5, 0.5, 0)
	Manager.Size = UDim2.new(0.155000001, 0, 0.649999976, 0)
	Manager.ZIndex = 45

	MinButton.Name = "MinButton"
	MinButton.Parent = Manager
	MinButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	MinButton.BackgroundTransparency = 1.000
	MinButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	MinButton.BorderSizePixel = 0
	MinButton.Size = UDim2.new(1, 0, 1, 0)
	MinButton.SizeConstraint = Enum.SizeConstraint.RelativeYY
	MinButton.ZIndex = 46
	MinButton.Image = "rbxassetid://9886659276"

	UIListLayout.Parent = Manager
	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	UIListLayout.Padding = UDim.new(0, 5)

	MaxButton.Name = "MaxButton"
	MaxButton.Parent = Manager
	MaxButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	MaxButton.BackgroundTransparency = 1.000
	MaxButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	MaxButton.BorderSizePixel = 0
	MaxButton.Size = UDim2.new(1, 0, 1, 0)
	MaxButton.SizeConstraint = Enum.SizeConstraint.RelativeYY
	MaxButton.ZIndex = 46
	MaxButton.Image = "rbxassetid://9886659406"

	CloseButton.Name = "CloseButton"
	CloseButton.Parent = Manager
	CloseButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	CloseButton.BackgroundTransparency = 1.000
	CloseButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	CloseButton.BorderSizePixel = 0
	CloseButton.Size = UDim2.new(1, 0, 1, 0)
	CloseButton.SizeConstraint = Enum.SizeConstraint.RelativeYY
	CloseButton.ZIndex = 46
	CloseButton.Image = "rbxassetid://9886659671"

	InterfaceManagerTable:CreateHover(MinButton , 0.5);
	InterfaceManagerTable:CreateHover(MaxButton , 0.5);
	InterfaceManagerTable:CreateHover(CloseButton , 0.5);


	buttonFrame.Name = "buttonFrame"
	buttonFrame.Parent = MainFrame
	buttonFrame.BackgroundColor3 = Color3.fromRGB(31, 31, 36)
	buttonFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	buttonFrame.BorderSizePixel = 0
	buttonFrame.ClipsDescendants = true
	buttonFrame.Size = UDim2.new(0, 35, 1, 0)
	buttonFrame.ZIndex = 35

	UICorner_3.CornerRadius = UDim.new(0, 4)
	UICorner_3.Parent = buttonFrame

	buttonFrameMain.Name = "buttonFrameMain"
	buttonFrameMain.Parent = buttonFrame
	buttonFrameMain.Active = true
	buttonFrameMain.AnchorPoint = Vector2.new(0.5, 1)
	buttonFrameMain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	buttonFrameMain.BackgroundTransparency = 1.000
	buttonFrameMain.BorderColor3 = Color3.fromRGB(0, 0, 0)
	buttonFrameMain.BorderSizePixel = 0
	buttonFrameMain.ClipsDescendants = false
	buttonFrameMain.Position = UDim2.new(0.5, 0, 1, -30)
	buttonFrameMain.Size = UDim2.new(1, -5, 1, -62)
	buttonFrameMain.ZIndex = 36
	buttonFrameMain.ScrollBarThickness = 0
	buttonFrameMain.ClipsDescendants = true

	UIListLayout_2.Parent = buttonFrameMain
	UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_2.Padding = UDim.new(0, 100)

	InterfaceManagerTable:Tween(UIListLayout_2,TweenInfo.new(1,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
		Padding = UDim.new(0, 9)
	})

	UIListLayout_2:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
		buttonFrameMain.CanvasSize = UDim2.fromOffset(0,UIListLayout_2.AbsoluteContentSize.Y)
	end)

	Hightlight.Name = "Hightlight"
	Hightlight.Parent = buttonFrame
	Hightlight.BackgroundColor3 = InterfaceManagerTable.Hightlight
	Hightlight.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Hightlight.BorderSizePixel = 0
	Hightlight.Position = UDim2.new(0, 5, 0, 62)
	Hightlight.Size = UDim2.new(0, 25, 0, 25)
	Hightlight.ZIndex = 36
	Hightlight.BackgroundTransparency = 1

	UICorner_4.CornerRadius = UDim.new(0, 3)
	UICorner_4.Parent = Hightlight

	ImageLabel.Parent = Hightlight
	ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ImageLabel.BackgroundTransparency = 1.000
	ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ImageLabel.BorderSizePixel = 0
	ImageLabel.Size = UDim2.new(1, 0, 1, 0)
	ImageLabel.ZIndex = 37
	ImageLabel.Image = "rbxassetid://4576475446"
	ImageLabel.ImageTransparency = 0.600

	InterfaceManager.Name = "InterfaceManager"
	InterfaceManager.Parent = buttonFrame
	InterfaceManager.AnchorPoint = Vector2.new(0, 1)
	InterfaceManager.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	InterfaceManager.BackgroundTransparency = 1.000
	InterfaceManager.BorderColor3 = Color3.fromRGB(0, 0, 0)
	InterfaceManager.BorderSizePixel = 0
	InterfaceManager.Position = UDim2.new(0, 5, 1, -2)
	InterfaceManager.Size = UDim2.new(0, 125, 0, 25)
	InterfaceManager.ZIndex = 36

	UIListLayout_3.Parent = InterfaceManager
	UIListLayout_3.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_3.VerticalAlignment = Enum.VerticalAlignment.Center
	UIListLayout_3.Padding = UDim.new(0, 100)

	InterfaceManagerTable:Tween(UIListLayout_3,TweenInfo.new(1,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
		Padding = UDim.new(0, 10)
	})

	TabButtonOpen.Name = "TabButtonOpen"
	TabButtonOpen.Parent = InterfaceManager
	TabButtonOpen.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabButtonOpen.BackgroundTransparency = 1.000
	TabButtonOpen.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TabButtonOpen.BorderSizePixel = 0
	TabButtonOpen.Size = UDim2.new(1, 0, 1, 0)
	TabButtonOpen.SizeConstraint = Enum.SizeConstraint.RelativeYY
	TabButtonOpen.ZIndex = 37
	TabButtonOpen.Image = "rbxassetid://10709791437"
	TabButtonOpen.ImageTransparency = 0.350

	InterfaceManagerTable:CreateHover(TabButtonOpen , 0.75);

	UICorner_5.CornerRadius = UDim.new(0, 4)
	UICorner_5.Parent = TabButtonOpen

	TMFrame.Name = "TMFrame"
	TMFrame.Parent = MainFrame
	TMFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TMFrame.BackgroundTransparency = 1.000
	TMFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TMFrame.BorderSizePixel = 0
	TMFrame.ClipsDescendants = true
	TMFrame.Position = UDim2.new(0, 37, 0, 27)
	TMFrame.Size = UDim2.new(1, -40, 1, -30)


	BlackFrame.Name = "BlackFrame"
	BlackFrame.Parent = MainFrame
	BlackFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	BlackFrame.BackgroundTransparency = 1.000
	BlackFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	BlackFrame.BorderSizePixel = 0
	BlackFrame.Size = UDim2.new(1, 0, 1, 0)
	BlackFrame.Visible = false
	BlackFrame.ZIndex = 34

	TabButtonOpen.MouseButton1Click:Connect(function()
		KNC_Interface.IsOpenTab = not KNC_Interface.IsOpenTab;

		if KNC_Interface.IsOpenTab then
			InterfaceManagerTable:Tween(buttonFrame , TweenInfo.new(0.12) ,{
				Size = UDim2.new(0, 135, 1, 0)
			})

			InterfaceManagerTable:Tween(BlackFrame , TweenInfo.new(0.12) ,{
				BackgroundTransparency = 0.7
			})

			InterfaceManagerTable:Tween(TabButtonOpen , TweenInfo.new(0.12) ,{
				Rotation = 180
			})

			buttonFrameMain.ScrollBarThickness = 1
		else

			buttonFrameMain.ScrollBarThickness = 0
			InterfaceManagerTable:Tween(BlackFrame , TweenInfo.new(0.12) ,{
				BackgroundTransparency = 1
			})

			InterfaceManagerTable:Tween(TabButtonOpen , TweenInfo.new(0.12) ,{
				Rotation = 0
			})

			InterfaceManagerTable:Tween(buttonFrame , TweenInfo.new(0.12) ,{
				Size = UDim2.new(0, 35, 1, 0)
			})
		end;
	end)

	function KNC_Interface:Authorize(argsIndex)
		argsIndex = argsIndex or {};
		argsIndex.Title = argsIndex.Title or "Key System";
		argsIndex.OnClick = argsIndex.OnClick or function() end;
		argsIndex.OnLogin = argsIndex.OnLogin or function() end;
		argsIndex.OnStart = argsIndex.OnStart or function() end;
		
		argsIndex.ClickLabel = argsIndex.ClickLabel or "Get Key";
		argsIndex.LoginLabel = argsIndex.LoginLabel or "Login";
		argsIndex.Placeholder = argsIndex.Placeholder or "Enter Key";
		KNC_Interface.Busy = true

		InterfaceManagerTable:Tween(MainFrame,TweenInfo.new(1.25,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
			Size = UDim2.fromOffset(300,150)
		})

		KNC_Interface:SetHide();

		local old_UICorner = UICorner;
		local Authorize = Instance.new("Frame")
		local Title = Instance.new("TextLabel")
		local Line = Instance.new("Frame")
		local TextBox = Instance.new("TextBox")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local ClickFrame = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")
		local UIStroke_2 = Instance.new("UIStroke")
		local Text = Instance.new("TextLabel")
		local LoginFrame = Instance.new("Frame")
		local UICorner_3 = Instance.new("UICorner")
		local UIStroke_3 = Instance.new("UIStroke")
		local Text_2 = Instance.new("TextLabel")
		local event = Instance.new('BindableEvent');

		Authorize.Name = "Authorize"
		Authorize.Parent = MainFrame
		Authorize.AnchorPoint = Vector2.new(0.5, 0.5)
		Authorize.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Authorize.BackgroundTransparency = 1.000
		Authorize.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Authorize.BorderSizePixel = 0
		Authorize.Position = UDim2.new(0.5, 0, 0.5, 0)
		Authorize.Size = UDim2.new(0.5,0,0.5,0)
		Authorize.ClipsDescendants = true
		Authorize.ZIndex = 4

		InterfaceManagerTable:Tween(Authorize,TweenInfo.new(1.75,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
			Size = UDim2.new(1, 0, 1, 0)
		})

		Title.Name = "Title"
		Title.Parent = Authorize
		Title.AnchorPoint = Vector2.new(0.5, 0)
		Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Title.BackgroundTransparency = 1.000
		Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Title.BorderSizePixel = 0
		Title.Position = UDim2.new(0.5, 0, 0, 5)
		Title.Size = UDim2.new(1, -10, 0, 15)
		Title.Font = Enum.Font.GothamMedium
		Title.Text = argsIndex.Title
		Title.TextColor3 = Color3.fromRGB(255, 255, 255)
		Title.TextScaled = true
		Title.TextSize = 14.000
		Title.TextStrokeTransparency = 1
		Title.TextWrapped = true
		Title.TextTransparency = 1;
		Title.RichText = true;

		InterfaceManagerTable:Tween(Title,TweenInfo.new(2.5,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
			TextTransparency = 0,
			TextStrokeTransparency = 0.900,
			Position = UDim2.new(0.5, 0, 0, 5)
		})

		Line.Name = "Line"
		Line.Parent = Authorize
		Line.AnchorPoint = Vector2.new(0.5, 0)
		Line.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		Line.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Line.BorderSizePixel = 0
		Line.Position = UDim2.new(0.5, 0, 0, 25)
		Line.Size = UDim2.new(1, -5, 0, 1)
		Line.ZIndex = 7

		InterfaceManagerTable:Tween(Line,TweenInfo.new(2.5,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
			BackgroundTransparency = 0
		})

		TextBox.Parent = Authorize
		TextBox.AnchorPoint = Vector2.new(0.5, 0)
		TextBox.BackgroundColor3 = Color3.fromRGB(18, 18, 21)
		TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextBox.BorderSizePixel = 0
		TextBox.ClipsDescendants = true
		TextBox.Position = UDim2.new(0.5, 0, 0, 45)
		TextBox.Size = UDim2.new(1, -20, 0, 20)
		TextBox.ZIndex = 5
		TextBox.ClearTextOnFocus = false
		TextBox.Font = Enum.Font.GothamMedium
		TextBox.PlaceholderText = argsIndex.Placeholder
		TextBox.Text = ""
		TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextBox.TextSize = 10.000
		TextBox.TextTransparency = 1

		InterfaceManagerTable:Tween(TextBox,TweenInfo.new(2.5,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
			TextTransparency = 0.400,
			Position = UDim2.new(0.5, 0, 0, 45)
		})

		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = TextBox

		UIStroke.Color = Color3.fromRGB(24, 24, 24)
		UIStroke.Parent = TextBox

		ClickFrame.Name = "ClickFrame"
		ClickFrame.Parent = Authorize
		ClickFrame.AnchorPoint = Vector2.new(0.5, 0.5)
		ClickFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 21)
		ClickFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ClickFrame.BorderSizePixel = 0
		ClickFrame.Position = UDim2.new(0.25, 0, 0.8, 0)
		ClickFrame.Size = UDim2.new(0, 111, 0, 30)
		ClickFrame.BackgroundTransparency = 1;

		InterfaceManagerTable:Tween(ClickFrame,TweenInfo.new(2.5,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
			BackgroundTransparency = 0,
			Position = UDim2.new(0.25, 0, 0.649999976, 0)
		})

		UICorner_2.CornerRadius = UDim.new(0, 4)
		UICorner_2.Parent = ClickFrame

		UIStroke_2.Color = Color3.fromRGB(29, 29, 29)
		UIStroke_2.Parent = ClickFrame

		Text.Name = "Text"
		Text.Parent = ClickFrame
		Text.AnchorPoint = Vector2.new(0.5, 0.5)
		Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Text.BackgroundTransparency = 1.000
		Text.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Text.BorderSizePixel = 0
		Text.Position = UDim2.new(0.5, 0, 0.5, 0)
		Text.Size = UDim2.new(1, 0, 0.5, 0)
		Text.Font = Enum.Font.GothamMedium
		Text.Text = argsIndex.ClickLabel
		Text.TextColor3 = Color3.fromRGB(255, 255, 255)
		Text.TextSize = 14.000
		Text.TextTransparency = 0.400
		Text.RichText = true;

		LoginFrame.Name = "LoginFrame"
		LoginFrame.Parent = Authorize
		LoginFrame.AnchorPoint = Vector2.new(0.5, 0.5)
		LoginFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 21)
		LoginFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LoginFrame.BorderSizePixel = 0
		LoginFrame.Position = UDim2.new(0.75, 0, 0.8, 0)
		LoginFrame.Size = UDim2.new(0, 111, 0, 30)
		LoginFrame.BackgroundTransparency = 1

		InterfaceManagerTable:Tween(LoginFrame,TweenInfo.new(2.5,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
			BackgroundTransparency = 0,
			Position = UDim2.new(0.75, 0, 0.649999976, 0)
		})

		UICorner_3.CornerRadius = UDim.new(0, 4)
		UICorner_3.Parent = LoginFrame

		UIStroke_3.Color = Color3.fromRGB(29, 29, 29)
		UIStroke_3.Parent = LoginFrame

		Text_2.Name = "Text"
		Text_2.Parent = LoginFrame
		Text_2.AnchorPoint = Vector2.new(0.5, 0.5)
		Text_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Text_2.BackgroundTransparency = 1.000
		Text_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Text_2.BorderSizePixel = 0
		Text_2.Position = UDim2.new(0.5, 0, 0.5, 0)
		Text_2.Size = UDim2.new(1, 0, 0.5, 0)
		Text_2.Font = Enum.Font.GothamMedium
		Text_2.Text = argsIndex.LoginLabel
		Text_2.TextColor3 = Color3.fromRGB(255, 255, 255)
		Text_2.TextSize = 14.000
		Text_2.TextTransparency = 0.400
		Text_2.RichText = true;

		LoginFrame.MouseLeave:Connect(function()
			InterfaceManagerTable:Tween(UIStroke_3,TweenInfo.new(0.1),{
				Color = Color3.fromRGB(29, 29, 29)
			})
		end)

		LoginFrame.MouseEnter:Connect(function()
			InterfaceManagerTable:Tween(UIStroke_3,TweenInfo.new(0.1),{
				Color = Color3.fromRGB(33, 33, 33)
			})
		end)

		ClickFrame.MouseLeave:Connect(function()
			InterfaceManagerTable:Tween(UIStroke_2,TweenInfo.new(0.1),{
				Color = Color3.fromRGB(29, 29, 29)
			})
		end)

		ClickFrame.MouseEnter:Connect(function()
			InterfaceManagerTable:Tween(UIStroke_2,TweenInfo.new(0.1),{
				Color = Color3.fromRGB(33, 33, 33)
			})
		end)
		
		local MakeLoad = function()
			InterfaceManagerTable:Tween(MainFrame,TweenInfo.new(0.5,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
				Size = UDim2.fromOffset(100,100)
			})

			InterfaceManagerTable:Tween(LoginFrame,TweenInfo.new(0.5,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
				BackgroundTransparency = 0,
				Position = UDim2.new(0.9, 0, 1.4, 0)
			})

			InterfaceManagerTable:Tween(ClickFrame,TweenInfo.new(0.5,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
				BackgroundTransparency = 0,
				Position = UDim2.new(0.1, 0, 1.4, 0)
			})

			InterfaceManagerTable:Tween(TextBox,TweenInfo.new(0.45,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
				Position = UDim2.new(0.5, 0, 0, 150)
			})

			InterfaceManagerTable:Tween(old_UICorner,TweenInfo.new(0.75,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
				CornerRadius = UDim.new(1,0)
			})

			InterfaceManagerTable:Tween(DropShadow,TweenInfo.new(0.55,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
				ImageTransparency = 1
			})

			InterfaceManagerTable:Tween(Line,TweenInfo.new(0.75,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
				BackgroundTransparency = 1
			})

			InterfaceManagerTable:Tween(Title,TweenInfo.new(0.65,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
				Position = UDim2.new(0.5, 0, 0, 40)
			})
			
			argsIndex.Auth = true
		end;
		
		local ToDefautl = function()
			argsIndex.Auth = false
			
			InterfaceManagerTable:Tween(Title,TweenInfo.new(0.65,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
				TextTransparency = 0,
				TextStrokeTransparency = 0.900,
				Position = UDim2.new(0.5, 0, 0, 5)
			})

			InterfaceManagerTable:Tween(Line,TweenInfo.new(0.75,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
				BackgroundTransparency = 0
			})

			InterfaceManagerTable:Tween(DropShadow,TweenInfo.new(0.55,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
				ImageTransparency = 0.5
			})

			InterfaceManagerTable:Tween(old_UICorner,TweenInfo.new(0.75,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
				CornerRadius = UDim.new(0,4)
			})

			InterfaceManagerTable:Tween(TextBox,TweenInfo.new(0.45,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
				TextTransparency = 0.400,
				Position = UDim2.new(0.5, 0, 0, 45)
			})

			InterfaceManagerTable:Tween(LoginFrame,TweenInfo.new(0.5,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
				BackgroundTransparency = 0,
				Position = UDim2.new(0.75, 0, 0.649999976, 0)
			})

			InterfaceManagerTable:Tween(ClickFrame,TweenInfo.new(0.5,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
				BackgroundTransparency = 0,
				Position = UDim2.new(0.25, 0, 0.649999976, 0)
			})

			InterfaceManagerTable:Tween(MainFrame,TweenInfo.new(0.75,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
				Size = UDim2.fromOffset(300,150)
			})
		end;

		local InputLogin = InterfaceManagerTable:InputButton(LoginFrame);
		local InputClick = InterfaceManagerTable:InputButton(ClickFrame);

		InputLogin.Modal = true;

		InputLogin.MouseButton1Click:Connect(function()
			if argsIndex.Auth then
				return;
			end;

			MakeLoad();

			argsIndex.Auth = true;

			if argsIndex.OnLogin(TextBox.Text) then
				event:Fire();
				return
			end;

			TextBox.Text = "";

			argsIndex.Auth = false;

			ToDefautl()
		end)
		
		local starterConnect = {};
		
		function starterConnect:Loading()
			MakeLoad();
		end;
		
		function starterConnect:Default()
			ToDefautl()
		end;
		
		function starterConnect:Cancel()
			event:Fire();
		end;
		
		task.delay(0.1,argsIndex.OnStart,starterConnect)

		InputClick.MouseButton1Click:Connect(function()
			argsIndex.OnClick()
		end)

		do
			local UIStroke = Instance.new("UIStroke")
			local UIGradient = Instance.new("UIGradient")

			UIStroke.Color = InterfaceManagerTable.Hightlight
			UIStroke.Parent = MainFrame
			UIStroke.Transparency = 1;

			UIGradient.Rotation = 180
			UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.00), NumberSequenceKeypoint.new(1.00, 1.00)}
			UIGradient.Parent = UIStroke

			local Thread = task.spawn(function()
				while true do task.wait()
					if argsIndex.Auth then
						InterfaceManagerTable:Tween(UIStroke,TweenInfo.new(0.5),{
							Transparency = 0;
						})
					else
						InterfaceManagerTable:Tween(UIStroke,TweenInfo.new(0.5),{
							Transparency = 1;
						})
					end;

					UIGradient.Rotation = UIGradient.Rotation + 4;
				end;
			end);

			event.Event:Wait();

			task.delay(1,function()
				task.cancel(Thread);
				task.wait(0.2)
				InterfaceManagerTable:Tween(UIStroke,TweenInfo.new(0.5),{
					Transparency = 1;
				})

				task.delay(0.5,function()
					UIStroke:Destroy()
				end)
			end)
		end;

		KNC_Interface.Busy = false

		InterfaceManagerTable:Tween(LoginFrame,TweenInfo.new(0.5,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
			BackgroundTransparency = 0,
			Position = UDim2.new(0.9, 0, 1.4, 0)
		})

		InterfaceManagerTable:Tween(Authorize,TweenInfo.new(0.5,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
			Size = UDim2.fromScale(0,0)
		})

		InterfaceManagerTable:Tween(ClickFrame,TweenInfo.new(0.5,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
			BackgroundTransparency = 0,
			Position = UDim2.new(0.1, 0, 1.4, 0)
		})

		InterfaceManagerTable:Tween(Title,TweenInfo.new(0.5,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
			TextTransparency = 1,
			TextStrokeTransparency = 1,
			Position = UDim2.new(0.5, 0, 0, 5)
		})

		InterfaceManagerTable:Tween(TextBox,TweenInfo.new(0.45,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
			Position = UDim2.new(0.5, 0, 0, 150)
		})

		InterfaceManagerTable:Tween(MainFrame,TweenInfo.new(1.25,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
			Size = args.Size
		})

		task.delay(0.65,function()
			Authorize:Destroy()
		end)

		task.delay(0.8,function()
			KNC_Interface:SetDefault()
		end)
	end;

	function KNC_Interface:SetHide()
		KNC_Interface.Ready = false;

		InterfaceManagerTable:Tween(buttonFrame,TweenInfo.new(0.6,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
			Position = UDim2.fromOffset(-50,0)
		})

		InterfaceManagerTable:Tween(Headers,TweenInfo.new(0.6,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
			Position = UDim2.fromOffset(0,-30)
		})

		InterfaceManagerTable:Tween(TMFrame,TweenInfo.new(0.45,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
			Position = UDim2.new(1, 37, 0, 27)
		})
	end;

	function KNC_Interface:SetDefault()
		KNC_Interface.Ready = true;

		InterfaceManagerTable:Tween(DropShadow,TweenInfo.new(0.55,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
			ImageTransparency = 0.5
		})

		InterfaceManagerTable:Tween(UICorner,TweenInfo.new(0.3,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
			CornerRadius = UDim.new(0,3)
		})

		InterfaceManagerTable:Tween(buttonFrame,TweenInfo.new(0.6,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
			Position = UDim2.fromScale(0,0)
		})

		InterfaceManagerTable:Tween(Headers,TweenInfo.new(0.6,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
			Position = UDim2.fromScale(0,0)
		})

		InterfaceManagerTable:Tween(TMFrame,TweenInfo.new(0.55,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
			Position = UDim2.new(0, 37, 0, 27)
		})
	end;

	KNC_Interface:SetDefault();

	function KNC_Interface:AddTab(args)
		args = args or {};
		args.Title = args.Title or "Tab";
		args.Icon = args.Icon or "home";
		args.Type = args.Type or "Multiple";

		local KNC_Tab = {};

		local TabInput = Instance.new("Frame")
		local Icon = Instance.new("ImageLabel")
		local TextLabel = Instance.new("TextLabel")
		local TabFrame = Instance.new("Frame");
		local EventSlide = Instance.new('BoolValue',TabInput);

		EventSlide.Name = 'Enabled';

		TabInput.Name = "TabInput"
		TabInput.Parent = buttonFrameMain
		TabInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TabInput.BackgroundTransparency = 1.000
		TabInput.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabInput.BorderSizePixel = 0
		TabInput.Size = UDim2.new(0, 125, 0, 25)
		TabInput.ZIndex = 37

		Icon.Name = "Icon"
		Icon.Parent = TabInput
		Icon.AnchorPoint = Vector2.new(0, 0.5)
		Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Icon.BackgroundTransparency = 1.000
		Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Icon.BorderSizePixel = 0
		Icon.Position = UDim2.new(0, 4, 0.5, 0)
		Icon.Size = UDim2.new(0.899999976, 0, 0.899999976, 0)
		Icon.SizeConstraint = Enum.SizeConstraint.RelativeYY
		Icon.ZIndex = 37
		Icon.Image = InterfaceManagerTable:FetchIcon(args.Icon) or tostring(args.Icon);

		TextLabel.Parent = TabInput
		TextLabel.AnchorPoint = Vector2.new(0, 0.5)
		TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.BackgroundTransparency = 1.000
		TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextLabel.BorderSizePixel = 0
		TextLabel.Position = UDim2.new(0, 33, 0.5, 0)
		TextLabel.Size = UDim2.new(1, 0, 0.5, 0)
		TextLabel.ZIndex = 37
		TextLabel.Font = Enum.Font.GothamMedium
		TextLabel.Text = args.Title
		TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.TextSize = 14.000
		TextLabel.TextTransparency = 0.150
		TextLabel.TextWrapped = true
		TextLabel.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel.RichText = true;

		local CallFunction = function(value)

			EventSlide.Value = value;

			if value then
				InterfaceManagerTable:Tween(Icon , TweenInfo.new(0.1) , {
					ImageTransparency = 0,
				})

				InterfaceManagerTable:Tween(TextLabel , TweenInfo.new(0.1) , {
					TextTransparency = 0.150
				})

				InterfaceManagerTable:Tween(TabFrame , TweenInfo.new(0.35 , Enum.EasingStyle.Quint) , {
					Position = UDim2.fromScale(0.5,0.5),
					Size = UDim2.fromScale(1,1)
				})


				TabFrame.Visible = true
			else
				TabFrame.Visible = false

				InterfaceManagerTable:Tween(TabFrame , TweenInfo.new(0.35, Enum.EasingStyle.Quint) , {
					Position = UDim2.fromScale(0.5,0.6),
					Size = UDim2.new(1,-11,1,-11)
				})

				InterfaceManagerTable:Tween(Icon , TweenInfo.new(0.1) , {
					ImageTransparency = 0.4,
				})

				InterfaceManagerTable:Tween(TextLabel , TweenInfo.new(0.1) , {
					TextTransparency = 0.5
				})
			end;
		end;

		TabFrame.Name = "TabFrame"
		TabFrame.Parent = TMFrame
		TabFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TabFrame.BackgroundTransparency = 1.000
		TabFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabFrame.BorderSizePixel = 0
		TabFrame.Size = UDim2.new(1, 0, 1, 0)
		TabFrame.ZIndex = 3
		TabFrame.AnchorPoint = Vector2.new(0.5,0.5)
		TabFrame.Position = UDim2.fromScale(0.5,0.5)

		if args.Type == "Single" then
			local Center = Instance.new("ScrollingFrame")
			local UIListLayout = Instance.new("UIListLayout")

			Center.Name = "Center"
			Center.Parent = TabFrame
			Center.Active = true
			Center.AnchorPoint = Vector2.new(0.5, 0.5)
			Center.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Center.BackgroundTransparency = 1.000
			Center.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Center.BorderSizePixel = 0
			Center.ClipsDescendants = false
			Center.Position = UDim2.new(0.5, 0, 0.5, 0)
			Center.Size = UDim2.new(1, 0, 1, -5)
			Center.ZIndex = 5
			Center.ScrollBarThickness = 0
			Center.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left

			UIListLayout.Parent = Center
			UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Padding = UDim.new(0, 500)

			InterfaceManagerTable:Tween(UIListLayout,TweenInfo.new(2,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
				Padding = UDim.new(0, 5)
			})

			UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
				Center.CanvasSize = UDim2.fromOffset(0,UIListLayout.AbsoluteContentSize.Y)
			end)

			KNC_Tab = InterfaceManagerTable:CreateInstances(Center , EventSlide)
		elseif args.Type == "Multiple" then
			local Left = Instance.new("ScrollingFrame")
			local UIListLayout = Instance.new("UIListLayout")
			local Right = Instance.new("ScrollingFrame")
			local UIListLayout_2 = Instance.new("UIListLayout")

			Left.Name = "Left"
			Left.Parent = TabFrame
			Left.Active = true
			Left.AnchorPoint = Vector2.new(0.5, 0.5)
			Left.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Left.BackgroundTransparency = 1.000
			Left.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Left.BorderSizePixel = 0
			Left.ClipsDescendants = false
			Left.Position = UDim2.new(0.25, 0, 0.5, 0)
			Left.Size = UDim2.new(0.5, 0, 1, -2)
			Left.ZIndex = 5
			Left.ScrollBarThickness = 0
			Left.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left

			UIListLayout.Parent = Left
			UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Padding = UDim.new(0, 5)

			UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
				Left.CanvasSize = UDim2.fromOffset(0,UIListLayout.AbsoluteContentSize.Y)
			end)


			Right.Name = "Right"
			Right.Parent = TabFrame
			Right.Active = true
			Right.AnchorPoint = Vector2.new(0.5, 0.5)
			Right.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Right.BackgroundTransparency = 1.000
			Right.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Right.BorderSizePixel = 0
			Right.ClipsDescendants = false
			Right.Position = UDim2.new(0.75, 0, 0.5, 0)
			Right.Size = UDim2.new(0.5, 0, 1, -2)
			Right.ZIndex = 5
			Right.ScrollBarThickness = 0

			UIListLayout_2.Parent = Right
			UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout_2.Padding = UDim.new(0, 5)

			UIListLayout_2:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
				Right.CanvasSize = UDim2.fromOffset(0,UIListLayout_2.AbsoluteContentSize.Y)
			end)

			KNC_Tab.Left = InterfaceManagerTable:CreateInstances(Left , EventSlide);
			KNC_Tab.Right = InterfaceManagerTable:CreateInstances(Right , EventSlide);
		elseif args.Type == 'Chat' then

			args.ChatName = args.ChatName or "@General";
			args.Placeholder = args.Placeholder or "@General";

			local ChatFace = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local UIStroke = Instance.new("UIStroke")
			local Content = Instance.new("TextLabel")
			local Line = Instance.new("Frame")
			local Buttons = Instance.new("Frame")
			local UIListLayout = Instance.new("UIListLayout")
			local ScrollingFrame = Instance.new("ScrollingFrame")
			local UICorner_2 = Instance.new("UICorner")
			local UIStroke_2 = Instance.new("UIStroke")
			local UIListLayout_2 = Instance.new("UIListLayout")
			local InputType = Instance.new("Frame")
			local UICorner_3 = Instance.new("UICorner")
			local UIStroke_3 = Instance.new("UIStroke")
			local TextBox = Instance.new("TextBox")
			local Frame = Instance.new("Frame")
			local SendButton = Instance.new("ImageButton")

			ChatFace.Name = "ChatFace"
			ChatFace.Parent = TabFrame
			ChatFace.AnchorPoint = Vector2.new(0.5, 0.5)
			ChatFace.BackgroundColor3 = Color3.fromRGB(26, 26, 28)
			ChatFace.BackgroundTransparency = 0.500
			ChatFace.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ChatFace.BorderSizePixel = 0
			ChatFace.Position = UDim2.new(0.5, 0, 0.5, 0)
			ChatFace.Size = UDim2.new(1, -5, 1, -5)
			ChatFace.ZIndex = 8

			UICorner.CornerRadius = UDim.new(0, 3)
			UICorner.Parent = ChatFace

			UIStroke.Transparency = 0.500
			UIStroke.Color = Color3.fromRGB(24, 24, 24)
			UIStroke.Parent = ChatFace

			Content.Name = "Content"
			Content.Parent = ChatFace
			Content.AnchorPoint = Vector2.new(0.5, 0)
			Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Content.BackgroundTransparency = 1.000
			Content.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Content.BorderSizePixel = 0
			Content.Position = UDim2.new(0.5, 0, 0, 10)
			Content.Size = UDim2.new(1, -10, 0, 10)
			Content.ZIndex = 8
			Content.Font = Enum.Font.GothamMedium
			Content.Text = args.ChatName
			Content.TextColor3 = Color3.fromRGB(255, 255, 255)
			Content.TextSize = 14.000
			Content.TextStrokeTransparency = 0.900
			Content.TextTransparency = 0.200
			Content.TextXAlignment = Enum.TextXAlignment.Left
			Content.RichText = true

			Line.Name = "Line"
			Line.Parent = ChatFace
			Line.AnchorPoint = Vector2.new(0.5, 0)
			Line.BackgroundColor3 = Color3.fromRGB(38, 38, 44)
			Line.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Line.BorderSizePixel = 0
			Line.Position = UDim2.new(0.5, 0, 0, 35)
			Line.Size = UDim2.new(1, -10, 0, 1)
			Line.ZIndex = 9

			Buttons.Name = "Buttons"
			Buttons.Parent = ChatFace
			Buttons.AnchorPoint = Vector2.new(1, 0)
			Buttons.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Buttons.BackgroundTransparency = 1.000
			Buttons.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Buttons.BorderSizePixel = 0
			Buttons.Position = UDim2.new(1, -5, 0, 5)
			Buttons.Size = UDim2.new(0, 150, 0, 25)
			Buttons.ZIndex = 9

			UIListLayout.Parent = Buttons
			UIListLayout.FillDirection = Enum.FillDirection.Horizontal
			UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
			UIListLayout.Padding = UDim.new(0, 5)

			ScrollingFrame.Parent = ChatFace
			ScrollingFrame.Active = true
			ScrollingFrame.AnchorPoint = Vector2.new(0.5, 0)
			ScrollingFrame.BackgroundColor3 = Color3.fromRGB(23, 23, 25)
			ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ScrollingFrame.BorderSizePixel = 0
			ScrollingFrame.Position = UDim2.new(0.5, 0, 0, 42)
			ScrollingFrame.Size = UDim2.new(1, -10, 1, -80)
			ScrollingFrame.ZIndex = 10
			ScrollingFrame.BottomImage = ""
			ScrollingFrame.ScrollBarThickness = 2
			ScrollingFrame.TopImage = ""

			UICorner_2.CornerRadius = UDim.new(0, 3)
			UICorner_2.Parent = ScrollingFrame

			UIStroke_2.Transparency = 0.500
			UIStroke_2.Color = Color3.fromRGB(35, 35, 35)
			UIStroke_2.Parent = ScrollingFrame

			UIListLayout_2:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
				ScrollingFrame.CanvasSize = UDim2.fromOffset(0,UIListLayout_2.AbsoluteContentSize.Y + 10)
			end)

			UIListLayout_2.Parent = ScrollingFrame
			UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder

			InputType.Name = "InputType"
			InputType.Parent = ChatFace
			InputType.AnchorPoint = Vector2.new(0.5, 1)
			InputType.BackgroundColor3 = Color3.fromRGB(23, 23, 25)
			InputType.BorderColor3 = Color3.fromRGB(0, 0, 0)
			InputType.BorderSizePixel = 0
			InputType.Position = UDim2.new(0.5, 0, 1, -2)
			InputType.Size = UDim2.new(1, -10, 0, 31)
			InputType.ZIndex = 12

			UICorner_3.CornerRadius = UDim.new(0, 4)
			UICorner_3.Parent = InputType

			UIStroke_3.Color = Color3.fromRGB(29, 29, 29)
			UIStroke_3.Parent = InputType

			TextBox.Parent = InputType
			TextBox.AnchorPoint = Vector2.new(0, 0.5)
			TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextBox.BackgroundTransparency = 1.000
			TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TextBox.BorderSizePixel = 0
			TextBox.Position = UDim2.new(0, 10, 0.5, 0)
			TextBox.Size = UDim2.new(1, -45, 0.649999976, 0)
			TextBox.ZIndex = 13
			TextBox.ClearTextOnFocus = false
			TextBox.Font = Enum.Font.GothamMedium
			TextBox.PlaceholderText = args.Placeholder
			TextBox.Text = ""
			TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextBox.TextSize = 14.000
			TextBox.TextTransparency = 0.400
			TextBox.TextXAlignment = Enum.TextXAlignment.Left

			Frame.Parent = InputType
			Frame.AnchorPoint = Vector2.new(1, 0.5)
			Frame.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
			Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Frame.BorderSizePixel = 0
			Frame.Position = UDim2.new(1, -30, 0.5, 0)
			Frame.Size = UDim2.new(0, 1, 1, -5)
			Frame.ZIndex = 13

			SendButton.Name = "SendButton"
			SendButton.Parent = InputType
			SendButton.AnchorPoint = Vector2.new(1, 0.5)
			SendButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SendButton.BackgroundTransparency = 1.000
			SendButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SendButton.BorderSizePixel = 0
			SendButton.Position = UDim2.new(1, -3, 0.5, 0)
			SendButton.Size = UDim2.new(0.75, 0, 0.75, 0)
			SendButton.SizeConstraint = Enum.SizeConstraint.RelativeYY
			SendButton.ZIndex = 15
			SendButton.Image = "rbxassetid://76645474804869"
			SendButton.ImageTransparency = 0.300;


			local TweenInfoMain = TweenInfo.new(0.35,Enum.EasingStyle.Quint , Enum.EasingDirection.InOut);


			EventSlide:GetPropertyChangedSignal('Value'):Connect(function()
				if EventSlide.Value then
					InterfaceManagerTable:Tween(SendButton,TweenInfoMain,{
						ImageTransparency = 0.300,
					})

					InterfaceManagerTable:Tween(Frame,TweenInfoMain,{
						BackgroundTransparency = 0,
					})

					InterfaceManagerTable:Tween(Content,TweenInfoMain,{
						TextStrokeTransparency = 0.9,
						TextTransparency = 0.200
					})

					InterfaceManagerTable:Tween(ChatFace,TweenInfoMain,{
						BackgroundTransparency = 0.5,
					})

					InterfaceManagerTable:Tween(ScrollingFrame,TweenInfoMain,{
						BackgroundTransparency = 0,
					})

					InterfaceManagerTable:Tween(InputType,TweenInfoMain,{
						BackgroundTransparency = 0,
					})

					InterfaceManagerTable:Tween(TextBox,TweenInfoMain,{
						TextTransparency = 0.4,
					})
				else
					InterfaceManagerTable:Tween(SendButton,TweenInfo.new(0.4),{
						ImageTransparency = 1,
					})

					InterfaceManagerTable:Tween(Frame,TweenInfo.new(0.4),{
						BackgroundTransparency = 1,
					})

					InterfaceManagerTable:Tween(Content,TweenInfo.new(0.4),{
						TextStrokeTransparency = 1,
						TextTransparency = 1
					})

					InterfaceManagerTable:Tween(ChatFace,TweenInfo.new(0.4),{
						BackgroundTransparency = 1,
					})

					InterfaceManagerTable:Tween(ScrollingFrame,TweenInfo.new(0.4),{
						BackgroundTransparency = 1,
					})

					InterfaceManagerTable:Tween(InputType,TweenInfo.new(0.4),{
						BackgroundTransparency = 1,
					})

					InterfaceManagerTable:Tween(TextBox,TweenInfo.new(0.4),{
						TextTransparency = 1,
					})
				end;
			end);

			function KNC_Tab:ClearMessage()
				for i,v in next, ScrollingFrame:GetChildren() do
					if v:IsA('Frame') then
						v:Destroy()
					end
				end
			end;

			function KNC_Tab:SendMessage(option)
				option.Profile = option.Profile or 'rbxassetid://15011943540';
				option.Username = option.Username or "Unknow";
				option.Content = option.Content;

				local MainMessage = Instance.new("Frame")
				local Profile = Instance.new("Frame")
				local Icon = Instance.new("ImageLabel")
				local UICorner = Instance.new("UICorner")
				local TextLabel = Instance.new("TextLabel")
				local Content = Instance.new("TextLabel")

				MainMessage.Name = "MainMessage"
				MainMessage.Parent = ScrollingFrame
				MainMessage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				MainMessage.BackgroundTransparency = 1.000
				MainMessage.BorderColor3 = Color3.fromRGB(0, 0, 0)
				MainMessage.BorderSizePixel = 0
				MainMessage.Size = UDim2.new(1, -10, 0, 15)
				MainMessage.ZIndex = 11
				MainMessage.ClipsDescendants = true

				Profile.Name = "Profile"
				Profile.Parent = MainMessage
				Profile.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Profile.BackgroundTransparency = 1.000
				Profile.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Profile.BorderSizePixel = 0
				Profile.Size = UDim2.new(1, 0, 0, 25)
				Profile.ZIndex = 11

				Icon.Name = "Icon"
				Icon.Parent = Profile
				Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Icon.BackgroundTransparency = 1.000
				Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Icon.BorderSizePixel = 0
				Icon.Size = UDim2.new(1, 0, 1, 0)
				Icon.SizeConstraint = Enum.SizeConstraint.RelativeYY
				Icon.ZIndex = 12
				Icon.Image = option.Profile

				UICorner.CornerRadius = UDim.new(1, 0)
				UICorner.Parent = Icon

				TextLabel.Parent = Profile
				TextLabel.AnchorPoint = Vector2.new(0, 0.5)
				TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel.BackgroundTransparency = 1.000
				TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TextLabel.BorderSizePixel = 0
				TextLabel.Position = UDim2.new(0, 30, 0.5, 0)
				TextLabel.Size = UDim2.new(1, 0, 0.5, 0)
				TextLabel.ZIndex = 12
				TextLabel.Font = Enum.Font.GothamMedium
				TextLabel.Text = option.Username
				TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel.TextSize = 12.000
				TextLabel.TextTransparency = 0.200
				TextLabel.TextXAlignment = Enum.TextXAlignment.Left
				TextLabel.RichText = true

				Content.Name = "Content"
				Content.Parent = MainMessage
				Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Content.BackgroundTransparency = 1.000
				Content.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Content.BorderSizePixel = 0
				Content.Position = UDim2.new(0, 30, 0, 26)
				Content.Size = UDim2.new(1, 0, 0, 30)
				Content.ZIndex = 13
				Content.Font = Enum.Font.GothamMedium
				Content.Text = option.Content
				Content.TextColor3 = Color3.fromRGB(255, 255, 255)
				Content.TextSize = 10.000
				Content.TextTransparency = 0.500
				Content.TextXAlignment = Enum.TextXAlignment.Left
				Content.TextYAlignment = Enum.TextYAlignment.Top
				Content.RichText = true

				local upd = function()
					local isze = InterfaceManagerTable:GetTextSize(Content.Text,Content.TextSize,Content.Font);

					InterfaceManagerTable:Tween(MainMessage,TweenInfo.new(0.1),{
						Size = UDim2.new(1, -10, 0, 30 + isze.Y)
					})

					InterfaceManagerTable:Tween(Content,TweenInfo.new(0.1),{
						Size = UDim2.new(1, 0, 0, isze.Y + 5)
					})
				end;

				upd();
			end;

			function KNC_Tab:OnMessage(callback)
				TextBox.FocusLost:Connect(function(a)
					if a then
						if not TextBox.Text:byte() then
							return
						end;

						callback(TextBox.Text);
						TextBox.Text = "";
					end;
				end)

				SendButton.MouseButton1Click:Connect(function()
					if not TextBox.Text:byte() then
						return
					end;

					callback(TextBox.Text);
					TextBox.Text = "";
				end)
			end;

			function KNC_Tab:AddButton(option)
				option.Title = option.Title or "Button";
				option.Callback = option.Callback or function() end;

				local ButtonFrame = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local UIStroke = Instance.new("UIStroke")
				local Text = Instance.new("TextLabel")

				ButtonFrame.Name = "ButtonFrame"
				ButtonFrame.Parent = Buttons
				ButtonFrame.AnchorPoint = Vector2.new(0.5, 0.5)
				ButtonFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 21)
				ButtonFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ButtonFrame.BorderSizePixel = 0
				ButtonFrame.Position = UDim2.new(0.75, 0, 0.649999976, 0)
				ButtonFrame.Size = UDim2.new(0.899999976, 65, 0.899999976, 0)
				ButtonFrame.SizeConstraint = Enum.SizeConstraint.RelativeYY

				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = ButtonFrame

				UIStroke.Color = Color3.fromRGB(29, 29, 29)
				UIStroke.Parent = ButtonFrame

				Text.Name = "Text"
				Text.Parent = ButtonFrame
				Text.AnchorPoint = Vector2.new(0.5, 0.5)
				Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Text.BackgroundTransparency = 1.000
				Text.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Text.BorderSizePixel = 0
				Text.Position = UDim2.new(0.5, 0, 0.5, 0)
				Text.Size = UDim2.new(1, 0, 0.5, 0)
				Text.Font = Enum.Font.GothamMedium
				Text.Text = option.Title
				Text.TextColor3 = Color3.fromRGB(255, 255, 255)
				Text.TextSize = 14.000
				Text.TextTransparency = 0.200

				local uptext = function()
					local siz = InterfaceManagerTable:GetTextSize(Text.Text , Text.TextSize , Text.Font);

					if siz then
						InterfaceManagerTable:Tween(ButtonFrame,TweenInfo.new(0.1),{
							Size = UDim2.new(0, siz.X + 10, 0.899999976, 0)
						})
					end;
				end;

				local input = InterfaceManagerTable:InputButton(ButtonFrame);

				input.MouseEnter:Connect(function()
					InterfaceManagerTable:Tween(Text,TweenInfo.new(0.1),{
						TextTransparency = 0
					})

					InterfaceManagerTable:Tween(UIStroke,TweenInfo.new(0.1),{
						Color = Color3.fromRGB(33, 33, 33)
					})
				end);

				input.MouseLeave:Connect(function()

					InterfaceManagerTable:Tween(Text,TweenInfo.new(0.1),{
						TextTransparency = 0.2
					})

					InterfaceManagerTable:Tween(UIStroke,TweenInfo.new(0.1),{
						Color = Color3.fromRGB(29, 29, 29)
					})
				end)

				input.MouseButton1Click:Connect(function()

					InterfaceManagerTable:NewRipple(input)

					option.Callback(option);
				end);

				uptext();

				function option:Title(new)

					Text.Text = new;

					uptext();
				end;

				function option:Visible(new)
					ButtonFrame.Visible = new;
				end;

				return option;
			end;


		end;

		KNC_Interface.Tabs[TabInput] = CallFunction;

		CallFunction(KNC_Interface.FirstTab)

		if KNC_Interface.FirstTab then
			KNC_Interface.FirstTab = false;
			KNC_Interface.TabSelected = TabInput;
		end;

		local Input = InterfaceManagerTable:InputButton(TabInput);

		Input.ZIndex = 199

		Input.MouseButton1Click:Connect(function()
			KNC_Interface.TabSelected = TabInput;

			for i,v in next , KNC_Interface.Tabs do
				if i == TabInput then
					v(true)
				else
					v(false)
				end;
			end;
		end)

		function KNC_Tab:Select()
			KNC_Interface.TabSelected = TabInput;

			for i,v in next , KNC_Interface.Tabs do
				if i == TabInput then
					v(true)
				else
					v(false)
				end;
			end;
		end;

		return KNC_Tab;
	end;

	local function ScreenCheck()
		local screenSize = Interface.AbsoluteSize
		local elementPosition = (KNC_Interface.SavedPosition and Vector2.new(KNC_Interface.SavedPosition.X.Offset,KNC_Interface.SavedPosition.Y.Offset)) or MainFrame.AbsolutePosition
		local elementSize = Vector2.new(args.Size.X.Offset,args.Size.Y.Offset)

		local isOutX = ((elementPosition.X + elementSize.X) <= 100) or (elementPosition.X >= (screenSize.X - 655))
		local isOutY = ((elementPosition.Y + elementSize.Y) <= 100) or (elementPosition.Y >= (screenSize.Y - 655))

		return isOutX or isOutY
	end

	local UpdateScreen = function()
		if KNC_Interface.Toggle then
			if KNC_Interface.FullScreen then
				InterfaceManagerTable:Tween(MainFrame , TweenInfo.new(0.65 , Enum.EasingStyle.Quint),{
					Position = UDim2.fromScale(0.5,0.5),
					Size = UDim2.fromScale(1,1)
				})
			else

				if KNC_Interface.SavedPosition and ScreenCheck() then
					KNC_Interface.SavedPosition = nil
				end;

				InterfaceManagerTable:Tween(MainFrame , TweenInfo.new(0.65 , Enum.EasingStyle.Quint ),{
					Position = KNC_Interface.SavedPosition or UDim2.fromScale(0.5,0.5),
					Size = args.Size
				})
			end;

			KNC_Interface:SetDefault();
		else

			KNC_Interface:SetHide();

			local InterfaceSize = InterfaceManagerTable:GetTextSize(Title.Text , Title.TextSize , Title.Font)

			InterfaceManagerTable:Tween(MainFrame,TweenInfo.new(0.75, Enum.EasingStyle.Quint),{
				Size = UDim2.fromOffset(InterfaceSize.X + 100,25),
				Position = UDim2.fromOffset(MainFrame.AbsolutePosition.X + (MainFrame.AbsoluteSize.X / 2),MainFrame.AbsolutePosition.Y)
			})

			InterfaceManagerTable:Tween(Headers,TweenInfo.new(0.5, Enum.EasingStyle.Quint),{
				Position = UDim2.fromOffset(0,0),
			})
		end;
	end;

	MaxButton.MouseButton1Click:Connect(function()
		if not 	KNC_Interface.Toggle then
			return;
		end;

		KNC_Interface.FullScreen = not KNC_Interface.FullScreen;

		UpdateScreen()
	end)

	MinButton.MouseButton1Click:Connect(function()
		KNC_Interface.Toggle = not KNC_Interface.Toggle;

		UpdateScreen()

		if KNC_Interface.Toggle then
			InterfaceManagerTable:Tween(MainFrame,TweenInfo.new(0.65, Enum.EasingStyle.Quint),{
				Position = UDim2.fromScale(0.5,0.5),
			})
		end
	end)

	game:GetService('UserInputService').InputBegan:Connect(function(a,f)
		if not f and a.KeyCode == args.Keybind and not KNC_Interface.Busy then
			KNC_Interface.Toggle = not KNC_Interface.Toggle;

			UpdateScreen()

			if KNC_Interface.Toggle then
				InterfaceManagerTable:Tween(MainFrame,TweenInfo.new(0.65, Enum.EasingStyle.Quint),{
					Position = UDim2.fromScale(0.5,0.5),
				})
			end;
		end;
	end)

	task.spawn(function()
		while true do task.wait(0.001)
			if KNC_Interface.TabSelected then
				if not KNC_Interface.IsOpenTab then
					InterfaceManagerTable:Tween(Hightlight , TweenInfo.new(0.075),{
						BackgroundTransparency = 0,
						Size = UDim2.new(0, 30, 0, 30)
					})
				else
					InterfaceManagerTable:Tween(Hightlight , TweenInfo.new(0.075),{
						BackgroundTransparency = 0,
						Size = UDim2.new(0, 130, 0, 30)
					})
				end;

				InterfaceManagerTable:Tween(ImageLabel , TweenInfo.new(0.2),{
					ImageTransparency = 0.6
				})

				local Selected = KNC_Interface.Tabs[KNC_Interface.TabSelected];
				if Selected then
					local SelectedFrame : Frame = KNC_Interface.TabSelected;
					local X = SelectedFrame.AbsolutePosition.X - buttonFrame.AbsolutePosition.X;
					local Y = SelectedFrame.AbsolutePosition.Y - (buttonFrame.AbsolutePosition.Y + 3);

					InterfaceManagerTable:Tween(Hightlight , TweenInfo.new(0.1 , Enum.EasingStyle.Quint),{
						Position = UDim2.fromOffset(math.round(X) , math.round(Y))
					})
				end;
			else
				InterfaceManagerTable:Tween(Hightlight , TweenInfo.new(0.2),{
					BackgroundTransparency = 1,
					Size = UDim2.new(0, 20, 0, 20)
				})

				InterfaceManagerTable:Tween(ImageLabel , TweenInfo.new(0.2),{
					ImageTransparency = 1
				})
			end;

			if BlackFrame.BackgroundTransparency >= 0.99 then
				BlackFrame.Visible = false
			else
				BlackFrame.Visible = true
			end
		end;
	end);

	local dragToggle = nil
	local dragSpeed = 0.2
	local dragStart = nil
	local startPos = nil

	local function updateInput(input)
		local delta = input.Position - dragStart
		local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y);

		if KNC_Interface.FullScreen and KNC_Interface.Toggle then
			InterfaceManagerTable:Tween(MainFrame , TweenInfo.new(0.4 , Enum.EasingStyle.Quint ),{
				Position = KNC_Interface.SavedPosition or UDim2.fromScale(0.5,0.5),
				Size = args.Size
			});

			KNC_Interface.FullScreen = false;
		end;

		KNC_Interface.SavedPosition = position;

		game:GetService('TweenService'):Create(MainFrame, TweenInfo.new(dragSpeed), {Position = position}):Play()
	end

	Headers.InputBegan:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
			dragToggle = true;
			dragStart = input.Position;
			startPos = MainFrame.Position;
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragToggle = false;
				end;
			end);
		end;
	end);

	do
		local Resize = Instance.new("TextButton")
		local IsHold = false;

		Resize.Name = "Resize"
		Resize.Parent = MainFrame
		Resize.AnchorPoint = Vector2.new(0.5, 0.5)
		Resize.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Resize.BackgroundTransparency = 1.000
		Resize.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Resize.BorderSizePixel = 0
		Resize.Position = UDim2.new(1, 0, 1, 0)
		Resize.Rotation = 0.010
		Resize.Size = UDim2.new(0.075000003, 0, 0.075000003, 0)
		Resize.SizeConstraint = Enum.SizeConstraint.RelativeYY
		Resize.ZIndex = 100
		Resize.Font = Enum.Font.SourceSans
		Resize.Text = ""
		Resize.TextColor3 = Color3.fromRGB(0, 0, 0)
		Resize.TextSize = 14.000

		Resize.InputBegan:Connect(function(std)
			if std.UserInputType == Enum.UserInputType.MouseButton1 or std.UserInputType == Enum.UserInputType.Touch then
				KNC_Interface.HoldResize = true
				if InterfaceManagerTable.InputService.TouchEnabled then
					Resize.Size = UDim2.new(0.15000003, 85, 0.15000003, 85)
				end
			end
		end)

		Resize.InputEnded:Connect(function(std)
			if std.UserInputType == Enum.UserInputType.MouseButton1 or std.UserInputType == Enum.UserInputType.Touch then
				KNC_Interface.HoldResize = false
				Resize.Size = UDim2.new(0.075000003, 0, 0.075000003, 0)
			end
		end)
	end

	InterfaceManagerTable.InputService.InputChanged:Connect(function(input)
		if KNC_Interface.HoldResize and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			if KNC_Interface.Toggle and not KNC_Interface.FullScreen and KNC_Interface.Ready then
				local pios = input.Position;

				local x = (pios.X - MainFrame.AbsolutePosition.X) 
				local y = (pios.Y - MainFrame.AbsolutePosition.Y) 

				if x < 460 then x = 460; end;
				if y < 310 then y = 310; end;

				local Offset = UDim2.new(0,x,0,y)
				local plus = UDim2.fromOffset(-(MainFrame.AbsoluteSize.X - x) / 2, -(MainFrame.AbsoluteSize.Y - y) / 2);

				args.Size = Offset

				InterfaceManagerTable:Tween(MainFrame , TweenInfo.new(0.1),{
					Size = Offset,
					Position = MainFrame.Position + plus,
				})

				KNC_Interface.SavedPosition = MainFrame.Position + plus
			end
		end;


		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			if dragToggle then
				updateInput(input)
			end
		end
	end)

	return KNC_Interface;
end;

function InterfaceManagerTable:Notifier()
	local Notifier = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")

	Notifier.Name = "Notifier"
	Notifier.Parent = InterfaceManagerTable.ScreenGui
	Notifier.AnchorPoint = Vector2.new(1, 1)
	Notifier.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Notifier.BackgroundTransparency = 1.000
	Notifier.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Notifier.BorderSizePixel = 0
	Notifier.Position = UDim2.new(1, -5, 1, -5)
	Notifier.Size = UDim2.new(0, 100, 0, 100)

	UIListLayout.Parent = Notifier
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
	UIListLayout.Padding = UDim.new(0,5);

	return {
		new = function(args)
			args = args or {};
			args.Title = args.Title or "Notification";
			args.Description = args.Description or nil;
			args.Duration = args.Duration or 5;

			local Notify = Instance.new("Frame")
			local DropShadow = Instance.new("ImageLabel")
			local UICorner = Instance.new("UICorner")
			local UIStroke = Instance.new("UIStroke")
			local Title = Instance.new("TextLabel")
			local Description = Instance.new("TextLabel")

			Notify.Name = "Notify"
			Notify.Parent = Notifier
			Notify.BackgroundColor3 = Color3.fromRGB(38, 38, 44)
			Notify.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Notify.BorderSizePixel = 0
			Notify.Size = UDim2.new(0, 0, 0, 0)
			Notify.ClipsDescendants = true

			DropShadow.Name = "DropShadow"
			DropShadow.Parent = Notify
			DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
			DropShadow.BackgroundTransparency = 1.000
			DropShadow.BorderSizePixel = 0
			DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
			DropShadow.Rotation = 0.001
			DropShadow.Size = UDim2.new(1, 40, 1, 40)
			DropShadow.ZIndex = -1
			DropShadow.Image = "rbxassetid://6015897843"
			DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
			DropShadow.ImageTransparency =1
			DropShadow.ScaleType = Enum.ScaleType.Slice
			DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)
			DropShadow.Rotation = 0.001

			InterfaceManagerTable:Tween(DropShadow,TweenInfo.new(0.5),{
				ImageTransparency = 0.500
			})

			UICorner.CornerRadius = UDim.new(0, 4)
			UICorner.Parent = Notify

			UIStroke.Color = Color3.fromRGB(29, 29, 29)
			UIStroke.Parent = Notify

			Title.Name = "Title"
			Title.Parent = Notify
			Title.AnchorPoint = Vector2.new(0.5, 0)
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Position = UDim2.new(0.5, 0, 0, 3)
			Title.Size = UDim2.new(1, -8, 0, 15)
			Title.Font = Enum.Font.GothamMedium
			Title.Text = args.Title
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextSize = 14.000
			Title.TextStrokeTransparency = 0.900
			Title.TextXAlignment = Enum.TextXAlignment.Left
			Title.RichText = true

			if args.Description then
				Description.Name = "Description"
				Description.Parent = Notify
				Description.AnchorPoint = Vector2.new(0.5, 0)
				Description.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Description.BackgroundTransparency = 1.000
				Description.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Description.BorderSizePixel = 0
				Description.Position = UDim2.new(0.5, 0, 0, 18)
				Description.Size = UDim2.new(1, -8, 0, 15)
				Description.Font = Enum.Font.GothamMedium
				Description.Text = tostring(args.Description)
				Description.TextColor3 = Color3.fromRGB(255, 255, 255)
				Description.TextSize = 11.000
				Description.TextStrokeTransparency = 0.900
				Description.TextTransparency = 0.400
				Description.TextXAlignment = Enum.TextXAlignment.Left
				Description.TextYAlignment = Enum.TextYAlignment.Top
				Description.RichText = true
			else
				Description.Text = '';
			end;

			local update = function()
				local size1 = InterfaceManagerTable:GetTextSize(Title.Text,Title.TextSize,Title.Font);
				local size2 = InterfaceManagerTable:GetTextSize(Description.Text,Description.TextSize,Description.Font);

				if args.Description then
					local bt = ((size1.X > size2.X) and size1.X) or size2.X;

					InterfaceManagerTable:Tween(Notify,TweenInfo.new(0.3,Enum.EasingStyle.Quint),{
						Size = UDim2.new(0, bt + 45, 0, size1.Y + size2.Y + 10)
					})
				else
					InterfaceManagerTable:Tween(Notify,TweenInfo.new(0.3,Enum.EasingStyle.Quint),{
						Size = UDim2.new(0, size1.X + 45, 0, size1.Y)
					})
				end;
			end;

			local destroy = function()
				InterfaceManagerTable:Tween(Notify,TweenInfo.new(0.8,Enum.EasingStyle.Quint),{
					Size = UDim2.new(0, 0 , 0 ,0)
				})

				InterfaceManagerTable:Tween(DropShadow,TweenInfo.new(0.5),{
					ImageTransparency = 1
				})

				task.delay(0.5,function()
					InterfaceManagerTable:Tween(Notify,TweenInfo.new(0.4,Enum.EasingStyle.Quint),{
						BackgroundTransparency = 1
					})

					InterfaceManagerTable:Tween(UIStroke,TweenInfo.new(0.4,Enum.EasingStyle.Quint),{
						Transparency = 1
					})
				end)

				task.delay(0.85,function()
					Notify:Destroy()
				end)
			end;

			update();

			task.delay(args.Duration,destroy)

			return {
				Destroy = destroy,
			}
		end,
	}
end;

return InterfaceManagerTable; -- read only
