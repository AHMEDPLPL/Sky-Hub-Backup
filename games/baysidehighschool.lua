local nosaves = false
local saved_settings
local settings = {
	ui_bind = "Enum.KeyCode.RightControl";
	opaque = 0.4;
}
queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
HttpService = game:GetService("HttpService")
everyClipboard = setclipboard or toclipboard or set_clipboard or setrbxclipboard or (Clipboard and Clipboard.set)
HttpService = cloneref(game:GetService("HttpService")) or game:GetService("HttpService")
defaults = HttpService:JSONEncode(settings)
local OptTheme = "Midnight"
local string2 = "https://discord.com/invite/jVf7eSrED9"
_G.infydtype = 1
_G.guidragtype = "https://raw.githubusercontent.com/yofriendfromschool1/aw-temp-fix/main/skui.lua"
UserInputService = game:GetService("UserInputService")
VREnabled = game:GetService("VRService").VREnabled
local IsOnMobile = table.find({
	Enum.Platform.IOS,
	Enum.Platform.Android
}, UserInputService:GetPlatform())

if IsOnMobile then
	_G.infydtype = "https://raw.githubusercontent.com/yofriendfromschool1/mobile-delta-inf-yield/main/deltainfyield.txt"
elseif iswave then
	_G.infydtype = "https://raw.githubusercontent.com/yofriendfromschool1/wave_fixedscripts/main/iy.lua"
else
	_G.infydtype = "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"
end
local iswave = false
if detourfunction then
	if not IsOnMobile then
		iswave = true
	end
end

_G.lmao24 = "loo"
if game:GetService("SoundService").RespectFilteringEnabled == true then
	_G.lmao24 = "Enabled"
else
	_G.lmao24 = "Disabled"
end
function save()
	if not isfolder("Sky Hub") and not nosaves then
		makefolder("Sky Hub")
		nosaves = true
		task.wait()
		local update = {
			["ui_bind"] = settings["ui_bind"],
			["opaque"] = settings["opaque"]
		}
		task.wait()
		writefile([[Sky Hub/Sky Hub Settings.json]], HttpService:JSONEncode(update))
	end
end
function updatesaves()
	local update = {
		ui_bind = ui_bind;
		opaque = opaque;
	}
	writefile("Sky Hub/Sky Hub Settings.json", HttpService:JSONEncode(update))
end
task.wait()
function loadsettings()
	task.wait(1)
	if isfolder("Sky Hub") and isfile([[Sky Hub/Sky Hub Settings.json]]) then
		local success, response = pcall(function()
			local settings = HttpService:JSONDecode(readfile([[Sky Hub/Sky Hub Settings.json]]))
			if settings.ui_bind ~= nil or settings.ui_bind ~= "null" then
				if settings.ui_bind == "Enum.KeyCode.RightControl" then
					getgenv().SkyhubKeybind = Enum.KeyCode.RightControl
				elseif settings.ui_bind == "Enum.KeyCode.LeftControl" then
					getgenv().SkyhubKeybind = Enum.KeyCode.LeftControl
				elseif settings.ui_bind == "Enum.KeyCode.LeftAlt" then
					getgenv().SkyhubKeybind = Enum.KeyCode.LeftAlt
				elseif settings.ui_bind == "Enum.KeyCode.RightAlt" then
					getgenv().SkyhubKeybind = Enum.KeyCode.RightAlt
				elseif settings.ui_bind == "Enum.KeyCode.Insert" then
					getgenv().SkyhubKeybind = Enum.KeyCode.Insert
				elseif settings.ui_bind == "Enum.KeyCode.End" then
					getgenv().SkyhubKeybind = Enum.KeyCode.End
				elseif settings.ui_bind == "Enum.KeyCode.Delete" then
					getgenv().SkyhubKeybind = Enum.KeyCode.Delete
				elseif settings.ui_bind == "Enum.KeyCode.LeftShift" then
					getgenv().SkyhubKeybind = Enum.KeyCode.LeftShift
				elseif settings.ui_bind == "Enum.KeyCode.RightShift" then
					getgenv().SkyhubKeybind = Enum.KeyCode.RightShift
				elseif settings.ui_bind == "Enum.KeyCode.F1" then
					getgenv().SkyhubKeybind = Enum.KeyCode.F1
				elseif settings.ui_bind == "Enum.KeyCode.Q" then
					getgenv().SkyhubKeybind = Enum.KeyCode.Q
				elseif settings.ui_bind == "Enum.KeyCode.E" then
					getgenv().SkyhubKeybind = Enum.KeyCode.E
				elseif settings.ui_bind == "Enum.KeyCode.R" then
					getgenv().SkyhubKeybind = Enum.KeyCode.R
				elseif settings.ui_bind == "Enum.KeyCode.T" then
					getgenv().SkyhubKeybind = Enum.KeyCode.T
				elseif settings.ui_bind == "Enum.KeyCode.Y" then
					getgenv().SkyhubKeybind = Enum.KeyCode.Y
				elseif settings.ui_bind == "Enum.KeyCode.U" then
					getgenv().SkyhubKeybind = Enum.KeyCode.U
				elseif settings.ui_bind == "Enum.KeyCode.P" then
					getgenv().SkyhubKeybind = Enum.KeyCode.P
				elseif settings.ui_bind == "Enum.KeyCode.Z" then
					getgenv().SkyhubKeybind = Enum.KeyCode.Z
				elseif settings.ui_bind == "Enum.KeyCode.X" then
					getgenv().SkyhubKeybind = Enum.KeyCode.X
				elseif settings.ui_bind == "Enum.KeyCode.M" then
					getgenv().SkyhubKeybind = Enum.KeyCode.M
				elseif settings.ui_bind == "Enum.KeyCode.V" then
					getgenv().SkyhubKeybind = Enum.KeyCode.V
				elseif settings.ui_bind == "Enum.KeyCode.N" then
					getgenv().SkyhubKeybind = Enum.KeyCode.N
				elseif settings.ui_bind == "Enum.KeyCode.Period" then
					getgenv().SkyhubKeybind = Enum.KeyCode.Period
				end
			else
				getgenv().SkyhubKeybind = Enum.KeyCode.RightControl 
			end
			if settings.opaque ~= nil or settings.opaque ~= "null" then
				getgenv().BlurIntes = settings.opaque 
			else 
				getgenv().BlurIntes = 0.4 
			end
		end)
		if not success then
			Library.Notify("Warning", "Something went wrong while loading saves", 5)
			task.wait()
			save()
		end
	end
end
task.wait()
save()
local Library = loadstring(game:HttpGet(_G.guidragtype))()
loadsettings()
if IsOnMobile or VREnabled then
	Library.Notify("Warning", 'your OS is not supported with some scripts since of keyboard functions, do you want to execute a keyboard script?', 35, function(val)
		if val == true then
		else
			loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt"))()
		end
	end, {
		"Yes Please!",
		"Nah"
	})
end
if iswave then
	Library.Notify("Warning", 'Your Executor "Wave" Is dog shit and file functions are shit so would you like a fix for them so more support for more scripts or disable them? or ingore this and keep somewhat functions (takes abt 40 secs to go away)', 35, function(val)
		if val == true then
			loadstring(game:HttpGet("https://raw.githubusercontent.com/yofriendfromschool1/wave_fixedscripts/main/Disable%20file%20and%20folder%20functions%20Wave.lua"))()
		else
			loadstring(game:HttpGet("https://raw.githubusercontent.com/yofriendfromschool1/wave_fixedscripts/main/FileFixes.lua"))()
		end
	end, {
		"Enable Fix for file functions",
		"Disable File/Folder functions"
	})
end
if queueteleport then
	Library.Notify("Warning", "Would you like to bring this script with you on teleport/ to the next game?", 15, function(val)
		if val == true then
		else
			queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
		end
	end, {
		"Yes",
		"No thanks."
	})
end
if writefile and readfile and makefolder then
else
	Library.Notify("Warning", "Your Executor does not support saving files, Settings will not save.", 15)
end
if not IsOnMobile then
	Library.Notify("Current Keybind: " .. tostring(getgenv().SkyhubKeybind), "Your current keybind to toggle the gui is: " .. tostring(getgenv().SkyhubKeybind), 5)
end
local Window = Library.CreateLib("Sky Hub", OptTheme)
local Main = Window:NewTab("Main")
local MainSection = Main:NewSection("Main")
MainSection:NewDropdown("Teleports", "Teleports to Place", {
	"School",
	"Dorms",
	"Floor 1",
	"Floor 2",
	"Floor 3",
	"Floor 4",
	"Floor 5",
	"Penthouse",
	"Party",
	"Football Field",
	"Gym",
	"Principle Office",
	"Science/Boys Bathroom",
	"History",
	"English",
	"Math/Girls Bathroom",
	"Computer Lab",
	"Art",
	"Music",
	"Library",
	"Bus",
	"Aquatic Center"
}, function(currentOption)
	if currentOption == "School" then
		game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-511, 13, -24)
	elseif currentOption == "Dorms" then
		game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-511, 13, 356)
	elseif currentOption == "Floor 1" then
		game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-510, 13, 441)
	elseif currentOption == "Floor 2" then
		game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-510, 31, 441)
	elseif currentOption == "Floor 3" then
		game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-510, 48, 441)
	elseif currentOption == "Floor 4" then
		game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-510, 66, 441)
	elseif currentOption == "Floor 5" then
		game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-510, 83, 441)
	elseif currentOption == "Penthouse" then
		game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-510, 101, 441)
	elseif currentOption == "Party" then
		for i, v in pairs(game:GetService("Workspace"):GetDescendants()) do
			if v.Name == "PartyParticle" then
				game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = v.Parent.CFrame
			end
		end
	elseif currentOption == "Football Field" then
		game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-509, 17, -400)
	elseif currentOption == "Gym" then
		game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-650, 17, -195)
	elseif currentOption == "Principle Office" then
		game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-635, 17, -15)
	elseif currentOption == "Science/Boys Bathroom" then
		game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-640, 46, -122)
	elseif currentOption == "History" then
		game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-379, 46, -49)
	elseif currentOption == "English" then
		game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-641, 46, -48)
	elseif currentOption == "Math/Girls Bathroom" then
		game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-379, 46, -122)
	elseif currentOption == "Computer Lab" then
		game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-580, 46, -114)
	elseif currentOption == "Art" then
		game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-509, 46, -114)
	elseif currentOption == "Music" then
		game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-440, 46, -116)
	elseif currentOption == "Library" then
		game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-399, 17, -118)
	elseif currentOption == "Bus" then
		for i, v in pairs(game:GetService("Workspace"):GetDescendants()) do
			if v.Name == "BusSeat" then
				game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
			end
		end
	elseif currentOption == "Aquatic Center" then
		game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-488, 20, -557)
	end
end)
MainSection:NewDropdown("Spawn/despawns Vehicle/Cars", "spawns/despawns cars", {
	"Thunderbird",
	"Ladybug",
	"Offroader",
	"Golf Cart"
}, function(currentOption2)
	if currentOption2 == "Thunderbird" then
		local args = {
			[1] = "Spawn",
			[2] = "Thunderbird"
		}
		game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Vehicle"):FireServer(unpack(args))
	elseif currentOption2 == "Ladybug" then
		local args = {
			[1] = "Spawn",
			[2] = "Ladybug"
		}
		game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Vehicle"):FireServer(unpack(args))
	elseif currentOption2 == "Offroader" then
		local args = {
			[1] = "Spawn",
			[2] = "Offroader"
		}
		game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Vehicle"):FireServer(unpack(args))
	elseif currentOption2 == "Golf Cart" then
		local args = {
			[1] = "Spawn",
			[2] = "Golf Cart"
		}
		game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Vehicle"):FireServer(unpack(args))
	end
end)
MainSection:NewTextBox("Teleport in players car", "puts you in players passenger of car can put rp name too", function(txt)
	repeat
		task.wait()
		for i, v in pairs(game:GetService("Workspace").Vehicles:GetChildren()) do
			local player = txt
			local targname = ""
			for i, v in pairs(game:GetService("Players"):GetPlayers()) do
				if string.sub(string.lower(v.Name), 0, #player) == string.lower(player) or string.sub(string.lower(v.DisplayName), 0, #player) == string.lower(player) or string.sub(string.lower(v.Character.Head:WaitForChild("PlayerHover").Frame.RPName.Text), 0, #player) == string.lower(player) and v ~= game:GetService("Players").LocalPlayer  then
					targname = v.Name
				end
			end
			if v.Name == targname then
				game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = v.Body.VehicleSeat.CFrame
				wait(0.25)
				fireproximityprompt(v.Body.VehicleSeat.ButtonPrompt)
			end
		end
	until game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid").Sit == true
end)
MainSection:NewTextBox("Teleport to player", "can put rp name too for tp", function(txt)
	for i, v in pairs(game:GetService("Workspace"):GetChildren()) do
		local player = txt
		local targname = ""
		for i, v in pairs(game:GetService("Players"):GetPlayers()) do
			if string.sub(string.lower(v.Name), 0, #player) == string.lower(player) or string.sub(string.lower(v.DisplayName), 0, #player) == string.lower(player) or string.sub(string.lower(v.Character.Head:WaitForChild("PlayerHover").Frame.RPName.Text), 0, #player) == string.lower(player) and v ~= game:GetService("Players").LocalPlayer  then
				targname = v.Name
			end
		end
		if v.Name == targname then
			game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = v:WaitForChild("HumanoidRootPart").CFrame
		end
	end
end)
MainSection:NewButton("Notify all role play names", "rp names to usernames", function(txt)
	for i, v in pairs(game:GetService("Workspace"):GetDescendants()) do
		if v.Name == "RPName" and v.ClassName == "TextLabel" and v.Parent.Name == "Frame" then
			Library.Notify(v.Text .. " Is", v.Parent.Parent.Parent.Parent.Name, 4)
			task.wait(1)
		end
	end
end)
MainSection:NewTextBox("Steal Players Fit", " make sure u have avatar gui open on body then character or take off everything in their first, wears anothers player outfit and saves it", function(txt)
	local player = txt
	for i, v in pairs(game:GetService("Players"):GetPlayers()) do
		if string.sub(string.lower(v.Name), 0, #player) == string.lower(player) or string.sub(string.lower(v.DisplayName), 0, #player) == string.lower(player) or string.sub(string.lower(v.Character:FindFirstChild("Head"):WaitForChild("PlayerHover").Frame.RPName.Text), 0, #player) == string.lower(player) and v ~= game:GetService("Players").LocalPlayer  then
			targ = v
		end
	end
	local humanoiddescrip = targ.Character:WaitForChild("Humanoid"):FindFirstChild("HumanoidDescription")
	local accessory = {
		backaccessory = humanoiddescrip.BackAccessory,
		faceaccessory = humanoiddescrip.FaceAccessory,
		frontaccessory = humanoiddescrip.FrontAccessory,
		hairaccessory = humanoiddescrip.HairAccessory,
		neckaccessory = humanoiddescrip.NeckAccessory,
		shouldersaccessory = humanoiddescrip.ShouldersAccessory,
		waistaccessory = humanoiddescrip.WaistAccessory
	}
	local amins = {
		climbanimation = humanoiddescrip.ClimbAnimation,
		fallanimation = humanoiddescrip.FallAnimation,
		idleanimation = humanoiddescrip.IdleAnimation,
		jumpanimation = humanoiddescrip.JumpAnimation,
		moodanimation = humanoiddescrip.MoodAnimation,
		runanimation = humanoiddescrip.RunAnimation,
		swimanimation = humanoiddescrip.SwimAnimation,
		walkanimation = humanoiddescrip.WalkAnimation,
	}
	local bodypart = {
		face = humanoiddescrip.Face,
		head = humanoiddescrip.Head,
		leftarm = humanoiddescrip.LeftArm,
		leftleg = humanoiddescrip.LeftLeg,
		rightarm = humanoiddescrip.RightArm,
		rightleg = humanoiddescrip.RightLeg,
		torso = humanoiddescrip.Torso
	}
	local clothe = {
		graphictshirt = humanoiddescrip.GraphicTShirt,
		pants = humanoiddescrip.Pants,
		shirt = humanoiddescrip.Shirt
	}
	local color = humanoiddescrip.Parent.Parent.Head.BrickColor.Color
	local function splitStringByComma(input)
		local result = {}
		for str in string.gmatch(input, "([^,]+)") do
			table.insert(result, str)
		end
		return result
	end
	local splitstrings = {}
	for i, v in pairs(accessory) do
		local splitResults = splitStringByComma(v)
		for _, splitStr in ipairs(splitResults) do
			table.insert(splitstrings, splitStr)
		end
		task.wait()
	end
	for i, v in pairs(amins) do
		local splitResults = splitStringByComma(v)
		for _, splitStr in ipairs(splitResults) do
			table.insert(splitstrings, splitStr)
		end
		task.wait()
	end
	for i, v in pairs(bodypart) do
		local splitResults = splitStringByComma(v)
		for _, splitStr in ipairs(splitResults) do
			table.insert(splitstrings, splitStr)
		end
		task.wait()
	end
	for i, v in pairs(clothe) do
		local splitResults = splitStringByComma(v)
		for _, splitStr in ipairs(splitResults) do
			table.insert(splitstrings, splitStr)
		end
		task.wait()
	end
	for i, v in pairs(game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainGui"):WaitForChild("AvatarFrame"):WaitForChild("Scroll"):GetChildren()) do
		if v.Name ~= "UIGridLayout" and v.Name ~= "UIPadding" and v.Name ~= "Template" then
			local args = {
				[1] = "Update",
				[2] = {
					[1] = tonumber(v.Name),
					[2] = "MoodAnimation"
				}
			}
			game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Avatar"):FireServer(unpack(args))
			wait(0.75)
		end
	end
	wait(2)
	if humanoiddescrip.Parent:FindFirstChild("HeadScale").Value > 1 then
		local args = {
			[1] = "Scale",
			[2] = "Adult"
		}
		game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Avatar"):FireServer(unpack(args))
	else
		local args = {
			[1] = "Scale",
			[2] = "Teen"
		}
		game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Avatar"):FireServer(unpack(args))
	end
	local args = {
		[1] = "SkinTone",
		[2] = Color3.new(color)
	}
	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Avatar"):FireServer(unpack(args))
	for i, v in pairs(splitstrings) do
		local args = {
			[1] = "Update",
			[2] = v
		}
		game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Avatar"):FireServer(unpack(args))
		wait(0.85)
	end
	local args = {
		[1] = "Info",
		[2] = {
			[1] = humanoiddescrip.Parent.Parent:WaitForChild("Head"):WaitForChild("PlayerHover"):WaitForChild("Frame"):WaitForChild("RPName").Text,
			[2] = humanoiddescrip.Parent.Parent:WaitForChild("Head"):WaitForChild("PlayerHover"):WaitForChild("Frame"):WaitForChild("RPName").TextColor3
		},
		[3] = {
			[1] = humanoiddescrip.Parent.Parent:WaitForChild("Head"):WaitForChild("PlayerHover"):WaitForChild("Frame"):WaitForChild("Bio").Text,
			[2] = humanoiddescrip.Parent.Parent:WaitForChild("Head"):WaitForChild("PlayerHover"):WaitForChild("Frame"):WaitForChild("Bio").TextColor3
		}
	}
	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Profile"):FireServer(unpack(args))
	wait(1)
	local args = {
		[1] = "Role",
		[2] = humanoiddescrip.Parent.Parent:WaitForChild("Head"):WaitForChild("PlayerHover"):WaitForChild("Frame"):WaitForChild("Role"):WaitForChild("Label").Text
	}
	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Profile"):FireServer(unpack(args))
end)
local VehicleMods = Window:NewTab("Vehicle Mods")
local VehicleModsSection = VehicleMods:NewSection("Vehicle Mods")
VehicleModsSection:NewSlider("Vehicle Max Speed", "laggy idk why, Sets max speed of vehicle", 9999, 1, function(lol86)
	for i, v in pairs(game:GetService("Workspace"):GetDescendants()) do
		if v.Name == game:GetService("Players").LocalPlayer.Name then
			for i, v in pairs(v:GetChildren()) do
				if v.Name == "Stats" then
					for i, v in pairs(v:GetChildren()) do
						if v.Name == "MaxSpeed" then
							v.Value = lol86
						end
					end
				end
			end
		end
	end
end)
VehicleModsSection:NewSlider("Vehicle Torque", "laggy idk why, Sets torque/horsepower/hp/Acceleration of vehicle", 9999, 1, function(lol86)
	for i, v in pairs(game:GetService("Workspace"):GetDescendants()) do
		if v.Name == game:GetService("Players").LocalPlayer.Name then
			for i, v in pairs(v:GetChildren()) do
				if v.Name == "Stats" then
					for i, v in pairs(v:GetChildren()) do
						if v.Name == "Torque" then
							v.Value = lol86
						end
					end
				end
			end
		end
	end
end)
VehicleModsSection:NewSlider("Vehicle Max Turn Speed", "laggy idk why, Sets turn speed of vehicle", 9999, 1, function(lol86)
	for i, v in pairs(game:GetService("Workspace"):GetDescendants()) do
		if v.Name == game:GetService("Players").LocalPlayer.Name then
			for i, v in pairs(v:GetChildren()) do
				if v.Name == "Stats" then
					for i, v in pairs(v:GetChildren()) do
						if v.Name == "TurnSpeed" then
							v.Value = lol86
						end
					end
				end
			end
		end
	end
end)
VehicleModsSection:NewToggle("FE Rainbow Car", "rainbow car", function(state)
	if state then
		getgenv().whaterv = true -- set to false when you want it to stop and true when you want it to start again
		spawn(function()
			while wait() do
				if not getgenv().whaterv then
					break
				end
				local args = {
					[1] = "Paint",
					[2] = Color3.new(math.random(), math.random(), math.random())
				}
				game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Vehicle"):FireServer(unpack(args))
			end
		end)
	else
		getgenv().whaterv = false -- set to false when you want it to stop and true when you want it to start again
	end
end)
VehicleModsSection:NewToggle("FE Spam Horn", "annoying asf", function(state)
	if state then
		getgenv().whaterv3 = true -- set to false when you want it to stop and true when you want it to start again
		spawn(function()
			while wait() do
				if not getgenv().whaterv3 then
					break
				end
				local args = {
					[1] = "Horn"
				}
				game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Vehicle"):FireServer(unpack(args))
			end
		end)
	else
		getgenv().whaterv3 = false -- set to false when you want it to stop and true when you want it to start again
	end
end)
VehicleModsSection:NewToggle("Steal Color", "changes color of car to whatever part you click on", function(state)
	if state then
		local player = game:GetService("Players").LocalPlayer
		local mouse = player:GetMouse()
		getgenv().stealcolor = true
		local cptsOnMouseClick
		cptsOnMouseClick = mouse.Button1Down:Connect(function()
			if not getgenv().stealcolor then
				return
			end
			pcall(function()
				local object = mouse.Target
				if object and object.BrickColor then
					local args = {
						[1] = "Paint",
						[2] = object.BrickColor.Color
					}
					game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Vehicle"):FireServer(unpack(args))
				end
			end)
		end)
	else
		getgenv().stealcolor = false
	end
end)
VehicleModsSection:NewButton("Lock/Unlock Car", "Lock/unlock car", function()
	local args = {
		[1] = "Lock"
	}
	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Vehicle"):FireServer(unpack(args))
end)
MainSection:NewButton("FE Trolling GUI", "troll", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/FE%20Trolling%20GUI.luau"))()
end)
local Misc23 = Window:NewTab("Misc")
local Misc23Section = Misc23:NewSection("Misc")
Misc23Section:NewToggle("Backpack Loop", "loops tru all free backpacks", function(state)
	if state then
		getgenv().whaterv2 = true -- set to false when you want it to stop and true when you want it to start again
		spawn(function()
			while wait() do
				if not getgenv().whaterv2 then
					break
				end
				local args = {
					[1] = "Theme",
					[2] = "Default"
				}
				game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Backpack"):FireServer(unpack(args))
				local args = {
					[1] = "Theme",
					[2] = "Patched"
				}
				wait(0.51)
				game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Backpack"):FireServer(unpack(args))
				local args = {
					[1] = "Theme",
					[2] = "Checkered Luxury"
				}
				wait(0.51)
				game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Backpack"):FireServer(unpack(args))
				local args = {
					[1] = "Theme",
					[2] = "Gingham"
				}
				wait(0.51)
				game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Backpack"):FireServer(unpack(args))
				local args = {
					[1] = "Theme",
					[2] = "Hypebeast"
				}
				wait(0.51)
				game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Backpack"):FireServer(unpack(args))
				local args = {
					[1] = "Theme",
					[2] = "Preppy"
				}
				wait(0.51)
				game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Backpack"):FireServer(unpack(args))
			end
		end)
	else
		getgenv().whaterv2 = false -- set to false when you want it to stop and true when you want it to start again
	end
end)
Misc23Section:NewButton("Remove Most House/Dorm Doors", "Client sided ofc", function()
	for i, v in pairs(game:GetService("Workspace"):GetDescendants()) do
		if v.Name == "DormDoor" then
			v:Destroy()
		end
	end
end)
Misc23Section:NewToggle("Rainbow Name/Description", "Makes your name and description changes to a random color like every 0.5 secs or so, this game has delays for remote funcs", function(state)
	getgenv().lol225 = state
	local headd = game:GetService("Players").LocalPlayer.Character:WaitForChild("Head")
	local name, desc = headd:WaitForChild("PlayerHover").Frame.RPName.Text, headd:WaitForChild("PlayerHover").Frame.Bio.Text
	task.spawn(function()
		while true do
			wait()
			if not getgenv().lol225 then
				break
			end
			local args = {
				[1] = "Info",
				[2] = {
					[1] = name,
					[2] = Color3.new(math.random(), math.random(), math.random())
				},
				[3] = {
					[1] = desc,
					[2] = Color3.new(math.random(), math.random(), math.random())
				}
			}
			game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Profile"):FireServer(unpack(args))
		end
	end)
end)
local Discord = Window:NewTab("Discords", 16795709379)
local DiscordSection = Discord:NewSection("Discords")
DiscordSection:NewButton("Discord Invite", "copys discord link", function()
	if httprequest and not IsOnMobile then
		httprequest({
			Url = 'http://127.0.0.1:6463/rpc?v=1',
			Method = 'POST',
			Headers = {
				['Content-Type'] = 'application/json',
				Origin = 'https://discord.com'
			},
			Body = HttpService:JSONEncode({
				cmd = 'INVITE_BROWSER',
				nonce = HttpService:GenerateGUID(false),
				args = {
					code = 'xPDF3DkKhk'
				}
			})
		})
		Library.Notify("if nothing happened", "Make sure u have discord app open", 5)
	elseif everyClipboard then
		everyClipboard("https://discord.gg/xPDF3DkKhk")
		Library.Notify("Copied to Clipboard", "", 5)
	else
		Library.Notify("DOG SHIT EXECUTOR", "https://discord.gg/xPDF3DkKhk", 5)
	end
end)
DiscordSection:NewButton("Discord Invite OLD", "Copys Discord invite link", function()
	everyClipboard(string2)
end)
local Admins = Window:NewTab("Admins", 10016551771)
local AdminsSection = Admins:NewSection("Admins")
AdminsSection:NewButton("Infinite Yield FE", "Admin", function()
	loadstring(game:HttpGet(_G.infydtype))()
end)
AdminsSection:NewButton("Infinite Store", "Archived", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Infinite-Store/Infinite-Store/main/main.lua"))()
end)
AdminsSection:NewButton("Nameless Admin", "Admin", function()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/NamelessAdmin-NO-BYFRON-GUI/main/Source'))()
end)
AdminsSection:NewButton("fates admin", "Admin", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/fatesc/fates-admin/main/main.lua"))();
end)
AdminsSection:NewButton("Cmd", "Admin", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/lxte/cmd/main/main.lua"))()
end)
AdminsSection:NewButton("Cmd (TEST)", "Admin tests", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/lxte/cmd/main/testing-main.lua"))()
end)
AdminsSection:NewButton("Shattervast Admin", "Admin", function()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub-Backup/main/%5BFE%5D%20Shattervast.lua'))()
end)
AdminsSection:NewButton("Proton Free Admin", "Admin", function()
	_G.UI_Id = "default" --set this to "default" for the default ui
	loadstring(game:HttpGet('https://raw.githubusercontent.com/DigitalityScripts/roblox-scripts/main/Proton%20Free'))()
end)
AdminsSection:NewButton("Proton 2 free Admin", "Admin", function()
												 -- DEFAULT CMD BAR PREFIX IS ;
												 -- DEFAULT CHAT PREFIX IS /
	_G.UI_Id = "default" --set this to "default" for the default ui
	loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/5e6e6cc1bb32fd926764d064e2c60a3b.lua"))()
end)
AdminsSection:NewButton("Reviz Admin V2", "Admin", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/Reviz%20AdminV2"))()
end)
local Hubs = Window:NewTab("Hubs", 7360649366)
local HubsSection = Hubs:NewSection("Hubs")
if IsOnMobile or VREnabled then
	HubsSection:NewButton("Mobile Keyboard Script", "For mobile users", function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt"))()
	end)
end
HubsSection:NewButton("FE Trolling GUI", "FE Scripts and more.", function()--
	loadstring(game:HttpGet(('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/FE%20Trolling%20GUI.luau'), true))()
end)
HubsSection:NewButton("Sirius", "cool asl", function()--
	loadstring(game:HttpGet(('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub-Backup/main/Sirius/Sirius.txt'), true))()
end)
HubsSection:NewButton("Orca", "cool asff", function()--
	loadstring(game:HttpGet(('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub-Backup/main/Orca/latest.lua'), true))()
end)
HubsSection:NewButton("Hoho Hub", "key should be and if not then do it urself", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/acsu123/HohoV2/main/ScriptLoad.lua"))()
end)
HubsSection:NewButton("Psyhub", "idk", function()
	loadstring(game:GetObjects("rbxassetid://3014051754")[1].Source)()
end)
HubsSection:NewButton("VG Hub", "60+", function()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/1201for/V.G-Hub/main/V.Ghub'))()
end)
HubsSection:NewButton("Ezhub", "130+ games", function()--
	loadstring(game:HttpGet(('https://raw.githubusercontent.com/debug420/Ez-Industries-Launcher-Data/master/Launcher.lua'), true))()--
end)
HubsSection:NewButton("Owl Hub", "46+ how", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/CriShoux/OwlHub/master/OwlHub.txt"))();
end)
HubsSection:NewButton("CocoHub", "idk", function()
	loadstring(game:HttpGet(('https://raw.githubusercontent.com/MarsQQ/CocoHub/master/CocoZHub'), true))()
end)
HubsSection:NewButton("MonkeHub", "idk", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/KuriWasTaken/MonkeHub/main/Loader.lua"))()
end)
local Player = Window:NewTab("Player", 2795572800)
local PlayerSection = Player:NewSection("Player")
PlayerSection:NewSlider("WalkSpeed", "Changes how fast you walk", 500, 1, function(v)
	game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = v
end)
PlayerSection:NewSlider("Jumppower", "Changes how high you jump", 500, 1, function(v)
	game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower = v
end)
PlayerSection:NewSlider("Gravity", "Changes gravity", 500, 1, function(v)
	game:GetService("Workspace").Gravity = v
end)
PlayerSection:NewSlider("FOV", "Changes Field Of View", 120, 1, function(v)
	game:GetService("Workspace"):WaitForChild("Camera").FieldOfView = v
end)
PlayerSection:NewButton("Unlock Third Person", "unlocks on most games", function()
	game:GetService("Players").LocalPlayer.CameraMaxZoomDistance = 99999
	game:GetService("Players").LocalPlayer.CameraMode = Enum.CameraMode.Classic
end)
PlayerSection:NewSlider("Max Camera Zoom", "Changes zoom distance of camera", 99999, 1, function(v)
	game:GetService("Players").LocalPlayer.CameraMaxZoomDistance = v
end)
PlayerSection:NewButton("Anti Lag/Low GFX", "makes you less laggy and helps boost fps/performance", function()
	local Terrain = game:GetService("Workspace"):FindFirstChildOfClass('Terrain')
	Terrain.WaterWaveSize = 0
	Terrain.WaterWaveSpeed = 0
	Terrain.WaterReflectance = 0
	Terrain.WaterTransparency = 0
	Lighting.GlobalShadows = false
	Lighting.FogEnd = 9e9
	settings().Rendering.QualityLevel = 1
	for i, v in pairs(game:GetDescendants()) do
		if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
			v.Material = "Plastic"
			v.Reflectance = 0
		elseif v:IsA("Decal") then
			v.Transparency = 1
		elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
			v.Lifetime = NumberRange.new(0)
		elseif v:IsA("Explosion") then
			v.BlastPressure = 1
			v.BlastRadius = 1
		end
	end
	for i, v in pairs(Lighting:GetDescendants()) do
		if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
			v.Enabled = false
		end
	end
	game:GetService("Workspace").DescendantAdded:Connect(function(child)
		task.spawn(function()
			if child:IsA('ForceField') then
				RunService.Heartbeat:Wait()
				child:Destroy()
			elseif child:IsA('Sparkles') then
				RunService.Heartbeat:Wait()
				child:Destroy()
			elseif child:IsA('Smoke') or child:IsA('Fire') then
				RunService.Heartbeat:Wait()
				child:Destroy()
			end
		end)
	end)
end)
PlayerSection:NewToggle("Anti-AFK", "so you cant disconnect after 20 minutes of idling", function(state)
	if state then
		ANTIAFK = game:GetService("Players").LocalPlayer.Idled:connect(function()
			game:FindService("VirtualUser"):Button2Down(Vector2.new(0, 0), game:GetService("Workspace").CurrentCamera.CFrame)
			task.wait(1)
			game:FindService("VirtualUser"):Button2Up(Vector2.new(0, 0), game:GetService("Workspace").CurrentCamera.CFrame)
		end)
		Library.Notify("WARNING", "Successfully Enabled Anti-AFK!", 5)
	else
		if ANTIAFK then
			ANTIAFK:Disconnect()
			wait();
			Library.Notify("WARNING", "Successfully Disabled Anti-AFK!", 5)
		end
	end
end)
PlayerSection:NewToggle("Loop Full Bright", "makes game bright so if its dark u can actually see", function(state)
	local aLighting = game:GetService("Lighting")
	local oldbrit = aLighting.Brightness
	local oldclocktime = aLighting.ClockTime
	local oldfogend = aLighting.FogEnd
	local oldglobshads = aLighting.GlobalShadows
	local oldoutdooramb = aLighting.OutdoorAmbient
	local Lighting = cloneref(game:GetService("Lighting"))
	if not state then
		brightLoop:Disconnect()
		Lighting.Brightness = oldbrit
		Lighting.ClockTime = oldclocktime
		Lighting.FogEnd = oldfogend
		Lighting.GlobalShadows = oldglobshads
		Lighting.OutdoorAmbient = oldoutdooramb
	end
	local function brightFunc()
		Lighting.Brightness = 2
		Lighting.ClockTime = 14
		Lighting.FogEnd = 100000
		Lighting.GlobalShadows = false
		Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
	end
	brightLoop = game:GetService("RunService").RenderStepped:Connect(brightFunc)
end)
if IsOnMobile or VREnabled then
	PlayerSection:NewButton("enable Shiftlock", "unlocks on most games", function()
		Library.Notify("Shift Lock Enabled", "Gui should pop up on your right", 5)
		loadstring(game:HttpGet("https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub-Backup/main/mobileshiftlock.txt"))()
	end)
else
	PlayerSection:NewToggle("enable/disable shiftlock", "unlocks on most games", function(value)
		game:GetService("Players").LocalPlayer.DevEnableMouseLock = value
		if value then
			Library.Notify("Shift Lock Enabled", "Just press shift or enable it in roblox settings", 5)
		else
			Library.Notify("Shift Lock Disabled", "", 5)
		end
	end)
end
local Settingss = Window:NewTab("Settings", 11385220704)
local SettingssSection = Settingss:NewSection("Settings")
SettingssSection:NewDropdown("UI Toggle Bind", "Changes Toggle Bind for Sky Hub Default is Right Control ONLY ON PC", {
	"Right Control",
	"Left Control",
	"Left Alt",
	"Right Alt",
	"Insert",
	"End",
	"Del/Delete",
	"Left Shift",
	"Right Shift",
	"F1",
	"Q",
	"E",
	"R",
	"T",
	"Y",
	"U",
	"P",
	"Z",
	"X",
	"M",
	"V",
	"N",
	"."
}, function(currentoption)
	if currentoption == "Right Control" then
		getgenv().SkyhubKeybind = "Enum.KeyCode.RightControl"
		ui_bind = getgenv().SkyhubKeybind
		task.wait()
		if writefile then
			updatesaves()
			task.wait()
			loadsettings()
		else
			Library.Notify("DOG SHIT EXECUTOR", "Doesnt have file functions lol", 5)
		end
		if not IsOnMobile then
			Library.Notify("New Keybind: " .. tostring(getgenv().SkyhubKeybind), "Your new keybind to toggle the gui is: " .. tostring(getgenv().SkyhubKeybind), 5)
		end
	elseif currentoption == "Left Control" then
		getgenv().SkyhubKeybind = "Enum.KeyCode.LeftControl"
		ui_bind = getgenv().SkyhubKeybind
		task.wait()
		if writefile then
			updatesaves()
			task.wait()
			loadsettings()
		else
			Library.Notify("DOG SHIT EXECUTOR", "Doesnt have file functions lol", 5)
		end
		if not IsOnMobile then
			Library.Notify("New Keybind: " .. tostring(getgenv().SkyhubKeybind), "Your new keybind to toggle the gui is: " .. tostring(getgenv().SkyhubKeybind), 5)
		end
	elseif currentoption == "Left Alt" then
		getgenv().SkyhubKeybind = "Enum.KeyCode.LeftAlt"
		ui_bind = getgenv().SkyhubKeybind
		task.wait()
		if writefile then
			updatesaves()
			task.wait()
			loadsettings()
		else
			Library.Notify("DOG SHIT EXECUTOR", "Doesnt have file functions lol", 5)
		end
		if not IsOnMobile then
			Library.Notify("New Keybind: " .. tostring(getgenv().SkyhubKeybind), "Your new keybind to toggle the gui is: " .. tostring(getgenv().SkyhubKeybind), 5)
		end
	elseif currentoption == "Right Alt" then
		getgenv().SkyhubKeybind = "Enum.KeyCode.RightAlt"
		ui_bind = getgenv().SkyhubKeybind
		task.wait()
		if writefile then
			updatesaves()
			task.wait()
			loadsettings()
		else
			Library.Notify("DOG SHIT EXECUTOR", "Doesnt have file functions lol", 5)
		end
		if not IsOnMobile then
			Library.Notify("New Keybind: " .. tostring(getgenv().SkyhubKeybind), "Your new keybind to toggle the gui is: " .. tostring(getgenv().SkyhubKeybind), 5)
		end
	elseif currentoption == "Insert" then
		getgenv().SkyhubKeybind = "Enum.KeyCode.Insert"
		ui_bind = getgenv().SkyhubKeybind
		task.wait()
		if writefile then
			updatesaves()
			task.wait()
			loadsettings()
		else
			Library.Notify("DOG SHIT EXECUTOR", "Doesnt have file functions lol", 5)
		end
		if not IsOnMobile then
			Library.Notify("New Keybind: " .. tostring(getgenv().SkyhubKeybind), "Your new keybind to toggle the gui is: " .. tostring(getgenv().SkyhubKeybind), 5)
		end
	elseif currentoption == "End" then
		getgenv().SkyhubKeybind = "Enum.KeyCode.End"
		ui_bind = getgenv().SkyhubKeybind
		task.wait()
		if writefile then
			updatesaves()
			task.wait()
			loadsettings()
		else
			Library.Notify("DOG SHIT EXECUTOR", "Doesnt have file functions lol", 5)
		end
		if not IsOnMobile then
			Library.Notify("New Keybind: " .. tostring(getgenv().SkyhubKeybind), "Your new keybind to toggle the gui is: " .. tostring(getgenv().SkyhubKeybind), 5)
		end
	elseif currentoption == "Del/Delete" then
		getgenv().SkyhubKeybind = "Enum.KeyCode.Delete"
		ui_bind = getgenv().SkyhubKeybind
		task.wait()
		if writefile then
			updatesaves()
			task.wait()
			loadsettings()
		else
			Library.Notify("DOG SHIT EXECUTOR", "Doesnt have file functions lol", 5)
		end
		if not IsOnMobile then
			Library.Notify("New Keybind: " .. tostring(getgenv().SkyhubKeybind), "Your new keybind to toggle the gui is: " .. tostring(getgenv().SkyhubKeybind), 5)
		end
	elseif currentoption == "Left Shift" then
		getgenv().SkyhubKeybind = "Enum.KeyCode.LeftShift"
		ui_bind = getgenv().SkyhubKeybind
		task.wait()
		if writefile then
			updatesaves()
			task.wait()
			loadsettings()
		else
			Library.Notify("DOG SHIT EXECUTOR", "Doesnt have file functions lol", 5)
		end
		if not IsOnMobile then
			Library.Notify("New Keybind: " .. tostring(getgenv().SkyhubKeybind), "Your new keybind to toggle the gui is: " .. tostring(getgenv().SkyhubKeybind), 5)
		end
	elseif currentoption == "Right Shift" then
		getgenv().SkyhubKeybind = "Enum.KeyCode.RightShift"
		ui_bind = getgenv().SkyhubKeybind
		task.wait()
		if writefile then
			updatesaves()
			task.wait()
			loadsettings()
		else
			Library.Notify("DOG SHIT EXECUTOR", "Doesnt have file functions lol", 5)
		end
		if not IsOnMobile then
			Library.Notify("New Keybind: " .. tostring(getgenv().SkyhubKeybind), "Your new keybind to toggle the gui is: " .. tostring(getgenv().SkyhubKeybind), 5)
		end
	elseif currentoption == "F1" then
		getgenv().SkyhubKeybind = "Enum.KeyCode.F1"
		ui_bind = getgenv().SkyhubKeybind
		task.wait()
		if writefile then
			updatesaves()
			task.wait()
			loadsettings()
		else
			Library.Notify("DOG SHIT EXECUTOR", "Doesnt have file functions lol", 5)
		end
		if not IsOnMobile then
			Library.Notify("New Keybind: " .. tostring(getgenv().SkyhubKeybind), "Your new keybind to toggle the gui is: " .. tostring(getgenv().SkyhubKeybind), 5)
		end
	elseif currentoption == "Q" then
		getgenv().SkyhubKeybind = "Enum.KeyCode.Q"
		ui_bind = getgenv().SkyhubKeybind
		task.wait()
		if writefile then
			updatesaves()
			task.wait()
			loadsettings()
		else
			Library.Notify("DOG SHIT EXECUTOR", "Doesnt have file functions lol", 5)
		end
		if not IsOnMobile then
			Library.Notify("New Keybind: " .. tostring(getgenv().SkyhubKeybind), "Your new keybind to toggle the gui is: " .. tostring(getgenv().SkyhubKeybind), 5)
		end
	elseif currentoption == "E" then
		getgenv().SkyhubKeybind = "Enum.KeyCode.E"
		ui_bind = getgenv().SkyhubKeybind
		task.wait()
		if writefile then
			updatesaves()
			task.wait()
			loadsettings()
		else
			Library.Notify("DOG SHIT EXECUTOR", "Doesnt have file functions lol", 5)
		end
		if not IsOnMobile then
			Library.Notify("New Keybind: " .. tostring(getgenv().SkyhubKeybind), "Your new keybind to toggle the gui is: " .. tostring(getgenv().SkyhubKeybind), 5)
		end
	elseif currentoption == "R" then
		getgenv().SkyhubKeybind = "Enum.KeyCode.R"
		ui_bind = getgenv().SkyhubKeybind
		task.wait()
		if writefile then
			updatesaves()
			task.wait()
			loadsettings()
		else
			Library.Notify("DOG SHIT EXECUTOR", "Doesnt have file functions lol", 5)
		end
		if not IsOnMobile then
			Library.Notify("New Keybind: " .. tostring(getgenv().SkyhubKeybind), "Your new keybind to toggle the gui is: " .. tostring(getgenv().SkyhubKeybind), 5)
		end
	elseif currentoption == "T" then
		getgenv().SkyhubKeybind = "Enum.KeyCode.T"
		ui_bind = getgenv().SkyhubKeybind
		task.wait()
		if writefile then
			updatesaves()
			task.wait()
			loadsettings()
		else
			Library.Notify("DOG SHIT EXECUTOR", "Doesnt have file functions lol", 5)
		end
		if not IsOnMobile then
			Library.Notify("New Keybind: " .. tostring(getgenv().SkyhubKeybind), "Your new keybind to toggle the gui is: " .. tostring(getgenv().SkyhubKeybind), 5)
		end
	elseif currentoption == "Y" then
		getgenv().SkyhubKeybind = "Enum.KeyCode.Y"
		ui_bind = getgenv().SkyhubKeybind
		task.wait()
		if writefile then
			updatesaves()
			task.wait()
			loadsettings()
		else
			Library.Notify("DOG SHIT EXECUTOR", "Doesnt have file functions lol", 5)
		end
		if not IsOnMobile then
			Library.Notify("New Keybind: " .. tostring(getgenv().SkyhubKeybind), "Your new keybind to toggle the gui is: " .. tostring(getgenv().SkyhubKeybind), 5)
		end
	elseif currentoption == "U" then
		getgenv().SkyhubKeybind = "Enum.KeyCode.U"
		ui_bind = getgenv().SkyhubKeybind
		task.wait()
		if writefile then
			updatesaves()
			task.wait()
			loadsettings()
		else
			Library.Notify("DOG SHIT EXECUTOR", "Doesnt have file functions lol", 5)
		end
		if not IsOnMobile then
			Library.Notify("New Keybind: " .. tostring(getgenv().SkyhubKeybind), "Your new keybind to toggle the gui is: " .. tostring(getgenv().SkyhubKeybind), 5)
		end
	elseif currentoption == "P" then
		getgenv().SkyhubKeybind = "Enum.KeyCode.P"
		ui_bind = getgenv().SkyhubKeybind
		task.wait()
		if writefile then
			updatesaves()
			task.wait()
			loadsettings()
		else
			Library.Notify("DOG SHIT EXECUTOR", "Doesnt have file functions lol", 5)
		end
		if not IsOnMobile then
			Library.Notify("New Keybind: " .. tostring(getgenv().SkyhubKeybind), "Your new keybind to toggle the gui is: " .. tostring(getgenv().SkyhubKeybind), 5)
		end
	elseif currentoption == "Z" then
		getgenv().SkyhubKeybind = "Enum.KeyCode.Z"
		ui_bind = getgenv().SkyhubKeybind
		task.wait()
		if writefile then
			updatesaves()
			task.wait()
			loadsettings()
		else
			Library.Notify("DOG SHIT EXECUTOR", "Doesnt have file functions lol", 5)
		end
		if not IsOnMobile then
			Library.Notify("New Keybind: " .. tostring(getgenv().SkyhubKeybind), "Your new keybind to toggle the gui is: " .. tostring(getgenv().SkyhubKeybind), 5)
		end
	elseif currentoption == "X" then
		getgenv().SkyhubKeybind = "Enum.KeyCode.X"
		ui_bind = getgenv().SkyhubKeybind
		task.wait()
		if writefile then
			updatesaves()
			task.wait()
			loadsettings()
		else
			Library.Notify("DOG SHIT EXECUTOR", "Doesnt have file functions lol", 5)
		end
		if not IsOnMobile then
			Library.Notify("New Keybind: " .. tostring(getgenv().SkyhubKeybind), "Your new keybind to toggle the gui is: " .. tostring(getgenv().SkyhubKeybind), 5)
		end
	elseif currentoption == "M" then
		getgenv().SkyhubKeybind = "Enum.KeyCode.M"
		ui_bind = getgenv().SkyhubKeybind
		task.wait()
		if writefile then
			updatesaves()
			task.wait()
			loadsettings()
		else
			Library.Notify("DOG SHIT EXECUTOR", "Doesnt have file functions lol", 5)
		end
		if not IsOnMobile then
			Library.Notify("New Keybind: " .. tostring(getgenv().SkyhubKeybind), "Your new keybind to toggle the gui is: " .. tostring(getgenv().SkyhubKeybind), 5)
		end
	elseif currentoption == "V" then
		getgenv().SkyhubKeybind = "Enum.KeyCode.V"
		ui_bind = getgenv().SkyhubKeybind
		task.wait()
		if writefile then
			updatesaves()
			task.wait()
			loadsettings()
		else
			Library.Notify("DOG SHIT EXECUTOR", "Doesnt have file functions lol", 5)
		end
		if not IsOnMobile then
			Library.Notify("New Keybind: " .. tostring(getgenv().SkyhubKeybind), "Your new keybind to toggle the gui is: " .. tostring(getgenv().SkyhubKeybind), 5)
		end
	elseif currentoption == "N" then
		getgenv().SkyhubKeybind = "Enum.KeyCode.N"
		ui_bind = getgenv().SkyhubKeybind
		task.wait()
		if writefile then
			updatesaves()
			task.wait()
			loadsettings()
		else
			Library.Notify("DOG SHIT EXECUTOR", "Doesnt have file functions lol", 5)
		end
		if not IsOnMobile then
			Library.Notify("New Keybind: " .. tostring(getgenv().SkyhubKeybind), "Your new keybind to toggle the gui is: " .. tostring(getgenv().SkyhubKeybind), 5)
		end
	elseif currentoption == "." then
		getgenv().SkyhubKeybind = "Enum.KeyCode.Period"
		ui_bind = getgenv().SkyhubKeybind
		task.wait()
		if writefile then
			updatesaves()
			task.wait()
			loadsettings()
		else
			Library.Notify("DOG SHIT EXECUTOR", "Doesnt have file functions lol", 5)
		end
		if not IsOnMobile then
			Library.Notify("New Keybind: " .. tostring(getgenv().SkyhubKeybind), "Your new keybind to toggle the gui is: " .. tostring(getgenv().SkyhubKeybind), 5)
		end
	end
end)
SettingssSection:NewSlider("Blur/Opaque Intensitiy", "Changes blurryness", 1, 0, function(v)
	getgenv().BlurIntes = v
	opaque = getgenv().BlurIntes
	task.wait()
	if writefile then
		updatesaves()
		task.wait()
		loadsettings()
	else
		Library.Notify("DOG SHIT EXECUTOR", "Doesnt have file functions lol", 5)
	end
end)
SettingssSection:NewButton("Save Game", "Saves game MUST HAVE saveinstance()", function()
	local SSSSSS = ""
	if identifyexecutor then
		SSSSSS = select(1, identifyexecutor())
	end
	if SSSSSS == "Krampus" then
		saveplace({
			FileName = "SkyHubSavedGame",
			CopyToClipboard = true
		})
		return
	end
	if saveplace then
		saveplace({
			FileName = "SkyHubSavedGame"
		})
	end
	if saveinstance then
		saveinstance()
	else
		Library.Notify("Your executor doesnt have a saveinstance() function try Save Game 2", "", 10)
	end
end)
SettingssSection:NewButton("Save Game 2", "Saves game dont need saveinstance()", function()
	getgenv().saveinstance = nil
	loadstring(game:HttpGet("https://github.com/MuhXd/Roblox-mobile-script/blob/main/Arecus-X-Neo/Saveinstance.lua?raw=true"))();
end)
local Games = Window:NewTab("Games", 12689980465)
local GamesSection = Games:NewSection("Games")
GamesSection:NewButton("Da Hood", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(2788229376, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("Arsenal", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(286090429, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("Tower of Hell", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(1962086868, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("KAT", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(621129760, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("Fencing", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(12109643, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("Work at a Pizza Place", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(192800, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("VR Hands", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(4832438542, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("Adopt Me!", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(920587237, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("Jailbreak", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(606849621, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("Prison Life", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(155615604, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("Build A Boat For Treasure", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(537413528, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("Gorilla Tag Professional", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(8690998110, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("Murder Mystery 2", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(142823291, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("Blox Fruits", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(2753915549, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("Counter Blox", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(301549746, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("Mic Up", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(6884319169, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("Neighbors", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(12699642568, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("Natural Disaster Survival", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(189707, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("Ro-Ghoul", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(914010731, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("Blade Ball", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(13772394625, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("Pet Simulator X", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(13772394625, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("Pet Simulator 99", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(8737899170, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("Legends Of Speed", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(3101667897, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("Brookhaven RP", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(4924922222, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("Bedwars", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(6872265039, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("CHAOS", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(6441847031, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("Ninja Legends", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(3956818381, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("Bayside High School", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(12640491155, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("BIG Paintball!", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(3527629287, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("BIG Paintball 2!", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(9865958871, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("Muscle Legends", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(3623096087, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("Road to Grambys", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(5796917097, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("Bloxburg", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(185655149, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("Cursed Sea", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(14426444782, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("Doors", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(6516141723, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("Hide and Seek Extreme", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(205224386, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("Life in Paradise", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(1662219031, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("Adopt and Raise a Baby", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(383793228, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("Zombie Attack", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(1240123653, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("Super Simon Says", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(61846006, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("Life Sentence", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(13083893317, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("Rainbow Friends", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(7991339063, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("Infectious Smile", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(5985232436, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("Colony Survival", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(14888386963, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("Red Light, Green Light", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(7540891731, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("3008", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(2768379856, game:GetService("Players").LocalPlayer)
end)
GamesSection:NewButton("Guess the drawing!", "Teleports you to game", function()
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt'))()")
	game:GetService("TeleportService"):Teleport(3281073759, game:GetService("Players").LocalPlayer)
end)