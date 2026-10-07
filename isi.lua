local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local player = Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui")

if gui:FindFirstChild("EX_AutoReconnect") then 
    gui.EX_AutoReconnect:Destroy() 
end

local sg = Instance.new("ScreenGui", gui)
sg.Name = "EX_AutoReconnect"
sg.ResetOnSpawn = false

-- Main Frame
local f = Instance.new("Frame", sg)
f.Size = UDim2.new(0, 340, 0, 190)
f.Position = UDim2.new(0.5, -170, 0.5, -95)
f.BackgroundColor3 = Color3.fromRGB(15, 10, 25)
f.Active = true 
f.Draggable = true

local fCorner = Instance.new("UICorner", f)
fCorner.CornerRadius = UDim.new(0, 12)

-- Gradasi Ungu Blackhole
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
title.Size = UDim2.new(1, -50, 0, 40)
title.Position = UDim2.new(0, 15, 0, 5)
title.BackgroundTransparency = 1
title.Text = "⚡ EX Community - Auto Reconnect"
title.TextColor3 = Color3.fromRGB(240, 200, 255)
title.TextSize = 14
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left

-- Tombol Minimize (-)
local minBtn = Instance.new("TextButton", f)
minBtn.Size = UDim2.new(0, 30, 0, 30)
minBtn.Position = UDim2.new(1, -38, 0, 8)
minBtn.BackgroundColor3 = Color3.fromRGB(30, 15, 50)
minBtn.Text = "-"
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minBtn.TextSize = 16
minBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 6)

-- Custom Icon "EX" (Saat Diminimalkan)
local minIcon = Instance.new("TextButton", sg)
minIcon.Size = UDim2.new(0, 55, 0, 55)
minIcon.Position = UDim2.new(0, 20, 0, 20)
minIcon.BackgroundColor3 = Color3.fromRGB(20, 10, 35)
minIcon.Text = "EX"
minIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
minIcon.TextSize = 18
minIcon.Font = Enum.Font.FredokaOne
minIcon.Visible = false
minIcon.Active = true
minIcon.Draggable = true
Instance.new("UICorner", minIcon).CornerRadius = UDim.new(0, 12)

local iconGrad = Instance.new("UIGradient", minIcon)
iconGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(130, 20, 220)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 10, 90))
})
iconGrad.Rotation = 45

local iconStroke = Instance.new("UIStroke", minIcon)
iconStroke.Color = Color3.fromRGB(210, 100, 255)
iconStroke.Thickness = 2

-- Kotak Input Waktu (Menit)
local tb = Instance.new("TextBox", f)
tb.Size = UDim2.new(0.9, 0, 0, 38)
tb.Position = UDim2.new(0.05, 0, 0, 50)
tb.PlaceholderText = "Masukkan Waktu (Menit), contoh: 1" 
tb.Text = "1"
tb.TextColor3 = Color3.fromRGB(255, 255, 255)
tb.BackgroundColor3 = Color3.fromRGB(25, 12, 40)
tb.TextSize = 13
tb.Font = Enum.Font.Gotham
Instance.new("UICorner", tb).CornerRadius = UDim.new(0, 8)

-- Tombol Start / Stop
local btn = Instance.new("TextButton", f)
btn.Size = UDim2.new(0.9, 0, 0, 42)
btn.Position = UDim2.new(0.05, 0, 0, 96)
btn.Text = "START" 
btn.BackgroundColor3 = Color3.fromRGB(120, 20, 200) 
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.TextSize = 14
btn.Font = Enum.Font.GothamBold
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

-- Status Label
local st = Instance.new("TextLabel", f)
st.Size = UDim2.new(0.9, 0, 0, 25)
st.Position = UDim2.new(0.05, 0, 0, 146)
st.Text = "Status: Siap dijalankan" 
st.TextColor3 = Color3.fromRGB(200, 170, 230) 
st.BackgroundTransparency = 1
st.TextSize = 12
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

-- Logika Timer & Reconnect (Diperbaiki & Ditambah Queue)
local run = false
btn.MouseButton1Click:Connect(function()
    run = not run
    if run then
        btn.Text = "STOP"
        btn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
        local mins = tonumber(tb.Text) or 1
        
        task.spawn(function()
            local sec = mins * 60
            while run and sec > 0 do
                task.wait(1) 
                sec = sec - 1
                
                local m = math.floor(sec / 60)
                local s = sec % 60
                st.Text = string.format("Sisa waktu: %dm %ds", m, s)
                
                if sec <= 0 then 
                    st.Text = "Status: Reconnecting..."
                    task.wait(0.5)
                    
                    -- Perintah agar script otomatis jalan lagi setelah masuk game baru
                    if queue_on_teleport then
                        queue_on_teleport([[
                            loadstring(game:HttpGet("https://raw.githubusercontent.com/ballsmarkettreal-cyber/auto-Reconnect/refs/heads/main/isi.lua"))()
                        ]])
                    end
                    
                    -- Perintah Teleport (Rejoin game) yang lebih universal
                    TeleportService:Teleport(game.PlaceId)
                    break
                end
            end
        end)
    else
        run = false
        btn.Text = "START" 
        btn.BackgroundColor3 = Color3.fromRGB(120, 20, 200)
        st.Text = "Status: Berhenti"
    end
end)
