local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local player = Players.LocalPlayer

-- Menggunakan CoreGui agar UI tidak hilang pas mati (jika support), atau PlayerGui
local gui = player:WaitForChild("PlayerGui")
if gui:FindFirstChild("EX_StealAnEgg_VIP") then 
    gui.EX_StealAnEgg_VIP:Destroy() 
end

local sg = Instance.new("ScreenGui", gui)
sg.Name = "EX_StealAnEgg_VIP"
sg.ResetOnSpawn = false

-- ==========================================
-- LAYAR PUTIH (DISABLE 3D)
-- ==========================================
local whiteScreen = Instance.new("Frame", sg)
whiteScreen.Size = UDim2.new(1, 0, 1, 0)
whiteScreen.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
whiteScreen.Visible = false
whiteScreen.ZIndex = -10 -- Taruh di belakang menu tapi nutupin game

local stWhite = Instance.new("TextLabel", whiteScreen)
stWhite.Size = UDim2.new(1, 0, 1, 0)
stWhite.BackgroundTransparency = 1
stWhite.Text = "RENDERING 3D DISABLED (AFK MODE)\nGame menjadi sangat ringan."
stWhite.TextColor3 = Color3.fromRGB(50, 50, 50)
stWhite.Font = Enum.Font.GothamBold
stWhite.TextSize = 20

-- ==========================================
-- UI UTAMA (DESAIN SIDEBAR MEWAH)
-- ==========================================
local f = Instance.new("Frame", sg)
f.Size = UDim2.new(0, 500, 0, 300)
f.Position = UDim2.new(0.5, -250, 0.5, -150)
f.BackgroundColor3 = Color3.fromRGB(15, 10, 25)
f.Active = true 
f.Draggable = true
Instance.new("UICorner", f).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", f).Color = Color3.fromRGB(160, 60, 240)
Instance.new("UIStroke", f).Thickness = 2

-- Header
local header = Instance.new("Frame", f)
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = Color3.fromRGB(25, 12, 45)
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 10)
local headerBottom = Instance.new("Frame", header)
headerBottom.Size = UDim2.new(1, 0, 0, 10)
headerBottom.Position = UDim2.new(0, 0, 1, -10)
headerBottom.BackgroundColor3 = Color3.fromRGB(25, 12, 45)
headerBottom.BorderSizePixel = 0

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, -50, 1, 0)
title.Position = UDim2.new(0, 15, 0, 0)
title.BackgroundTransparency = 1
title.Text = "⚡ EX COMMUNITY - STEAL AN EGG (VIP)"
title.TextColor3 = Color3.fromRGB(240, 210, 255)
title.TextSize = 14
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left

local minBtn = Instance.new("TextButton", header)
minBtn.Size = UDim2.new(0, 30, 0, 30)
minBtn.Position = UDim2.new(1, -40, 0, 5)
minBtn.BackgroundColor3 = Color3.fromRGB(40, 20, 70)
minBtn.Text = "—"
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 6)

-- Sidebar (Kiri)
local sidebar = Instance.new("Frame", f)
sidebar.Size = UDim2.new(0, 130, 1, -40)
sidebar.Position = UDim2.new(0, 0, 0, 40)
sidebar.BackgroundColor3 = Color3.fromRGB(20, 12, 35)
sidebar.BorderSizePixel = 0

-- Kontainer Halaman (Kanan)
local pageContainer = Instance.new("Frame", f)
pageContainer.Size = UDim2.new(1, -130, 1, -40)
pageContainer.Position = UDim2.new(0, 130, 0, 40)
pageContainer.BackgroundTransparency = 1

-- Icon Minimize Melayang
local minIcon = Instance.new("TextButton", sg)
minIcon.Size = UDim2.new(0, 45, 0, 45)
minIcon.Position = UDim2.new(0, 20, 0, 20)
minIcon.BackgroundColor3 = Color3.fromRGB(25, 12, 45)
minIcon.Text = "EX"
minIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
minIcon.TextSize = 14
minIcon.Font = Enum.Font.FredokaOne
minIcon.Visible = false
minIcon.Active = true
minIcon.Draggable = true
Instance.new("UICorner", minIcon).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", minIcon).Color = Color3.fromRGB(180, 50, 255)
Instance.new("UIStroke", minIcon).Thickness = 2

-- ==========================================
-- SISTEM TAB & HALAMAN
-- ==========================================
local tabs = {}
local pages = {}

local function createTab(name, yPos, isFirst)
    local btn = Instance.new("TextButton", sidebar)
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.Position = UDim2.new(0, 5, 0, yPos)
    btn.Text = name
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    local page = Instance.new("Frame", pageContainer)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = isFirst
    
    if isFirst then
        btn.BackgroundColor3 = Color3.fromRGB(130, 30, 220)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    else
        btn.BackgroundColor3 = Color3.fromRGB(30, 15, 50)
        btn.TextColor3 = Color3.fromRGB(180, 150, 220)
    end
    
    table.insert(tabs, btn)
    table.insert(pages, page)
    
    btn.MouseButton1Click:Connect(function()
        for i, t in pairs(tabs) do
            t.BackgroundColor3 = Color3.fromRGB(30, 15, 50)
            t.TextColor3 = Color3.fromRGB(180, 150, 220)
            pages[i].Visible = false
        end
        btn.BackgroundColor3 = Color3.fromRGB(130, 30, 220)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        page.Visible = true
    end)
    return page
end

local pageMain = createTab("🎯 MAIN", 10, true)
local pageFilter = createTab("⚙️ FILTER", 50, false)
local pagePerf = createTab("🚀 PERFORMA", 90, false)

-- ==========================================
-- SETTING & DATA
-- ==========================================
local config = {
    running = false,
    method = "Fly", -- Fly / Instant
    filters = {
        Common = true, Uncommon = true, Rare = true, Epic = true,
        Legendary = true, Mythic = true, Secret = true, Cosmic = true
    }
}
local baseCFrame = nil

-- ==========================================
-- KONTEN: MAIN
-- ==========================================
local btnMethod = Instance.new("TextButton", pageMain)
btnMethod.Size = UDim2.new(0.9, 0, 0, 35)
btnMethod.Position = UDim2.new(0.05, 0, 0, 20)
btnMethod.Text = "Metode: TERBANG (Aman Noclip)"
btnMethod.BackgroundColor3 = Color3.fromRGB(45, 25, 80)
btnMethod.TextColor3 = Color3.fromRGB(255, 255, 255)
btnMethod.Font = Enum.Font.GothamMedium
btnMethod.TextSize = 12
Instance.new("UICorner", btnMethod).CornerRadius = UDim.new(0, 6)

btnMethod.MouseButton1Click:Connect(function()
    if config.method == "Fly" then
        config.method = "Instant"
        btnMethod.Text = "Metode: INSTAN (Teleport Cepat)"
    else
        config.method = "Fly"
        btnMethod.Text = "Metode: TERBANG (Aman Noclip)"
    end
end)

local btnStart = Instance.new("TextButton", pageMain)
btnStart.Size = UDim2.new(0.9, 0, 0, 50)
btnStart.Position = UDim2.new(0.05, 0, 0, 70)
btnStart.Text = "▶ START AUTO STEAL"
btnStart.BackgroundColor3 = Color3.fromRGB(130, 30, 220)
btnStart.TextColor3 = Color3.fromRGB(255, 255, 255)
btnStart.Font = Enum.Font.GothamBold
btnStart.TextSize = 14
Instance.new("UICorner", btnStart).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", btnStart).Color = Color3.fromRGB(180, 80, 255)

local statusLabel = Instance.new("TextLabel", pageMain)
statusLabel.Size = UDim2.new(0.9, 0, 0, 30)
statusLabel.Position = UDim2.new(0.05, 0, 0, 130)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Berdiri di base kamu lalu klik START"
statusLabel.TextColor3 = Color3.fromRGB(200, 170, 240)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 12

-- ==========================================
-- KONTEN: FILTER (Tinggal Klik)
-- ==========================================
local filterScroll = Instance.new("ScrollingFrame", pageFilter)
filterScroll.Size = UDim2.new(0.9, 0, 0.9, 0)
filterScroll.Position = UDim2.new(0.05, 0, 0.05, 0)
filterScroll.BackgroundTransparency = 1
filterScroll.CanvasSize = UDim2.new(0, 0, 0, 340)
filterScroll.ScrollBarThickness = 4

local yPosFilter = 0
for rarity, state in pairs(config.filters) do
    local b = Instance.new("TextButton", filterScroll)
    b.Size = UDim2.new(1, -10, 0, 35)
    b.Position = UDim2.new(0, 0, 0, yPosFilter)
    b.Text = rarity .. " : " .. (state and "ON" or "OFF")
    b.BackgroundColor3 = state and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(150, 40, 40)
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 12
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    
    b.MouseButton1Click:Connect(function()
        config.filters[rarity] = not config.filters[rarity]
        b.Text = rarity .. " : " .. (config.filters[rarity] and "ON" or "OFF")
        b.BackgroundColor3 = config.filters[rarity] and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(150, 40, 40)
    end)
    yPosFilter = yPosFilter + 40
end

-- ==========================================
-- KONTEN: PERFORMA & ANTI LAG
-- ==========================================
local perfScroll = Instance.new("ScrollingFrame", pagePerf)
perfScroll.Size = UDim2.new(0.9, 0, 0.9, 0)
perfScroll.Position = UDim2.new(0.05, 0, 0.05, 0)
perfScroll.BackgroundTransparency = 1
perfScroll.CanvasSize = UDim2.new(0, 0, 0, 250)
perfScroll.ScrollBarThickness = 4

local function addPerfBtn(txt, y, cb)
    local b = Instance.new("TextButton", perfScroll)
    b.Size = UDim2.new(1, -10, 0, 35)
    b.Position = UDim2.new(0, 0, 0, y)
    b.Text = txt
    b.BackgroundColor3 = Color3.fromRGB(45, 25, 70)
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 11
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(cb)
end

-- 1. Disable 3D (Layar Putih)
local is3DDisabled = false
addPerfBtn("⬜ DISABLE 3D (Layar Putih AFK)", 0, function()
    is3DDisabled = not is3DDisabled
    whiteScreen.Visible = is3DDisabled
    pcall(function() RunService:Set3dRenderingEnabled(not is3DDisabled) end)
end)

-- 2. Hapus Partikel
addPerfBtn("🧹 Bersihkan Map (Partikel/Dekorasi)", 45, function()
    pcall(function()
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("BasePart") and (v.Name:lower():find("tree") or v.Name:lower():find("prop")) then
                if v:IsA("BasePart") then
                    v.Transparency = 1; v.CanCollide = false
                else
                    v:Destroy()
                end
            end
        end
    end)
end)

-- 3. Hapus Treadmill Popups (Anti Force Close)
local antiTreadmillLag = false
addPerfBtn("🏃 Anti-Lag Treadmill (Hilangkan +Speed)", 90, function()
    antiTreadmillLag = not antiTreadmillLag
    if antiTreadmillLag then
        -- Loop pembersih popup speed yang muncul terus-menerus
        task.spawn(function()
            while antiTreadmillLag do
                task.wait(0.5)
                pcall(function()
                    for _, v in pairs(Workspace:GetDescendants()) do
                        if v:IsA("BillboardGui") or v:IsA("TextLabel") or (v:IsA("BasePart") and v.Name:lower():find("speed")) then
                            if v.Name:lower():find("speed") or v.Name:lower():find("+") or v.Name:lower():find("popup") then
                                v:Destroy()
                            end
                        end
                    end
                    if player.Character then
                        for _, v in pairs(player.Character:GetDescendants()) do
                            if v:IsA("BillboardGui") or v:IsA("ParticleEmitter") then v:Destroy() end
                        end
                    end
                end)
            end
        end)
    end
end)

-- 4. Max FPS (Grafik Kentang)
addPerfBtn("🚀 SUPER FPS BOOST (Grafik Kentang)", 135, function()
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

-- ==========================================
-- LOGIKA UTAMA (STEAL & NOCLIP)
-- ==========================================
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
        if v:IsA("Model") and (n:find("egg") or n:find("telur")) then
            table.insert(possibleEggs, v)
        end
    end
    
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end

    local bestEgg = nil
    local closestDist = math.huge

    for _, eggModel in pairs(possibleEggs) do
        local pass = false
        local n = eggModel.Name:lower()
        
        -- Cek Filter Rarity
        for rName, rActive in pairs(config.filters) do
            if rActive and n:find(rName:lower()) then pass = true; break end
        end
        
        -- Abaikan jika dekat base (menghindari telur sendiri)
        local rootPart = eggModel.PrimaryPart or eggModel:FindFirstChildWhichIsA("BasePart")
        if rootPart and baseCFrame and (rootPart.Position - baseCFrame.Position).Magnitude < 40 then
            pass = false 
        end
        
        if pass and rootPart then
            local dist = (rootPart.Position - hrp.Position).Magnitude
            if dist < closestDist then
                closestDist = dist
                bestEgg = {model = eggModel, part = rootPart, name = eggModel.Name}
            end
        end
    end
    return bestEgg
end

local function flyTo(targetCFrame)
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local dist = (hrp.Position - targetCFrame.Position).Magnitude
    local time = dist / 60 
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
                    statusLabel.Text = "Curi: " .. egg.name
                    
                    -- Masuk TEPAT ke titik telur (bukan di atasnya) agar 100% tersentuh
                    if config.method == "Fly" then
                        flyTo(egg.part.CFrame)
                    else
                        hrp.CFrame = egg.part.CFrame
                        task.wait(0.1)
                    end
                    
                    -- Paksa sentuh SEMUA bagian telur
                    if firetouchinterest then
                        for _, p in ipairs(egg.model:GetDescendants()) do
                            if p:IsA("BasePart") then
                                firetouchinterest(hrp, p, 0)
                                firetouchinterest(hrp, p, 1)
                            end
                        end
                    end
                    local prompt = egg.model:FindFirstChildWhichIsA("ProximityPrompt", true)
                    if prompt then fireproximityprompt(prompt) end
                    
                    task.wait(0.2)
                    
                    if baseCFrame then
                        if config.method == "Fly" then flyTo(baseCFrame) else hrp.CFrame = baseCFrame; task.wait(0.1) end
                    end
                else
                    statusLabel.Text = "Mencari telur di luar base..."
                    task.wait(1)
                end
            end
        end)
    else
        btnStart.Text = "▶ START AUTO STEAL"
        btnStart.BackgroundColor3 = Color3.fromRGB(130, 30, 220)
        statusLabel.Text = "Berhenti."
        toggleNoclip(false)
    end
end)

-- Interaksi Minimize
minBtn.MouseButton1Click:Connect(function() f.Visible = false; minIcon.Visible = true end)
minIcon.MouseButton1Click:Connect(function() f.Visible = true; minIcon.Visible = false end)
