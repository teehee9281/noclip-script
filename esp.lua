local FillColor = Color3.fromRGB(175, 25, 255)
local DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
local FillTransparency = 0.5
local OutlineColor = Color3.fromRGB(255, 255, 255)
local OutlineTransparency = 0

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local connections = {}

local Storage = Instance.new("Folder")
Storage.Parent = CoreGui
Storage.Name = "Highlight_Storage"

local function Highlight(plr)
    -- Create Highlight
    local highlight = Instance.new("Highlight")
    highlight.Name = plr.Name
    highlight.FillColor = FillColor
    highlight.DepthMode = DepthMode
    highlight.FillTransparency = FillTransparency
    highlight.OutlineColor = OutlineColor
    highlight.OutlineTransparency = OutlineTransparency
    highlight.Parent = Storage

    -- Attach Highlight to the player's character
    local function attachToCharacter()
        if plr.Character then
            highlight.Adornee = plr.Character
        else
            highlight.Adornee = nil
        end
    end

    -- Update Adornee when the player's character changes
    attachToCharacter()
    connections[plr] = plr.CharacterAdded:Connect(attachToCharacter)
end

-- Player Added Event
Players.PlayerAdded:Connect(Highlight)

-- Initial Highlight for existing players
for _, player in ipairs(Players:GetPlayers()) do
    Highlight(player)
end

-- Player Removing Event
Players.PlayerRemoving:Connect(function(plr)
    -- Remove highlight
    local plrName = plr.Name
    if Storage:FindFirstChild(plrName) then
        Storage[plrName]:Destroy()
    end

    -- Disconnect character connection
    if connections[plr] then
        connections[plr]:Disconnect()
        connections[plr] = nil
    end
end)

-- Refresh function to ensure highlights are up-to-date
while true do
    for _, plr in ipairs(Players:GetPlayers()) do
        -- Ensure the highlight still exists and is attached
        local highlight = Storage:FindFirstChild(plr.Name)
        if not highlight then
            Highlight(plr)
        elseif plr.Character ~= highlight.Adornee then
            highlight.Adornee = plr.Character
        end
    end
    wait(3) -- Wait for 3 seconds before refreshing again
    print("Highlights refreshed")
end
