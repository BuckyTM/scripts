--MyMomThinksImGay#1842 was here
--DO NOT TOUCH HERE IF YOU DO NOT KNOW WHAT YOU'RE DOING. 
repeat wait() until game.IsLoaded
getgenv().Class = 1
if getgenv().Class == nil or 3 < getgenv().Class or getgenv().Class == 0 then error("Invalid class"); end  
local SelectedClass;
if typeof(getgenv().Class) == "number" then SelectedClass = "Class "..tostring(getgenv().Class); elseif typeof(getgenv().Class) == "string" then SelectedClass = "Class "..getgenv().Class end
local conn = getconnections(game:GetService("ScriptContext").Error) --bypass error logging
if getgenv().Heist == nil then getgenv().Heist = AvaiableHeists["Authority"] end
local Ids = {
    Lobby = 21532277;
    Jewlery = 2557847604;
    Authority = 1419274802;
    ["Shadow Raid"] = 2088934656;
    ["Golden Mask Casino"] = 1470780246;
}
local Gamepasses = {
    ["Golden Mask Casino"] = 1088492;
}
local Codes = {
    [0] = "next";
    [1] = "whatadeal";
    [2] = "d4rkn1njarx";
    [3] = "hotsauce";
    [4] = "favorite";
    [5] = "onehundredk";
    [6] = "robber";
    [7] = "gunupdate";
    [8] = "100m";
    [9] = "bigbank";
    [10] = "banksy";
    [11] = "test";
    [12] = "shinysafe";
    [13] = "transport";
    [14] = "nighttime";
    [15] = "medic";
    [16] = "ninja";
    [17] = "downtown";
    [18] = "hellodarkness";
}
for i,v in pairs(conn) do 
    v:Disable()
end
conn = nil

if game.PlaceId == Ids.Lobby then
    wait(10)
    game:GetService("ReplicatedStorage"):WaitForChild("RequestData")
    --repeat wait() until game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("UI"):WaitForChild("frame_loading").Visible == false
    local funcs = {} 
    for i,v in pairs(getgc()) do 
        if typeof(v) == 'function' then 
            if debug.getinfo(v).name:lower():find("infam") then 
                print(debug.getinfo(v).name, "->", "workspace."..getfenv(v).script:GetFullName()) 
                funcs[debug.getinfo(v).name] = v
            end
        end
    end
    function lobby() 
        local HttpService, TPService = game:GetService("HttpService"), game:GetService("TeleportService")
        function a()
            local srv = nil
            local lowest = math.huge
            local ServersToTP = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..tostring(21532277).."/servers/Public?sortOrder=Asc&limit=100"))
            for i,v in pairs(ServersToTP.data) do
                if v.playing < lowest then
                    srv = v
                    lowest = v.playing
                end
            end
            return srv
        end
        TPService:TeleportToPlaceInstance(21532277, a().id)
    end
    function GetInfamyLetter() 
        local a = game:GetService("Players").LocalPlayer.PlayerGui.UI["frame_Infamy"]["frame_tierContainer"]:GetChildren()
        for i,v in pairs(a) do 
            if funcs.canHaveInfamyTier(v.Name) and funcs.hasInfamyTier(v.Name) == false then 
                return v.Name
            end
        end
    end
    function GetData() 
        local data = game:GetService("ReplicatedStorage").RequestData:InvokeServer(game.Players.LocalPlayer)
        return data
    end
    function GetCash() 
        --[[local orig = game:GetService("Players").LocalPlayer.PlayerGui.UI:WaitForChild("frame_Store"):WaitForChild("text_playerCash").Text
        local anal = orig:split(':')
        local cash = string.gsub(anal[2], ",", ""):sub(3)
        print(table.concat(anal, ", "))]]
        return tonumber(GetData().Cash)
    end
    function Infamy() 
        local msg = game:GetService("Players").LocalPlayer.PlayerGui.UI["frame_messageBox"]
        local letter = GetInfamyLetter()
        local g = getconnections(game:GetService("Players").LocalPlayer.PlayerGui.UI["frame_Infamy"]["frame_tierContainer"][letter].MouseButton1Click)
        for i,v in pairs(g) do 
            v:Fire()
        end
        wait(3)
        local g = getconnections(game:GetService("Players").LocalPlayer.PlayerGui.UI["frame_Infamy"]["frame_buttonContainer"]["button_infamyPurchase"].MouseButton1Click)
        for i,v in pairs(g) do 
            v:Fire()
        end
        repeat wait() until msg.msgBoxActive.Value
        wait(3)
        local g = getconnections(game:GetService("Players").LocalPlayer.PlayerGui.UI["frame_messageBox"]["frame_msgBoxContainer"]["frame_infamyWarning"]["button_confirm"].MouseButton1Click)
        for i,v in pairs(g) do 
            v:Fire()
        end
        wait(5)
        game:GetService("ReplicatedStorage").BecomeInfamous:FireServer(letter)
    end
    function GetInfamyLevel() 
        return tonumber(#GetData().Infamy)
    end
    function GetLevel() 
        return tonumber(GetData().Level)
    end
    function CanInfamy() 
        if GetCash() > tonumber("2"..string.rep('0',7)) and GetLevel() == 100 and GetInfamyLevel() ~= 25 then 
            return true
        end
        return false
    end
    function MakeLobby(Name, Diff) 
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local Lobby = ReplicatedStorage:WaitForChild("MakeLobby"):InvokeServer(Name, Diff, 3, "PRIVATE", "ANY", false, false)
        ReplicatedStorage:WaitForChild("StartGame"):FireServer(Lobby)
    end
    function ReedemCode(code) 
        assert(typeof(code) == "string","invalid code")
        game:GetService("ReplicatedStorage").RedeemCode:InvokeServer(code)
    end
    if GetCash() < 700000 and GetCash() > 200000 then 
        for i, v in pairs(Codes) do 
            wait()
            ReedemCode(v)
        end
    end
    if CanInfamy() then 
        Infamy()
        wait(1)
        lobby()
    end
    if GetCash() > 700000 then 
            print("Creating game..")
            if getgenv().Heist == AvaiableHeists["Golden Mask Casino"] and game:GetService("MarketplaceService"):UserOwnsGamePassAsync(game:GetService("Players").LocalPlayer.UserIdGamepasses["Golden Mask Casino"]) ~= true then
                MakeLobby("Authority","Nightmare")
                return;
            end
            MakeLobby(getgenv().Heist, "Nightmare")
    elseif GetCash() >= 5000 and GetCash() < 700000 then 
        MakeLobby("Jewelry Shop", "Nightmare")
        return;
    else
        MakeLobby("Jewelry Shop", "Normal")
        return;
    end
elseif game.PlaceId == Ids.Authority then 
    function GetData() 
        print("Getting data..")
        local plrData = game:GetService("ReplicatedStorage"):WaitForChild("PlayerData")
        local dataFolder1 = plrData:WaitForChild(game:GetService("Players").LocalPlayer.Name)
        local dataFolder = dataFolder1:WaitForChild(game:GetService("Players").LocalPlayer.Name.."\'s Data")
        repeat wait() until #dataFolder:GetChildren() >= 4
        print("Found data.")
        return dataFolder
    end
    wait(5)
    game:GetService("ReplicatedStorage"):WaitForChild("PlayerData")
    local MainData = GetData()
    function lobby() 
        local HttpService, TPService = game:GetService("HttpService"), game:GetService("TeleportService")
        function a()
            local srv = nil
            local lowest = math.huge
            local ServersToTP = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..tostring(21532277).."/servers/Public?sortOrder=Asc&limit=100"))
            for i,v in pairs(ServersToTP.data) do
                if v.playing < lowest then
                    srv = v
                    lowest = v.playing
                end
            end
            return srv
        end
        TPService:TeleportToPlaceInstance(21532277, a().id)
    end
    function Menu() 
        lobby()
    end
    function GetCash() 
       return MainData.Cash.Value
    end
    function GetDifficulty() 
        return game:GetService("Players").LocalPlayer.PlayerGui["SG_Package"].MainGui["frame_lobbyMenu"]["info_heist"].valueDifficulty.Text:lower()
    end
    function GetInfamy() 
       return #MainData.Infamy.Value
    end
    function GetLevel()
       return MainData.Level.Value
    end
    if GetInfamy() < 25 and GetCash() > 20700000  and GetLevel() == 100 then 
        Menu()
        return;
    end
    game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(State)
        pcall(function()
            if State == Enum.TeleportState.Started then
                syn.queue_on_teleport([[
                    local AvaiableHeists = {
                        ["Shadow Raid"] = "Shadow Raid";
                        ["Authority"] = "Authority";
                        ["Golden Mask Casino"] = "Golden Mask Casino";
                    }

                    getgenv().Heist = AvaiableHeists["]]..getgenv().Heist..[["]
                    loadstring(game:HttpGet("https://anomicxv2.000webhostapp.com/script/NotorietyAutoPlayer.lua"))()
                ]])
            end
        end)
    end)
    loadstring(game:HttpGet("https://anomicxv2.000webhostapp.com/script/authority.lua"))()
elseif game.PlaceId == Ids.Jewlery then
    function GetData() 
        print("Getting data..")
        local plrData = game:GetService("ReplicatedStorage"):WaitForChild("PlayerData")
        local dataFolder1 = plrData:WaitForChild(game:GetService("Players").LocalPlayer.Name)
        local dataFolder = dataFolder1:WaitForChild(game:GetService("Players").LocalPlayer.Name.."\'s Data")
        repeat wait() until #dataFolder:GetChildren() >= 4
        print("Found data.")
        return dataFolder
    end
    wait(5)
    game:GetService("ReplicatedStorage"):WaitForChild("PlayerData")
    local MainData = GetData()
    function lobby() 
        local HttpService, TPService = game:GetService("HttpService"), game:GetService("TeleportService")
        function a()
            local srv = nil
            local lowest = math.huge
            local ServersToTP = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..tostring(21532277).."/servers/Public?sortOrder=Asc&limit=100"))
            for i,v in pairs(ServersToTP.data) do
                if v.playing < lowest then
                    srv = v
                    lowest = v.playing
                end
            end
            return srv
        end
        TPService:TeleportToPlaceInstance(21532277, a().id)
    end
    function Menu() 
        lobby()
    end
    function GetCash() 
       return MainData.Cash.Value
    end
    function GetDifficulty() 
        return game:GetService("Players").LocalPlayer.PlayerGui["SG_Package"].MainGui["frame_lobbyMenu"]["info_heist"].valueDifficulty.Text:lower()
    end
    function GetInfamy() 
       return #MainData.Infamy.Value
    end
    function GetLevel()
       return MainData.Level.Value
    end
    if GetInfamy() < 25 and GetCash() > 20700000  and GetLevel() == 100 then 
        Menu()
        return;
    end
    if GetCash() > 5000 and GetDifficulty() == "normal" then 
        Menu()
        return;
    end
    if GetCash() > 700000 then 
        Menu();
        return;
    end
    game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(State)
        pcall(function()
            if State == Enum.TeleportState.Started then
                syn.queue_on_teleport([[
                    local AvaiableHeists = {
                        ["Shadow Raid"] = "Shadow Raid";
                        ["Authority"] = "Authority";
                        ["Golden Mask Casino"] = "Golden Mask Casino";
                    }

                    getgenv().Heist = AvaiableHeists["]]..getgenv().Heist..[["]
                    loadstring(game:HttpGet("https://anomicxv2.000webhostapp.com/script/NotorietyAutoPlayer.lua"))()
                ]])
            end
        end)
    end)
    loadstring(game:HttpGet("https://anomicxv2.000webhostapp.com/script/jewlery.lua"))()
elseif game.PlaceId == Ids["Shadow Raid"] then 
    function GetData() 
        print("Getting data..")
        local plrData = game:GetService("ReplicatedStorage"):WaitForChild("PlayerData")
        local dataFolder1 = plrData:WaitForChild(game:GetService("Players").LocalPlayer.Name)
        local dataFolder = dataFolder1:WaitForChild(game:GetService("Players").LocalPlayer.Name.."\'s Data")
        repeat wait() until #dataFolder:GetChildren() >= 4
        print("Found data.")
        return dataFolder
    end
    wait(5)
    game:GetService("ReplicatedStorage"):WaitForChild("PlayerData")
    local MainData = GetData()
    function lobby() 
        local HttpService, TPService = game:GetService("HttpService"), game:GetService("TeleportService")
        function a()
            local srv = nil
            local lowest = math.huge
            local ServersToTP = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..tostring(21532277).."/servers/Public?sortOrder=Asc&limit=100"))
            for i,v in pairs(ServersToTP.data) do
                if v.playing < lowest then
                    srv = v
                    lowest = v.playing
                end
            end
            return srv
        end
        TPService:TeleportToPlaceInstance(21532277, a().id)
    end
    function Menu() 
        lobby()
    end
    function GetCash() 
       return MainData.Cash.Value
    end
    function GetDifficulty() 
        return game:GetService("Players").LocalPlayer.PlayerGui["SG_Package"].MainGui["frame_lobbyMenu"]["info_heist"].valueDifficulty.Text:lower()
    end
    function GetInfamy() 
       return #MainData.Infamy.Value
    end
    function GetLevel()
       return MainData.Level.Value
    end
    if GetInfamy() < 25 and GetCash() > 20700000  and GetLevel() == 100 then 
        Menu()
        return;
    end
    game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(State)
        pcall(function()
            if State == Enum.TeleportState.Started then
                syn.queue_on_teleport([[
                    local AvaiableHeists = {
                        ["Shadow Raid"] = "Shadow Raid";
                        ["Authority"] = "Authority";
                        ["Golden Mask Casino"] = "Golden Mask Casino";
                    }

                    getgenv().Heist = AvaiableHeists["]]..getgenv().Heist..[["]
                    loadstring(game:HttpGet("https://anomicxv2.000webhostapp.com/script/NotorietyAutoPlayer.lua"))()
                ]])
            end
        end)
    end)
    loadstring(game:HttpGet("https://anomicxv2.000webhostapp.com/script/shadowraid.lua"))()
elseif game.PlaceId == Ids["Golden Mask Casino"] then
    function GetData() 
        print("Getting data..")
        local plrData = game:GetService("ReplicatedStorage"):WaitForChild("PlayerData")
        local dataFolder1 = plrData:WaitForChild(game:GetService("Players").LocalPlayer.Name)
        local dataFolder = dataFolder1:WaitForChild(game:GetService("Players").LocalPlayer.Name.."\'s Data")
        repeat wait() until #dataFolder:GetChildren() >= 4
        print("Found data.")
        return dataFolder
    end
    wait(5)
    game:GetService("ReplicatedStorage"):WaitForChild("PlayerData")
    local MainData = GetData()
    function lobby() 
        local HttpService, TPService = game:GetService("HttpService"), game:GetService("TeleportService")
        function a()
            local srv = nil
            local lowest = math.huge
            local ServersToTP = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..tostring(21532277).."/servers/Public?sortOrder=Asc&limit=100"))
            for i,v in pairs(ServersToTP.data) do
                if v.playing < lowest then
                    srv = v
                    lowest = v.playing
                end
            end
            return srv
        end
        TPService:TeleportToPlaceInstance(21532277, a().id)
    end
    function Menu() 
        lobby()
    end
    function GetCash() 
       return MainData.Cash.Value
    end
    function GetDifficulty() 
        return game:GetService("Players").LocalPlayer.PlayerGui["SG_Package"].MainGui["frame_lobbyMenu"]["info_heist"].valueDifficulty.Text:lower()
    end
    function GetInfamy() 
       return #MainData.Infamy.Value
    end
    function GetLevel()
       return MainData.Level.Value
    end
    if GetInfamy() < 25 and GetCash() > 20700000  and GetLevel() == 100 then 
        Menu()
        return;
    end
    game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(State)
        pcall(function()
            if State == Enum.TeleportState.Started then
                syn.queue_on_teleport([[
                    local AvaiableHeists = {
                        ["Shadow Raid"] = "Shadow Raid";
                        ["Authority"] = "Authority";
                        ["Golden Mask Casino"] = "Golden Mask Casino";
                    }

                    getgenv().Heist = AvaiableHeists["]]..getgenv().Heist..[["]
                    loadstring(game:HttpGet("https://anomicxv2.000webhostapp.com/script/NotorietyAutoPlayer.lua"))()
                ]])
            end
        end)
    end)
    loadstring(game:HttpGet("https://anomicxv2.000webhostapp.com/script/gmc.lua"))()
end
