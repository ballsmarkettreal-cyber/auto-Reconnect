local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

local gui = player:WaitForChild("PlayerGui")
if gui:FindFirstChild("EX_StealAnEgg_VIP") then 
    gui.EX_StealAnEgg_VIP:Destroy() 
end

local sg = Instance.new("ScreenGui", gui)
sg.Name = "EX_StealAnEgg_VIP"
sg.ResetOnSpawn = false

-- LAYAR PUTIH MURNI (DISABLE 3D)
local whiteScreen = Instance.new("Frame", sg)
whiteScreen.Size = UDim2.new(1, 0, 1, 0)
whiteScreen.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
whiteScreen.Visible = false
whiteScreen.ZIndex = -10 

-- UI UTAMA
local f = Instance.new("Frame", sg)
f.Size = UDim2.new(0, 460, 0, 270)
f.Position = UDim2.new(0.5, -230, 0.5, -135)
f.BackgroundColor3 = Color3.fromRGB(12, 10, 18)
f.Active = true 
f.Draggable = true
Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", f).Color = Color3.fromRGB(140, 50, 220)
Instance.new("UIStroke", f).Thickness = 1.5

-- HEADER
local header = Instance.new("Frame", f)
header.Size = UDim2.new(1, 0, 0, 35)
header.BackgroundColor3 = Color3.fromRGB(20, 15, 30)
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 8)

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, -70, 1, 0)
title.Position = UDim2.new(0, 15, 0, 0)
title.BackgroundTransparency = 1
title.Text = "⚡ EX COMMUNITY - STEAL AN EGG (V10 MASTER)"
title.TextColor3 = Color3.fromRGB(230, 200, 255)
title.TextSize = 10
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left

-- Tombol Minimize (-)
local minBtn = Instance.new("TextButton", header)
minBtn.Size = UDim2.new(0, 25, 0, 25)
minBtn.Position = UDim2.new(1, -35, 0, 5)
minBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
minBtn.Text = "—"
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 12
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 4)

-- RESIZE HANDLE (Pojok Kanan Bawah)
local resizeHandle = Instance.new("TextButton", f)
resizeHandle.Size = UDim2.new(0, 18, 0, 18)
resizeHandle.Position = UDim2.new(1, -20, 1, -20)
resizeHandle.BackgroundColor3 = Color3.fromRGB(120, 40, 200)
resizeHandle.Text = "◢"
resizeHandle.TextColor3 = Color3.fromRGB(255, 255, 255)
resizeHandle.TextSize = 10
Instance.new("UICorner", resizeHandle).CornerRadius = UDim.new(0, 3)

local resizing = false
resizeHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        resizing = true
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        resizing = false
    end
end)
RunService.RenderStepped:Connect(function()
    if resizing then
        local mousePos = UserInputService:GetMouseLocation()
        local newSizeX = math.clamp(mousePos.X - f.AbsolutePosition.X, 350, 700)
        local newSizeY = math.clamp(mousePos.Y - f.AbsolutePosition.Y, 200, 500)
        f.Size = UDim2.new(0, newSizeX, 0, newSizeY)
    end
end)

-- ICON MINIMIZE MUNGIL
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

-- SIDEBAR & HALAMAN
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
    btn.TextSize = 10
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
btnMethod.TextSize = 10
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
statusLabel.Text = "Status: Siap dijalankan"
statusLabel.TextColor3 = Color3.fromRGB(180, 150, 220)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 10

btnMethod.MouseButton1Click:Connect(function()
    if config.method == "Fly" then
        config.method = "Instant"
        btnMethod.Text = "Metode: INSTAN (Teleport)"
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

addPerfBtn("🧹 Hapus Plot, Hewan & Dekorasi Map", 35, function()
    pcall(function()
        for _, v in pairs(Workspace:GetDescendants()) do
            local name = v.Name:lower()
            if v:IsA("Model") and (name:find("pet") or name:find("guardian") or name:find("mob") or name:find("animal")) then
                if not Players:GetPlayerFromCharacter(v) then v:Destroy() end
            elseif v:IsA("BasePart") and (name:find("plot") or name:find("tree") or name:find("prop") or name:find("decora") or name:find("fence")) then
                v:Destroy()
            end
        end
    end)
end)

local antiTreadmillLag = false
addPerfBtn("🏃 Anti-Lag Treadmill (Auto Hapus Partikel)", 70, function()
    antiTreadmillLag = not antiTreadmillLag
    if antiTreadmillLag then
        task.spawn(function()
            while antiTreadmillLag do
                task.wait(0.1)
                pcall(function()
                    for _, v in pairs(Workspace:GetDescendants()) do
                        if v:IsA("ParticleEmitter") or v:IsA("BillboardGui") or v:IsA("Trail") then
                            v:Destroy()
                        elseif v:IsA("TextLabel") and (v.Text:find("+") or v.Text:lower():find("speed")) then
                            v:Destroy()
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

-- LOGIKA NOCLIP & PENCARIAN TELUR V10 (MASTER PRECISION)
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
    local targetEgg = nil
    local closestDist = math.huge
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end

    -- Scan semua ProximityPrompt atau objek bernuansa egg di Workspace
    for _, v in pairs(Workspace:GetDescendants()) do
        local n = v.Name:lower()
        if v:IsA("ProximityPrompt") or n:find("egg") or n:find("telur") then
            local part = nil
            local parentObj = v.Parent
            
            if v:IsA("ProximityPrompt") then
                part = parentObj:IsA("BasePart") and parentObj or (parentObj.PrimaryPart or parentObj:FindFirstChildWhichIsA("BasePart"))
            elseif v:IsA("Model") then
                part = v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart")
            elseif v:IsA("BasePart") then
                part = v
            end
            
            if part and not n:find("treadmill") and not n:find("belt") then
                local dist = (part.Position - hrp.Position).Magnitude
                -- Pastikan jaraknya di luar area base sendiri (> 25 stud) agar fokus ke telur map luar
                if dist > 25 and dist < closestDist then
                    closestDist = dist
                    targetEgg = {
                        part = part, 
                        prompt = v:IsA("ProximityPrompt") and v or parentObj:FindFirstChildWhichIsA("ProximityPrompt", true), 
                        name = parentObj.Name
                    }
                end
            end
        end
    end
    return targetEgg
end

local function flyTo(targetCFrame)
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local dist = (hrp.Position - targetCFrame.Position).Magnitude
    local time = dist / 70 
    local tween = TweenService:Create(hrp, TweenInfo.new(time, Enum.EasingStyle.Linear), {CFrame = targetCFrame})
    tween:Play()
    tween.Completed:Wait()
end

btnStart.MouseButton1Click:Connect(function()
    config.running = not config.running
    if config.running then
        btnStart.Text = "⏹ STOP AUTO STEAL"
        btnStart.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
        statusLabel.Text = "Status: Mencari & Mengambil Telur"
        
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if hrp then baseCFrame = hrp.CFrame end 
        toggleNoclip(true)
        
        task.spawn(function()
            while config.running do
                task.wait(0.2)
                local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                if not hrp then continue end
                
                hrp.Velocity = Vector3.zero
                
                local egg = getBestEgg()
                if egg then
                    statusLabel.Text = "Mencuri: " .. egg.name
                    
                    if config.method == "Fly" then
                        flyTo(egg.part.CFrame + Vector3.new(0, 1, 0))
                    else
                        hrp.CFrame = egg.part.CFrame + Vector3.new(0, 1, 0)
                        task.wait(0.1)
                    end
                    
                    -- Eksekusi Interaksi Pengambilan (Prompt + Touch secara konsisten)
                    if egg.prompt then
                        pcall(function()
                            fireproximityprompt(egg.prompt)
                        end)
                    end
                    if firetouchinterest then
                        firetouchinterest(hrp, egg.part, 0)
                        task.wait(0.05)
                        firetouchinterest(hrp, egg.part, 1)
                    end
                    
                    task.wait(0.3)
                    
                    -- Pulang ke Base
                    if baseCFrame then
                        if config.method == "Fly" then
                            flyTo(baseCFrame)
                        else
                            hrp.CFrame = baseCFrame
                            task.wait(0.1)
                        end
                    end
                else
                    statusLabel.Text = "Status: Menunggu telur spawn..."
                    task.wait(1)
                end
            end
        end)
    else
        config.running = false
        btnStart.Text = "▶ START AUTO STEAL"
        btnStart.BackgroundColor3 = Color3.fromRGB(110, 30, 200)
        statusLabel.Text = "Status: Berhenti"
        toggleNoclip(false)
    end
end)

minBtn.MouseButton1Click:Connect(function() f.Visible = false; minIcon.Visible = true end)
minIcon.MouseButton1Click:Connect(function() f.Visible = true; minIcon.Visible = false end)
