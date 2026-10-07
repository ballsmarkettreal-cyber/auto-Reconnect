local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

local gui = player:WaitForChild("PlayerGui")
if gui:FindFirstChild("EX_StealAnEgg_V11") then 
    gui.EX_StealAnEgg_V11:Destroy() 
end

local sg = Instance.new("ScreenGui", gui)
sg.Name = "EX_StealAnEgg_V11"
sg.ResetOnSpawn = false

-- LAYAR PUTIH MURNI (DISABLE 3D)
local whiteScreen = Instance.new("Frame", sg)
whiteScreen.Size = UDim2.new(1, 0, 1, 0)
whiteScreen.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
whiteScreen.Visible = false
whiteScreen.ZIndex = -10 

-- UI UTAMA (Gradasi Blackhole Ungu Elegan)
local f = Instance.new("Frame", sg)
f.Size = UDim2.new(0, 480, 0, 310)
f.Position = UDim2.new(0.5, -240, 0.5, -155)
f.BackgroundColor3 = Color3.fromRGB(15, 8, 25)
f.Active = true 
f.Draggable = true
Instance.new("UICorner", f).CornerRadius = UDim.new(0, 12)

local bgGrad = Instance.new("UIGradient", f)
bgGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 12, 70)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 5, 18))
})
bgGrad.Rotation = 45

local bgStroke = Instance.new("UIStroke", f)
bgStroke.Color = Color3.fromRGB(170, 60, 255)
bgStroke.Thickness = 1.5

-- HEADER
local header = Instance.new("Frame", f)
header.Size = UDim2.new(1, 0, 0, 38)
header.BackgroundTransparency = 1

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, -70, 1, 0)
title.Position = UDim2.new(0, 15, 0, 0)
title.BackgroundTransparency = 1
title.Text = "⚡ EX COMMUNITY - STEAL AN EGG"
title.TextColor3 = Color3.fromRGB(240, 210, 255)
title.TextSize = 11
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left

-- Tombol Minimize (-)
local minBtn = Instance.new("TextButton", header)
minBtn.Size = UDim2.new(0, 26, 0, 26)
minBtn.Position = UDim2.new(1, -35, 0, 6)
minBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
minBtn.Text = "—"
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 12
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 6)

-- RESIZE HANDLE (Pojok Kanan Bawah)
local resizeHandle = Instance.new("TextButton", f)
resizeHandle.Size = UDim2.new(0, 18, 0, 18)
resizeHandle.Position = UDim2.new(1, -18, 1, -18)
resizeHandle.BackgroundColor3 = Color3.fromRGB(120, 40, 200)
resizeHandle.Text = "◢"
resizeHandle.TextColor3 = Color3.fromRGB(255, 255, 255)
resizeHandle.TextSize = 9
Instance.new("UICorner", resizeHandle).CornerRadius = UDim.new(0, 4)

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
        local newSizeX = math.clamp(mousePos.X - f.AbsolutePosition.X, 380, 700)
        local newSizeY = math.clamp(mousePos.Y - f.AbsolutePosition.Y, 250, 500)
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
sidebar.Size = UDim2.new(0, 120, 1, -45)
sidebar.Position = UDim2.new(0, 0, 0, 40)
sidebar.BackgroundTransparency = 1

local pageContainer = Instance.new("Frame", f)
pageContainer.Size = UDim2.new(1, -130, 1, -45)
pageContainer.Position = UDim2.new(0, 125, 0, 40)
pageContainer.BackgroundTransparency = 1

local tabs, pages = {}, {}
local function createTab(name, yPos, isFirst)
    local btn = Instance.new("TextButton", sidebar)
    btn.Size = UDim2.new(1, -10, 0, 32)
    btn.Position = UDim2.new(0, 5, 0, yPos)
    btn.Text = name
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 10
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    local page = Instance.new("ScrollingFrame", pageContainer)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = isFirst
    page.CanvasSize = UDim2.new(0, 0, 0, 450)
    page.ScrollBarThickness = 3
    
    if isFirst then
        btn.BackgroundColor3 = Color3.fromRGB(120, 30, 210)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    else
        btn.BackgroundColor3 = Color3.fromRGB(25, 12, 40)
        btn.TextColor3 = Color3.fromRGB(170, 140, 210)
    end
    
    table.insert(tabs, btn)
    table.insert(pages, page)
    
    btn.MouseButton1Click:Connect(function()
        for i, t in pairs(tabs) do
            t.BackgroundColor3 = Color3.fromRGB(25, 12, 40)
            t.TextColor3 = Color3.fromRGB(170, 140, 210)
            pages[i].Visible = false
        end
        btn.BackgroundColor3 = Color3.fromRGB(120, 30, 210)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        page.Visible = true
    end)
    return page
end

local pageMain = createTab("🎯 MAIN", 10, true)
local pagePerf = createTab("🚀 PERFORMA", 50, false)

local config = {
    running = false,
    method = "Fly",
    targetMode = "All", -- "All" atau "Filter"
    selectedFilterType = nil, -- "Size", "Rarities", "Variant"
    activeFilterValue = nil,
    perf = { disable3D = false, cleanMap = false, antiTreadmill = false, fpsBoost = false }
}
local baseCFrame = nil

-- FUNGSI PEMBUAT SAKLAR GESER (TOGGLE SWITCH)
local function createToggle(parent, text, yPos, callback)
    local lbl = Instance.new("TextLabel", parent)
    lbl.Size = UDim2.new(1, -55, 0, 30)
    lbl.Position = UDim2.new(0, 5, 0, yPos)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(220, 200, 240)
    lbl.TextSize = 10
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local bgToggle = Instance.new("TextButton", parent)
    bgToggle.Size = UDim2.new(0, 42, 0, 22)
    bgToggle.Position = UDim2.new(1, -48, 0, yPos + 4)
    bgToggle.BackgroundColor3 = Color3.fromRGB(45, 25, 70)
    bgToggle.Text = ""
    Instance.new("UICorner", bgToggle).CornerRadius = UDim.new(1, 0)
    Instance.new("UIStroke", bgToggle).Color = Color3.fromRGB(140, 60, 220)

    local knob = Instance.new("Frame", bgToggle)
    knob.Size = UDim2.new(0, 16, 0, 16)
    knob.Position = UDim2.new(0, 3, 0, 3)
    knob.BackgroundColor3 = Color3.fromRGB(180, 150, 220)
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

    local isOn = false
    bgToggle.MouseButton1Click:Connect(function()
        isOn = not isOn
        if isOn then
            TweenService:Create(knob, TweenInfo.new(0.2), {Position = UDim2.new(1, -19, 0, 3)}):Play()
            TweenService:Create(bgToggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(130, 30, 220)}):Play()
        else
            TweenService:Create(knob, TweenInfo.new(0.2), {Position = UDim2.new(0, 3, 0, 3)}):Play()
            TweenService:Create(bgToggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 25, 70)}):Play()
        end
        callback(isOn)
    end)
    return bgToggle
end

-- ==========================================
-- KONTEN MAIN
-- ==========================================
local yMain = 10

createToggle(pageMain, "Metode Terbang (Aman Noclip)", yMain, function(state)
    config.method = state and "Instant" or "Fly"
end)
yMain = yMain + 40

-- Tombol Utama Auto Steal
local btnStart = Instance.new("TextButton", pageMain)
btnStart.Size = UDim2.new(1, -10, 0, 40)
btnStart.Position = UDim2.new(0, 5, 0, yMain)
btnStart.Text = "▶ START AUTO STEAL"
btnStart.BackgroundColor3 = Color3.fromRGB(120, 30, 210)
btnStart.TextColor3 = Color3.fromRGB(255, 255, 255)
btnStart.Font = Enum.Font.GothamBold
btnStart.TextSize = 11
Instance.new("UICorner", btnStart).CornerRadius = UDim.new(0, 6)
yMain = yMain + 48

-- SUB MENU PILIHAN STEAL (Dibawah Auto Steal)
local subStealFrame = Instance.new("Frame", pageMain)
subStealFrame.Size = UDim2.new(1, -10, 0, 75)
subStealFrame.Position = UDim2.new(0, 5, 0, yMain)
subStealFrame.BackgroundColor3 = Color3.fromRGB(20, 12, 35)
Instance.new("UICorner", subStealFrame).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", subStealFrame).Color = Color3.fromRGB(100, 40, 160)

local btnStealAll = Instance.new("TextButton", subStealFrame)
btnStealAll.Size = UDim2.new(0.9, 0, 0, 30)
btnStealAll.Position = UDim2.new(0.05, 0, 0, 6)
btnStealAll.Text = "Steal All"
btnStealAll.BackgroundColor3 = Color3.fromRGB(130, 30, 220)
btnStealAll.TextColor3 = Color3.fromRGB(255, 255, 255)
btnStealAll.Font = Enum.Font.GothamBold
btnStealAll.TextSize = 10
Instance.new("UICorner", btnStealAll).CornerRadius = UDim.new(0, 4)
local strokeAll = Instance.new("UIStroke", btnStealAll)
strokeAll.Color = Color3.fromRGB(220, 150, 255)
strokeAll.Thickness = 2

local btnStealFilter = Instance.new("TextButton", subStealFrame)
btnStealFilter.Size = UDim2.new(0.9, 0, 0, 30)
btnStealFilter.Position = UDim2.new(0.05, 0, 0, 40)
btnStealFilter.Text = "Steal (Filter)"
btnStealFilter.BackgroundColor3 = Color3.fromRGB(35, 18, 55)
btnStealFilter.TextColor3 = Color3.fromRGB(180, 150, 220)
btnStealFilter.Font = Enum.Font.GothamBold
btnStealFilter.TextSize = 10
Instance.new("UICorner", btnStealFilter).CornerRadius = UDim.new(0, 4)
local strokeFilterBtn = Instance.new("UIStroke", btnStealFilter)
strokeFilterBtn.Transparency = 1

btnStealAll.MouseButton1Click:Connect(function()
    config.targetMode = "All"
    strokeAll.Transparency = 0
    strokeFilterBtn.Transparency = 1
    btnStealAll.BackgroundColor3 = Color3.fromRGB(130, 30, 220)
    btnStealFilter.BackgroundColor3 = Color3.fromRGB(35, 18, 55)
end)

btnStealFilter.MouseButton1Click:Connect(function()
    config.targetMode = "Filter"
    strokeFilterBtn.Transparency = 0
    strokeAll.Transparency = 1
    btnStealFilter.BackgroundColor3 = Color3.fromRGB(130, 30, 220)
    btnStealAll.BackgroundColor3 = Color3.fromRGB(35, 18, 55)
end)
yMain = yMain + 85

-- MENU UTAMA: FILTER EGG (Sebelum diklik, tidak ada pilihan)
local btnFilterEgg = Instance.new("TextButton", pageMain)
btnFilterEgg.Size = UDim2.new(1, -10, 0, 35)
btnFilterEgg.Position = UDim2.new(0, 5, 0, yMain)
btnFilterEgg.Text = "▼ FILTER EGG (Klik untuk Buka)"
btnFilterEgg.BackgroundColor3 = Color3.fromRGB(25, 15, 45)
btnFilterEgg.TextColor3 = Color3.fromRGB(230, 200, 255)
btnFilterEgg.Font = Enum.Font.GothamBold
btnFilterEgg.TextSize = 10
Instance.new("UICorner", btnFilterEgg).CornerRadius = UDim.new(0, 6)
yMain = yMain + 42

-- KONTTAINER PILIHAN FILTER (Awalnya Invisible)
local filterExpandedFrame = Instance.new("Frame", pageMain)
filterExpandedFrame.Size = UDim2.new(1, -10, 0, 0)
filterExpandedFrame.Position = UDim2.new(0, 5, 0, yMain)
filterExpandedFrame.BackgroundTransparency = 1
filterExpandedFrame.Visible = false

local isFilterOpen = false
btnFilterEgg.MouseButton1Click:Connect(function()
    isFilterOpen = not isFilterOpen
    filterExpandedFrame.Visible = isFilterOpen
    btnFilterEgg.Text = isFilterOpen and "▲ FILTER EGG (Tutup)" or "▼ FILTER EGG (Klik untuk Buka)"
end)

-- Tombol Sub-Kategori Filter
local function createCategoryFilter(name, posY, options)
    local lbl = Instance.new("TextButton", filterExpandedFrame)
    lbl.Size = UDim2.new(1, 0, 0, 28)
    lbl.Position = UDim2.new(0, 0, 0, posY)
    lbl.Text = "• " .. name
    lbl.BackgroundColor3 = Color3.fromRGB(22, 14, 38)
    lbl.TextColor3 = Color3.fromRGB(200, 170, 240)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 10
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", lbl).CornerRadius = UDim.new(0, 4)

    local optContainer = Instance.new("Frame", filterExpandedFrame)
    optContainer.Size = UDim2.new(1, 0, 0, 0)
    optContainer.Position = UDim2.new(0, 0, 0, posY + 32)
    optContainer.BackgroundTransparency = 1
    optContainer.Visible = false

    local optY = 0
    local optButtons = {}
    for _, optName in ipairs(options) do
        local optBtn = Instance.new("TextButton", optContainer)
        optBtn.Size = UDim2.new(0.95, 0, 0, 25)
        optBtn.Position = UDim2.new(0.05, 0, 0, optY)
        optBtn.Text = optName
        optBtn.BackgroundColor3 = Color3.fromRGB(18, 10, 30)
        optBtn.TextColor3 = Color3.fromRGB(180, 150, 220)
        optBtn.Font = Enum.Font.Gotham
        optBtn.TextSize = 9
        Instance.new("UICorner", optBtn).CornerRadius = UDim.new(0, 4)
        
        -- Warna ungu menyala di pinggir teks yang dipilih (Tanpa tulisan ON/OFF)
        local strokeSel = Instance.new("UIStroke", optBtn)
        strokeSel.Color = Color3.fromRGB(200, 80, 255)
        strokeSel.Thickness = 1.8
        strokeSel.Transparency = 1

        optBtn.MouseButton1Click:Connect(function()
            for _, b in pairs(optButtons) do
                b.UIStroke.Transparency = 1
                b.TextColor3 = Color3.fromRGB(180, 150, 220)
            end
            strokeSel.Transparency = 0
            optBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            config.selectedFilterType = name
            config.activeFilterValue = optName
        end)
        table.insert(optButtons, optBtn)
        optY = optY + 28
    end
    optContainer.Size = UDim2.new(1, 0, 0, optY)

    local isOpenOpt = false
    lbl.MouseButton1Click:Connect(function()
        isOpenOpt = not isOpenOpt
        optContainer.Visible = isOpenOpt
    end)
    return posY + 36 + optY
end

local nextY = 0
nextY = createCategoryFilter("Filter with Size", nextY, {"Small", "Medium", "Large", "Giant"})
nextY = createCategoryFilter("Filter with Rarities", nextY, {"Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic", "Secret", "Cosmic"})
nextY = createCategoryFilter("Filter with Variant", nextY, {"Normal", "Golden", "Rainbow", "Dark"})
filterExpandedFrame.Size = UDim2.new(1, -10, 0, nextY)
pageMain.CanvasSize = UDim2.new(0, 0, 0, yMain + nextY + 30)

-- ==========================================
-- KONTEN PERFORMA (SAKLAR GESER)
-- ==========================================
local yPerf = 10
createToggle(pagePerf, "Disable 3D (Layar Putih Murni)", yPerf, function(state)
    config.perf.disable3D = state
    whiteScreen.Visible = state
    pcall(function() RunService:Set3dRenderingEnabled(not state) end)
end)
yPerf = yPerf + 40

createToggle(pagePerf, "Hapus Plot, Hewan & Dekorasi Map", yPerf, function(state)
    if state then
        pcall(function()
            for _, v in pairs(Workspace:GetDescendants()) do
                local name = v.Name:lower()
                if v:IsA("Model") and (name:find("pet") or name:find("guardian") or name:find("mob")) then
                    if not Players:GetPlayerFromCharacter(v) then v:Destroy() end
                elseif v:IsA("BasePart") and (name:find("plot") or name:find("tree") or name:find("prop") or name:find("decora")) then
                    v:Destroy()
                end
            end
        end)
    end
end)
yPerf = yPerf + 40

createToggle(pagePerf, "Anti-Lag Treadmill (+Speed)", yPerf, function(state)
    config.perf.antiTreadmill = state
    if state then
        task.spawn(function()
            while config.perf.antiTreadmill do
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
yPerf = yPerf + 40

createToggle(pagePerf, "Super FPS Boost (Grafik Kentang)", yPerf, function(state)
    if state then
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
    end
end)
pagePerf.CanvasSize = UDim2.new(0, 0, 0, yPerf + 50)

-- ==========================================
-- LOGIKA UTAMA AUTO STEAL
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
    local targetEgg = nil
    local closestDist = math.huge
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end

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
                local pass = true
                -- Jika mode filter aktif, cek apakah sesuai dengan pilihan user
                if config.targetMode == "Filter" and config.activeFilterValue then
                    if not parentObj.Name:lower():find(config.activeFilterValue:lower()) and not n:find(config.activeFilterValue:lower()) then
                        pass = false
                    end
                end

                if pass then
                    local dist = (part.Position - hrp.Position).Magnitude
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
                    if config.method == "Fly" then
                        flyTo(egg.part.CFrame + Vector3.new(0, 1, 0))
                    else
                        hrp.CFrame = egg.part.CFrame + Vector3.new(0, 1, 0)
                        task.wait(0.1)
                    end
                    
                    if egg.prompt then
                        pcall(function() fireproximityprompt(egg.prompt) end)
                    end
                    if firetouchinterest then
                        firetouchinterest(hrp, egg.part, 0)
                        task.wait(0.05)
                        firetouchinterest(hrp, egg.part, 1)
                    end
                    
                    task.wait(0.3)
                    if baseCFrame then
                        if config.method == "Fly" then flyTo(baseCFrame) else hrp.CFrame = baseCFrame; task.wait(0.1) end
                    end
                else
                    task.wait(1)
                end
            end
        end)
    else
        config.running = false
        btnStart.Text = "▶ START AUTO STEAL"
        btnStart.BackgroundColor3 = Color3.fromRGB(120, 30, 210)
        toggleNoclip(false)
    end
end)

minBtn.MouseButton1Click:Connect(function() f.Visible = false; minIcon.Visible = true end)
minIcon.MouseButton1Click:Connect(function() f.Visible = true; minIcon.Visible = false end)
