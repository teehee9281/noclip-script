        -- Create the GUI
local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
local frame = Instance.new("Frame", screenGui)
local textBox = Instance.new("TextBox", frame)
local button = Instance.new("TextButton", frame)
local outputLabel = Instance.new("TextLabel", frame)
local copyButton = Instance.new("TextButton", frame)

-- Customize the GUI components
screenGui.Name = "ChatGUI"

frame.Size = UDim2.new(0, 300, 0, 250)
frame.Position = UDim2.new(0.5, -150, 0.5, -125)
frame.BackgroundColor3 = Color3.fromRGB(40, 41, 40)
frame.BorderSizePixel = 0

textBox.Size = UDim2.new(0, 280, 0, 50)
textBox.Position = UDim2.new(0, 10, 0, 10)
textBox.PlaceholderText = "Enter your text here"
textBox.Text = ""
textBox.TextScaled = true
textBox.Font = Enum.Font.Arial
textBox.BackgroundColor3 = Color3.fromRGB(85, 85, 85)
textBox.BorderSizePixel = 0

button.Size = UDim2.new(0, 280, 0, 50)
button.Position = UDim2.new(0, 10, 0, 70)
button.Text = "Format Text"
button.TextScaled = true
button.Font = Enum.Font.Bangers
button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
button.BorderSizePixel = 0

outputLabel.Size = UDim2.new(0, 280, 0, 50)
outputLabel.Position = UDim2.new(0, 10, 0, 130)
outputLabel.Text = ""
outputLabel.TextScaled = true
outputLabel.Font = Enum.Font.SourceSans
outputLabel.BackgroundColor3 = Color3.fromRGB(85, 85, 85)
outputLabel.BorderSizePixel = 0

copyButton.Size = UDim2.new(0, 280, 0, 50)
copyButton.Position = UDim2.new(0, 10, 0, 190)
copyButton.Text = "Copy to Clipboard"
copyButton.TextScaled = true
copyButton.Font = Enum.Font.Bangers
copyButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
copyButton.BorderSizePixel = 0

-- Add functionality to the format button
button.MouseButton1Click:Connect(function()
    local inputText = textBox.Text
    if inputText ~= "" then
        -- Format the text with > between letters
        local formattedText = inputText:sub(1, 1)
        for i = 2, #inputText do
            formattedText = formattedText .. ">" .. inputText:sub(i, i)
        end

        -- Set the formatted text as the output
        outputLabel.Text = formattedText
    end
end)

-- Add functionality to the copy button
copyButton.MouseButton1Click:Connect(function()
    local formattedText = outputLabel.Text
    if formattedText ~= "" then
        -- This works only in Roblox Studio, not in live games
        setclipboard(formattedText)
        print("Text copied to clipboard!")
    end
end)

-- Make the frame draggable (improved)
local dragging = false
local dragStartPos = Vector2.new(0, 0)
local dragOffset = UDim2.new(0, 0, 0, 0)

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStartPos = input.Position
        dragOffset = frame.Position
    end
end)

frame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging then
        local delta = input.Position - dragStartPos
        frame.Position = dragOffset + UDim2.new(0, delta.X, 0, delta.Y)
    end
end)
