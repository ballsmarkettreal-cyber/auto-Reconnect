local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local gui = player:WaitForChild("PlayerGui")
if gui:FindFirstChild("EX_StealAnEgg_VIP") then 
    gui.EX_StealAnEgg_VIP:Destroy() 
end

local sg = Instance.new("ScreenGui", gui)
sg.Name = "EX_StealAnEgg_VIP"
sg.ResetOnSpawn = false

-- ==========================================
-- LAYAR PUTIH MURNI (TANPA TEKS SAMA SEKALI)
-- ==========================================
local whiteScreen = Instance.new("Frame", sg)
whiteScreen.Size = UDim2.new(1, 0, 1, 0)
whiteScreen.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
whiteScreen.Visible = false
whiteScreen.ZIndex = -10 

-- ==========================================
-- UI SIDEBAR (DESAIN LEBIH KECIL & ELEGAN)
-- ==========================================
local f = Instance.new("Frame", sg)
f.Size = UDim2.new(0, 460, 0, 270)
f.Position = UDim2.new(0.5, -230, 0.5, -135)
f.BackgroundColor3 = Color3.fromRGB(12, 10, 18) -- Warna dasar lebih gelap premium
f.Active = true 
f.Draggable = true
Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", f).Color = Color3.fromRGB(140, 50, 220)
Instance.new("UIStroke", f).Thickness = 1.5

-- FITUR SKALA UI (BESAR/KECIL)
local uiScale = Instance.new("UIScale", f)
uiScale.Scale = 1

local header = Instance.new("Frame", f)
header.Size = UDim2.new(1, 0, 0, 35)
header.BackgroundColor3 = Color3.fromRGB(20, 15, 30)
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 8)

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, -120, 1, 0)
title.Position = UDim2.new(0, 15, 0, 0)
title.BackgroundTransparency = 1
title.Text = "⚡ EX COMMUNITY - STEAL AN EGG (V5 PRO)"
title.TextColor3 = Color3.fromRGB(230, 200, 255)
title.TextSize = 11 -- Teks judul dikecilkan
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left

-- Tombol Resize UI (-)
local btnMinScale = Instance.new("TextButton", header)
btnMinScale.Size = UDim2.new(0, 25, 0, 25)
btnMinScale.Position = UDim2.new(1, -95, 0, 5)
btnMinScale.BackgroundColor3 = Color3.fromRGB(40, 25, 60)
btnMinScale.Text = "🔍-"
btnMinScale.TextColor3 = Color3.fromRGB(255, 255, 255)
btnMinScale.TextSize = 10
Instance.new("UICorner", btnMinScale).CornerRadius = UDim.new(0, 4)

-- Tombol Resize UI (+)
local btnMaxScale = Instance.new("TextButton", header)
btnMaxScale.Size = UDim2.new(0, 25, 0, 25)
btnMaxScale.Position = UDim2.new(1, -65, 0, 5)
btnMaxScale.BackgroundColor3 = Color3.fromRGB(40, 25, 60)
btnMaxScale.Text = "🔍+"
btnMaxScale.TextColor3 = Color3.fromRGB(255, 255, 255)
btnMaxScale.TextSize = 10
Instance.new("UICorner", btnMaxScale).CornerRadius = UDim.new(0, 4)

-- Tombol Minimize UI
local minBtn = Instance.new("TextButton", header)
minBtn.Size = UDim2.new(0, 25, 0, 25)
minBtn.Position = UDim2.new(1, -35, 0, 5)
minBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
minBtn.Text = "—"
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 12
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 4)

-- Logika Skala UI (Zoom In / Zoom Out)
btnMinScale.MouseButton1Click:Connect(function()
    uiScale.Scale = math.clamp(uiScale.Scale - 0.1, 0.5, 2)
end)
btnMaxScale.MouseButton1Click:Connect(function()
    uiScale.Scale = math.clamp(uiScale.Scale + 0.1, 0.5, 2)
end)

local minIcon = Instance.new("TextButton", sg)
minIcon.Size = UDim2.new(0, 40, 0, 40)
minIcon.Position = UDim2.new(0, 20, 0, 20)
minIcon.BackgroundColor3 = Color3.fromRGB(20, 10, 30)
minIcon.Text = "EX"
minIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
minIcon.TextSize = 12
minIcon.Font = Enum.Font.FredokaOne
minIcon.Visible = false
minIcon.Active = true
minIcon.Draggable = true
Instance.new("UICorner", minIcon).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", minIcon).Color = Color3.fromRGB(150, 50, 220)
Instance.new("UIStroke", minIcon).Thickness = 1.5

local sidebar = Instance.new("Frame", f)
sidebar.Size = UDim2.new(0, 120, 1, -35)
sidebar.Position = UDim2.new(0, 0, 0, 35)
sidebar.BackgroundColor3 = Color3.fromRGB(16, 12, 24)
sidebar.BorderSizePixel = 0

local pageContainer = Instance.new("Frame", f)
pageContainer.Size = UDim2.new(1, -120, 1, -35)
pageContainer.Position = UDim2.new(0, 120, 0, 35)
pageContainer.BackgroundTransparency = 1

local tabs, pages = {}, {}
local function createTab(name, yPos, isFirst)
    local btn = Instance.new("TextButton", sidebar)
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.Position = UDim2.new(0, 5, 0, yPos)
    btn.Text = name
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 10 -- Teks tab dikecilkan
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    
    local page = Instance.new("Frame", pageContainer)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = isFirst
    
    if isFirst then
        btn.BackgroundColor3 = Color3.fromRGB(110, 30, 200)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    else
        btn.BackgroundColor3 = Color3.fromRGB(25, 15, 40)
        btn.TextColor3 = Color3.fromRGB(160, 140, 200)
    end
    
    table.insert(tabs, btn)
    table.insert(pages, page)
    
    btn.MouseButton1Click:Connect(function()
        for i, t in pairs(tabs) do
            t.BackgroundColor3 = Color3.fromRGB(25, 15, 40)
            t.TextColor3 = Color3.fromRGB(160, 140, 200)
            pages[i].Visible = false
        end
        btn.BackgroundColor3 = Color3.fromRGB(110, 30, 200)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        page.Visible = true
    end)
    return page
end

local pageMain = createTab("🎯 MAIN", 10, true)
local pageFilter = createTab("⚙️ FILTER", 45, false)
local pagePerf = createTab("🚀 PERFORMA", 80, false)

local config = {
    running = false, method = "Fly", target = "All",
    filters = {
        Common = false, Uncommon = true, Rare = false, Epic = false,
        Legendary = false, Mythic = false, Secret = false, Cosmic = false
    }
}
local baseCFrame = nil

-- KONTEN MAIN
local btnMethod = Instance.new("TextButton", pageMain)
btnMethod.Size = UDim2.new(0.9, 0, 0, 30)
btnMethod.Position = UDim2.new(0.05, 0, 0, 15)
btnMethod.Text = "Metode: TERBANG (Aman Noclip)"
btnMethod.BackgroundColor3 = Color3.fromRGB(35, 20, 60)
btnMethod.TextColor3 = Color3.fromRGB(255, 255, 255)
btnMethod.Font = Enum.Font.GothamMedium
btnMethod.TextSize = 10 -- Teks tombol lebih proporsional
Instance.new("UICorner", btnMethod).CornerRadius = UDim.new(0, 4)

local btnTarget = Instance.new("TextButton", pageMain)
btnTarget.Size = UDim2.new(0.9, 0, 0, 30)
btnTarget.Position = UDim2.new(0.05, 0, 0, 50)
btnTarget.Text = "Target: AMBIL SEMUA TELUR"
btnTarget.BackgroundColor3 = Color3.fromRGB(40, 80, 40)
btnTarget.TextColor3 = Color3.fromRGB(255, 255, 255)
btnTarget.Font = Enum.Font.GothamBold
btnTarget.TextSize = 10
Instance.new("UICorner", btnTarget).CornerRadius = UDim.new(0, 4)

local btnStart = Instance.new("TextButton", pageMain)
btnStart.Size = UDim2.new(0.9, 0, 0, 45)
btnStart.Position = UDim2.new(0.05, 0, 0, 90)
btnStart.Text = "▶ START AUTO STEAL"
btnStart.BackgroundColor3 = Color3.fromRGB(110, 30, 200)
btnStart.TextColor3 = Color3.fromRGB(255, 255, 255)
btnStart.Font = Enum.Font.GothamBold
btnStart.TextSize = 12
Instance.new("UICorner", btnStart).CornerRadius = UDim.new(0, 6)

local statusLabel = Instance.new("TextLabel", pageMain)
statusLabel.Size = UDim2.new(0.9, 0, 0, 25)
statusLabel.Position = UDim2.new(0.05, 0, 0, 140)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Berdiri di base kamu lalu klik START"
statusLabel.TextColor3 = Color3.fromRGB(180, 150, 220)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 10

btnMethod.MouseButton1Click:Connect(function()
    if config.method == "Fly" then
        config.method = "Instant"
        btnMethod.Text = "Metode: INSTAN (Teleport Cepat)"
    else
        config.method = "Fly"
        btnMethod.Text = "Metode: TERBANG (Aman Noclip)"
    end
end)
btnTarget.MouseButton1Click:Connect(function()
    if config.target == "All" then
        config.target = "Filter"
        btnTarget.Text = "Target: GUNAKAN FILTER"
        btnTarget.BackgroundColor3 = Color3.fromRGB(110, 40, 40)
    else
        config.target = "All"
        btnTarget.Text = "Target: AMBIL SEMUA TELUR"
        btnTarget.BackgroundColor3 = Color3.fromRGB(40, 80, 40)
    end
end)

-- KONTEN FILTER
local filterScroll = Instance.new("ScrollingFrame", pageFilter)
filterScroll.Size = UDim2.new(0.9, 0, 0.9, 0)
filterScroll.Position = UDim2.new(0.05, 0, 0.05, 0)
filterScroll.BackgroundTransparency = 1
filterScroll.CanvasSize = UDim2.new(0, 0, 0, 290)
filterScroll.ScrollBarThickness = 3

local yPosFilter = 0
for rarity, state in pairs(config.filters) do
    local b = Instance.new("TextButton", filterScroll)
    b.Size = UDim2.new(1, -10, 0, 30)
    b.Position = UDim2.new(0, 0, 0, yPosFilter)
    b.Text = rarity .. " : " .. (state and "ON" or "OFF")
    b.BackgroundColor3 = state and Color3.fromRGB(40, 120, 40) or Color3.fromRGB(120, 30, 30)
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 10
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)
    
    b.MouseButton1Click:Connect(function()
        config.filters[rarity] = not config.filters[rarity]
        b.Text = rarity .. " : " .. (config.filters[rarity] and "ON" or "OFF")
        b.BackgroundColor3 = config.filters[rarity] and Color3.fromRGB(40, 120, 40) or Color3.fromRGB(120, 30, 30)
    end)
    yPosFilter = yPosFilter + 35
end

-- KONTEN PERFORMA
local perfScroll = Instance.new("ScrollingFrame", pagePerf)
perfScroll.Size = UDim2.new(0.9, 0, 0.9, 0)
perfScroll.Position = UDim2.new(0.05, 0, 0.05, 0)
perfScroll.BackgroundTransparency = 1
perfScroll.CanvasSize = UDim2.new(0, 0, 0, 200)
perfScroll.ScrollBarThickness = 3

local function addPerfBtn(txt, y, cb)
    local b = Instance.new("TextButton", perfScroll)
    b.Size = UDim2.new(1, -10, 0, 30)
    b.Position = UDim2.new(0, 0, 0, y)
    b.Text = txt
    b.BackgroundColor3 = Color3.fromRGB(35, 20, 60)
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 10
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)
    b.MouseButton1Click:Connect(cb)
end

local is3DDisabled = false
addPerfBtn("⬜ DISABLE 3D (Layar Putih Murni)", 0, function()
    is3DDisabled = not is3DDisabled
    whiteScreen.Visible = is3DDisabled
    pcall(function() RunService:Set3dRenderingEnabled(not is3DDisabled) end)
end)

addPerfBtn("🧹 Bersihkan Map (Hapus Plot/Pet)", 35, function()
    pcall(function()
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("Model") and (v.Name:lower():find("pet") or v.Name:lower():find("guardian")) then
                if not Players:GetPlayerFromCharacter(v) then v:Destroy() end
            end
            if v:IsA("BasePart") and (v.Name:lower():find("tree") or v.Name:lower():find("prop") or v.Name:lower():find("decora")) then
                v.Transparency = 1; v.CanCollide = false
            end
        end
    end)
end)

local antiTreadmillLag = false
addPerfBtn("🏃 Anti-Lag Treadmill", 70, function()
    antiTreadmillLag = not antiTreadmillLag
    if antiTreadmillLag then
        task.spawn(function()
            while antiTreadmillLag do
                task.wait(0.2)
                pcall(function()
                    local char = player.Character
                    if char then
                        for _, v in pairs(char:GetDescendants()) do
                            if v:IsA("BillboardGui") or v:IsA("TextLabel") or v:IsA("ParticleEmitter") then v:Destroy() end
                        end
                    end
                end)
            end
        end)
    end
end)

addPerfBtn("🚀 SUPER FPS BOOST (Grafik Kentang)", 105, function()
    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        game:GetService("Lighting").GlobalShadows = false
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Material = Enum.Material.SmoothPlastic
                v.Reflectance = 0
            end
        end
    end)
end)

-- LOGIKA NOCLIP & STEAL EGG
local noclipConn
local function toggleNoclip(state)
    if state then
        noclipConn = RunService.Stepped:Connect(function()
            if player.Character then
                for _, v in pairs(player.Character:GetDescendants()) do
                    if v:IsA("BasePart") and v.CanCollide then v.CanCollide = false end
                end
            end
        end)
    else
        if noclipConn then noclipConn:Disconnect() end
    end
end

local function getBestEgg()
    local possibleEggs = {}
    for _, v in pairs(Workspace:GetDescendants()) do
        local n = v.Name:lower()
        if (v:IsA("Model") or v:IsA("BasePart")) and (n:find("egg") or n:find("telur")) then
            if v.Parent and not v.Parent:FindFirstChild("Humanoid") then
                table.insert(possibleEggs, v)
            end
        end
    end
    
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end

    local bestEgg = nil
    local closestDist = math.huge

    for _, eggObj in pairs(possibleEggs) do
        local pass = true
        local n = eggObj.Name:lower()
        local rootPart = eggObj:IsA("BasePart") and eggObj or (eggObj.PrimaryPart or eggObj:FindFirstChildWhichIsA("BasePart"))
        
        if rootPart then
            if baseCFrame and (rootPart.Position - baseCFrame.Position).Magnitude < 25 then
                pass = false 
            end
            if pass and config.target == "Filter" then
                pass = false
                for rName, rActive in pairs(config.filters) do
                    if rActive and n:find(rName:lower()) then pass = true; break end
                end
            end
            if pass then
                local dist = (rootPart.Position - hrp.Position).Magnitude
                if dist < closestDist then
                    closestDist = dist
                    bestEgg = {obj = eggObj, part = rootPart, name = eggObj.Name}
                end
            end
        end
    end
    return bestEgg
end

local function flyTo(targetCFrame)
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local dist = (hrp.Position - targetCFrame.Position).Magnitude
    local time = dist / 65 
    local tween = TweenService:Create(hrp, TweenInfo.new(time, Enum.EasingStyle.Linear), {CFrame = targetCFrame})
    tween:Play()
    tween.Completed:Wait()
end

btnStart.MouseButton1Click:Connect(function()
    config.running = not config.running
    if config.running then
        btnStart.Text = "⏹ STOP AUTO STEAL"
        btnStart.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
        
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if hrp then baseCFrame = hrp.CFrame end 
        toggleNoclip(true)
        
        task.spawn(function()
            while config.running do
                task.wait(0.1)
                local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                if not hrp then continue end
                
                hrp.Velocity = Vector3.zero
                
                local egg = getBestEgg()
                if egg then
                    statusLabel.Text = "Mencuri: " .. egg.name
                    if config.method == "Fly" then
                        flyTo(egg.part.CFrame)
                    else
                        hrp.CFrame = egg.part.CFrame
                        task.wait(0.1)
                    end
                    
                    if firetouchinterest then
                        firetouchinterest(hrp, egg.part, 0)
                        task.wait(0.05)
                        firetouchinterest(hrp, egg.part, 1)
                    end
                    local prompt = egg.obj:FindFirstChildWhichIsA("ProximityPrompt", true)
                    if prompt then fireproximityprompt(prompt) end
                    
                    task.wait(0.2)
                    
                    if baseCFrame then
                        if config.method == "Fly" then flyTo(baseCFrame) else hrp.CFrame = baseCFrame; task.wait(0.1) end
                    end
                else
                    statusLabel.Text = "Mencari telur... (Pastikan ada telur yg cocok)"
                    task.wait(1)
                end
            end
        end)
    else
        btnStart.Text = "▶ START AUTO STEAL"
        btnStart.BackgroundColor3 = Color3.fromRGB(110, 30, 200)
        statusLabel.Text = "Berhenti."
        toggleNoclip(false)
    end
end)

minBtn.MouseButton1Click:Connect(function() f.Visible = false; minIcon.Visible = true end)
minIcon.MouseButton1Click:Connect(function() f.Visible = true; minIcon.Visible = false end)
