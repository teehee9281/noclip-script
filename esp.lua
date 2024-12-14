local FillColor = Color3.fromRGB(175,25,255)
local DepthMode = "AlwaysOnTop"
local FillTransparency = 0.5
local OutlineColor = Color3.fromRGB(255,255,255)
local OutlineTransparency = 0

local CoreGui = game:FindService("CoreGui")
local Players = game:FindService("Players")
local lp = Players.LocalPlayer
local connections = {}

local Storage = Instance.new("Folder")
Storage.Parent = CoreGui
Storage.Name = "Highlight_Storage"

local function Highlight(plr)
    -- Create Highlight
    local Highlight = Instance.new("Highlight")
    Highlight.Name = plr.Name
    Highlight.FillColor = FillColor
    Highlight.DepthMode = DepthMode
    Highlight.FillTransparency = FillTransparency
    Highlight.OutlineColor = OutlineColor
    Highlight.OutlineTransparency = 0
    Highlight.Parent = Storage
    
    local plrchar = plr.Character
    if plrchar then
        Highlight.Adornee = plrchar
    end

    -- Create Nametag (BillboardGui)
    local billboard = Instance.new("BillboardGui")
    billboard.Name = plr.Name.."Nametag"
    billboard.Parent = plr.Character:WaitForChild("Head")
    billboard.Adornee = plr.Character:WaitForChild("Head")
    billboard.Size = UDim2.new(0, 100, 0, 50)  -- Fixed size, no scaling
    billboard.StudsOffset = Vector3.new(0, 2, 0)  -- Adjust height above the player's head
    billboard.AlwaysOnTop = true  -- Ensure it stays above other GUI elements

    local label = Instance.new("TextLabel")
    label.Parent = billboard
    label.Size = UDim2.new(1, 0, 1, 0)
    label.Text = plr.Name
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextStrokeTransparency = 0.5
    label.BackgroundTransparency = 1
    label.TextScaled = true

    connections[plr] = plr.CharacterAdded:Connect(function(char)
        if char:FindFirstChild("Head") then
            billboard.Adornee = char:FindFirstChild("Head")
        end
    end)
end

Players.PlayerAdded:Connect(Highlight)
for i,v in next, Players:GetPlayers() do
    Highlight(v)
end

Players.PlayerRemoving:Connect(function(plr)
    local plrname = plr.Name
    if Storage[plrname] then
        Storage[plrname]:Destroy()
    end
    if connections[plr] then
        connections[plr]:Disconnect()
    end
end)

-- Refresh function to update highlights every 3 seconds
while true do
    for _,plr in pairs(Players:GetPlayers()) do
        -- Remove existing highlight
        if Storage[plr.Name] then
            Storage[plr.Name]:Destroy()
        end
        -- Add highlight again
        Highlight(plr)
    end
    wait(3)  -- Wait for 3 seconds before refreshing again
    print("refreshed")
end
