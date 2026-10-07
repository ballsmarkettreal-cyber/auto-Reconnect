local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui")

if gui:FindFirstChild("EX_StealAnEgg") then 
    gui.EX_StealAnEgg:Destroy() 
end

local sg = Instance.new("ScreenGui", gui)
sg.Name = "EX_StealAnEgg"
sg.ResetOnSpawn = false

-- Main Frame (Clean & Proportional Landscape)
local f = Instance.new("Frame", sg)
f.Size = UDim2.new(0, 340, 0, 220)
f.Position = UDim2.new(0.5, -170, 0.5, -110)
f.BackgroundColor3 = Color3.fromRGB(18, 12, 30)
f.Active = true 
f.Draggable = true

local fCorner = Instance.new("UICorner", f)
fCorner.CornerRadius = UDim.new(0, 10)

-- Clean Blackhole Gradient
local gradient = Instance.new("UIGradient", f)
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 18, 60)),  
    ColorSequenceKeypoint.new(1, Color3.fromRGB(12, 8, 20))     
})
gradient.Rotation = 45

local stroke = Instance.new("UIStroke", f)
stroke.Color = Color3.fromRGB(160, 60, 240)
stroke.Thickness = 1.5

-- Title / Header
local title = Instance.new("TextLabel", f)
title.Size = UDim2.new(1, -40, 0, 35)
title.Position = UDim2.new(0, 12, 0, 4)
title.BackgroundTransparency = 1
title.Text = "⚡ EX Community - Steal An Egg"
title.TextColor3 = Color3.fromRGB(235, 210, 255)
title.TextSize = 12
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left

-- Tombol Minimize (-)
local minBtn = Instance.new("TextButton", f)
minBtn.Size = UDim2.new(0, 24, 0, 24)
minBtn.Position = UDim2.new(1, -30, 0, 8)
minBtn.BackgroundColor3 = Color3.fromRGB(30, 15, 50)
minBtn.Text = "-"
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minBtn.TextSize = 14
minBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 6)

-- ==========================================
-- ICON "EX" KECIL & RAPI (Sama persis Auto Reconnect)
-- ==========================================
local minIcon = Instance.new("TextButton", sg)
minIcon.Size = UDim2.new(0, 42, 0, 42)
minIcon.Position = UDim2.new(0, 20, 0, 20)
minIcon.BackgroundColor3 = Color3.fromRGB(20, 10, 35)
minIcon.Text = "EX"
minIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
minIcon.TextSize = 13
minIcon.Font = Enum.Font.FredokaOne
minIcon.Visible = false
minIcon.Active = true
minIcon.Draggable = true
Instance.new("UICorner", minIcon).CornerRadius = UDim.new(0, 10)

local iconGrad = Instance.new("UIGradient", minIcon)
iconGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 25, 200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(45, 10, 80))
})
iconGrad.Rotation = 45

local iconStroke = Instance.new("UIStroke", minIcon)
iconStroke.Color = Color3.fromRGB(200, 90, 255)
iconStroke.Thickness = 1.5
-- ==========================================

-- Container Tombol Menu (Scrolling)
local container = Instance.new("ScrollingFrame", f)
container.Size = UDim2.new(0.88, 0, 0, 130)
container.Position = UDim2.new(0.06, 0, 0, 44)
container.BackgroundTransparency = 1
container.CanvasSize = UDim2.new(0, 0, 0, 190)
container.ScrollBarThickness = 3

local function createButton(text, yPos, callback)
    local btn = Instance.new("TextButton", container)
    btn.Size = UDim2.new(1, 0, 0, 34)
    btn.Position = UDim2.new(0, 0, 0, yPos)
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(25, 12, 40)
    btn.TextColor3 = Color3.fromRGB(235, 210, 255)
    btn.TextSize = 11
    btn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    local btnStroke = Instance.new("UIStroke", btn)
    btnStroke.Color = Color3.fromRGB(110, 30, 160)
    btnStroke.Thickness = 1
    
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- Tombol Fitur Steal An Egg
createButton("⚡ Instant Steal (Teleport ke Telur)", 0, function()
    pcall(function()
        local char = player.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj:IsA("Model") and (obj.Name:lower():find("egg") or obj.Name:lower():find("telur")) then
                local part = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                if part then
                    char.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 3, 0)
                    break
                end
            end
        end
    end)
end)

createButton("🧹 Hapus Partikel & Efek Berat", 40, function()
    pcall(function()
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") then
                v:Destroy()
            end
        end
    end)
end)

createButton("🐾 Hapus Hewan & Monster (Anti-Lag)", 80, function()
    pcall(function()
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("Model") and (v.Name:lower():find("pet") or v.Name:lower():find("chicken") or v.Name:lower():find("guardian") or v.Name:lower():find("mob")) then
                if not Players:GetPlayerFromCharacter(v) then
                    v:Destroy()
                end
            end
        end
    end)
end)

createButton("🏡 Sembunyikan Dekorasi / Plot", 120, function()
    pcall(function()
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") and (v.Name:lower():find("decoration") or v.Name:lower():find("prop") or v.Name:lower():find("tree")) then
                v.Transparency = 1
                v.CanCollide = false
            end
        end
    end)
end)

-- Status Bar
local st = Instance.new("TextLabel", f)
st.Size = UDim2.new(0.88, 0, 0, 20)
st.Position = UDim2.new(0.06, 0, 0, 184)
st.Text = "Status: Menu Siap Digunakan" 
st.TextColor3 = Color3.fromRGB(190, 160, 220) 
st.BackgroundTransparency = 1
st.TextSize = 10
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
