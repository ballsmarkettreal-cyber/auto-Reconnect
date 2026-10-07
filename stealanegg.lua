local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui")

if gui:FindFirstChild("EX_StealAnEgg_Ultimate") then 
    gui.EX_StealAnEgg_Ultimate:Destroy() 
end

local sg = Instance.new("ScreenGui", gui)
sg.Name = "EX_StealAnEgg_Ultimate"
sg.ResetOnSpawn = false

-- ==========================================
-- 1. MAIN UI FRAME (Kategori & Layout)
-- ==========================================
local f = Instance.new("Frame", sg)
f.Size = UDim2.new(0, 440, 0, 260)
f.Position = UDim2.new(0.5, -220, 0.5, -130)
f.BackgroundColor3 = Color3.fromRGB(18, 12, 30)
f.Active = true 
f.Draggable = true
Instance.new("UICorner", f).CornerRadius = UDim.new(0, 10)

local gradient = Instance.new("UIGradient", f)
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 18, 60)),  
    ColorSequenceKeypoint.new(1, Color3.fromRGB(12, 8, 20))     
})
gradient.Rotation = 45

local stroke = Instance.new("UIStroke", f)
stroke.Color = Color3.fromRGB(160, 60, 240)
stroke.Thickness = 1.5

-- Header
local title = Instance.new("TextLabel", f)
title.Size = UDim2.new(1, -40, 0, 35)
title.Position = UDim2.new(0, 12, 0, 4)
title.BackgroundTransparency = 1
title.Text = "⚡ EX Community - Steal An Egg Ultimate"
title.TextColor3 = Color3.fromRGB(235, 210, 255)
title.TextSize = 13
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left

-- Tombol Minimize
local minBtn = Instance.new("TextButton", f)
minBtn.Size = UDim2.new(0, 24, 0, 24)
minBtn.Position = UDim2.new(1, -30, 0, 8)
minBtn.BackgroundColor3 = Color3.fromRGB(30, 15, 50)
minBtn.Text = "-"
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minBtn.TextSize = 14
minBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 6)

-- Custom Icon "EX"
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
-- 2. TABS & PAGES SYSTEM
-- ==========================================
local tabContainer = Instance.new("Frame", f)
tabContainer.Size = UDim2.new(0, 110, 0, 210)
tabContainer.Position = UDim2.new(0, 10, 0, 40)
tabContainer.BackgroundTransparency = 1

local pageContainer = Instance.new("Frame", f)
pageContainer.Size = UDim2.new(0, 305, 0, 210)
pageContainer.Position = UDim2.new(0, 125, 0, 40)
pageContainer.BackgroundTransparency = 1

local btnTabMain = Instance.new("TextButton", tabContainer)
btnTabMain.Size = UDim2.new(1, 0, 0, 35)
btnTabMain.Text = "🎯 MAIN"
btnTabMain.BackgroundColor3 = Color3.fromRGB(120, 25, 200)
btnTabMain.TextColor3 = Color3.fromRGB(255, 255, 255)
btnTabMain.Font = Enum.Font.GothamBold
btnTabMain.TextSize = 11
Instance.new("UICorner", btnTabMain).CornerRadius = UDim.new(0, 6)

local btnTabPerf = Instance.new("TextButton", tabContainer)
btnTabPerf.Size = UDim2.new(1, 0, 0, 35)
btnTabPerf.Position = UDim2.new(0, 0, 0, 45)
btnTabPerf.Text = "⚡ PERFORMA"
btnTabPerf.BackgroundColor3 = Color3.fromRGB(30, 15, 50)
btnTabPerf.TextColor3 = Color3.fromRGB(200, 170, 230)
btnTabPerf.Font = Enum.Font.GothamBold
btnTabPerf.TextSize = 11
Instance.new("UICorner", btnTabPerf).CornerRadius = UDim.new(0, 6)

local pageMain = Instance.new("Frame", pageContainer)
pageMain.Size = UDim2.new(1, 0, 1, 0)
pageMain.BackgroundTransparency = 1

local pagePerf = Instance.new("Frame", pageContainer)
pagePerf.Size = UDim2.new(1, 0, 1, 0)
pagePerf.BackgroundTransparency = 1
pagePerf.Visible = false

btnTabMain.MouseButton1Click:Connect(function()
    pageMain.Visible = true; pagePerf.Visible = false
    btnTabMain.BackgroundColor3 = Color3.fromRGB(120, 25, 200)
    btnTabMain.TextColor3 = Color3.fromRGB(255, 255, 255)
    btnTabPerf.BackgroundColor3 = Color3.fromRGB(30, 15, 50)
    btnTabPerf.TextColor3 = Color3.fromRGB(200, 170, 230)
end)

btnTabPerf.MouseButton1Click:Connect(function()
    pageMain.Visible = false; pagePerf.Visible = true
    btnTabPerf.BackgroundColor3 = Color3.fromRGB(120, 25, 200)
    btnTabPerf.TextColor3 = Color3.fromRGB(255, 255, 255)
    btnTabMain.BackgroundColor3 = Color3.fromRGB(30, 15, 50)
    btnTabMain.TextColor3 = Color3.fromRGB(200, 170, 230)
end)

-- ==========================================
-- 3. KONTEN TAB: MAIN (AUTO STEAL)
-- ==========================================
local stealSettings = { running = false, method = "Instant", target = "All", filterText = "" }

local btnMethod = Instance.new("TextButton", pageMain)
btnMethod.Size = UDim2.new(1, 0, 0, 30)
btnMethod.Text = "Metode: INSTAN (Teleport)"
btnMethod.BackgroundColor3 = Color3.fromRGB(40, 20, 70)
btnMethod.TextColor3 = Color3.fromRGB(255, 255, 255)
btnMethod.Font = Enum.Font.GothamMedium
btnMethod.TextSize = 11
Instance.new("UICorner", btnMethod).CornerRadius = UDim.new(0, 6)

local btnTarget = Instance.new("TextButton", pageMain)
btnTarget.Size = UDim2.new(1, 0, 0, 30)
btnTarget.Position = UDim2.new(0, 0, 0, 38)
btnTarget.Text = "Target: SEMUA TELUR"
btnTarget.BackgroundColor3 = Color3.fromRGB(40, 20, 70)
btnTarget.TextColor3 = Color3.fromRGB(255, 255, 255)
btnTarget.Font = Enum.Font.GothamMedium
btnTarget.TextSize = 11
Instance.new("UICorner", btnTarget).CornerRadius = UDim.new(0, 6)

local txtFilter = Instance.new("TextBox", pageMain)
txtFilter.Size = UDim2.new(1, 0, 0, 30)
txtFilter.Position = UDim2.new(0, 0, 0, 76)
txtFilter.PlaceholderText = "Ketik filter (Misal: Mythic, Cosmic, Lava)"
txtFilter.Text = ""
txtFilter.BackgroundColor3 = Color3.fromRGB(25, 12, 40)
txtFilter.TextColor3 = Color3.fromRGB(255, 255, 255)
txtFilter.Font = Enum.Font.Gotham
txtFilter.TextSize = 11
txtFilter.Visible = false
Instance.new("UICorner", txtFilter).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", txtFilter).Color = Color3.fromRGB(90, 40, 130)

local btnStart = Instance.new("TextButton", pageMain)
btnStart.Size = UDim2.new(1, 0, 0, 45)
btnStart.Position = UDim2.new(0, 0, 0, 114)
btnStart.Text = "▶ START AUTO STEAL"
btnStart.BackgroundColor3 = Color3.fromRGB(110, 20, 190)
btnStart.TextColor3 = Color3.fromRGB(255, 255, 255)
btnStart.Font = Enum.Font.GothamBold
btnStart.TextSize = 13
Instance.new("UICorner", btnStart).CornerRadius = UDim.new(0, 6)

local stLabel = Instance.new("TextLabel", pageMain)
stLabel.Size = UDim2.new(1, 0, 0, 20)
stLabel.Position = UDim2.new(0, 0, 0, 165)
stLabel.Text = "Berdiri di base kamu sebelum klik START!"
stLabel.BackgroundTransparency = 1
stLabel.TextColor3 = Color3.fromRGB(190, 160, 220)
stLabel.Font = Enum.Font.GothamMedium
stLabel.TextSize = 11

-- Interaksi Tombol Tab Main
btnMethod.MouseButton1Click:Connect(function()
    if stealSettings.method == "Instant" then
        stealSettings.method = "Normal"
        btnMethod.Text = "Metode: NORMAL (Jalan Kaki)"
    else
        stealSettings.method = "Instant"
        btnMethod.Text = "Metode: INSTAN (Teleport)"
    end
end)

btnTarget.MouseButton1Click:Connect(function()
    if stealSettings.target == "All" then
        stealSettings.target = "Filter"
        btnTarget.Text = "Target: FILTER KHUSUS"
        txtFilter.Visible = true
    else
        stealSettings.target = "All"
        btnTarget.Text = "Target: SEMUA TELUR"
        txtFilter.Visible = false
    end
end)

-- ==========================================
-- 4. KONTEN TAB: PERFORMA (ANTI-LAG)
-- ==========================================
local function createPerfButton(txt, yPos, cb)
    local b = Instance.new("TextButton", pagePerf)
    b.Size = UDim2.new(1, 0, 0, 32)
    b.Position = UDim2.new(0, 0, 0, yPos)
    b.Text = txt
    b.BackgroundColor3 = Color3.fromRGB(35, 15, 60)
    b.TextColor3 = Color3.fromRGB(240, 210, 255)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 11
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(cb)
end

createPerfButton("🧹 Hapus Partikel & Efek Visual", 0, function()
    pcall(function()
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Beam") then v:Destroy() end
        end
    end)
end)

createPerfButton("🐾 Hapus Hewan / Monster / Pet", 40, function()
    pcall(function()
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("Model") and (v.Name:lower():find("pet") or v.Name:lower():find("guardian") or v.Name:lower():find("chicken") or v.Name:lower():find("boss")) then
                if not Players:GetPlayerFromCharacter(v) then v:Destroy() end
            end
        end
    end)
end)

createPerfButton("🏡 Sembunyikan Dekorasi Map", 80, function()
    pcall(function()
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") and (v.Name:lower():find("decora") or v.Name:lower():find("tree") or v.Name:lower():find("prop")) then
                v.Transparency = 1; v.CanCollide = false
            end
        end
    end)
end)

createPerfButton("🚀 SUPER MAX FPS BOOST (Grafik Kentang)", 120, function()
    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        game:GetService("Lighting").GlobalShadows = false
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Material = Enum.Material.SmoothPlastic
                v.Reflectance = 0
            elseif v:IsA("Decal") or v:IsA("Texture") then
                v.Transparency = 1
            end
        end
    end)
end)

-- ==========================================
-- 5. LOGIKA AUTO STEAL ROBUST
-- ==========================================
local baseCFrame = nil

local function getBestEgg()
    local possibleEggs = {}
    -- Cari semua part/model yang namanya ada unsur telur
    for _, v in pairs(Workspace:GetDescendants()) do
        local n = v.Name:lower()
        if v:IsA("Model") and (n:find("egg") or n:find("telur")) then
            local primary = v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart")
            if primary then table.insert(possibleEggs, {part = primary, name = n, obj = v}) end
        elseif v:IsA("BasePart") and (n:find("egg") or n:find("telur")) then
            if not v.Parent:FindFirstChild("Humanoid") then table.insert(possibleEggs, {part = v, name = n, obj = v}) end
        elseif v:IsA("ProximityPrompt") and (v.ActionText:lower():find("steal") or v.ActionText:lower():find("grab") or n:find("egg")) then
            table.insert(possibleEggs, {part = v.Parent, name = v.Parent.Name:lower(), obj = v.Parent, prompt = v})
        end
    end
    
    -- Terapkan Filter
    for _, eggData in pairs(possibleEggs) do
        local pass = true
        if stealSettings.target == "Filter" and txtFilter.Text ~= "" then
            pass = false
            local fText = txtFilter.Text:lower()
            for word in string.gmatch(fText, '([^,]+)') do
                word = word:match("^%s*(.-)%s*$") -- Trim spasi
                if word ~= "" and eggData.name:find(word) then pass = true; break end
            end
        end
        if pass then return eggData end
    end
    return nil
end

btnStart.MouseButton1Click:Connect(function()
    stealSettings.running = not stealSettings.running
    if stealSettings.running then
        btnStart.Text = "⏹ STOP AUTO STEAL"
        btnStart.BackgroundColor3 = Color3.fromRGB(180, 35, 35)
        
        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp then baseCFrame = hrp.CFrame end -- Simpan lokasi base
        
        task.spawn(function()
            while stealSettings.running do
                task.wait(0.5)
                local char = player.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                local hum = char and char:FindFirstChild("Humanoid")
                if not hrp or not hum then continue end
                
                local egg = getBestEgg()
                if egg then
                    stLabel.Text = "Mengambil: " .. egg.name
                    
                    if stealSettings.method == "Instant" then
                        -- Teleport ke telur
                        hrp.CFrame = egg.part.CFrame
                        task.wait(0.3)
                        
                        -- Bypass cara ambil (Sentuh & Prompt)
                        if firetouchinterest then
                            firetouchinterest(hrp, egg.part, 0); task.wait(0.1); firetouchinterest(hrp, egg.part, 1)
                        end
                        if egg.prompt then fireproximityprompt(egg.prompt) end
                        
                        task.wait(0.4)
                        -- Teleport balik ke Base
                        if baseCFrame then hrp.CFrame = baseCFrame end
                        task.wait(0.5)
                        
                    elseif stealSettings.method == "Normal" then
                        -- Jalan ke telur
                        hum:MoveTo(egg.part.Position)
                        local timeout = 0
                        while (hrp.Position - egg.part.Position).Magnitude > 6 and timeout < 6 do
                            task.wait(0.2); timeout = timeout + 0.2
                        end
                        
                        if firetouchinterest then
                            firetouchinterest(hrp, egg.part, 0); task.wait(0.1); firetouchinterest(hrp, egg.part, 1)
                        end
                        if egg.prompt then fireproximityprompt(egg.prompt) end
                        
                        -- Jalan balik ke Base
                        if baseCFrame then
                            hum:MoveTo(baseCFrame.Position)
                            local timeout2 = 0
                            while (hrp.Position - baseCFrame.Position).Magnitude > 6 and timeout2 < 6 do
                                task.wait(0.2); timeout2 = timeout2 + 0.2
                            end
                        end
                    end
                else
                    stLabel.Text = "Mencari telur..."
                end
            end
        end)
    else
        btnStart.Text = "▶ START AUTO STEAL"
        btnStart.BackgroundColor3 = Color3.fromRGB(110, 20, 190)
        stLabel.Text = "Auto Steal Berhenti."
    end
end)

-- Minimize Logic
minBtn.MouseButton1Click:Connect(function()
    f.Visible = false; minIcon.Visible = true
end)
minIcon.MouseButton1Click:Connect(function()
    f.Visible = true; minIcon.Visible = false
end)
