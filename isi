local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local player = Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui")

if gui:FindFirstChild("EX_AutoReconnect") then 
    gui.EX_AutoReconnect:Destroy() 
end

local sg = Instance.new("ScreenGui", gui)
sg.Name = "EX_AutoReconnect"

-- Main Frame (Tema Ungu Blackhole)
local f = Instance.new("Frame", sg)
f.Size = UDim2.new(0, 240, 0, 160)
f.Position = UDim2.new(0.5, -120, 0.5, -80)
f.BackgroundColor3 = Color3.fromRGB(15, 10, 25)
f.Active = true 
f.Draggable = true

local fCorner = Instance.new("UICorner", f)
fCorner.CornerRadius = UDim.new(0, 12)

-- Efek Gradasi Ungu & Blackhole di Background Utama
local gradient = Instance.new("UIGradient", f)
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 12, 75)),  
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 5, 15))     
})
gradient.Rotation = 45

local stroke = Instance.new("UIStroke", f)
stroke.Color = Color3.fromRGB(180, 50, 255)
stroke.Thickness = 2

-- Title / Header
local title = Instance.new("TextLabel", f)
title.Size = UDim2.new(1, -40, 0, 35)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = "⚡ EX Community"
title.TextColor3 = Color3.fromRGB(240, 200, 255)
title.TextSize = 13
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left

-- Tombol Minimize (-)
local minBtn = Instance.new("TextButton", f)
minBtn.Size = UDim2.new(0, 25, 0, 25)
minBtn.Position = UDim2.new(1, -32, 0, 7)
minBtn.BackgroundColor3 = Color3.fromRGB(30, 15, 50)
minBtn.Text = "-"
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minBtn.TextSize = 14
minBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 6)

-- ==========================================
-- CUSTOM ICON "EX" (Saat Diminimalkan)
-- ==========================================
local minIcon = Instance.new("TextButton", sg)
minIcon.Size = UDim2.new(0, 55, 0, 55) -- Bentuk kotak emblem logo
minIcon.Position = UDim2.new(0, 20, 0, 20)
minIcon.BackgroundColor3 = Color3.fromRGB(20, 10, 35)
minIcon.Text = "EX"
minIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
minIcon.TextSize = 18
minIcon.Font = Enum.Font.FredokaOne -- Font tebal dan mencolok khas logo
minIcon.Visible = false
minIcon.Active = true
minIcon.Draggable = true
Instance.new("UICorner", minIcon).CornerRadius = UDim.new(0, 12)

-- Gradasi & Border Menyala untuk Logo "EX"
local iconGrad = Instance.new("UIGradient", minIcon)
iconGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(130, 20, 220)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 10, 90))
})
iconGrad.Rotation = 45

local iconStroke = Instance.new("UIStroke", minIcon)
iconStroke.Color = Color3.fromRGB(210, 100, 255)
iconStroke.Thickness = 2
-- ==========================================

-- Kotak Input Waktu (Menit)
local tb = Instance.new("TextBox", f)
tb.Size = UDim2.new(0.85, 0, 0, 32)
tb.Position = UDim2.new(0.075, 0, 0, 45)
tb.PlaceholderText = "Waktu (Menit)" 
tb.Text = "60"
tb.TextColor3 = Color3.fromRGB(255, 255, 255)
tb.BackgroundColor3 = Color3.fromRGB(25, 12, 40)
tb.TextSize = 12
tb.Font = Enum.Font.Gotham
Instance.new("UICorner", tb).CornerRadius = UDim.new(0, 6)

-- Tombol Start / Stop
local btn = Instance.new("TextButton", f)
btn.Size = UDim2.new(0.85, 0, 0, 35)
btn.Position = UDim2.new(0.075, 0, 0, 82)
btn.Text = "START" 
btn.BackgroundColor3 = Color3.fromRGB(120, 20, 200) 
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.TextSize = 13
btn.Font = Enum.Font.GothamBold
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

-- Status Label
local st = Instance.new("TextLabel", f)
st.Size = UDim2.new(0.85, 0, 0, 22)
st.Position = UDim2.new(0.075, 0, 0, 124)
st.Text = "Status: Siap" 
st.TextColor3 = Color3.fromRGB(200, 170, 230) 
st.BackgroundTransparency = 1
st.TextSize = 11
st.Font = Enum.Font.GothamMedium

-- Logika Minimize & Restore
minBtn.MouseButton1Click:Connect(function()
    f.Visible = false
    minIcon.Visible = true
end)

minIcon.MouseButton1Click:Connect(function()
    f.Visible = true
    minIcon.Visible = false
end)

-- Logika Timer & Reconnect
local run = false
btn.MouseButton1ContextAction = nil -- clean
btn.MouseButton1Click:Connect(function()
    run = not run
    if run then
        btn.Text = "STOP"
        btn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
        local mins = tonumber(tb.Text) or 60
        task.spawn(function()
            local sec = mins * 60
            while run and sec > 0 do
                task.wait(1) 
                sec = sec - 1
                st.Text = "Sisa: " .. math.floor(sec/60) .. "m " .. (sec%60) .. "d"
                if sec <= 0 then 
                    TeleportService:Teleport(game.PlaceId, player) 
                end
            end
        end)
    else
        btn.Text = "START" 
        btn.BackgroundColor3 = Color3.fromRGB(120, 20, 200)
        st.Text = "Status: Berhenti"
    end
end)
