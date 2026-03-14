local a = loadstring(game:HttpGet("https://raw.githubusercontent.com/Turtle-Brand/Turtle-Lib/main/source.lua"))()

local b = a:Window("pnka")

local c = game:GetService("TeleportService")
local d = game:GetService("Players")
local e = game:GetService("AssetService")
local f = game:GetService("MarketplaceService")
local g = game:GetService("StarterGui")

local function h(t)
    pcall(function()
        g:SetCore("SendNotification",{
            Title="if u use delta, pls disable verify teleports in setting UI belong to delta",
            Text=t,
            Duration=3
        })
    end)
end

local i = {}
local j = {}

local k
local l

local m
local n = pcall(function()
    m = e:GetGamePlacesAsync()
end)

if not n then
    m = f:GetGamePlacesAsync(game.PlaceId)
end

repeat
    for _,o in pairs(m:GetCurrentPage()) do
        i[o.Name] = o.PlaceId
        table.insert(j,o.Name)
    end
    if not m.IsFinished then
        m:AdvanceToNextPageAsync()
    end
until m.IsFinished

local p = "none"
local q = "none"

local r = b:Label("Place: none | Method: none", Color3.fromRGB(255,0,0))

local function s()
    r.Text = "Place: "..p.." | Method: "..q
end

b:Dropdown("Select Place", j, function(v)
    k = v
    p = v
    s()
    h("Selected place: "..v)
end)

b:Dropdown("Method", {"TP","Copy Script","Copy PlaceId","Copy Game Link"}, function(v)
    l = v
    q = v
    s()
    h("Selected method: "..v)
end)

b:Button("Execute", function()
    if not k or not l then
        h("Select place and method first")
        return
    end

    local t = i[k]

    if l == "TP" then
        h("Executing teleport to "..k)
        c:Teleport(t, d.LocalPlayer)

    elseif l == "Copy Script" then
        setclipboard("-- script made by pnka\n"..
        "game:GetService('TeleportService'):Teleport("..tostring(t)..", game:GetService('Players').LocalPlayer)")
        h("Execute success: Script copied")

    elseif l == "Copy PlaceId" then
        setclipboard(tostring(t))
        h("Execute success: PlaceId copied")

    elseif l == "Copy Game Link" then
        setclipboard("https://www.roblox.com/games/"..tostring(t))
        h("Execute success: Game link copied")
    end
end)

a:Keybind("RightShift")