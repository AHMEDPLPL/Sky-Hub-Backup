--[[
  THIS IS A TESTING LOADSTRING, EXPECT BUGS!
  THIS IS A TESTING LOADSTRING, EXPECT BUGS!
  
   cmd v1.0
   github - lxte/cmd
   
   todo: (so i remember lol)
   
   1. re-enable the automatic fpsbooster (it lags lol)
]]

if not game:IsLoaded() then
	game.Loaded:Wait()
end

if getgenv and getgenv().CmdLoaded then
	pcall(function()
	    getgenv().CmdPath.Parent = nil
	end)
end

local Settings = {
	Prefix = ";",
	Seperator = ",",
	Player = "/",
	Version = "1.0",
	ScaleSize = 1,
	Themes = {
		Primary = Color3.fromRGB(35, 35, 35),
		Secondary = Color3.fromRGB(40, 40, 40),
		Third = Color3.fromRGB(45, 45, 45),
		Title = Color3.fromRGB(255, 255, 255),
		Description = Color3.fromRGB(200, 200, 200),
		Icon = Color3.fromRGB(255, 255, 255),
		Shadow = Color3.fromRGB(0, 0, 0),
		Outline = Color3.fromRGB(45, 45, 45),
		Transparency = 0.05,
		Mode = "Dark"
	},
	Binds = {},
}

local Services = {
	Players = game:GetService("Players");
	Lighting = game:GetService("Lighting");
	Replicated = game:GetService("ReplicatedStorage");
	Starter = game:GetService("StarterGui");
	Teams = game:GetService("Teams");
	Http = game:GetService("HttpService");
	Market = game:GetService("MarketplaceService");
	Tween = game:GetService("TweenService");
	Input = game:GetService("UserInputService");
	Sound = game:GetService("SoundService");
	Run = game:GetService("RunService");
	Chat = game:GetService("TextChatService");
	ContextActionService = game:GetService("ContextActionService");
	Camera = game:GetService("Workspace").Camera;
	Teleport = game:GetService("TeleportService");
	AvatarEditor = game:GetService("AvatarEditorService");
	StarterPlayer = game:GetService("StarterPlayer");
}

local Players = Services.Players
local LoadTime = tick()

local Local = {
	Player = Players.LocalPlayer,
	Character = Players.LocalPlayer.Character or Players.LocalPlayer.CharacterAdded:Wait(),
	Mouse = Players.LocalPlayer:GetMouse(),
	Backpack = Players.LocalPlayer.Backpack,
}

local Checks = {
	File = isfile and isfolder and writefile and readfile
}

Players.LocalPlayer.CharacterAdded:Connect(function(Character)
	Local.Character = Character
end)

local FSuccess, FResult = pcall(function()
	if Checks.File then
		if not isfolder('Cmd') then
			makefolder('Cmd')
		end

		if not isfolder('Cmd/Data') then
			makefolder('Cmd/Data')
		end

		if not isfolder('Cmd/Plugins') then
			makefolder('Cmd/Plugins')
		end
	end
end)

if not FSuccess then
	warn(FResult)
end

-- ui - insert
local Screen = game:GetObjects("rbxassetid://17078695559")[1] --script.Parent
local Cmd = Screen.Command
local Lib = Screen.Library
local Example = Screen.Example
local Open = Screen.Open
local Bar = Cmd.Bar
local Autofill = Cmd.Autofill
local Box = Bar.Box
local Recommend = Bar.Recommend
local Popup = Screen.Popup

local CoreSuccess = pcall(function()
	Screen.Parent = game:GetService("CoreGui")
end)

if not CoreSuccess then
	Screen.Parent = Local.Player.PlayerGui
end

Example.Visible = false
Open.Visible = false

for Index, Canvas in  next, Cmd:GetChildren() do
	if Canvas:IsA("CanvasGroup") then
		Canvas.Visible = false
	end
end

-- functions & stuff like that lol
local lower = string.lower
local split = string.split
local sub = string.sub
local gsub = string.gsub
local find = string.find
local match = string.match
local format = string.format
local unpack = table.unpack
local spawn = task.spawn
local delay = task.delay
local Wait = task.wait

SetNumber = function(Input, Minimum, Max)
	Minimum = tonumber(Minimum) or 0 
	Max = tonumber(Max) or math.huge

	if Input then
		local Numbered = tonumber(Input)

		if Numbered and ((Numbered == (Minimum or Max) or (Numbered < Max) or (Numbered > Minimum))) then
			return Numbered
		elseif lower(Input) == "inf" then
			return Max
		else 
			return Minimum
		end
	else
		return Minimum
	end
end

Character = function(Player)
	if not Player then return end
	local Character = Player.Character

	if Character then
		return Character
	else
		warn("Character not found.")
	end
end

GetRoot = function(Character)
	if not Character then return end
	local Root = Character:FindFirstChild("HumanoidRootPart")

	if Character and Root then
		return Root
	else
		return
	end
end

GetHumanoid = function(Character)
	if not Character then return end
	local Humanoid = Character:FindFirstChildOfClass("Humanoid")

	if Character and Humanoid then
		return Humanoid
	else
		return
	end
end

FindTable = function(Table, Input)	
	for Index, Value in next, Table do
		if Value == Input then
			return Value
		end
	end
end

GetTools = function(Player)
	Player = Player or Local.Player
	local Backpack = Player.Backpack
	local Char = Character(Player)
	local Tools = {}

	for Index, Tool in next, Backpack:GetChildren() do
		if Tool:IsA("Tool") then
			table.insert(Tools, Tool)
		end
	end

	if Char then
		for Index, Tool in next, Char:GetChildren() do
			if Tool:IsA("Tool") then
				table.insert(Tools, Tool)
			end
		end
	end

	return Tools
end

R6Check = function(Player)
	Player = Player or Local.Player
	if Player then
		if Player.Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
			return true
		else
			return false
		end
	end
end

StringToInstance = function(String)
	local Split = split(String, ".")
	local Current = game

	if Split[1] == "workspace" then
		Current = workspace
	end

	table.remove(Split, 1)

	for Index, Child in next, Split do
		Current = Current[Child]
	end

	return Current
end

minimum = function(Table, Minimum)
	local New = {}

	if Table then
		for i,v in next, Table do
			if i == Minimum or i > Minimum then
				table.insert(New, v)
			end
		end
	end

	return New
end

Chat = function(Message)
	if Services.Chat:FindFirstChild("TextChannels") then
		Services.Chat.TextChannels.RBXGeneral:SendAsync(Message)
	else
		Services.Replicated.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(Message, "All")
	end
end

local CreateInstance = function(Name, Properties, Children)
	local Object = Instance.new(Name)
	for i, Property in next, Properties or {} do
		Object[i] = Property
	end

	for i, Children in next, Children or {} do
		Children.Parent = Object
	end

	return Object
end

if Local.Player:FindFirstChild("ControlModule", true) then
	local IdleAnimation = CreateInstance("Animation", {AnimationId = "rbxassetid://616006778"})
	local Move = CreateInstance("Animation", {AnimationId = "rbxassetid://616010382"})

	local BodyGyro = Instance.new("BodyGyro")
	BodyGyro.maxTorque = Vector3.new(1, 1, 1) * 10 ^ 6
	BodyGyro.P = 10 ^ 6

	local BodyVelocity = Instance.new("BodyVelocity")
	BodyVelocity.maxForce = Vector3.new(1, 1, 1) * 10 ^ 6
	BodyVelocity.P = 10 ^ 4

	local isFlying = false
	local Movement = {forward = 0, backward = 0, right = 0, left = 0}

	-- functions

	local function SetFlying(flying)
		isFlying = flying
		BodyGyro.Parent = isFlying and Local.Character.HumanoidRootPart or nil
		BodyVelocity.Parent = isFlying and Local.Character.HumanoidRootPart or nil
		BodyVelocity.Velocity = Vector3.new()

		Local.Character:WaitForChild("Animate").Disabled = isFlying

		if (isFlying) then
			BodyGyro.CFrame = Local.Character.HumanoidRootPart.CFrame
		end
	end

	local FlySpeed = 3
	local function onUpdate(dt)
		pcall(
			function()
				if (isFlying) then
					local cf = Services.Camera.CFrame
					local direction =
						cf.rightVector * (Movement.right - Movement.left) +
						cf.lookVector * (Movement.forward - Movement.backward)

					if (direction:Dot(direction) > 0) then
						direction = direction.unit
					end

					BodyGyro.CFrame = cf
					BodyVelocity.Velocity = direction * Local.Character.Humanoid.WalkSpeed * FlySpeed
				end
			end
		)
	end

	local function ModifyMovement(newMovement)
		Movement = newMovement or Movement
		if (isFlying) then
			local isMoving = Movement.right + Movement.left + Movement.forward + Movement.backward > 0
		end
	end

	local function MovementBind(actionName, InputState, inputObject)
		if (InputState == Enum.UserInputState.Begin) then
			Movement[actionName] = 1

			ModifyMovement()
		elseif (InputState == Enum.UserInputState.End) then
			Movement[actionName] = 0

			ModifyMovement()
		end

		return Enum.ContextActionResult.Pass
	end

	Services.ContextActionService:BindAction("forward", MovementBind, false, Enum.PlayerActions.CharacterForward)
	Services.ContextActionService:BindAction("backward", MovementBind, false, Enum.PlayerActions.CharacterBackward)
	Services.ContextActionService:BindAction("left", MovementBind, false, Enum.PlayerActions.CharacterLeft)
	Services.ContextActionService:BindAction("right", MovementBind, false, Enum.PlayerActions.CharacterRight)

	pcall(function()
		if (not Local.Character.Humanoid or Local.Character.Humanoid:GetState() == Enum.HumanoidStateType.Dead) then
			return
		end
	end)

	local Controller = require(Local.Player:FindFirstChild("ControlModule", true))
	local TouchFrame = Local.Player:FindFirstChild("TouchControlFrame", true)

	if Controller and TouchFrame then
		local IsMovingThumbstick = false
		local DeadZone = 0.15
		local DeadZoneNormalized = 1 - DeadZone

		local function isTouchOnThumbstick(Position)
			if not TouchFrame then
				return false
			end
			local ClassicFrame = TouchFrame:FindFirstChild("ThumbstickFrame")
			local DynamicFrame = TouchFrame:FindFirstChild("DynamicThumbstickFrame")

			local StickFrame = (ClassicFrame and ClassicFrame.Visible) and ClassicFrame or DynamicFrame
			if (StickFrame) then
				local StickPosition = StickFrame.AbsolutePosition
				local StickSize = StickFrame.AbsoluteSize
				return Position.X >= StickPosition.X and Position.X <= (StickPosition.X + StickSize.X) and
					Position.Y >= StickPosition.Y and
					Position.Y <= (StickPosition.Y + StickSize.Y)
			end
			return false
		end

		Services.Input.TouchStarted:Connect(
			function(touch, gameProcessedEvent)
				isMovingThumbstick = isTouchOnThumbstick(touch.Position)
			end
		)

		Services.Input.TouchEnded:Connect(
			function(touch, gameProcessedEvent)
				if not isMovingThumbstick then
					return
				end
				isMovingThumbstick = false
				ModifyMovement({forward = 0, backward = 0, right = 0, left = 0})
			end
		)

		Services.Input.TouchMoved:Connect(
			function(touch, gameProcessedEvent)
				if not isMovingThumbstick then
					return
				end
				local MouseVector = Controller:GetMoveVector()
				local LeftRight = MouseVector.X
				local ForeBack = MouseVector.Z

				-- change the range from [0.15-1] to [0-1] if it is outside the deadzone
				Movement.left = LeftRight < -DeadZone and -(LeftRight - DeadZone) / DeadZoneNormalized or 0
				Movement.right = LeftRight > DeadZone and (LeftRight - DeadZone) / DeadZoneNormalized or 0

				Movement.forward = ForeBack < -DeadZone and -(ForeBack - DeadZone) / DeadZoneNormalized or 0
				Movement.backward = ForeBack > DeadZone and (ForeBack - DeadZone) / DeadZoneNormalized or 0
				ModifyMovement()
			end
		)
	end

	function Fly(Boolean, SpeedValue)
		FlySpeed = SpeedValue or 1
		SetFlying(Boolean)

		Services.Run.RenderStepped:Connect(onUpdate)
	end
end

function GetPlayer(Arg)
	local Target = {}
	local PlayerNames = split(Arg, Settings.Player)

	for i, String in next, PlayerNames or {} do
		if String == nil then
			table.insert(Target, Local.Player)
		elseif String:lower() == "random" then
			table.insert(Target, Services.Players:GetPlayers()[math.random(#Services.Players:GetPlayers())])
		elseif String:lower() == "me" then
			table.insert(Target, Local.Player)
		elseif String:lower() == "all" then
			for i, Player in next, Services.Players:GetPlayers() do
				table.insert(Target, Player)
			end
		elseif String:lower() == "others" then
			for i, Player in next, Services.Players:GetPlayers() do
				if Player ~= Local.Player then
					table.insert(Target, Player)
				end
			end
		elseif String:lower() == "seated" then
			for i, Player in next, Services.Players:GetPlayers() do
				if Player ~= Local.Player and Player.Character and GetHumanoid(Player.Character).Sit then
					table.insert(Target, Player)
				end
			end
		elseif String:lower() == "stood" then
			for i, Player in next, Services.Players:GetPlayers() do
				if Player ~= Local.Player and Player.Character and not GetHumanoid(Player.Character).Sit then
					table.insert(Target, Player)
				end
			end

		elseif String:lower() == "closest" then
			local Lowest = math.huge
			local LPlayer
			if Local.Character then
				for i, Player in next, Services.Players:GetPlayers() do
					if Player.Character and Player ~= Local.Player then
						local Distance =
							Player:DistanceFromCharacter(GetRoot(Local.Character).Position)
						if Distance < Lowest then
							Lowest = Distance
							LPlayer = Player
						end
					end
				end
				table.insert(Target, LPlayer)
			end
		elseif String:lower() == "furthest" then
			local Highest, Furthest = 0, nil
			if Local.Character then
				for i, Player in next, Services.Players:GetPlayers() do
					if Player.Character and Player ~= Local.Player then
						local Distance = Player:DistanceFromCharacter(GetRoot(Local.Character).Position)
						if Distance > Highest then
							Highest = Distance
							Furthest = Player
						end
					end
				end

				Target = { Furthest }
			else
				return
			end
		elseif String:sub(1, 1) == "*" then
			for i, Player in next, Services.Players:GetPlayers() do
				if tostring(Player.Team):lower():find(String:sub(2, #String):lower()) then
					table.insert(Target, Player)
				end
			end
		elseif String:lower() == "enemies" then
			for i, Player in next, Services.Players:GetPlayers() do
				if Player.Team ~= Local.Player.Team then
					table.insert(Target, Player)
				end
			end
		elseif String:lower() == "dead" then
			for i, Player in next, Services.Players:GetPlayers() do
				if Player.Character and Player.Character.Humanoid then
					if Player.Character.Humanoid.Health == 0 then
						table.insert(Target, Player)
					end
				end
			end
		elseif String:lower() == "alive" then
			for i, Player in next, Services.Players:GetPlayers() do
				if Player.Character and Player.Character.Humanoid then
					if Player.Character.Humanoid.Health >= 0 then
						table.insert(Target, Player)
					end
				end
			end
		elseif String:lower() == "friends" then
			for i, Player in next, Services.Players:GetPlayers() do
				if Player:IsFriendsWith(Local.Player.UserId) and Player ~= Local.Player then
					table.insert(Target, Player)
				end
			end
		elseif String:lower() == "nonfriends" then
			for i, Player in next, Services.Players:GetPlayers() do
				if not Player:IsFriendsWith(Local.Player.UserId) and Player ~= Local.Player then
					table.insert(Target, Player)
				end
			end
		elseif String:lower() == "closest" then
			local Lowest = math.huge
			local LPlayer
			if Local.Player.Character then
				for i, Player in next, Services.Players:GetPlayers() do
					if Player.Character and Player ~= Local.Player then
						local Distance = Player:DistanceFromCharacter(Local.Character.HumanoidRootPart.Position)
						if Distance < Lowest then
							Lowest = Distance
							LPlayer = Player
						end
					end
				end
				table.insert(Target, LPlayer)
			end
		elseif String:lower() == "farthest" then
			local Highest = 0
			if Local.Player.Character then
				for i, Player in next, Services.Players:GetPlayers() do
					if Player.Character and Player ~= Local.Player then
						local Distance = Player:DistanceFromCharacter(Local.Character.HumanoidRootPart.Position)
						if Distance > Highest then
							Highest = Distance
							table.insert(Target, Player)
						end
					end
				end
			else
				return
			end
		else
			String = String:lower():gsub("%s", "")
			for _, Player in next, Services.Players:GetPlayers() do
				if Player.Name:lower():match(String) then
					table.insert(Target, Player)
				elseif Player.DisplayName:lower():match("^" .. String) then
					table.insert(Target, Player)
				end
			end
		end
	end
	return Target
end

function RGB(Color, Factor)
	if Settings.Themes.Mode == "Light" then
		return Color3.fromRGB((Color.R * 255) - Factor, (Color.G * 255) - Factor, (Color.B * 255) - Factor)
	else
		return Color3.fromRGB((Color.R * 255) + Factor, (Color.G * 255) + Factor, (Color.B * 255) + Factor)
	end
end

function StringToRGB(Item)
	local Color = nil
	if typeof(Item) == "string" then
		Color = Color3.new(unpack(split(Item, ",")))
	elseif typeof(Item) == "table" then
		Color = Color3.new(unpack(Item))
	end

	return Color3.fromRGB(Color.R * 255, Color.G * 255, Color.B * 255)
end

function DivideUDim2(Value, Amount)
	local New = {
		Value.X.Scale / Amount;
		Value.X.Offset / Amount;
		Value.Y.Scale / Amount;
		Value.Y.Offset / Amount;
	}

	return UDim2.new(unpack(New))
end

function MultiplyUDim2(Value, Amount)
	local New = {
		Value.X.Scale * Amount;
		Value.X.Offset * Amount;
		Value.Scale * Amount;
		Value.Y.Offset * Amount;
	}

	return UDim2.new(unpack(New))
end

local Tween = function(Object, Info, Table)
	local Success, Result = pcall(function()
		Services.Tween:Create(Object, Info, Table):Play()
	end)

	if not Success then
		warn(format("error tweening %s\n%s", Object.Name, Result))
	end
end

-- command lib
Command = {}
Commands = {}
Admins = {}
FullArgs = {}
Command.Count = 0
Command.Toggles = {}

-- command functions 

Methods = {}

Methods.RemoveRightGrip = function(Tool)
	Tool.Parent = Local.Character
	Tool.Parent = Local.Backpack
	Tool.Parent = Local.Character.Humanoid
	Tool.Parent = Local.Character
end

Methods.CheckIfVulnerable = function()
	if Services.Replicated:FindFirstChild("DeleteCar") then
		return true
	elseif Local.Character:FindFirstChild("HandlessSegway") then
		return true
	elseif Local.Backpack:FindFirstChild("Building Tools") then
		return true
	else
		for i, Descendant in next, game:GetDescendants() do
			if Descendant.Name == "DestroySegway" then
				return true
			end
		end
	end
end

Methods.Destroy = function(Part)
	if Services.Replicated:FindFirstChild("DeleteCar") then
		Services.Replicated.DeleteCar:FireServer(Part)
	elseif Local.Character:FindFirstChild("HandlessSegway") then
		for i, Descendant in next, game:GetDescendants() do
			if Descendant.Name == "DestroySegway" then
				Descentdant:FireServer(Part, {Value = Part})
			end
		end
	elseif Services.ReplicatedStorage:FindFirstChild("GuiHandler") then
		Services.ReplicatedStorage.GuiHandler:FireServer(false, Part)
	elseif Local.Player.Backpack:FindFirstChild("Building Tools") then
		local ArgumentTable = {
			[1] = "Remove",
			[2] = {
				[1] = Part
			}
		}

		Local.Player.Backpack:FindFirstChild("Building Tools").SyncAPI.ServerEndpoint:InvokeServer(
		unpack(ArgumentTable)
		)
	end
end


local Modules = {
	Freecam = nil,
	Glass = nil,
	Bhop = nil,
}

spawn(function()
	Modules.Freecam = loadstring(game:HttpGet("https://raw.githubusercontent.com/lxte/cmd/main/assets/freecam"))()
	Modules.Bhop = loadstring(game:HttpGet("https://raw.githubusercontent.com/lxte/cmd/main/assets/bhop"))()
end)

local PromptChangeRigType = function(RigType)
	Services.AvatarEditor:PromptSaveAvatar(
		GetHumanoid(Local.Character).HumanoidDescription,
		Enum.HumanoidRigType[RigType]
	)

	Services.AvatarEditor.PromptSaveAvatarCompleted:Wait()
	Command.Parse("respawn")
end

Command.Toggles.WalkFling = false
local Walkfling = function(Power, Distance, Bool)
	Command.Toggles.WalkFling = false
	Wait()
	Command.Toggles.WalkFling = Bool

	Distance = tonumber(Distance) or 5

	spawn( function()
		local HumanoidRootPart, Character, Velocity, Movel = GetRoot(Local.Character), Local.Character, nil, 0.1
		repeat
			task.wait()
			if Command.Toggles.WalkFling then
				while Command.Toggles.WalkFling and
					not (Character and Character.Parent and HumanoidRootPart and HumanoidRootPart.Parent) do
					Services.Run.Heartbeat:Wait()
					local HumanoidRootPart, Character = GetRoot(Local.Character), Local.Character
				end

				if Command.Toggles.WalkFling then
					if unpack(GetPlayer("closest")):DistanceFromCharacter(GetRoot(Local.Character).Position) <= Distance then
						Velocity = HumanoidRootPart.Velocity
						HumanoidRootPart.Velocity = Velocity * tonumber(Power) + Vector3.new(0, tonumber(Power), 0)
						Services.Run.RenderStepped:Wait()
						if Character and Character.Parent and HumanoidRootPart and HumanoidRootPart.Parent then
							HumanoidRootPart.Velocity = Velocity
						end
						Services.Run.Stepped:Wait()
						if Character and Character.Parent and HumanoidRootPart and HumanoidRootPart.Parent then
							HumanoidRootPart.Velocity = Velocity + Vector3.new(0, Movel, 0)
							Movel = Movel * -1
						end
					end
				end
			end
		until not Command.Toggles.WalkFling
	end)
end

-- ui lib
local Utils = {}
local Tweens = {}
local Tab = {}
local Library = {}
local Autofills = {}
local Utils = {}
Tweens.Info = {}
Autofills.Args = {
	["String"] = {
		Name = "String",
		Background = Color3.fromRGB(121, 255, 111),
		Outline = Color3.fromRGB(135, 255, 116),
		Icon = "http://www.roblox.com/asset/?id=6034934040"
	},

	["Player"] = {
		Name = "Player",
		Background = Color3.fromRGB(255, 107, 107),
		Outline = Color3.fromRGB(255, 116, 116),
		Icon = "http://www.roblox.com/asset/?id=6034287594"
	},

	["Number"] = {
		Name = "Number",
		Background = Color3.fromRGB(102, 171, 255),
		Outline = Color3.fromRGB(112, 145, 255),
		Icon = "rbxassetid://16798074797"
	},

	["Bool"] = {
		Name = "Bool",
		Background = Color3.fromRGB(252, 255, 98),
		Outline = Color3.fromRGB(255, 250, 103),
		Icon = "rbxassetid://7743869317"
	}
}

Tweens.AddInfo = function(Element)
	if Element and Element:IsA("CanvasGroup") then
		local Shadow = Element:FindFirstChildOfClass("UIStroke");
		local Name = Element.Name;

		if not Tweens.Info[Name] then
			Tweens.Info[Name] = { 
				Size = Element.Size, 
				Transparency = Element.GroupTransparency,
				Shadow = nil,
			}

			if Shadow then
				Tweens.Info[Name].Shadow = Shadow.Transparency 
			end
		end

		return Tweens.Info[Name]
	end
end

Tweens.Open = function(List)
	local Canvas = List.Canvas
	local Speed = List.Speed
	local Position = List.Position or UDim2.new(0.5, 0, 0.5, 0)
	local Name = Canvas.Name
	local Info = Tweens.AddInfo(Canvas)
	local Shadow = Canvas:FindFirstChildOfClass("UIStroke")

	local Size = Info.Size
	local Transparency = Settings.Themes.Transparency
	local Outline = Info.Shadow
	local New = DivideUDim2(Size, 1.1)
	local Info = TweenInfo.new(Speed, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

	Canvas.Size = New
	Canvas.Position = Position
	Canvas.GroupTransparency = 1
	Canvas.Visible = true

	Tween(Canvas, Info, { Size = Size })
	Tween(Canvas, Info, { GroupTransparency = Transparency })

	if Shadow then
		Tween(Shadow, Info, { Transparency = Outline })
	end

	delay(Speed, function()
		Canvas.GroupTransparency = Transparency
	end)
end

Tweens.Close = function(List)
	local Canvas = List.Canvas
	local Speed = List.Speed
	local Name = Canvas.Name
	local Info = Tweens.AddInfo(Canvas)
	local Shadow = Canvas:FindFirstChildOfClass("UIStroke")
	local Size = Info.Size
	local Transparency = Settings.Themes.Transparency
	local New = DivideUDim2(Size, 1.1)
	local Info = TweenInfo.new(Speed, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

	Tween(Canvas, Info, { Size = New })
	Tween(Canvas, Info, { GroupTransparency = 1 })

	if Shadow then
		Tween(Shadow, Info, { Transparency = 1 })
	end

	delay(Speed, function()
		Canvas.Visible = false
	end)
end

Tab.SetPage = function(Page)
	local Tabs = Page.Parent
	local Info = TweenInfo.new(0.4)

	for Index, Tab in next, Tabs:GetChildren() do
		if Tab:IsA("Frame") then
			local Opened = Tab.Opened

			if Opened.Value and Tab ~= Page then
				Tween(Tab, Info, { Position = UDim2.new(1.5, 0,0.562, 0) })
				Opened.Value = false
			elseif Tab == Page and not Page.Opened.Value then
				Tab.Position = UDim2.new(-0.5, 0,0.562, 0)
				Tween(Tab, Info, { Position = UDim2.new(0.5, 0, 0.562, 0) })
				Opened.Value = true
			end
		end
	end
end

Library.Hover = function(Object, Speed, Color)
	task.spawn(function()
		Speed = Speed or 0.3

		if Object:IsA("GuiObject") then
			local Hover = Object:FindFirstChild("HoverPadding")
			local Info = TweenInfo.new(Speed)

			Object.InputBegan:Connect(function()
				local Theme = Color or Settings.Themes.Secondary
				Object.BackgroundColor3 = Theme

				Tween(Object, Info, { BackgroundColor3 = RGB(Theme, 5)})

				if Hover then
					Tween(Hover, Info, { PaddingLeft = UDim.new(0, 5) })
				end
			end)

			Object.InputEnded:Connect(function()
				local Theme = Color or Settings.Themes.Secondary

				Tween(Object, Info, { BackgroundColor3 = Theme})

				if Hover then
					Tween(Hover, Info, { PaddingLeft = UDim.new(0, 0) })
				end
			end)
		end
	end)
end

Tab.new = function(Info)
	local Title = Info.Title
	local Drag = Info.Drag
	local New = Example:Clone()
	local Top = New.Top
	local Buttons = Top.Buttons
	local Minimized = New.Minimized
	local Info = TweenInfo.new(0.3)

	New.Parent = Screen
	New.TabPopup.Visible = false
	New.Visible = false
	Top.Title.Text = Title
	New.Name = Title

	for Index, Button in next, Buttons:GetChildren() do
		Library.Hover(Button)
	end

	if Drag then
		Library.Drag(New)
	end

	Buttons.Close.MouseButton1Click:Connect(function()
		Tweens.Close({ Canvas = New, Speed = 0.25 })
	end)

	Buttons.Back.MouseButton1Click:Connect(function()
		Tab.SetPage(New.Tabs.Main)
	end)

	Buttons.Minimize.MouseButton1Click:Connect(function()
		if Minimized.Value then
			Tween(New, Info, { Size = UDim2.new(0, 293, 0, 367) })
		else
			Tween(New, Info, { Size = UDim2.new(0, 293, 0, 46) })
		end

		Minimized.Value = not Minimized.Value
	end)

	return New
end

Tab.Popup = function(Tab, Title)
	local Popup = Tab:FindFirstChild("TabPopup")
	local Shadow = Tab:FindFirstChild("ShadowBG")
	local InfoTween = TweenInfo.new(0.2)

	if Popup then
		local New = Popup:Clone()
		local Top = New.Top
		local Scroll = New.Main.Scroll

		New.Parent = Tab
		New.Position = UDim2.fromScale(0, 1.4)
		Top.Title.Text = Title

		Top.Buttons.Close.MouseButton1Click:Connect(function()
			Tweens.Close({
				Canvas = New,
				Speed = 0.25,
			})

			if Shadow then
				Tween(Shadow, InfoTween, { BackgroundTransparency = 1 })
			end
		end)

		return New, Scroll
	end
end

Tab.ShowPopup = function(Popup)
	local Shadow = Popup.Parent:FindFirstChild("ShadowBG")

	if Popup then
		local Info = TweenInfo.new(0.25)
		Popup.Position = UDim2.fromScale(0, 1.4)
		Popup.GroupTransparency = 1
		Popup.Visible = true

		Tweens.Open({
			Canvas = Popup,
			Speed = 0.25,
			Position = UDim2.new(0.5, 0, 0.615, 0)
		})

		if Shadow then
			Tween(Shadow, Info, { BackgroundTransparency = 0.8 })
		end
	end
end

Library.Drag = function(Canvas)
	if Canvas then
		local Dragging;
		local DragInput;
		local Start;
		local StartPosition;

		local function Update(input)
			local delta = input.Position - Start
			Canvas.Position = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + delta.Y)
		end

		Canvas.InputBegan:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				Dragging = true
				Start = Input.Position
				StartPosition = Canvas.Position

				Input.Changed:Connect(function()
					if Input.UserInputState == Enum.UserInputState.End then
						Dragging = false
					end
				end)
			end
		end)

		Canvas.InputChanged:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
				DragInput = Input
			end
		end)

		Services.Input.InputChanged:Connect(function(Input)
			if Input == DragInput and Dragging then
				Update(Input)
			end
		end)
	end
end

Library.new = function(Object, Info)
	local Parent = Info.Parent
	local Title = Info.Title
	local Description = Info.Description
	local Default = Info.Default
	local Callback = Info.Callback
	local Item = Lib:FindFirstChild(Object)

	if Item then
		local New = Item:Clone()
		New.Parent = Parent
		New.Visible = true

		if New:IsA("GuiButton") then
			Library.Hover(New)
		end

		if Title then
			New.Content.Title.Text = Title
		else
			New.Content.Title:Destroy()
		end

		if Description then
			New.Content.Description.Text = Description
		else
			New.Content.Description:Destroy()
		end

		if Object == "Button" then
			New.MouseButton1Click:Connect(function()
				Callback()
			end)

		elseif Object == "Bind" then
			local Keybind = New.Title
			local Done, Time = false, tick()
			local Detect = nil

			New.MouseButton1Click:Connect(function()
				Done = false
				Keybind.Text = "..."

				Detect = Services.Input.InputBegan:Connect(function(Key)
					if not Done then
						Callback(Key.KeyCode)
						Done = true
						Keybind.Text = tostring(Key.KeyCode):gsub("Enum.KeyCode.", "")
					end
				end)
			end)

			task.spawn(function()
				repeat task.wait() until Done or tick() - Time == 5

				if Detect then
					Detect:Disconnect()
				end
			end)

		elseif Object == "Input" then
			local TextBox = New.Box
			TextBox.Text = tostring(Default)

			New.MouseButton1Click:Connect(function()
				TextBox:CaptureFocus()
			end)

			TextBox.FocusLost:Connect(function(Enter)
				Callback(TextBox.Text)
			end)

			return TextBox
		elseif Object == "Toggle" then
			local Bool = New.On
			local Toggle = New.Toggle
			local Circle = Toggle.Circle
			local Info = TweenInfo.new(0.3)

			local Set = function(On)
				if On then
					Tween(Toggle, Info, { BackgroundColor3 = Color3.fromRGB(99, 218, 92) })
					Tween(Circle, Info, { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.new(0.509, 0,0.5, 0) })
				else
					Tween(Toggle, Info, { BackgroundColor3 = Settings.Themes.Outline })
					Tween(Circle, Info, { BackgroundColor3 = Settings.Themes.Secondary, Position = UDim2.new(0.089, 0,0.5, 0) })
				end

				Bool.Value = On
			end

			Set(Default)

			New.MouseButton1Click:Connect(function()
				Set(not Bool.Value)
				Callback(Bool.Value)
			end)
		elseif Object == "Label" then
			return New
		elseif Object == "Switch" then
			local NewTab = Lib.Tab:Clone()
			local Scroll = NewTab.Scroll
			local Folder = Parent

			if not Folder:IsA("Folder") then
				for i = 1,5 do
					if Folder.Parent:IsA("Folder") then
						Folder = Folder.Parent
						break
					else
						Folder = Folder.Parent
					end
				end
			end

			NewTab.Parent = Folder
			NewTab.Position = UDim2.new(-0.5, 0, 0.562, 0)
			NewTab.Visible = true
			NewTab.Opened.Value = false

			New.MouseButton1Click:Connect(function()
				Tab.SetPage(NewTab)
			end)

			return NewTab.Scroll, New
		end
	end
end
Library.Bar = function(Bool)
	local UI = { b = { UDim2.new(0.5, 0, 0, 0), Bar }, a = { UDim2.new(0.5, 0, 0, 80), Autofill }}

	if Bool then
		for Index, Variable in UI do
			if Variable then
				Tweens.Open({
					Canvas = Variable[2],
					Speed = 0.15,
					Position = Variable[1],
				})
			end
		end
	else
		for Index, Variable in UI do
			if Variable then
				Tweens.Close({
					Canvas = Variable[2],
					Speed = 0.15,
				})
			end
		end
	end
end

Library.Theming = {
	Names = {
		["Opened"] = function(Item)
			if Item:IsA("BoolValue") then
				local Tab = Item.Parent
				Tab.BackgroundColor3 = RGB(Settings.Themes.Primary, 3)
			end
		end,

		["Title"] = function(Item)
			Item.TextColor3 = Settings.Themes.Title
		end,

		["Description"] = function(Item)
			Item.TextColor3 = Settings.Themes.Description
		end,

		["Top"] = function(Item)
			Item.BackgroundColor3 = Settings.Themes.Secondary
		end,

		["Box"] = function(Item)
			Item.TextColor3 = Settings.Themes.Title
			Item.BackgroundColor3 = Settings.Themes.Outline
		end,

		["Recommend"] = function(Item)
			Box.TextColor3 = Settings.Themes.Description
		end,

		["Stroke"] = function(Item)
			Item.Color = Settings.Themes.Outline
		end,

		["Shadow"] = function(Item)
			if Item:IsA("UIStroke") then
				Item.Color = Settings.Themes.Shadow
			end
		end,

		["AutofillObject"] = function(Item)
			Item.BackgroundColor3 = Settings.Themes.Secondary
		end,

		["Buttons"] = function(Item)
			if Item:IsA("Frame") then
				for Index, Button in next, Item:GetChildren() do
					if Button:IsA("GuiButton") then
						Button.BackgroundColor3 = Settings.Themes.Secondary
					end
				end
			end
		end,

		["Decline"] = function(Item)
			Item.BackgroundColor3 = Settings.Themes.Primary
		end,
	},

	Classes = {
		["CanvasGroup"] = function(Item)
			Item.BackgroundColor3 = Settings.Themes.Primary
			Item.GroupTransparency = Settings.Themes.Transparency
		end,

		["ImageLabel"] = function(Item)
			Item.ImageColor3 = Settings.Themes.Icon
		end,

		["ImageButton"] = function(Item)
			if not Autofills.Args[Item.Name] then
				Item.ImageColor3 = Settings.Themes.Icon
			end
		end,

		["ScrollingFrame"] = function(Item)
			Item.ScrollBarImageColor3 = Settings.Themes.Outline
		end,
	},
}

for Index, Button in next, Lib:GetChildren() do
	if (Button:IsA("GuiButton") or Button:IsA("Frame")) and Button.Name ~= "Section" then
		Library.Theming.Names[Button.Name] = function(Item)
			Item.BackgroundColor3 = Settings.Themes.Secondary
		end
	end
end

Library.LoadTheme = function(Table)
	if Table then
		Settings.Themes = Table
	else
		Settings.Themes = Settings.Themes
	end

	for Index, Object in next, Screen:GetDescendants() do
		if Library.Theming.Names[Object.Name] then
			local Function = Library.Theming.Names[Object.Name]
			Function(Object)
		elseif Library.Theming.Classes[Object.ClassName] then
			local Function = Library.Theming.Classes[Object.ClassName]
			Function(Object)
		end
	end
end

Library.Themes = {
	["Dark"] = function()
		local Old = Settings.Themes.Transparency

		Settings.Themes = {
			Primary = Color3.fromRGB(35, 35, 35),
			Secondary = Color3.fromRGB(40, 40, 40),
			Third = Color3.fromRGB(45, 45, 45),
			Title = Color3.fromRGB(255, 255, 255),
			Description = Color3.fromRGB(200, 200, 200),
			Icon = Color3.fromRGB(255, 255, 255),
			Shadow = Color3.fromRGB(0, 0, 0),
			Outline = Color3.fromRGB(45, 45, 45),
			Transparency = Old,
			Mode = "Dark"
		}

		Library.LoadTheme()
	end,

	["Nord"] = function()
		local Old = Settings.Themes.Transparency

		Settings.Themes = {
			Primary = Color3.fromRGB(47, 54, 66),
			Secondary = Color3.fromRGB(52, 58, 72),
			Title = Color3.fromRGB(255, 255, 255),
			Description = Color3.fromRGB(200, 200, 200),
			Icon = Color3.fromRGB(255, 255, 255),
			Shadow = Color3.fromRGB(46, 52, 64),
			Outline = Color3.fromRGB(57, 65, 80),
			Transparency = Old,
			Mode = "Dark",
		}

		Library.LoadTheme()
	end,

	["Dracula"] = function()
		local Old = Settings.Themes.Transparency

		Settings.Themes = {
			Primary = Color3.fromRGB(40, 42, 54),
			Secondary = Color3.fromRGB(44, 46, 59),
			Title = Color3.fromRGB(255, 255, 255),
			Description = Color3.fromRGB(200, 200, 200),
			Icon = Color3.fromRGB(255, 255, 255),
			Shadow = Color3.fromRGB(0, 0, 0),
			Outline = Color3.fromRGB(48, 51, 65),
			Transparency = Old,
			Mode = "Dark",
		}

		Library.LoadTheme()
	end,

	["Light"] = function()
		local Old = Settings.Themes.Transparency

		Settings.Themes = {
			Primary = Color3.fromRGB(237,237,237),
			Secondary = Color3.fromRGB(242, 242, 242),
			Title = Color3.fromRGB(85, 85, 85),
			Description = Color3.fromRGB(100, 100, 100),
			Icon = Color3.fromRGB(85, 85, 85),
			Shadow = Color3.fromRGB(176, 176, 176),
			Outline = Color3.fromRGB(222, 222, 222),
			Transparency = Old,
			Mode = "Light",
		}

		Library.LoadTheme()
	end,

	["c00lkidd"] = function()
		local Old = Settings.Themes.Transparency

		Settings.Themes = {
			Primary = Color3.fromRGB(29, 0, 2),
			Secondary = Color3.fromRGB(44, 0, 2),
			Title = Color3.fromRGB(255, 255, 255),
			Description = Color3.fromRGB(200, 200, 200),
			Icon = Color3.fromRGB(255, 255, 255),
			Shadow = Color3.fromRGB(54, 0, 1),
			Outline = Color3.fromRGB(65, 0, 2),
			Transparency = Old,
			Mode = "Dark",
		}

		Library.LoadTheme()
	end,

	["Void"] = function()
		local Old = Settings.Themes.Transparency

		Settings.Themes = {
			Primary = Color3.fromRGB(9, 9, 9),
			Secondary = Color3.fromRGB(12, 12, 12),
			Title = Color3.fromRGB(255, 255, 255),
			Description = Color3.fromRGB(200, 200, 200),
			Icon = Color3.fromRGB(255, 255, 255),
			Shadow = Color3.fromRGB(0, 0, 0),
			Outline = Color3.fromRGB(18, 18, 18),
			Transparency = Old,
			Mode = "Dark",
		}

		Library.LoadTheme()
	end,
}

Autofills.AutoSize = function(Number)
	task.spawn(function()
		local Info = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local Sizes = {
			[1] = UDim2.fromOffset(441, 70),
			[2] = UDim2.fromOffset(441, 125),
			[3] = UDim2.fromOffset(441, 188),
			[4] = UDim2.fromOffset(441, 246),
		}

		if Number < 4 then
			Tween(Autofill, Info, { Size = Sizes[Number] })
		elseif Number == 4 or Number > 4 then
			Tween(Autofill, Info, { Size = Sizes[4] })
		end
	end)
end

Autofills.AddArguments = function(Frame, Arguments)
	for Index, Argument in Arguments do
		if Index and Argument then
			local Name = Argument.Name
			local Type = Argument.Type

			local Arg = Autofills.Args[Type]

			if Arg then
				local Name, Background, Outline, Icon = Arg.Name, Arg.Background, Arg.Outline, Arg.Icon
				local UI = Lib.AutofillArgument:Clone()
				UI.BackgroundColor3 = Background;
				UI.Stroke.Color = Outline;
				UI.Icon.Image = Icon;
				UI.Visible = true;
				UI.Parent = Frame;
				UI.Name = Name;
			end
		end
	end
end

Autofills.Recommend = function(Input)
	local Split = lower(split(Input, ' ')[1])
	local Found = false

	for Index, Table in Commands do
		for Index, Name in Table[1] do
			if Name == Split then
				Recommend.Text = gsub(Name, Split, split(Input, " ")[1])
				Found = true
			elseif find(sub(Name, 1, #Split), lower(Split)) then
				Recommend.Text = gsub(Name, Split, split(Input, " ")[1])
				Found = true
			end
		end
	end

	if not Found or #split(Input, " ") > 1 then
		Recommend.Text = ""
	end
end

Autofills.Add = function(Table)
	local Aliases = Table[1]
	local Description = Table[2]
	local Arguments = Table[3]
	local Plugin = Table[4]
	local Callback = Table[5]
	local Scroll = Autofill.Main.Scroll
	local Example = Scroll.Example
	local New = Example:Clone()
	local Content = New.Content
	local Args = New.Arguments
	local Title = ''

	if #Aliases > 1 then
		for Index, Value in next, Aliases do
			local Seperate = ""

			if Index > 1 then
				Seperate = " / "
			end

			Title = Title .. Seperate .. Value
		end
	elseif #Aliases == 1 then
		Title = Aliases[1]
	end

	Content.Title.Text = Title
	Content.Description.Text = Description
	New.Parent = Scroll
	New.Visible = true
	New.Name = "AutofillObject"

	Autofills.AddArguments(Args, Arguments)
end

Autofills.Search = function(Input)
	task.spawn(function()
		local Split = gsub(lower(split(Input, " ")[1]), Settings.Prefix, '')
		local Scroll = Autofill.Main.Scroll
		local FoundFirst = false
		local Amount = 0

		for Index, Frame in next, Scroll:GetChildren() do
			if Frame:IsA("Frame") and Frame.Name == "AutofillObject" then
				local Content = Frame.Content

				if find(lower(Content.Title.Text), Split) then 
					Amount = Amount + 1

					if not FoundFirst then
						Frame.BackgroundColor3 = Settings.Themes.Secondary
						FoundFirst = true
					else
						Frame.BackgroundColor3 = RGB(Settings.Themes.Primary, 3)
					end

					Frame.Visible = true
				else
					Frame.Visible = false
				end
			end
		end
		Autofills.AutoSize(Amount)
	end)
end

Utils.NotificationInfo = {
	["Information"] = {
		Color = Color3.fromRGB(111, 163, 211),
	},

	["Error"] = {
		Color = Color3.fromRGB(211, 108, 109),
	},

	["Warning"] = {
		Color = Color3.fromRGB(211, 208, 110),
	},

	["Success"] = {
		Color = Color3.fromRGB(93, 171, 93),
	},
}

Utils.Notify = function(Type, Title, Description, Duration)
	Duration = tonumber(Duration) or 5
	local Notification = Screen.Notification.Example:Clone()
	local Timer = Notification.Timer
	local Top = Notification.Top
	local Info = TweenInfo.new(Duration)
	local Table = Utils.NotificationInfo[Type] or Utils.NotificationInfo.Information

	if Title then
		Top.Title.Text = Title
	end

	if Description then
		Notification.Description.Text = Description
	end

	Notification.Visible = true
	Notification.Parent = Screen.Notification
	Timer.BackgroundColor3 = Table.Color

	Tween(Timer, Info, { Size = UDim2.new(0, 0, 0, 3), Position = UDim2.new(0, 0, 0.977, 0) })
	Tweens.Open({ Canvas = Notification, Speed = 0.25 })

	delay(Duration, function()
		Tweens.Close({ Canvas = Notification, Speed = 0.25 })
		Wait(0.3)
		Notification:Destroy()
	end)
end

Utils.Popup = function(Title, Description, Callback)
	local New = Popup:Clone()
	local Content = New.Content
	local Bottom = New.Top

	local Close = function()
		Tweens.Close({
			Canvas = New,
			Speed = 0.25,
		})
	end

	Content.Title.Text = Title
	Content.Description.Text = Description
	New.Parent = Screen

	for Index, Button in next, Bottom:GetChildren() do
		if Button:IsA("GuiButton") then
			if Button.Name == "Confirm" then
				Library.Hover(Button, 0.2, Button.BackgroundColor3)
			else
				Library.Hover(Button, 0.2, Settings.Themes.Primary)
			end

			Button.MouseButton1Click:Connect(function()
				if Button.Name == "Confirm" then
					Callback()
				end

				Close()
			end)
		end
	end

	Tweens.Open({
		Canvas = New,
		Speed = 0.25,
	})
end

-- data functions
local Data = {}

Data.new = function(Name, Info)
	if Checks.File then
		writefile(format('Cmd/Data/%s', Name), Info)
	else
		warn("Exploit doesn't support file functions")
	end
end

Data.get = function(Name)
	if Checks.File and isfile(format('Cmd/Data/%s', Name)) then
		return readfile(format('Cmd/Data/%s', Name))
	else
		warn("Data not found :(")
	end
end

Data.GetSetting = function(Info)
	local Settings = Services.Http:JSONDecode(Data.get("Settings.json")) or Settings

	if Settings[Info] then
		return Settings[Info]
	else
		warn(Info)
		return false
	end
end

Data.SetSetting = function(Setting, Info)
	local Decoded = Services.Http:JSONDecode(Data.get("Settings.json")) or Settings

	if Decoded[Setting] then
		Decoded[Setting] = Info
		Settings[Setting] = Info
	end

	Data.new("Settings.json", Services.Http:JSONEncode(Decoded))
end

Data.SaveTheme = function(ThemeTable)
	Library.LoadTheme(ThemeTable)
	local Themes = {}

	for Index, Color in next, ThemeTable do
		Themes[Index] = tostring(Color)
	end

	Data.new("Themes.json", Services.Http:JSONEncode(Themes))
end

Data.SetUpThemeTable = function(ThemeTable)
	local Themes = {}

	for Index, Theme in next, ThemeTable do
		if Index ~= "Transparency" and Index ~= "Mode" then
			Themes[Index] = StringToRGB(Theme)
		elseif Index == "Transparency" then
			Themes[Index] = tonumber(Theme)
		else
			Themes[Index] = Theme
		end
	end

	return Themes
end

if not Data.get("Settings.json") then
	Data.new("Settings.json", Services.Http:JSONEncode(Settings))
end

if not Data.get("Themes.json") then
	local Themes = {}

	for Index, Color in next, Settings.Themes do
		Themes[Index] = tostring(Color)
	end

	Data.new("Themes.json", Services.Http:JSONEncode(Themes))
end

if not Data.get("Scale.json") then
	Data.new("Scale.json", "1")
end

if Checks.File then
	Settings.Themes = Data.SetUpThemeTable(Services.Http:JSONDecode(Data.get("Themes.json")))

	local Themes = Settings.Themes
	Settings = Services.Http:JSONDecode(Data.get("Settings.json"))
	Settings.Themes = Themes
	Settings.ScaleSize = Data.get("Scale.json")
end

SetUIScale = function(Scale)
	if not tonumber(Scale) then return end
    Settings.ScaleSize = tonumber(Scale)

	for Index, UIScale in next, Screen:GetDescendants() do
		if UIScale:IsA("UIScale") and UIScale.Name == "DeviceScale" then
			UIScale.Scale = tonumber(Scale)
		end
	end

	if Checks.File then
		Data.new("Scale.json", tostring(Scale))
	end
end

-- command lib
Command.Add = function(Information)
	local Aliases = Information.Aliases;
	local Description = Information.Description;
	local Arguments = Information.Arguments;
	local Plugin = Information.Plugin;
	local Task = Information.Task;

	for Index, Value in next, Aliases do
		Index = lower(Value)
	end

	Commands[Aliases[1]] = { Aliases, Description, Arguments, Plugin, Task } 
	Command.Count = Command.Count + 1
end

Command.Find = function(Input)
	for Index, Table in next, Commands do
		local Aliases = Table[1]
		local Found = FindTable(Aliases, Input)

		if Found then
			return Table
		end
	end
end

Command.Run = function(Name, Callbacks)
	spawn(function()
		local Table = Command.Find(Name)

		if Table and Name ~= "" then
			local Callback = Table[5]

			local Success, Result = pcall(function()
			Callback(unpack(Callbacks))
			end)

			if not Success then
				warn(Result)
			end

		elseif Name ~= "" then
			Utils.Notify("Error", "Command not found", string.format("The command <b>%s</b> doesn't exist", Name), 5)
		end
	end)
end

Command.Parse = function(Input)
	if Screen.Parent then
	local Name, ArgsString = gsub(Input, Settings.Prefix, ""):match("^%s*([^%s]+)%s*(.*)$")

	if Name then
		local Arguments = {}
		for arg in ArgsString:gmatch("%s*([^"..Settings.Seperator .."]+)") do
			table.insert(Arguments, arg)
		end

		FullArgs = Arguments
		Command.Run(lower(Name), Arguments)
	end
    end
end

Command.Whitelist = function(Player)
	Admins[Player.UserId] = true
	Player.Chatted:Connect(function(Message)
		if Admins[Player.UserId] and match(Message, "^%p") then
			Command.Parse(Message)
		end
	end)
end

Command.RemoveWhitelist = function(Player)
	Admins[Player.UserId] = false
end

-- Commands

Command.Add({
	Aliases = { "tutorial" },
	Description = "Explanation on how to use Cmd",
	Arguments = {},
	Plugin = false,
	Task = function()
		if not Screen:FindFirstChild("Tutorial") then

			local Main = Tab.new({
				Title = "Tutorial",
				Drag = true
			})

			local Tabs = Main.Tabs
			local MainTab = Tabs.Main.Scroll


            Library.new("Label", { Title = "Seperating arguments for running commands", Description = "To seperate the arguments for example ;command arg1, arg2 - you need to seperate it using a ',' (comma)", Parent = MainTab })
            Library.new("Label", { Title = "Player arguments", Description = "The current arguments for getting players are - their username, their displayname, all, others, seated, stood, me, closest, farthest, *team_name, enemies, dead, alive, friends, nonfriends", Parent = MainTab })
            Library.new("Label", { Title = "Adding plugins", Description = "For a tutorial on how to add plugins visit - github.com/lxte/cmd/wiki/Plugins", Parent = MainTab })
            Library.new("Label", { Title = "Applying themes", Description = "To apply themes open the Settings tab (by using the 'settings' command), and go to the Themes section. There you can edit them.", Parent = MainTab })

			Tweens.Open({ Canvas = Main, Speed = 0.3 })
		else
			Tweens.Open({ Canvas = Screen:FindFirstChild("Tutorial"), Speed = 0.3 })
		end
	end,
})

Command.Add({
	Aliases = { "commands", "cmds" },
	Description = "See all the commands",
	Arguments = {},
	Plugin = false,
	Task = function()
		if not Screen:FindFirstChild("Commands") then

			local Main = Tab.new({
				Title = "Commands",
				Drag = true
			})

			local Tabs = Main.Tabs
			local MainTab = Tabs.Main.Scroll

			local ShowResults = function(Message)
				Message = Message:lower()

				for Index, Cmd in next, MainTab:GetChildren() do
					if Cmd.Name == "Switch" and Cmd:IsA("GuiButton") and Cmd.Name ~= "Example" then
						local Title = Cmd.Content.Title
						Cmd.Visible = find(lower(Title.Text), Message)
					end
				end
			end

			local Search = Library.new("Input", { 
				Title = "Search",
				Parent = MainTab,
				Default = "",
				Callback = function(Message)
					ShowResults(Message)
				end,
			})

			Search:GetPropertyChangedSignal("Text"):Connect(function()
				ShowResults(Search.Text)
			end)

			for Index, Table in next, Commands do
				local Aliases = Table[1]
				local Description = Table[2]
				local Arguments = Table[3]
				local Plugin = Table[4]
				local Title = ''
				local Argument = ''
				local ArgAmount = 1

				-- Command Title
				if #Aliases > 1 then
					for Index, Value in next, Aliases do
						local Seperate = ""

						if Index > 1 then
							Seperate = " / "
						end

						Title = Title .. Seperate .. Value
					end
				elseif #Aliases == 1 then
					Title = Aliases[1]
				end

				-- Argument Description
				for Index, Arg in Arguments do
					if Index and Arg then
						local Name = Arg.Name
						local Type = Arg.Type
						local Seperate = ""

						if ArgAmount > 1 then
							Seperate = ", "
						end

						Argument = Argument .. string.format("%s%s (%s)", Seperate, Name, Type)
						ArgAmount = ArgAmount + 1
					end

					if ArgAmount == 1 then
						Argument = 'None'
					end
				end

				-- UI
				local Tab = Library.new("Switch", { Title = Title, Description = Description, Parent = MainTab })
				Library.new("Section", { Title = "Command Info", Parent = Tab }) 
				Library.new("Label", { Title = "Arguments", Description = Argument, Parent = Tab })
				Library.new("Label", { Title = "Is plugin", Description = tostring(Plugin), Parent = Tab })
			end

			Tweens.Open({ Canvas = Main, Speed = 0.3 })
		else
			Tweens.Open({ Canvas = Screen:FindFirstChild("Commands"), Speed = 0.3 })
		end
	end,
})

Command.Add({
	Aliases = { "servers" },
	Description = "Lists all other servers",
	Arguments = {},
	Plugin = false,
	Task = function()
		if not Screen:FindFirstChild("Servers") then

			local Main = Tab.new({
				Title = "Servers",
				Drag = true
			})

			local Tabs = Main.Tabs
			local MainTab = Tabs.Main.Scroll	
			local URL = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?limit=100"
			local ServerTable = {}
			local Info = game:GetService("HttpService"):JSONDecode(game:HttpGetAsync(URL))

			for Index, Server in next, Info.data do
				if type(Server) == "table" and Server.maxPlayers > Server.playing then
					table.insert(ServerTable, {Server.ping, Server.id, Server.playing, Server.maxPlayers})
				end
			end

			for Index, Info in next, ServerTable do
				Library.new("Button", { 
					Title = tostring(Info[2]),
					Description =  format('Ping: %s \n%s/%s Players', tostring(Info[1]), tostring(Info[3]), tostring(Info[4])),
					Parent = MainTab,
					Callback = function()
						Services.Teleport:TeleportToPlaceInstance(game.PlaceId, Info[2], Local.Player)
					end,
				})
			end

			Tweens.Open({ Canvas = Main, Speed = 0.3 })
		else
			Tweens.Open({ Canvas = Screen:FindFirstChild("Servers"), Speed = 0.3 })
		end
	end,
})

Command.Add({
	Aliases = { "bind" },
	Description = "Add a command bind",
	Arguments = {},
	Plugin = false,
	Task = function()
		if not Screen:FindFirstChild("Bind") then
			local Main = Tab.new({
				Title = "Bind",
				Drag = true
			})

			local Tabs = Main.Tabs
			local MainTab = Tabs.Main.Scroll

			local Binds = Library.new("Switch", { 
				Title = "Binds",
				Description = "Shows a list of all the keybinds",
				Parent = MainTab,
			})

			local AddBind = function(Table)
				local Name = Table.Name
				local Start = Table.Start
				local End = Table.End
				local KeyCode = Table.KeyCode

				if not Settings.Binds[tostring(KeyCode)] then
					Settings.Binds[tostring(KeyCode)] = {
						Start = Start,
						End = End,
						Nickname = Name,
					}

					local NewSwitch = Library.new("Switch", { 
						Title = Name,
						Description = "Information about this bind",
						Parent = Binds,
					})

					Library.new("Label", { 
						Title = "Input began command",
						Description = Start,
						Parent = NewSwitch,
					})

					Library.new("Label", { 
						Title = "Input ended command",
						Description = End,
						Parent = NewSwitch,
					})

					Library.new("Label", { 
						Title = "KeyCode",
						Description = tostring(KeyCode),
						Parent = NewSwitch,
					})

					Library.new("Button", { 
						Title = "Delete bind",
						Description = "Deletes the bind",
						Parent = NewSwitch,
						Callback = function()
							Utils.Popup("Confirmation", format("Are you sure you want to remove the '%s' bind?", Name), function()
								Settings.Binds[tostring(KeyCode)] = nil
								Utils.Notify("Success", "Success!", "Bind has been removed")
							end)
						end,
					})

				else
					Utils.Notify("Error", "Error!", format("A bind already exists with this keybind! (Keybind - %s", tostring(KeyCode)))
				end
			end

			Library.new("Button", { 
				Title = "New Bind",
				Description = "Create a new command keybind!",
				Parent = MainTab,

				Callback = function()
					local Popup, Scroll = Tab.Popup(Main, "Add a new bind")

					local Info = {
						Start = false,
						End = false,
						Bind = false,
						Nickname = nil,
					}

					Tab.ShowPopup(Popup)

					Library.new("Input", { 
						Title = "Bind Name",
						Description = "The name of the bind (REQUIRED)",
						Parent = Scroll,
						Default = "",
						Callback = function(Nick)
							Info.Nickname = Nick
						end,
					})

					Library.new("Input", { 
						Title = "Bind Start",
						Description = "Command that runs when you begin holding the key",
						Parent = Scroll,
						Default = "",
						Callback = function(Cmd)
							Info.Start = Cmd
						end,
					})

					Library.new("Input", { 
						Title = "Bind End",
						Description = "Command that runs when you stop holding the selected key",
						Parent = Scroll,
						Default = "",
						Callback = function(Cmd)
							Info.End = Cmd
						end,
					})

					Library.new("Bind", { 
						Title = "KeyCode",
						Description = "The key (letter) that fires the commands when pressed",
						Parent = Scroll,
						Callback = function(Key)
							Info.Bind = Key
						end,
					})

					Library.new("Button", { 
						Title = "Create",
						Description = "Create the keybind!",
						Parent = Scroll,
						Callback = function()
							local Start, End, Bind, Nickname = Info.Start, Info.End, Info.Bind, Info.Nickname

							if Start and End and Bind and Nickname then
								AddBind({
									Name = Nickname,
									Start = Start,
									End = End,
									KeyCode = Bind,
								})

								Utils.Notify("Success", "Success!", "Bind made!")
							else
								Utils.Notify("Error", "Error!", "Missing one or more arguments, couldn't make bind")
							end
						end,
					})		
				end,
			})

			Tweens.Open({ Canvas = Main, Speed = 0.3 })
		else
			Tweens.Open({ Canvas = Screen:FindFirstChild("Bind"), Speed = 0.3 })
		end
	end,
})

Command.Add({
	Aliases = { "settings", "options" },
	Description = "Modify all the Settings of Cmd",
	Arguments = {},
	Plugin = false,
	Task = function()
		if not Screen:FindFirstChild("Settings") then
			local Main = Tab.new({ Title = "Settings", Drag = true })
			local Tabs = Main.Tabs
			local MainTab = Tabs.Main.Scroll

			-- Tabs
			local Information = Library.new("Switch", { Title = "Information", Description = "Get info about Cmd", Parent = MainTab })
			local Themes = Library.new("Switch", { Title = "Themes", Description = "Modify the appearance of Cmd", Parent = MainTab })	
			local Default = Library.new("Switch", { Title = "Default Themes", Description = "Default Themes on Cmd", Parent = Themes })
			local Custom = Library.new("Switch", { Title = "Custom", Description = "Make your own custom theme", Parent = Themes })

			-- Information
			Library.new("Section", { Title = "Discord", Parent = Information })

			Library.new("Label", { Title = "Join our Discord!",
				Description = "discord.com/invite/qXcMYSgQ",
				Parent = Information 
			})

			Library.new("Section", { Title = "Cmd", Parent = Information })

			Library.new("Label", { Title = "Commands loaded",
				Description = tostring(Command.Count),
				Parent = Information 
			})

			Library.new("Label", { Title = "Version",
				Description = Settings.Version,
				Parent = Information 
			})

			Library.new("Label", { Title = "Prefix",
				Description = Settings.Prefix,
				Parent = Information 
			})

			Library.new("Label", { Title = "Player Seperator (player1,player2)",
				Description = Settings.Player,
				Parent = Information 
			})

			Library.new("Label", { Title = "UI Scale Size",
				Description = tostring(Settings.ScaleSize),
				Parent = Information 
			})


			-- Themes
			Library.new("Input", { Title = "Transparency", Description = "Set transparency of the UI", Default = "0.05", Parent = Themes, Callback = function(Input) 
				local Numeral = tonumber(Input)

				if Numeral and Numeral < 0.9 then
					Settings.Themes.Transparency = Numeral
					Library.LoadTheme()
				end
			end})

			Library.new("Input", { Title = "UIScale", Description = "Set the Scale of the UI.\nDefault - 1", Default = tostring(Settings.ScaleSize), Parent = Themes, Callback = function(Input) 
				local Numeral = tonumber(Input)

				if Numeral and Numeral < 2 and Numeral > 0.2 then
					SetUIScale(Numeral)

					Utils.Notify("Success", "Success!", "Set and saved your UIScale successfully!", 15)
				else
					Utils.Notify("Error", "Error!", "Couldn't set UIScale, make sure that the value inputted is more than 0.2 and less than 2!", 15)
				end
			end})

			Library.new("Button", { 
				Title = "Save Theme",
				Description = "Save the current theme you have applied",
				Parent = Custom,
				Callback = function()
					Data.SaveTheme(Settings.Themes)
					Utils.Notify("Success", "Success!", "Theme has been saved", 5)
				end,
			})

			for Index, Theme in Library.Themes do
				Library.new("Button", { 
					Title = Index,
					Parent = Default,
					Callback = function()
						Theme()
					end,
				})
			end

			Tweens.Open({ Canvas = Main, Speed = 0.3 })
		else
			Tweens.Open({ Canvas = Screen:FindFirstChild("Settings"), Speed = 0.3 })
		end
	end,
})

local ESPSettings = {
	Fill = 0.5,
	Outline = 0,
	Current = false,
}

Command.Add({
	Aliases = { "esp", },
	Description = "See players through walls",
	Arguments = {},
	Plugin = false,
	Task = function()
		local SetESP = function(Bool, Transparency, Fill)
			ESPSettings.Outline = Transparency
			ESPSettings.Fill = Fill

			for Index, Player in next, Services.Players:GetPlayers() do
				local Character = Character(Player)

				if Character then
					if Bool then
						local Find = Character:FindFirstChildOfClass("Highlight")

						if not Find then
							local Highlight = Instance.new("Highlight", Character)
							Highlight.OutlineTransparency = Transparency
							Highlight.FillTransparency = Fill
							ESPSettings.Outline = Transparency
							ESPSettings.Fill = Fill
						else
							Find.Enabled = true
							Find.OutlineTransparency = Transparency
							Find.FillTransparency = Fill
						end
					else
						local Highlight = Character:FindFirstChildOfClass("Highlight")

						if Highlight then
							Highlight:Destroy()
						end
					end
				end
			end
		end

		if not Screen:FindFirstChild("ESP") then
			local Main = Tab.new({ Title = "ESP", Drag = true })
			local Tabs = Main.Tabs
			local MainTab = Tabs.Main.Scroll

			Library.new("Toggle", { Title = "Enabled",
				Description = "Switch to enable the ESP",
				Default = false,
				Parent = MainTab,
				Callback = function(Boolean)
					SetESP(Boolean, ESPSettings.Outline, ESPSettings.Fill)
					ESPSettings.Current = Boolean
				end,
			})

			Library.new("Input", { Title = "Outline Transparency",
				Description = "Change the transparency of the outlines",
				Default = 0,
				Parent = MainTab,
				Callback = function(Input)
					Outline = SetNumber(Input)
					SetESP(ESPSettings.Current, Outline, ESPSettings.Fill)
				end,
			})

			Library.new("Input", { Title = "Fill Transparency",
				Description = "Change the transparency of the ESP Fill",
				Default = 0.5,
				Parent = MainTab,
				Callback = function(Input)
					Fill = SetNumber(Input)
					SetESP(ESPSettings.Current, ESPSettings.Outline, Fill)
				end,
			})

			for Index, Player in next, Services.Players:GetPlayers() do
				local Char = Character(Player)

				if ESPSettings.Current and Char and not Char:FindFirstChildOfClass("Highlight") then
					local Highlight = Instance.new("Highlight", Char)
					Highlight.OutlineTransparency = ESPSettings.Outline
					Highlight.FillTransparency = ESPSettings.Fill
				end

				Player.CharacterAdded:Connect(function(Char)
					if ESPSettings.Current then
						local Highlight = Instance.new("Highlight", Char)
						Highlight.OutlineTransparency = ESPSettings.Outline
						Highlight.FillTransparency = ESPSettings.Fill
					end
				end)
			end

			Services.Players.PlayerAdded:Connect(function(Player)
				local Char = Character(Player)

				if Char and ESPSettings.Current then
					local Highlight = Instance.new("Highlight", Char)
					Highlight.OutlineTransparency = ESPSettings.Outline
					Highlight.FillTransparency = ESPSettings.Fill
				end

				Player.CharacterAdded:Connect(function(Char)
					if ESPSettings.Current then
						local Highlight = Instance.new("Highlight", Char)
						Highlight.OutlineTransparency = ESPSettings.Outline
						Highlight.FillTransparency = ESPSettings.Fill
					end
				end)
			end)

			Tweens.Open({ Canvas = Main, Speed = 0.3 })
		else
			Tweens.Open({ Canvas = Screen:FindFirstChild("ESP"), Speed = 0.3 })
		end
	end,
})

Command.Add({
	Aliases = { "players", },
	Description = "Get a list of info on players",
	Arguments = {},
	Plugin = false,
	Task = function()
		if not Screen:FindFirstChild("Players") then
			local Main = Tab.new({
				Title = "Players",
				Drag = true
			})

			local Tabs = Main.Tabs
			local MainTab = Tabs.Main.Scroll

			local MakeTab = function(Player)
				if Player then
					local Name = Player.Name
					local Display = Player.DisplayName
					local Age = Player.AccountAge
					local UserId = Player.UserId
					local Team = Player.Team

					local New, Button = Library.new("Switch", { Title = Display, Description = format("@%s", Name), Parent = MainTab })
					Library.new("Section", { Title = "Information", Parent = New })

					Library.new("Label", { 
						Title = "Account Age",
						Description = format("%s days", tostring(Age)),
						Parent = New,
					})

					Library.new("Label", { 
						Title = "User Id",
						Description = tostring(UserId),
						Parent = New,
					})

					Library.new("Label", { 
						Title = "Team",
						Description = Team,
						Parent = New,
					})

					Library.new("Section", { Title = "Actions", Parent = New })

					Library.new("Button", { 
						Title = "Goto",
						Description = "Teleports you to the target",
						Parent = New,
						Callback = function()
							GetRoot(Local.Character).CFrame = GetRoot(Character(Player)).CFrame
						end,
					})

					Library.new("Toggle", { 
						Title = "Spectate",
						Description = "Makes you view the player",
						Parent = New,
						Default = false,
						Callback = function(Bool)
							local Humanoid = GetHumanoid(Character(Player))

							if Humanoid then
								if Bool then
									Services.Camera.CameraSubject = Humanoid
								else
									Services.Camera.CameraSubject = GetHumanoid(Local.Character)
								end
							end
						end,
					})

					Library.new("Input", { 
						Title = "Whisper",
						Description = "Whisper something to them",
						Parent = New,
						Default = "",
						Callback = function(Message)
							Chat(string.format("/w %s %s", Name, Message))
						end,
					})

					Services.Players.PlayerRemoving:Connect(function(PlayerInstance)
						if PlayerInstance == Player then
							Button:Destroy()
						end
					end)
				end
			end

			for Index, Player in next, Services.Players:GetPlayers() do
				MakeTab(Player)
			end

			Services.Players.PlayerAdded:Connect(function(Player)
				MakeTab(Player)
			end)

			Tweens.Open({ Canvas = Main, Speed = 0.3 })
		else
			Tweens.Open({ Canvas = Screen:FindFirstChild("Players"), Speed = 0.3 })
		end
	end,
})

Command.Add({
	Aliases = { "logs" },
	Description = "Shows all the stuff Cmd has logged (Http, Joins, Leaves, etc.)",
	Arguments = {},
	Plugin = false,
	Task = function()
		if not Screen:FindFirstChild("Logs") then
			local Order = 99999999

			local Main = Tab.new({
				Title = "Logs",
				Drag = true
			})

			local SetOrder = function(LibraryInstance)

				local Success, Result = pcall(function()
					Order = Order - 1
					LibraryInstance.LayoutOrder = Order
				end)

				if not Success then
					warn(Result)
				end

				return LibraryInstance
			end

			local Tabs = Main.Tabs
			local MainTab = Tabs.Main.Scroll

			local Chat = Library.new("Switch", { Title = "Chat", Description = "Logs everytime someone chats", Parent = MainTab })
			local Joins = Library.new("Switch", { Title = "Joins", Description = "Logs when someone joins the game", Parent = MainTab })
			local Leaves = Library.new("Switch", { Title = "Leaves", Description = "Logs when someone leaves the game", Parent = MainTab })
			local Http = Library.new("Switch", { Title = "Http", Description = "Logs all Http requests made by other scripts", Parent = MainTab })

			Services.Players.PlayerAdded:Connect(function(Player)
				SetOrder(Library.new("Label", { Title = format("%s (@%s)", Player.DisplayName, Player.Name), Description = "has joined the game", Parent = Joins }))

				Player.Chatted:Connect(function(Message)
					SetOrder(Library.new("Label", { Title = format("%s (@%s)", Player.DisplayName, Player.Name), Description = format('said "%s"', Message), Parent = Chat }))
				end)
			end)

			Services.Players.PlayerRemoving:Connect(function(Player)
				SetOrder(Library.new("Label", { Title = format("%s (@%s)", Player.DisplayName, Player.Name), Description = "has left the game", Parent = Leaves }))
			end)

			for Index, Player in next, Services.Players:GetPlayers() do
				Player.Chatted:Connect(function(Message)
					SetOrder(Library.new("Label", { Title = format("%s (@%s)", Player.DisplayName, Player.Name), Description = format('said "%s"', Message), Parent = Chat }))
				end)
			end

			pcall(function()

				local Httpget

				Httpget =
					hookfunction(
						game.HttpGet,
						newcclosure(
							function(self, url)
								SetOrder(Library.new("Label", { Title = "HttpGet logged", Description = url, Parent = Http }))
								return Httpget(self, url)
							end
						)
					)

				local Httppost
				Httppost =
					hookfunction(
						game.HttpPost,
						newcclosure(
							function(self, url)
								SetOrder(Library.new("Label", { Title = "HttpPost logged", Description = url, Parent = Http }))
								return Httppost(self, url)
							end
						)
					)

				if (game.HttpGet ~= game.HttpGetAsync) then
					local HttpgetAsync
					HttpgetAsync =
						hookfunction(
							game.HttpGetAsync,
							newcclosure(
								function(self, url)
									SetOrder(Library.new("Label", { Title = "HttpGetAsync request logged", Description = url, Parent = Http }))
									return HttpgetAsync(self, url)
								end
							)
						)
				end

				if (game.HttpPost ~= game.HttpPostAsync) then
					local HttppostAsync
					HttppostAsync =
						hookfunction(
							game.HttpPostAsync,
							newcclosure(
								function(self, url)
									SetOrder(Library.new("Label", { Title = "HttpPostAsync request logged", Description = url, Parent = Http }))
									return HttppostAsync(self, url)
								end
							)
						)
				end
			end)

			Tweens.Open({ Canvas = Main, Speed = 0.3 })
		else
			Tweens.Open({ Canvas = Screen:FindFirstChild("Logs"), Speed = 0.3 })
		end
	end,
})

Command.Add({
	Aliases = { "notify", "send", "notification" },
	Description = "Send a notification using Cmd's Utility System",
	Arguments = { 
		{ Name = "Mode", Type = "String" },
		{ Name = "Title", Type = "String" },
		{ Name = "Description", Type = "String" },
		{ Name = "Duration", Type = "Number" },
	},
	Plugin = false,
	Task = function(Mode, Title, Description, Duration)
		Utils.Notify(Mode, Title, Description, Duration)
	end,
})

Command.Add({
	Aliases = { "chat", "say" },
	Description = "Say something in chat",
	Arguments = { 
		{ Name = "Text", Type = "String" }
	},
	Plugin = false,
	Task = function(Input)
		Chat(Input)
	end,
})

Command.Add({
	Aliases = { "fieldofview", "fov" },
	Description = "Set your field of view amount",
	Arguments = { 
		{ Name = "FOV", Type = "Number" }
	},
	Plugin = false,
	Task = function(Input)
		workspace.Camera.FieldOfView = SetNumber(Input)
	end,
})

Command.Add({
	Aliases = { "walkspeed", "speed", "ws" },
	Description = "Set your walkspeed amount",
	Arguments = { 
		{ Name = "Speed", Type = "Number" }
	},
	Plugin = false,
	Task = function(Input)
		local Amount = SetNumber(Input)

		GetHumanoid(Local.Character).WalkSpeed = Amount
	end,
})

Command.Add({
	Aliases = { "hipheight" },
	Description = "Set your hipheight amount",
	Arguments = { 
		{ Name = "Hipheight", Type = "Number" }
	},
	Plugin = false,
	Task = function(Input)
		local Amount = SetNumber(Input)

		GetHumanoid(Local.Character).HipHeight = Amount
	end,
})


Command.Add({
	Aliases = { "jumppower", "power", "jp" },
	Description = "Set your jumppower amount",
	Arguments = { 
		{ Name = "Jump Power Amount", Type = "Number" }
	},
	Plugin = false,
	Task = function(Input)
		local Amount = SetNumber(Input)
		local Humanoid = GetHumanoid(Local.Character)

		Humanoid.JumpPower = Amount
		Humanoid.UseJumpPower = true
	end,
})

Command.Add({
	Aliases = { "prefix" },
	Description = "Set the prefix for the command bar & chat",
	Arguments = {
		{ Name = "Prefix", Type = "String" }
	},
	Plugin = false,
	Task = function(Prefix)
		if Prefix and #Prefix == 1 then
			Settings.Prefix = Prefix
			Utils.Notify("Success", "Success!", format("Set your command bar to %s", Prefix))
		else
			Utils.Notify("Error", "Error!", "Failed to set prefix")
		end
	end,
})

Command.Add({
	Aliases = { "saveprefix" },
	Description = "Save the prefix for the command bar & chat",
	Arguments = {
		{ Name = "Prefix", Type = "String" }
	},
	Plugin = false,
	Task = function(Prefix)
		if Prefix and #Prefix == 1 then
			Data.SetSetting("Prefix", Prefix)
			Utils.Notify("Success", "Success!", format("Set your command bar to %s", Prefix))
		else
			Utils.Notify("Error", "Error!", "Failed to set prefix")
		end
	end,
})

Command.Add({
	Aliases = { "infinitejump", "infjump" },
	Description = "Lets you jump in the air",
	Arguments = {},
	Plugin = false,
	Task = function()
		Services.Input.InputBegan:Connect(function(Key)
			if Key.KeyCode == Enum.KeyCode.Space then
				GetHumanoid(Local.Character):ChangeState("Jumping")
				Wait()
				GetHumanoid(Local.Character):ChangeState("Seated")
			end
		end)

		Utils.Notify("Success", "Success!", "Infinite Jump is enabled!", 5)
	end,
})

Command.Add({
	Aliases = { "badges" },
	Description = "Touches all badge collectors in the game, if they have the word 'badge' in them",
	Arguments = {},
	Plugin = false,
	Task = function()
		local Amount = 0

		if firetouchinterest then
			for Index, BadgeGiver in next, workspace:GetDescendants() do
				if BadgeGiver.Name:lower():find("badge") and BadgeGiver:FindFirstChildOfClass("TouchTransmitter") then
					firetouchinterest(Local.Character.HumanoidRootPart, BadgeGiver, 0)
					firetouchinterest(Local.Character.HumanoidRootPart, BadgeGiver, 1)
					Amount = Amount + 1
				end
			end

			Utils.Notify("Success", "Success!", format("Found %s badge givers!", tostring(Amount)))
		else
			Utils.Notify("Error", "Error!", "Your executor doesnt support this command, missing function : firetouchinterst()", 5)
		end
	end,
})

Command.Add({
	Aliases = { "admin" },
	Description = "Give the target access to use Cmd's commands",
	Arguments = {
		{ Name = "Target", Type = "Player" }
	},
	Plugin = false,
	Task = function(Player)
		local Target = GetPlayer(Player)

		for Index, Player in next, Target do
			Command.Whitelist(Player)
			Chat(format("/w %s You are now admin! Prefix is '%s'", Player.Name, Settings.Prefix))
		end
	end,
})

Command.Add({
	Aliases = { "unadmin" },
	Description = "Unadmin the target",
	Arguments = {
		{ Name = "Target", Type = "Player" }
	},
	Plugin = false,
	Task = function(Player)
		local Target = GetPlayer(Player)

		for Index, Player in next, Target do
			Command.RemoveWhitelist(Player)
			Chat(format("/w %s You are no longer whitelisted to use commands.", Player.Name))
		end
	end,
})

Command.Add({
	Aliases = { "goto", "to" },
	Description = "Teleports you to your target",
	Arguments = {
		{ Name = "Target", Type = "Player" }
	},
	Plugin = false,
	Task = function(Player)
		local Target = GetPlayer(Player)

		for Index, Player in next, Target do
			local Root = GetRoot(Player.Character)

			if Root then
				GetRoot(Local.Character).CFrame = Root.CFrame
			end
		end
	end,
})

Command.Toggles.LoopGoto = false
Command.Add({
	Aliases = { "loopgoto", "loopto" },
	Description = "Repeatedly teleports you to your target",
	Arguments = {
		{ Name = "Target", Type = "Player" }
	},
	Plugin = false,
	Task = function(Player)
		local Target = GetPlayer(Player)

		for Index, Player in next, Target do
			local Root = GetRoot(Player.Character)

			if Root then
				Command.Toggles.LoopGoto = true

				repeat task.wait()
					GetRoot(Local.Character).CFrame = Root.CFrame
				until not Command.Toggles.LoopGoto
			end
		end
	end,
})

Command.Add({
	Aliases = { "unloopgoto", "unloopto" },
	Description = "Stops the loopgoto command",
	Arguments = {},
	Plugin = false,
	Task = function()
		Command.Toggles.LoopGoto = false
	end,
})

Command.Add({
	Aliases = { "godmode", "god" },
	Description = "Touching any kill bricks won't kill you",
	Arguments = {},
	Plugin = false,
	Task = function()
		for Index, Part in next, workspace:GetDescendants() do
			if Part:IsA("BasePart") then
				Part.CanTouch = false
			end
		end
	end,
})


Command.Add({
	Aliases = { "serverfreeze", "freezewalk" },
	Description = "Freezes your character on the server but lets you walk on the client, lets you kill enemies without them seeing you",
	Arguments = {},
	Plugin = false,
	Task = function()
		local Character = Local.Character
		local Root = GetRoot(Character)

		if R6Check(Local.Player) then
			local Clone = Root:Clone()
			Root:Destroy()
			Clone.Parent = Character
		else
			Character.LowerTorso.Anchored = true
			Character.LowerTorso.Root:Destroy()
		end

		Utils.Notify("Success", "Success!", "Server freeze is now activated, reset to stop it.", 10)
	end,
})

Command.Add({
	Aliases = { "massplay" },
	Description = "Uses all the boomboxes in your inventory and plays them all at the same time",
	Arguments = {
		{ Name = "Sound Id", Type = "String" }
	},
	Plugin = false,
	Task = function(SoundId)
		local Settings = {
			[1] = "PlaySong",
			[2] = SoundId
		}

		for i, Boombox in next, Local.Backpack:GetChildren() do
			if (Boombox.Name == "Radio" or Boombox.Name == "Boombox") or (Boombox:FindFirstChild("Server") and Boombox:FindFirstChild("Client")) then
				Boombox.Parent = Local.Character
				Boombox.Remote:FireServer(unpack(Settings))
			end
		end
	end,
})

Command.Toggles.Sync = false
Command.Add({
	Aliases = { "sync" },
	Description = "Repeatedly plays all the sounds in game",
	Arguments = {
		{ Name = "Delay", Type = "String" }
	},
	Plugin = false,
	Task = function(Time)
		local Cooldown = SetNumber(Time, 0.1, math.huge)
		Command.Toggles.Sync = true

		if not Services.Sound.RespectFilteringEnabled then
			Command.Toggles.Sync = true
			repeat Wait(Cooldown)
				for Index, Sound in next, workspace:GetDescendants() do
					if Sound:IsA("Sound") then
						Sound.Volume = 10
						Sound:Play()
					end
				end
			until not Command.Toggles.Sync
		else
			Utils.Notify("Error", "Error!", "Respect Filtering Enabled is on, so this command wont work.", 5)
		end
	end,
})

Command.Add({
	Aliases = { "unsync" },
	Description = "Stops the sync command",
	Arguments = {},
	Plugin = false,
	Task = function(Time)
		Command.Toggles.Sync = false
	end,
})

Command.Add({
	Aliases = { "dex" },
	Description = "Opens up an explorer showing you all instances in the game",
	Arguments = {},
	Plugin = false,
	Task = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
	end,
})


Command.Add({
	Aliases = { "cameranoclip", "camnoclip" },
	Description = "Clips your camera through walls",
	Arguments = {},
	Plugin = false,
	Task = function()
		Local.Player.DevCameraOcclusionMode = Enum.DevCameraOcclusionMode.Invisicam
	end,
})

Command.Add({
	Aliases = { "thirdperson", "third" },
	Description = "Lets you view in third person mode",
	Arguments = {},
	Plugin = false,
	Task = function()
		Local.Player.CameraMaxZoomDistance = 10
		Local.Player.CameraMode = "Classic"
	end,
})

Command.Add({
	Aliases = { "view", "spectate" },
	Description = "View your target",
	Arguments = {
		{ Name = "Target", Type = "Player" }
	},
	Plugin = false,
	Task = function(Player)
		local Target = GetPlayer(Player)

		for Index, Player in next, Target do
			local Humanoid = GetHumanoid(Player.Character)

			if Humanoid then
				Services.Camera.CameraSubject = Humanoid
			end
		end
	end,
})

Command.Add({
	Aliases = { "unview", "unspectate" },
	Description = "View yourself",
	Arguments = {},
	Plugin = false,
	Task = function()
		Services.Camera.CameraSubject = GetHumanoid(Local.Character)
	end,
})

Command.Toggles.HiddenWalls = {}
Command.Add({
	Aliases = { "showwalls" },
	Description = "Shows all the invisible walls",
	Arguments = {},
	Plugin = false,
	Task = function()
		for Index, Wall in next, workspace:GetDescendants() do
			if Wall:IsA("BasePart") and Wall.Transparency == 1 and Wall.Name ~= "HumanoidRootPart" then
				table.insert(Command.Toggles.HiddenWalls, Wall)
				Wall.Transparency = 0
			end
		end
	end,
})

Command.Add({
	Aliases = { "hidewalls" },
	Description = "Undoes the show walls command",
	Arguments = {},
	Plugin = false,
	Task = function()
		for Index, Wall in next, Command.Toggles.HiddenWalls do
			Wall.Transparency = 1
		end
	end,
})

Command.Add({
	Aliases = { "buildingtools", "btools" },
	Description = "Gives you building tools",
	Arguments = {},
	Plugin = false,
	Task = function()
		for Index = 1, 4 do
			local Tool = Instance.new("HopperBin", Local.Backpack)
			Tool.BinType = Index
		end
	end,
})

Command.Add({
	Aliases = { "respawn", "re" },
	Description = "Respawns your character",
	Arguments = {},
	Plugin = false,
	Task = function()
		local Humanoid = GetHumanoid(Local.Character)
		local Old = GetRoot(Local.Character).CFrame

		if Humanoid then
			Humanoid.Health = 0
			Local.Player.CharacterAdded:Wait()
			GetRoot(Local.Character).CFrame = Old
		end
	end,
})

Command.Add({
	Aliases = { "rejoin", "rj" },
	Description = "Rejoins the game",
	Arguments = {},
	Plugin = false,
	Task = function()
		Services.Teleport:TeleportToPlaceInstance(game.PlaceId, game.JobId)
		Utils.Notify("Success", "Success!", "Rejoining..")
	end,
})

Command.Add({
	Aliases = { "rejoinre", "rjre" },
	Description = "Rejoins and teleports you to where you were before teleporting",
	Arguments = {},
	Plugin = false,
	Task = function()
		local QueueTeleport =
			(syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
		local Done = false
		local Run
		local CF = GetRoot(Local.Character).CFrame

		if not Done then
			Done = not Done
			local Run = format("spawn(function() game.Loaded:Wait() local Player = game:GetService('Players').LocalPlayer local Character = Player.Character or Player.CharacterAdded:Wait() Character:WaitForChild('HumanoidRootPart').CFrame = CFrame.new(%s) end)", tostring(CF))
			QueueTeleport(Run)
			Services.TeleportService:TeleportCancel()
			Services.TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, Local.Player)
		end
	end,
})

Command.Add({
	Aliases = { "rejoinreload" },
	Description = "Rejoins and reloads Cmd",
	Arguments = {},
	Plugin = false,
	Task = function()
		local QueueTeleport =
			(syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
		local Done = false
		local Run
		local CF = GetRoot(Local.Character).CFrame

		if not Done then
			Done = not Done
			local Run = "loadstring(game:HttpGet('https://raw.githubusercontent.com/lxte/cmd/main/testing-main.lua'))()"
			QueueTeleport(Run)
			Services.TeleportService:TeleportCancel()
			Services.TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, Local.Player)
		end
	end,
})

Command.Add({
	Aliases = { "tickgoto", "tto" },
	Description = "Teleports you to a player for a set amount of seconds",
	Arguments = {
		{ Name = "Target", Type = "Player" }, 
		{ Name = "Time", Type = "Seconds" }, 
	},
	Plugin = false,
	Task = function(Player, Time)
		local OldCFrame = GetRoot(Local.Character).CFrame 
		local Seconds = SetNumber(Time)

		for i, Player in next, GetPlayer(Player) do
			if Character(Player) and GetHumanoid(Character(Player)) then
				Local.Character:SetPrimaryPartCFrame(GetRoot(Character(Player)).CFrame)
				Wait(Seconds)
				GetRoot(Local.Character).CFrame = OldCFrame
				break
			end
		end
	end,
})


-- might be patched, will look into it.
--[[Command.Add({
	Aliases = { "toolballs" },
	Description = "Makes all your tools in inventory act like balls",
	Arguments = {},
	Plugin = false,
	Task = function()
		local Humanoid = GetHumanoid(Local.Character)
		local Tools = GetTools(Local.Player)

		if not Humanoid then return end

		for _, x in next, Tools do
			Methods.RemoveRightGrip(x)
		end

		for i,v in next, Tools do
			local Part = Instance.new("Part", workspace)
			Part.CFrame = GetRoot(Local.Character).CFrame
			Part.Size = Vector3.new(3.5,3.5,3.5)
			Part.Shape = "Ball"
			Part.Transparency = 0.9
			spawn(function()
				while Wait() do
					if v and v.Parent == Local.Character then
						v.Handle.Position = Part.Position
						v.Handle.CFrame = Part.CFrame
					else
						Wait()
						Part:Destroy()
					end
				end
			end)
		end
	end,
})]]

Command.Add({
	Aliases = { "antisit", "nosit" },
	Description = "Makes you not able to sit in chairs",
	Arguments = {},
	Plugin = false,
	Task = function()
		GetHumanoid(Local.Character):SetStateEnabled("Seated", false)
		GetHumanoid(Local.Character).Sit = true

		Utils.Notify("Success", "Success!", "Anti sit is enabled!", 5)
	end,
})

Command.Add({
	Aliases = { "unantisit", "unnosit" },
	Description = "Stops the anti sit command",
	Arguments = {},
	Plugin = false,
	Task = function()
		GetHumanoid(Local.Character):SetStateEnabled("Seated", true)
		GetHumanoid(Local.Character).Sit = false

		Utils.Notify("Success", "Success!", "Anti sit is disabled!", 5)
	end,
})

Command.Toggles.AntiFling = false
Command.Add({
	Aliases = { "antifling" },
	Description = "Makes you a harder target to fling",
	Arguments = {},
	Plugin = false,
	Task = function()
		Command.Toggles.AntiFling = true
		Utils.Notify("Success", "Success!", "Antifling is now enabled", 5)

		repeat Wait()
			for _, Players in next, Services.Players:GetPlayers() do
				if Players and Players ~= Local.Player and Players.Character then
					pcall(function()
						for i, Part in next, Players.Character:GetChildren() do
							if Part:IsA("BasePart") and Part.CanCollide then
								Part.CanCollide = false
								if Part.Name == "Torso" then
									Part.Massless = true
								end
								Part.Velocity = Vector3.new()
								Part.RotVelocity = Vector3.new()
							end
						end
					end)
				end
			end
		until not Command.Toggles.AntiFling
	end,
})

Command.Add({
	Aliases = { "unantifling" },
	Description = "Stops the antifling command",
	Arguments = {},
	Plugin = false,
	Task = function()
		Command.Toggles.AntiFling = true
		Utils.Notify("Success", "Success!", "Antifling is now disabled", 5)
	end,
})

Command.Add({
	Aliases = { "rawset" },
	Description = "Set the value of an instance's property",
	Arguments = { 
		{ Name = "Instance", Type = "String" }, 
		{ Name = "Value", Type = "String" }, 
		{ Name = "Amount", Type = "String" }
	},
	Plugin = false,
	Task = function(Object, Value, Amount)
		local instance = StringToInstance(Object)

		if Amount == "nil" then
			Amount = nil
		elseif Amount == "false" then
			Amount = false
		end

		if not instance:FindFirstChild(Value) and Value then
			instance[Value] = Amount
		end
	end,
})

Command.Toggles.Loop = false
Command.Add({
	Aliases = { "loop", "spam" },
	Description = "Loop fire a specific command",
	Arguments = { 
		{ Name = "Command Name", Type = "String" }, 
		{ Name = "Arguments", Type = "String" }, 
	},
	Plugin = false,
	Task = function(Name, Argumemts)
		local Arguments = minimum(FullArgs, 2)

		Command.Toggles.Loop = false
		Wait()
		Command.Toggles.Loop = true

		repeat Wait()
			Command.Run(Name, Arguments)
		until not Command.Toggles.Loop
	end,
})

Command.Add({
	Aliases = { "unloop", "unspam" },
	Description = "Stops all the commands that are currently being looped",
	Arguments = {},
	Plugin = false,
	Task = function()
		Command.Toggles.Loop = false
		Utils.Notify("Success", "Success!", "Stopped looping the commands that are being looped!")
	end,
})

Command.Add({
	Aliases = { "gravity" },
	Description = "Set the gravity in-game",
	Arguments = {
		{ Name = "Amount", Type = "Number" }
	},
	Plugin = false,
	Task = function(Amount)
		local Number = SetNumber(Amount)

		workspace.Gravity = Number
		Utils.Notify("Success", "Success!", format("Set gravity to %s", tostring(Number)))
	end,
})

Command.Add({
	Aliases = { "setunanchoredgravity", "sug" },
	Description = "Sets the gravity for unanchored parts",
	Arguments = {
		{ Name = "Amount", Type = "Number" }
	},
	Plugin = false,
	Task = function(Amount)
		local Gravity = SetNumber(Amount)

		spawn(function()
			while true do
				Local.Player.MaximumSimulationRadius = math.pow(math.huge, math.huge) * math.huge
				Local.Player.SimulationRadius = math.pow(math.huge, math.huge) * math.huge
				Wait()
			end
		end)

		local function SetGrav(Part)
			if Part:FindFirstChild("BodyForce") then
				return
			end

			CreateInstance("BodyForce", {
				Parent = Part, Force = Part:GetMass() * Vector3.new(Gravity, workspace.Gravity, Gravity)
			})
		end

		for i, Descendant in next, workspace:GetDescendants() do
			if Descendant:IsA("Part") and Descendant.Anchored == false then
				if not (Descendant:IsDescendantOf(Local.Character)) then
					SetGrav(Descendant)
				end
			end
		end

		workspace.DescendantAdded:Connect(function(Part)
			if Part:IsA("Part") and Part.Anchored == false then
				if not (Part:IsDescendantOf(Local.Character)) then
					SetGrav(Part)
				end
			end
		end)

		Utils.Notify("Success", "Success!", format("Set gravity for unanchored parts to %s", tostring(Gravity)))
	end,
})

Command.Add({
	Aliases = { "pushforce" },
	Description = "Makes it easier to push unanchored parts",
	Arguments = {},
	Plugin = false,
	Task = function()		
		for Index, Part in next, Local.Character:GetDescendants() do
			if Part:IsA("Part") then
				Part.CustomPhysicalProperties = PhysicalProperties.new(math.huge, 0.5, 0.5)
			end
		end

		Utils.Notify("Success", "Success!", "Push force is enabled!", 5)
	end,
})

Command.Add({
	Aliases = { "xray" },
	Description = "Lets you see through walls",
	Arguments = {},
	Plugin = false,
	Task = function()		
		for Index, Part in next, workspace:GetDescendants() do
			if Part:IsA("BasePart") and not Part.Parent:FindFirstChild("Humanoid") and not Part.Parent.Parent:FindFirstChild("Humanoid") then
				Part.LocalTransparencyModifier = 0.7
			end
		end

		Utils.Notify("Success", "Success!", "XRay is enabled!", 5)
	end,
})

Command.Add({
	Aliases = { "unxray" },
	Description = "Stops the XRay command",
	Arguments = {},
	Plugin = false,
	Task = function()		
		for Index, Part in next, workspace:GetDescendants() do
			if Part:IsA("BasePart") and not Part.Parent:FindFirstChild("Humanoid") and not Part.Parent.Parent:FindFirstChild("Humanoid") then
				Part.LocalTransparencyModifier = 0
			end
		end

		Utils.Notify("Success", "Success!", "XRay is disabled!", 5)
	end,
})

Command.Add({
	Aliases = { "clearterrain" },
	Description = "Clears all the terrain in the game",
	Arguments = {},
	Plugin = false,
	Task = function()	
		Utils.Popup("Clear Terrain", "Are you sure you want to clear all the terrain?", function()
			workspace.Terrain:Clear()
		end)
	end,
})

Command.Add({
	Aliases = { "getplayer" },
	Description = "Just used to test the GetPlayer function",
	Arguments = {
		{ Name = "Player", Type = "Player" },
	},
	Plugin = false,
	Task = function(Player)	
		print(unpack(GetPlayer(Player)))
	end,
})

Command.Toggles.Fakelag = false
Command.Add({
	Aliases = { "fakelag" },
	Description = "Makes it seem like you're lagging",
	Arguments = {},
	Plugin = false,
	Task = function()	
		Command.Toggles.Fakelag = true

		repeat
			GetRoot(Local.Character).Anchored = true
			task.wait(.05)
			GetRoot(Local.Character).Anchored = false
			task.wait(.05)
		until not Command.Toggles.Fakelag or not Local.Character
	end,
})

Command.Add({
	Aliases = { "unfakelag" },
	Description = "Stops the fake lag command",
	Arguments = {},
	Plugin = false,
	Task = function()	
		Command.Toggles.Fakelag = false
	end,
})

Command.Add({
	Aliases = { "fpsbooster" },
	Description = "Deletes all textures and more to save fps",
	Arguments = {},
	Plugin = false,
	Task = function()	
		Utils.Popup("FPS Booster", "Are you sure you want to enable this? This can't be undone", function()
			local Boost = function()
				for Index, Child in next, workspace:GetDescendants() do
					if Child:IsA("Decal") or Child:IsA("Texture") then
						Child:Destroy()
					elseif Child:IsA("BasePart") then
						Child.Material = Enum.Material.Plastic
						Child.Reflectance = 0
					elseif Child:IsA("ParticleEmitter") or Child:IsA("Trail") then
						Child.Lifetime = NumberRange.new(0)
					elseif Child:IsA("Explosion") then
						Child.BlastPressure = 1
						Child.BlastRadius = 1
					elseif
						Child:IsA("Fire") or Child:IsA("SpotLight") or Child:IsA("Smoke") or Child:IsA("Sparkles")
					then
						Child.Enabled = false
					elseif Child:IsA("MeshPart") then
						Child.Material = "Plastic"
						Child.Reflectance = 0
						Child.TextureID = 0
					elseif Child:IsA("SpecialMesh") then
						Child.TextureId = 0
					end
				end

				local Terrain = workspace.Terrain

				if sethiddenproperty then
					sethiddenproperty(Services.Lighting, "Technology", 2)
					sethiddenproperty(Terrain, "Decoration", false)
				end

				Terrain.WaterWaveSize = 0
				Terrain.WaterWaveSpeed = 0
				Terrain.WaterReflectance = 0
				Terrain.WaterTransparency = 0
				Services.Lighting.GlobalShadows = 0
				Services.Lighting.FogEnd = 9e9
				Services.Lighting.Brightness = 0
			end

			Boost()

			--[[workspace.DescendantAdded:Connect(function()
				Boost()
			end)]]
		end)
	end,
})

Command.Add({
	Aliases = { "swim" },
	Description = "Allows you to swim in the air",
	Arguments = {
		{ Name = "Speed", Type = "Number" },
	},
	Plugin = false,
	Task = function(Speed)
		Speed = SetNumber(Speed)
		workspace.Gravity = 0

		GetHumanoid(Local.Character):ChangeState(Enum.HumanoidStateType.Swimming)
		GetHumanoid(Local.Character).WalkSpeed = Speed

		for Index, Enum in next, Enum.HumanoidStateType.GetEnumItems(Enum.HumanoidStateType) do
			GetHumanoid(Local.Character):SetStateEnabled(Enum, false)
		end
	end,
})

Command.Add({
	Aliases = { "unswim" },
	Description = "Stops the swim command",
	Arguments = {},
	Plugin = false,
	Task = function()
		GetHumanoid(Local.Character).WalkSpeed = 16
		workspace.Gravity = 198

		for Index, Enum in next, Enum.HumanoidStateType.GetEnumItems(Enum.HumanoidStateType) do
			GetHumanoid(Local.Character):SetStateEnabled(Enum, true)
		end
	end,
})

Command.Add({
	Aliases = { "replicationlag" },
	Description = "Set your replication lag amount",
	Arguments = {
		{ Name = "Amount", Type = "Number" },
	},
	Plugin = false,
	Task = function(Amount)
		settings():GetService("NetworkSettings").IncommingReplicationLag = SetNumber(Amount)
	end,
})

Command.Add({
	Aliases = { "setfps" },
	Description = "Set your FPS maximum",
	Arguments = {
		{ Name = "Amount", Type = "Number" },
	},
	Plugin = false,
	Task = function(Amount)
		Amount = SetNumber(Amount, 30, 9999)
		if setfpscap then
			setfpscap(Amount)
			Utils.Notify("Success", "Success!", format("FPS cap is set to %s", tostring(Amount)), 5)
		else
			Utils.Notify("Error", "Error!", "Your executor doesn't support this command, missing function : setfpscap()", 5)
		end
	end,
})


Command.Toggles.Trigger = false
Command.Add({
	Aliases = { "triggerbot" },
	Description = "Clicks automatically when your mouse in on a player",
	Arguments = {
		{ Name = "Delay", Type = "Number" },
	},
	Plugin = false,
	Task = function(Delay)
		Delay = SetNumber(Delay, 0, 100)

		local Toggle = Enum.KeyCode.E
		Utils.Notify("Success", "Success!", "Ran triggerbot, press <b>E</b> to toggle it")

		Services.Input.InputBegan:Connect(function(Input)
			if Input.KeyCode == Toggle then
				Command.Toggles.Trigger = not Command.Toggles.Trigger
				Utils.Notify("Success", "Success!", format("Trigger bot is set to %s", tostring(Command.Toggles.Trigger)))
			end
		end)

		while Wait() do
			if Local.Mouse.Target then
				if Services.Players:GetPlayerFromCharacter(Local.Mouse.Target.Parent) and Command.Toggles.Trigger then
					Wait(Delay)
					mouse1click()
				end
			end
		end
	end,
})

Command.Add({
	Aliases = { "unlockfps" },
	Description = "Unlocks your FPS count",
	Arguments = {},
	Plugin = false,
	Task = function()
		if setfpscap then
			setfpscap(99999)
			Utils.Notify("Error", "Error!", "FPS Unlocked!", 5)
		else
			Utils.Notify("Error", "Error!", "Your executor doesn't support this command, missing function : setfpscap()", 5)
		end
	end,
})

Command.Add({
	Aliases = { "sit" },
	Description = "Makes you sit",
	Arguments = {},
	Plugin = false,
	Task = function()
		GetHumanoid(Local.Character).Sit = true
	end,
})

Command.Add({
	Aliases = { "antikick" },
	Description = "If a LOCALSCRIPT tries kicking you, it won't work",
	Arguments = {},
	Plugin = false,
	Task = function()
		local OldNamecall
		OldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(Self, ...)
			local Method = getnamecallmethod()
			if Self == Local.Player and (Method == "Kick" or Method == "kick") then
				return
			end
			return OldNamecall(Self, ...)
		end))

		Utils.Notify("Success", "Success!", "Anti Kick enabled!", 5)
	end,
})

Command.Add({
	Aliases = { "antiteleport" },
	Description = "If a LOCALSCRIPT tries teleporting you, it won't work",
	Arguments = {},
	Plugin = false,
	Task = function()
		local OldNameCall
		OldNameCall = hookmetamethod(game, "__namecall", newcclosure(function(Self, ...)
			if Self == Services.TeleportService and getnamecallmethod():lower() == "teleport" or getnamecallmethod() == "TeleportToPlaceInstance" then
				return
			end

			return OldNameCall(Self, ...)
		end))

		Utils.Notify("Success", "Success!", "Anti Teleport enabled!", 5)
	end,
})

Command.Add({
	Aliases = { "checkgrabber" },
	Description = "If someones using a tool grabber, it will tell you which one is doing that",
	Arguments = {},
	Plugin = false,
	Task = function()
		local Tool = Local.Backpack:FindFirstChildOfClass("Tool")
		local Grabber = nil
		Tool.Parent = Local.Character
		Tool.Parent = workspace

		wait(2)

		if Tool and Tool.Parent ~= workspace and Tool.Parent ~= nil then
			if Tool.Parent:IsA("Backpack") and Tool.Parent.Parent ~= Local.Player then
				Grabber = Tool.Parent.Parent.Name
			elseif Tool.Parent:IsA("Model") and Tool.Parent ~= Local.Character then
				Grabber = Tool.Parent.Name
			end
		elseif Tool.Parent == workspace then
			Local.Character.Humanoid:EquipTool(Tool)
			Utils.Notify("Information", "Info", "No grabber has been found", 5)
		end

		if Grabber then
			Utils.Notify("Information", "Info", format("Grabber found, username - %s", Grabber), 5)
		end
	end,
})

Command.Add({
	Aliases = { "gotospawn", "tospawn" },
	Description = "Teleports you to a spawnpoint",
	Arguments = {},
	Plugin = false,
	Task = function()
		for Index, Spawn in next, workspace:GetDescendants() do
			if Spawn:IsA("SpawnLocation") then
				GetRoot(Local.Character).CFrame = Spawn.CFrame * CFrame.new(0, 10, 0)
			end
		end
	end,
})

Command.Toggles.HeadStand = false
Command.Add({
	Aliases = { "headstand" },
	Description = "Stand on your target's head",
	Arguments = {
		{ Name = "Target", Type = "Player" },
	},
	Plugin = false,
	Task = function(Player)
		local Target = GetPlayer(Player)

		for Index, Player in next, Target do
			Command.Toggles.HeadStand = false
			Wait()
			Command.Toggles.HeadStand = true

			local Char = Character(Player)
			Services.Camera.CameraSubject = Char.Humanoid

			repeat
				Wait()
				Local.Character:FindFirstChild("HumanoidRootPart").CFrame =
					Char:FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(0, 5, 0)
			until not Command.Toggles.HeadStand or not Local.Character or not Char or not Char.HumanoidRootPart

			break
		end
	end,
})

Command.Add({
	Aliases = { "unheadstand" },
	Description = "Stops the headstand command",
	Arguments = {},
	Plugin = false,
	Task = function()
		Command.Toggles.HeadStand = false
	end,
})

Command.Toggles.Follow = false
Command.Add({
	Aliases = { "follow" },
	Description = "Follows your target",
	Arguments = {
		{ Name = "Target", Type = "Player" }
	},
	Plugin = false,
	Task = function(Player)
		local LocalHumanoid = GetHumanoid(Local.Character)
		local Target = GetPlayer(Player)
		Command.Toggles.Follow = true

		for Index, Player in next, Target do
			local Char = Character(Player)
			local Root = GetRoot(Char)

			if LocalHumanoid and Root then
				repeat Wait()
					LocalHumanoid:MoveTo(Root.Position)
				until not Root or not LocalHumanoid or not Command.Toggles.Follow
			end
		end
	end,
})

Command.Add({
	Aliases = { "unfollow" },
	Description = "Stops following your target",
	Arguments = {},
	Plugin = false,
	Task = function()
		Command.Toggles.Follow = false
	end,
})

Command.Add({
	Aliases = { "toolfling" },
	Description = "Fling people using tools",
	Arguments = {},
	Plugin = false,
	Task = function()
		local Random = GetTools();
		local Tool = Random[math.random(#Random)];
		Tool.Parent = Local.Character;

		if not Random or #Random == 0 then
			return
		end

		Tool.Handle.Massless = true
		Tool.GripPos = Vector3.new(0, -10000, 0)
		Utils.Notify("Success", "Success!", "Walk up to a person to fling them", 5)

	end,
})

Command.Add({
	Aliases = { "teleportposition", "tppos" },
	Description = "Teleports you to the XYZ CFrame you input",
	Arguments = {
		{ Name = "X", Type = "Number" },
		{ Name = "Y", Type = "Number" },
		{ Name = "Z", Type = "Number" },
	},
	Plugin = false,
	Task = function(X, Y, Z)
		X, Y, Z = SetNumber(X), SetNumber(Y), SetNumber(Z)

		GetRoot(Local.Character).CFrame = CFrame.new(X, Y, Z)
	end,
})

Command.Add({
	Aliases = { "unpushforce" },
	Description = "Stops the pushforce command",
	Arguments = {},
	Plugin = false,
	Task = function()		
		for Index, Part in next, Local.Character:GetDescendants() do
			if Part:IsA("Part") then
				Part.CustomPhysicalProperties = PhysicalProperties.new(1, 0.5, 0.5)
			end
		end

		Utils.Notify("Success", "Success!", "Push force is disabled!", 5)
	end,
})

Command.Add({
	Aliases = { "noclip" },
	Description = "Lets you walk through walls",
	Arguments = {},
	Plugin = false,
	Task = function()
		for i, v in next, Local.Character:GetDescendants() do
			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
	end,
})

Command.Add({
	Aliases = { "clip" },
	Description = "Stops noclipping",
	Arguments = {},
	Plugin = false,
	Task = function()
		for i, v in next, Local.Character:GetDescendants() do
			if v:IsA("BasePart") then
				v.CanCollide = true
			end
		end
	end,
})

Command.Add({
	Aliases = { "saveinstance" },
	Description = "Copies the game into an editable rbxl file",
	Arguments = {},
	Plugin = false,
	Task = function()
		if saveinstance then
			saveinstance()
			Utils.Notify("Success", "Success!", "Saving...")
		else
			Utils.Notify("Error", "Error!", "Your executor doesn't support saveinstance!", 5)
		end
	end,
})

Command.Add({
	Aliases = { "fireremote", "firer" },
	Description = "Fires the remote you put",
	Arguments = {
		{ Name = "Remote Path", Type = "String" }, 
		{ Name = "Remote Arguments", Type = "String" }, 
	},
	Plugin = false,
	Task = function(Path, Arguments)
		local Args = minimum(FullArgs, 2)
		local Remote = StringToInstance(Path)

		if Remote then
			if Remote:IsA("RemoteEvent") then
				Remote:FireServer(Args)
			elseif Remote:IsA("BindableEvent") then
				Remote:Fire(Args)
			elseif Remote:IsA("RemoteFunction") then
				Remote:InvokeServer(Args)
			end
		end
	end,
})

Command.Add({
	Aliases = { "fireremotes" },
	Description = "Fires all remotes in the game",
	Arguments = {},
	Plugin = false,
	Task = function()
		local Amount = 0

		for i, Remote in next, game:GetDescendants() do
			if Remote:IsA("BindableEvent") then
				Amount = Amount + 1
				Remote:Fire()
			elseif Remote:IsA("RemoteEvent") then
				Amount = Amount + 1
				Remote:FireServer()
			elseif Remote:IsA("RemoteFunction") then
				Amount = Amount + 1
				Remote:InvokeServer()
			end
		end

		Utils.Notify("Information", "Remotes", format("Fired %s remotes", tostring(Amount)), 5)

	end,
})

Command.Add({
	Aliases = { "fireclickdetectors", "fcd" },
	Description = "Fires all click detectors in the game",
	Arguments = {},
	Plugin = false,
	Task = function()
		local Amount = 0

		if fireclickdetector then
			for i, ClickDetector in next, workspace:GetDescendants() do
				if ClickDetector:IsA("ClickDetector") then
					Amount = Amount + 1
					fireclickdetector(ClickDetector)
				end
			end
			Utils.Notify("Information", "Click Detectors", "Fired " .. tostring(Amount) .. " click detectors", 5)
		else
			Utils.Notify("Error", "Error!", "Your executor doesnt support this command, missing function : fireclickdetector()", 5)
		end
	end,
})

Command.Add({
	Aliases = { "firetouchinterests", "fti" },
	Description = "Fires all touch interests in the game",
	Arguments = {},
	Plugin = false,
	Task = function()
		local Amount = 0

		if firetouchinterest then
			for i, Touch in next, workspace:GetDescendants() do
				if Touch:IsA("TouchTransmitter") then
					Amount = Amount + 1
					firetouchinterest(Local.Character.HumanoidRootPart, Touch.Parent, 0)
					firetouchinterest(Local.Character.HumanoidRootPart, Touch.Parent, 1)
				end
			end
			Utils.Notify("Information", "Touch Interests", format("Fired %s touch intersts", tostring(Amount)), 5)
		else
			Utils.Notify("Error", "Error!", "Your executor doesnt support this command, missing function : firetouchinterst()", 5)
		end
	end,
})

Command.Add({
	Aliases = { "fireproximityprompts", "fpp" },
	Description = "Fires all proximity prompts in the game",
	Arguments = {},
	Plugin = false,
	Task = function()
		local Amount = 0

		if fireproximityprompt then
			for i, Prox in next, workspace:GetDescendants() do
				if Prox:IsA("Part") and Prox.Name == "BanditClick" then
					Amount = Amount + 1
					fireproximityprompt(Prox.Parent)
				end
			end
			Utils.Notify("Information", "Proximity Prompts", format("Fired %s proximity prompts", tostring(Amount)), 5)
		else
			Utils.Notify("Error", "Error!", "Your executor doesnt support this command, missing function : fireproximityprompt()", 5)
		end
	end,
})

Command.Add({
	Aliases = { "setfflag", "fflag" },
	Description = "Set an fflag's value, to see FFlags go to github.com/MaximumADHD/Roblox-FFlag-Tracker",
	Arguments = {
		{ Name = "FFlag", Type = "String" },
		{ Name = "Value", Type = "String" },
	},
	Plugin = false,
	Task = function(FFlag, Value)
		if setfflag then

			if Value == "nil" then
				Value = nil
			elseif Value == "false" then
				Value = false
			elseif tonumber(Value) then
				Value = SetNumber(Value)
			end

			setfflag(FFlag, Value)
		else
			Utils.Notify("Error", "Error!", "Your executor doesn't support this command, missing functions : setfflag()", 5)
		end
	end,
})

Command.Add({
	Aliases = { "loadstring" },
	Description = "What you input into the Command Bar will be ran as code",
	Arguments = {
		{ Name = "Code", Type = "String" },
	},
	Plugin = false,
	Task = function(Code)
		loadstring(Code)()
	end,
})

Command.Add({
	Aliases = { "url" },
	Description = "Run scripts using their URL",
	Arguments = {
		{ Name = "URL", Type = "String" },
	},
	Plugin = false,
	Task = function(URL)
		loadstring(game:HttpGet(URL))()
	end,
})

Command.Toggles.AnimSpeed = false
Command.Add({
	Aliases = { "animationspeed", "animspeed" },
	Description = "Set your character's animation speed",
	Arguments = { { Name = "Amount", Type = "Number" } },
	Plugin = false,
	Task = function(Amount)
		Amount = SetNumber(Amount, 2, math.huge)

		Command.Toggles.AnimSpeed = false
		Wait()
		Command.Toggles.AnimSpeed = true

		Utils.Notify("Success", "Success!", format("Set your animation speed to %s", tostring(Amount)))

		repeat Wait()
			for Index, Track in next, Local.Character:FindFirstChild("Humanoid"):GetPlayingAnimationTracks() do
				Track:AdjustSpeed(Amount)
			end
		until not Command.Toggles.AnimSpeed
	end,
})

Command.Add({
	Aliases = { "unanimationspeed", "unanimspeed" },
	Description = "Set your character's animation speed back to normal",
	Arguments = {},
	Plugin = false,
	Task = function()
		Command.Toggles.AnimSpeed = false

		for Index, Track in next, Local.Character:FindFirstChild("Humanoid"):GetPlayingAnimationTracks() do
			Track:AdjustSpeed(2)
		end
	end,
})

Command.Add({
	Aliases = { "vehicleseat" },
	Description = "Sits you in a vehicle seat, useful for trying to find cars in games",
	Arguments = {},
	Plugin = false,
	Task = function()
		for Index, Seat in next, workspace:GetDescendants() do
			if Seat:IsA("VehicleSeat") then
				Seat:Sit(GetHumanoid(Local.Character))
				break
			end
		end
	end,
})

Command.Add({
	Aliases = { "vehiclespeed" },
	Description = "Set the speed of the vehicle you're in",
	Arguments = {
		{ Name = "Speed", Type = "Number" }	
	},
	Plugin = false,
	Task = function(Speed)	
		local Amount = SetNumber(Speed, -math.huge, math.huge)

		if VehicleSpeed then
			VehicleSpeed = VehicleSpeed:Disconnect()
		end

		VehicleSpeed = Services.Run.Stepped:Connect(function()
			local Hum = GetHumanoid(Local.Character)

			if Hum.SeatPart then
				Hum.SeatPart:ApplyImpulse(Hum.SeatPart.CFrame.LookVector * Vector3.new(Amount, Amount, Amount))
			end
		end)
	end,
})

Command.Add({
	Aliases = { "unvehiclespeed" },
	Description = "Stops the vehicle speed command",
	Arguments = {},
	Plugin = false,
	Task = function()	
		if VehicleSpeed then
			VehicleSpeed = VehicleSpeed:Disconnect()
		end
	end,
})

Command.Add({
	Aliases = { "seat" },
	Description = "Sits you in a random seat in the game",
	Arguments = {},
	Plugin = false,
	Task = function()
		for Index, Seat in next, workspace:GetDescendants() do
			if Seat:IsA("Seat") then
				Seat:Sit(GetHumanoid(Local.Character))
				break
			end
		end
	end,
})

Command.Add({
	Aliases = { "airwalk" },
	Description = "Lets you walk in the air",
	Arguments = {},
	Plugin = false,
	Task = function()
		local Part = CreateInstance("Part", {
			Parent = workspace,
			Size = Vector3.new(7, 2, 3),
			Transparency = 1,
			Anchored = true,
			Name = "AW",
		})

		while Part do
			Wait()
			Part.CFrame = Local.Character.HumanoidRootPart.CFrame + Vector3.new(0, -4, 0)
		end
	end,
})

Command.Add({
	Aliases = { "unairwalk" },
	Description = "Stops the airwalk command",
	Arguments = {},
	Plugin = false,
	Task = function()
		local Part = workspace:FindFirstChild("AW")

		if Part then
			Part:Destroy()
		end
	end,
})

Command.Add({
	Aliases = { "climb" },
	Description = "Lets you climb in the air",
	Arguments = {},
	Plugin = false,
	Task = function()
		local Part = CreateInstance("TrussPart", {
			Transparency = 1,
			Size = Vector3.new(2, 10, 2),
			Parent = workspace,
			CanCollide = true,
			Name = "ClimbPart",
		})

		while Part do
			Wait()
			Part.CFrame = Local.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -1.5)
		end
	end,
})

Command.Add({
	Aliases = { "unclimb" },
	Description = "Stops the climb command",
	Arguments = {},
	Plugin = false,
	Task = function()
		local Part = workspace:FindFirstChild("ClimbPart")

		if Part then
			Part:Destroy()
		end
	end,
})

Command.Add({
	Aliases = { "freecam" },
	Description = "Spectate the game freely",
	Arguments = {},
	Plugin = false,
	Task = function(Speed)
		local Free = Modules.Freecam

		if typeof(Free) == "table" then
			Modules.Freecam:EnableFreecam()
		else
			Utils.Notify("Error", "Error!", "Freecam failed to load", 5)
		end
	end,
})

Command.Add({
	Aliases = { "unfreecam" },
	Description = "Stops free camming",
	Arguments = {},
	Plugin = false,
	Task = function(Speed)
		local Free = Modules.Freecam

		if typeof(Free) == "table" then
			Modules.Freecam:StopFreecam()
		else
			Utils.Notify("Error", "Error!", "Freecam failed to load", 5)
		end
	end,
})

Command.Add({
	Aliases = { "bhop" },
	Description = "Bunny hop",
	Arguments = {},
	Plugin = false,
	Task = function()
		Modules.Bhop.Start()
	end,
})


Command.Add({
	Aliases = { "fly" },
	Description = "Lets you fly around the map",
	Arguments = {
		{ Name = "Speed", Type = "Number" }
	},
	Plugin = false,
	Task = function(Speed)
		local Speed = tonumber(Speed) or 10

		Fly(true, Speed)
	end,
})

Command.Add({
	Aliases = { "unfly" },
	Description = "Stops flying",
	Arguments = {},
	Plugin = false,
	Task = function()
		Fly(false)
	end,
})

Command.Add({
	Aliases = { "fling" },
	Description = "Fling your target, must have character collisions enabled to work [not finished]",
	Arguments = {},
	Plugin = false,
	Task = function(Player)
		local Targets = GetPlayer(Player);
		local LocalRoot = GetRoot(Local.Character);
		local LocalHumanoid = GetHumanoid(Local.Character);
		local Old = LocalRoot.CFrame;

		Walkfling(10000, 1000, true)

		for Index, Target in next, Targets do
			local Success, Result = pcall(function()
			local Timer = tick()
			Command.Parse("noclip")

			repeat task.wait()
				local Character = Character(Target);
				local Root = GetRoot(Character);
				local Humanoid = GetHumanoid(Character);
				
				local Position = Root.CFrame
				local Info = TweenInfo.new(0.2)

				Services.Camera.CameraSubject = GetHumanoid(Character)
				LocalHumanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
 
				Tween(LocalRoot, Info, { CFrame = (Root.CFrame + (Root.Velocity * 1.1)) })
				task.wait(0.2)
				Tween(LocalRoot, Info, { CFrame = Position * CFrame.new(0, 1, math.random(-2, 2))})
				task.wait(0.2)

			until (tick() - Timer > 3) or not Root or Root.Velocity.Magnitude > 200 or not LocalRoot
		   end)

		   if not Success then
			warn(format("failed to fling player, error: %s", Result))
		   end
		end

		task.wait(0.2)
		Command.Parse("clip")
		workspace.CurrentCamera.CameraSubject = GetHumanoid(Local.Character)
		LocalRoot.CFrame = Old
		Walkfling(10000, 1000, false)
		Utils.Notify("Success", "Success", "Finished flinging!")

	end,
})

Command.Toggles.Earthquake = false
Command.Add({
	Aliases = { "earthquake" },
	Description = "Shakes all unanchored parts in the game to give an earthquake effect",
	Arguments = {},
	Plugin = false,
	Task = function()
		Command.Toggles.Earthquake = true

		Utils.Notify("Success", "Earthquake!", "Please wait...", 5)

		spawn(function()
			while Services.Run.Heartbeat:Wait() do
				pcall(function()
					Local.Player.MaximumSimulationRadius = math.pow(math.huge, math.huge) * math.huge
					sethiddenproperty(Local.Player, "SimulationRadius", math.pow(math.huge, math.huge) * math.huge)
				end)
			end
		end)

		for Index, Part in next, workspace:GetDescendants() do
			if Part:IsA("BasePart") and not Part.Anchored and not Part.Parent:FindFirstChildOfClass("Humanoid") and not Part.Parent.Parent:FindFirstChildOfClass("Humanoid") then
				for Index = 1, 10 do
					local Velocity = CreateInstance("BodyVelocity", {
						MaxForce = Vector3.new(math.huge, math.huge, math.huge),
						P = 10000000,
						Name = "EarthquakeBodyVelocity",
						Parent = Part
					})

					spawn(function()
						repeat Wait()
							Velocity.Velocity = Vector3.new(math.random(-20, 20), math.random(-5, 5), math.random(-20, 20))
						until not Velocity
					end)
				end
			end
		end
	end,
})

Command.Add({
	Aliases = { "unearthquake" },
	Description = "Stops the earthquake command",
	Arguments = {},
	Plugin = false,
	Task = function()
		for Index, BodyVelocity in next, workspace:GetDescendants() do
			if BodyVelocity:IsA("BodyVelocity") and BodyVelocity.Name == "EarthquakeBodyVelocity" then
				BodyVelocity:Destroy()
			end
		end

		Utils.Notify("Success", "Success!", "Stopped the earthquake command!", 5)
	end,
})

Command.Add({
	Aliases = { "grabtools" },
	Description = "Grabs all dropped tools",
	Arguments = {},
	Plugin = false,
	Task = function()
		local Amount = 0

		for i, Tools in next, workspace:GetChildren() do
			if Tools:IsA("Tool") then
				GetHumanoid(Local.Character):EquipTool(Tools)
				Amount = Amount + 1
			end
		end

		Utils.Notify("Success", "Success!", format("Grabbed %s tools", tostring(Amount)), 5)
	end,
})

Command.Toggles.AutoGrabTools = false
Command.Add({
	Aliases = { "autograbtools" },
	Description = "Automatically grabs tools once they are dropped",
	Arguments = {},
	Plugin = false,
	Task = function()
		Command.Toggles.AutoGrabTools  = true
		Command.Parse("grabtools")

		workspace.ChildAdded:Connect(function(Child)
			if Child:IsA("Tool") and Command.Toggles.AutoGrabDeleteTools then
				GetHumanoid(Local.Character):EquipTool(Child)
			end
		end)

		Utils.Notify("Success", "Success!", "Auto grab tools activated!", 5)
	end,
})

Command.Add({
	Aliases = { "unautograbtools" },
	Description = "Stops the auto grab tools command",
	Arguments = {},
	Plugin = false,
	Task = function()
		Command.Toggles.AutoGrabTools = false
		Utils.Notify("Success", "Success!", "Auto grab tools disabled!", 5)
	end,
})

Command.Add({
	Aliases = { "grabdeletetools", "gdt" },
	Description = "Grabs all dropped tools and deletes them",
	Arguments = {},
	Plugin = false,
	Task = function()
		local Amount = 0

		for i, Tools in next, workspace:GetChildren() do
			if Tools:IsA("Tool") then
				GetHumanoid(Local.Character):EquipTool(Tools)
				Tools:Destroy()
				Amount = Amount + 1
			end
		end

		Utils.Notify("Success", "Success!", format("Deleted %s tools", tostring(Amount)), 5)
	end,
})

Command.Toggles.AutoGrabDeleteTools = false
Command.Add({
	Aliases = { "autograbdeletetools", "autogdt" },
	Description = "Automatically deletes tools once they are dropped",
	Arguments = {},
	Plugin = false,
	Task = function()
		Command.Toggles.AutoGrabDeleteTools  = true
		Command.Parse("grabdeletetools")

		workspace.ChildAdded:Connect(function(Child)
			if Child:IsA("Tool") and Command.Toggles.AutoGrabDeleteTools then
				GetHumanoid(Local.Character):EquipTool(Child)
				Child:Destroy()
			end
		end)

		Utils.Notify("Success", "Success!", "Auto grab delete tools activated!", 5)
	end,
})

Command.Add({
	Aliases = { "unautograbtools" },
	Description = "Stops the auto grab tools command",
	Arguments = {},
	Plugin = false,
	Task = function()
		Command.Toggles.AutoGrabDeleteTools  = false
		Utils.Notify("Success", "Success!", "Auto grab delete tools disabled!", 5)
	end,
})

Command.Toggles.Annoy = false
Command.Add({
	Aliases = { "annoy" },
	Description = "Annoys your target",
	Arguments = {
		{ Name = "Target", Type = "Player" }	
	},
	Plugin = false,
	Task = function(Player)
		local Target = GetPlayer(Player)
		Command.Toggles.Annoy = true

		for Index, Player in next, Target do
			Services.Camera.CameraSubject = Player.Character:FindFirstChildOfClass("Humanoid")

			repeat Wait()
				local R1, R2, R3 = math.random(-3, 3)
				Local.Character.HumanoidRootPart.CFrame =
					Player.Character.HumanoidRootPart.CFrame + Vector3.new(R1, R2, R3)
			until not Command.Toggles.Annoy

			break
		end
	end,
})

Command.Add({
	Aliases = { "unannoy" },
	Description = "Stops annoying your target",
	Arguments = {
		{ Name = "Target", Type = "Player" }	
	},
	Plugin = false,
	Task = function(Player)
		Command.Toggles.Annoy = false
	end,
})

Command.Add({
	Aliases = { "activatealltools", "aat" },
	Description = "Activates all tools in your inventory",
	Arguments = {},
	Plugin = false,
	Task = function()
		local Tools = GetTools();

		for i, Tool in next, Tools do
			Tool.Parent = Local.Character

			if mouse1click then
				mouse1click()
			else
				Tool:Activate()
			end

			task.wait()
			Tool.Parent = Local.Backpack
		end
	end,
})

Command.Add({
	Aliases = { "activatetool", "at" },
	Description = "Activates the specific tool in your inventory with the same name you input",
	Arguments = {
		{ Name = "Tool Name", Type = "String" }
	},
	Plugin = false,
	Task = function(Input)
		if Input then
			for i, Tool in next, Local.Backpack:GetChildren() do
				if Tool:IsA("Tool") and find(lower(Tool.Name), lower(Input)) then
					Tool.Parent = Local.Character
					if mouse1click then
						mouse1click()
					end
					Tool:Activate()
					task.wait()
					Tool.Parent = Local.Backpack
				end
			end
		end
	end,
})

Command.Add({
	Aliases = { "deletetools" },
	Description = "Deletes all tools in your inventory",
	Arguments = {},
	Plugin = false,
	Task = function()
		for i, Tool in next, GetTools() do
			if Tool:IsA("Tool") then
				Tool:Destroy()
			end
		end
	end,
})

Command.Add({
	Aliases = { "droptools" },
	Description = "Drops all tools in your inventory",
	Arguments = {},
	Plugin = false,
	Task = function()
		local Tools = GetTools();
		
		for i, Tool in next, GetTools() do
			Tool.Parent = Local.Character
			Wait()
			Tool.Parent = workspace
		end
	end,
})

Command.Add({
	Aliases = { "clickteleport", "clicktp" },
	Description = "Teleports you where ever you click",
	Arguments = {},
	Plugin = false,
	Task = function()
		local CTPTool = CreateInstance("Tool", {
			Parent = Local.Backpack,
			Name = "ClickTP",
			RequiresHandle = false
		})

		CTPTool.Activated:Connect(function()
			local Position = Local.Mouse.Hit + Vector3.new(0, 2.5, 0)
			Position = CFrame.new(Position.X, Position.Y, Position.Z)
			Local.Character:SetPrimaryPartCFrame(Position)
		end)

		local TweenTool = CreateInstance("Tool", {
			Parent = Local.Backpack,
			Name = "Tween ClickTP", 
			RequiresHandle = false
		})

		TweenTool.Activated:Connect(function()
			local Position = Local.Mouse.Hit + Vector3.new(0, 2.5, 0)
			local TweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)

			Tween(Local.Character.HumanoidRootPart, TweenInfo, { CFrame = CFrame.new(Position.X, Position.Y, Position.Z)} )
		end)
	end,
})

Command.Add({
	Aliases = { "maxslopeangle", "msa" },
	Description = "Changes your character's MaxSlopeAngle",
	Arguments = {
		{ Name = "Amount", Type = "Number" }
	},
	Plugin = false,
	Task = function(Amount)
		Amount = SetNumber(Amount)

		GetHumanoid(Local.Character).MaxSlopeAngle = Amount
		Utils.Notify("Success", "Success!", format("Set MaxSlopeAngle to %s", tostring(Amount)), 5)
	end,
})

Command.Add({
	Aliases = { "spin" },
	Description = "Makes you spin",
	Arguments = {
		{ Name = "Spin Speed", Type = "Number" }
	},
	Plugin = false,
	Task = function(Amount)
		local Amount = SetNumber(Amount)
		local Angular = GetRoot(Local.Character):FindFirstChild("Spin")

		if Angular then
			Angular:Destroy()
		end

		local Spin = CreateInstance("BodyAngularVelocity", {
			MaxTorque = Vector3.new(0, 9e9, 0),
			AngularVelocity = Vector3.new(0, Amount, 0),
			Name = "Spin",
			Parent = GetRoot(Local.Character),
		})
	end,
})

Command.Add({
	Aliases = { "unspin" },
	Description = "Stops spinning",
	Arguments = {},
	Plugin = false,
	Task = function()
		local Angular = GetRoot(Local.Character):FindFirstChild("Spin")

		if Angular then
			Angular:Destroy()
		end
	end,
})

Command.Add({
	Aliases = { "r6" },
	Description = "Shows a prompt that will switch your character rig type into R6",
	Arguments = {},
	Plugin = false,
	Task = function()
		PromptChangeRigType("R6")
	end,
})

Command.Add({
	Aliases = { "r15" },
	Description = "Shows a prompt that will switch your character rig type into R15",
	Arguments = {},
	Plugin = false,
	Task = function()
		PromptChangeRigType("R15")
	end,
})

Command.Add({
	Aliases = { "walkfling" },
	Description = "Fling without spinning",
	Arguments = {},
	Plugin = false,
	Task = function()
		Walkfling(10000, 5, true)
	end,
})

Command.Add({
	Aliases = { "unwalkfling" },
	Description = "Stops the walk fling command",
	Arguments = {},
	Plugin = false,
	Task = function()
		Walkfling(10000, 5, false)
	end,
})

Command.Add({
	Aliases = { "fastcarts" },
	Description = "Makes all carts in the game fast",
	Arguments = {},
	Plugin = false,
	Task = function()
		for i, v in next, workspace:GetDescendants() do
			if v:IsA("Model") and v:FindFirstChild("Up") and v:FindFirstChild("Down") and v:FindFirstChild("On") then
				spawn(function()
					pcall(function()
						if v.Up:FindFirstChildOfClass("ClickDetector") then
							while v do
								task.wait()
								fireclickdetector(v.Up:FindFirstChildOfClass("ClickDetector"))
							end
						end
					end)
				end)
			end
		end
	end,
})

Command.Add({
	Aliases = { "slowcarts" },
	Description = "Makes all carts in the game slow",
	Arguments = {},
	Plugin = false,
	Task = function()
		for i, v in next, workspace:GetDescendants() do
			if v:IsA("Model") and v:FindFirstChild("Up") and v:FindFirstChild("Down") and v:FindFirstChild("On") then
				spawn(function()
					pcall(function()
						if v.Up:FindFirstChildOfClass("ClickDetector") then
							while v do
								task.wait()
								fireclickdetector(v.Down:FindFirstChildOfClass("ClickDetector"))
							end
						end
					end)
				end)
			end
		end
	end,
})

Command.Toggles.Animations = {}
Command.Add({
	Aliases = { "playanimation" },
	Description = "Plays animation using its ID",
	Arguments = {
		{ Name = "Animation ID", Type = "String" }
	},
	Plugin = false,
	Task = function(Animation)
		Services.StarterPlayer.AllowCustomAnimations = true

		local Anim = Instance.new("Animation")
		Anim.AnimationId = format("rbxassetid://%s", Animation)
		local Dance = GetHumanoid(Local.Character):LoadAnimation(Anim)
		table.insert(Command.Toggles.Animations, Dance)
		Dance:Play()
	end,
})

Command.Add({
	Aliases = { "stopanimations" },
	Description = "Stops all the animations that were ran using the playanimation command",
	Arguments = {},
	Plugin = false,
	Task = function()
		for Index, Animation in next, Command.Toggles.Animations do
			if Animation then
				Animation:Stop()
			end
		end
	end,
})

Command.Add({
	Aliases = { "freezeanimations" },
	Description = "Freezes your character's animations",
	Arguments = {},
	Plugin = false,
	Task = function()
		Local.Character.Animate.Disabled = true
	end,
})

Command.Add({
	Aliases = { "unfreezeanimations" },
	Description = "Unfreezes your character's animations",
	Arguments = {},
	Plugin = false,
	Task = function()
		Local.Character.Animate.Disabled = false
	end,
})

Command.Add({
	Aliases = { "freeze" },
	Description = "Freezes your character",
	Arguments = {},
	Plugin = false,
	Task = function()
		for Index, BodyPart in next, Local.Character:GetChildren() do
			if BodyPart:IsA("BasePart") then
				BodyPart.Anchored = true
			end
		end
	end,
})

Command.Add({
	Aliases = { "unfreeze" },
	Description = "Unfreezes your character",
	Arguments = {},
	Plugin = false,
	Task = function()
		for Index, BodyPart in next, Local.Character:GetChildren() do
			if BodyPart:IsA("BasePart") then
				BodyPart.Anchored = false
			end
		end
	end,
})

Command.Toggles.Hitbox = false
Command.Add({
	Aliases = { "hitbox" },
	Description = "Set everyone's character hitbox in the server",
	Arguments = {
		{ Name = "Size", Type = "Number" }
	},
	Plugin = false,
	Task = function(Size)
		Size = tonumber(Size) or 10
		Command.Toggles.Hitbox = false
		task.wait(0.1)
		Command.Toggles.Hitbox = true

		repeat task.wait(0.1)
			for Index, Player in next, Services.Players:GetPlayers() do
				local Char = Character(Player)
				local Root = GetRoot(Char)

				if Char and Root and Player ~= Local.Player then
					Root.Size = Vector3.new(Size, Size, Size)
					Root.Transparency = 0.7
					Root.CanCollide = false
				end
			end
		until not Command.Toggles.Hitbox
	end,
})

Command.Add({
	Aliases = { "unhitbox" },
	Description = "Set everyone's character hitbox back to normal",
	Arguments = {},
	Plugin = false,
	Task = function(Size)
		Command.Toggles.Hitbox = false

		task.wait(0.2)

		for Index, Player in next, Services.Players:GetPlayers() do
			local Char = Character(Player)
			local Root = GetRoot(Char)

			if Char and Root and Player ~= Local.Player then
				Root.Size = Vector3.new(5, 5, 5)
				Root.Transparency = 1
			end
		end
	end,
})

Command.Add({
	Aliases = { "tpwalk" },
	Description = "More undetectable walkspeed changer",
	Arguments = {
		{ Name = "Speed", Type = "Number" }
	},
	Plugin = false,
	Task = function(Speed)
		Speed = SetNumber(Speed, 0, math.huge)
		TPWalk = false
		Wait()
		TPWalk = true

		repeat Wait()
			if GetHumanoid(Local.Character).MoveDirection.Magnitude > 0 then
				Local.Character:TranslateBy(GetHumanoid(Local.Character).MoveDirection * Speed * Services.Run.Heartbeat:Wait() * 10)
			end
		until not TPWalk or not Local.Character
	end,
})

Command.Add({
	Aliases = { "untpwalk" },
	Description = "Stops the tpwalk command",
	Arguments = {},
	Plugin = false,
	Task = function()
		TPWalk = false
	end,
})

Command.Add({
	Aliases = { "remotespy", "rspy" },
	Description = "Runs remote spy",
	Arguments = {},
	Plugin = false,
	Task = function()
		loadstring(game:HttpGet("https://github.com/exxtremestuffs/SimpleSpySource/raw/master/SimpleSpy.lua"))()
	end,
})

if Methods.CheckIfVulnerable() then
	Utils.Notify("Information", "Vulnerability found!", "This game has a vulnerability that can be exploited using Cmd, use the <b>vuln</b> command for more information", 15)

	Command.Add({
		Aliases = { "vuln" },
		Description = "Using the vulnerability feature built into Cmd, you can use bonus commands on players",
		Arguments = {},
		Plugin = false,
		Task = function()
			if not Screen:FindFirstChild("Vuln") then

				local Main = Tab.new({
					Title = "Vuln",
					Drag = true
				})

				local Tabs = Main.Tabs
				local MainTab = Tabs.Main.Scroll

				Library.new("Input", { 
					Title = "Kill",
					Description = "Kill your target",
					Parent = MainTab,
					Default = "",
					Callback = function(Message)
						local Plr = GetPlayer(Message)

						for Index, Target in next, Plr do
							if Character(Target) then
								Methods.Destroy(Character(Target).Head)
							end
						end
					end,
				})

				Library.new("Input", { 
					Title = "Sink",
					Description = "Sink your target to the ground",
					Parent = MainTab,
					Default = "",
					Callback = function(Message)
						local Plr = GetPlayer(Message)

						for Index, Target in next, Plr do
							if Character(Target) then
								Methods.Destroy(GetRoot(Character(Target)))
							end
						end
					end,
				})

				Library.new("Input", { 
					Title = "Bald",
					Description = "Turns your target bald",
					Parent = MainTab,
					Default = "",
					Callback = function(Message)
						local Plr = GetPlayer(Message)

						for Index, Target in next, Plr do
							if Character(Target) then
								for i, v in next, Character(Target):GetChildren() do
									if v:IsA("Accessory") then
										Methods.Destroy(v)
									end
								end
							end
						end
					end,
				})

				Library.new("Input", { 
					Title = "Fat",
					Description = "Turns your target fat",
					Parent = MainTab,
					Default = "",
					Callback = function(Message)
						local Plr = GetPlayer(Message)

						for Index, Target in next, Plr do
							if Character(Target) then
								for i, v in next, Character(Target):GetChildren() do
									if v:IsA("CharacterMesh") then
										Methods.Destroy(v)
									end
								end
							end
						end
					end,
				})

				Library.new("Input", { 
					Title = "Naked",
					Description = "Turns your target naked",
					Parent = MainTab,
					Default = "",
					Callback = function(Message)
						local Plr = GetPlayer(Message)
						local Classes = { "Shirt", "Pants", "ShirtGraphics" }

						for Index, Target in next, Plr do
							if Character(Target) then
								for i, v in next, Character(Target):GetChildren() do
									if Classes[v.ClassName] then
										Methods.Destroy(v)
									end
								end
							end
						end
					end,
				})

				Library.new("Input", { 
					Title = "Punish",
					Description = "Makes your target's character not able to reset",
					Parent = MainTab,
					Default = "",
					Callback = function(Message)
						local Plr = GetPlayer(Message)
						local Classes = { "Shirt", "Pants", "ShirtGraphics" }

						for Index, Target in next, Plr do
							if Character(Target) then
								Methods.Destroy(Character(Target))
							end
						end
					end,
				})

				Library.new("Button", { 
					Title = "BTools",
					Description = "Give yourself BTools",
					Parent = MainTab,
					Callback = function()
						local DestroyTool = CreateInstance("Tool", {
							Parent = Local.Backpack,
							RequiresHandle = false,
							Name = "Delete",
							ToolTip = "Btools (Delete)",
							TextureId = "https://www.roblox.com/asset/?id=12223874",
							CanBeDropped = false
						})

						local BtoolsEquipped = false
						DestroyTool.Equipped:Connect(function()
							BtoolsEquipped = true
						end)

						DestroyTool.Unequipped:Connect(function()
							BtoolsEquipped = false
						end)

						DestroyTool.Activated:Connect(function()
							local Explosion = CreateInstance("Explosion", {
								Parent = workspace,
								BlastPressure = 0,
								BlastRadius = 0,
								DestroyJointRadiusPercent = 0,
								ExplosionType = Enum.ExplosionType.NoCraters,
								Position = Local.Mouse.Target.Position
							})
							Methods.Destroy(Local.Mouse.Target)
						end)
					end,
				})

				Library.new("Button", { 
					Title = "Clear Map",
					Description = "Gets rid of the map",
					Parent = MainTab,
					Callback = function()
						for i, v in next, workspace:GetChildren() do
							Methods.Destroy(v)
						end
					end,
				})

				Library.new("Button", { 
					Title = "Break Game",
					Description = "Deletes every remote and script in the game",
					Parent = MainTab,
					Callback = function()
						for i, v in next, Services.Replicated:GetChildren() do
							Methods.Destroy(v)
						end
					end,
				})



				Tweens.Open({ Canvas = Main, Speed = 0.3 })
			else
				Tweens.Open({ Canvas = Screen:FindFirstChild("Commands"), Speed = 0.3 })
			end
		end,
	})
end

spawn(function()
	if Checks.File then
		local Success, Result = pcall(function()
			for Index, File in next, listfiles("Cmd/Plugins") do
				loadstring(readfile(File))()
			end
		end)

		if not Success then
			warn(format("error running plugin, error : %s", Result))
		end
	end
end)

-- Rest
for Index, Table in next, Commands do
	Autofills.Add(Table)
end

Library.LoadTheme(Settings.Themes)
Autofills.Search("")

Box:GetPropertyChangedSignal("Text"):Connect(function()
	Autofills.Recommend(Box.Text)
	Autofills.Search(Box.Text)
end)

Local.Player.Chatted:Connect(function(Message)
	if sub(Message, 1, 1) == Settings.Prefix then
		Command.Parse(Message)
	end
end)

Local.Mouse.KeyDown:Connect(function(Key)
	if Key == Settings.Prefix then
		Library.Bar(true)
		Wait()
		Box.Text = ""
		Box:CaptureFocus()
	end
end)

Services.Input.InputBegan:Connect(function(Key, Processed)
	if Processed then return end
	local Bind = Settings.Binds[tostring(Key.KeyCode)]

	if Bind then
		Command.Parse(Bind.Start)
	end
end)

Services.Input.InputEnded:Connect(function(Key, Processed)
	if Processed then return end
	local Bind = Settings.Binds[tostring(Key.KeyCode)]

	if Bind then
		Command.Parse(Bind.End)
	end
end)

Box.FocusLost:Connect(function(Enter)
	if Enter then
		Command.Parse(Box.Text)
	end

	Library.Bar(false)
end)

SetUIScale(Settings.ScaleSize)

if table.find({Enum.Platform.IOS, Enum.Platform.Android}, Services.Input:GetPlatform()) then 
	Open.Visible = true
	Library.Drag(Open)
	Library.Hover(Open)

	Open.Title.MouseButton1Click:Connect(function()
		Library.Bar(true)
		Wait()
		Box.Text = ""
		Box:CaptureFocus()
	end)
end

if getgenv then
	getgenv().CmdLoaded = true
	getgenv().CmdPath = Screen
end

Utils.Notify("Information", "IMPORTANT", "This is the testing loadstring, if you find any bugs DM them to me on discord @qipu", 10)
Utils.Notify("Success", "Loaded!", format("Loaded in %.2f seconds", tick() - LoadTime), 5)
