local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui")

if gui:FindFirstChild("EX_StealAnEgg_V16") then gui.EX_StealAnEgg_V16:Destroy() end
local sg = Instance.new("ScreenGui", gui)
sg.Name = "EX_StealAnEgg_V16"
sg.ResetOnSpawn = false

local whiteScreen = Instance.new("Frame", sg)
whiteScreen.Size = UDim2.new(1,0,1,0)
whiteScreen.BackgroundColor3 = Color3.fromRGB(255,255,255)
whiteScreen.Visible = false
whiteScreen.ZIndex = -10

local f = Instance.new("Frame", sg)
f.Size = UDim2.new(0, 480, 0, 310)
f.Position = UDim2.new(0.5, -240, 0.5, -155)
f.BackgroundColor3 = Color3.fromRGB(15, 10, 22)
f.Active = true f.Draggable = true
Instance.new("UICorner", f).CornerRadius = UDim.new(0, 10)
local bgGrad = Instance.new("UIGradient", f)
bgGrad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 12, 60)), ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 4, 15))})
bgGrad.Rotation = 45
local bgStroke = Instance.new("UIStroke", f)
bgStroke.Color = Color3.fromRGB(160, 50, 240) bgStroke.Thickness = 1.5

local header = Instance.new("Frame", f)
header.Size = UDim2.new(1,0,0,35)
header.BackgroundColor3 = Color3.fromRGB(20, 12, 32)
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1,-60,1,0) title.Position = UDim2.new(0,12,0,0)
title.BackgroundTransparency = 1 title.Text = "EX COMMUNITY - STEAL AN EGG (V16)"
title.TextColor3 = Color3.fromRGB(230,200,255) title.TextSize = 10 title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left

local minBtn = Instance.new("TextButton", header)
minBtn.Size = UDim2.new(0,24,0,24) minBtn.Position = UDim2.new(1,-30,0,5)
minBtn.BackgroundColor3 = Color3.fromRGB(180,40,40) minBtn.Text = "—"
minBtn.TextColor3 = Color3.fromRGB(255,255,255) minBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 5)

local minIcon = Instance.new("TextButton", sg)
minIcon.Size = UDim2.new(0,40,0,40) minIcon.Position = UDim2.new(0,20,0,20)
minIcon.BackgroundColor3 = Color3.fromRGB(20,10,30) minIcon.Text = "EX"
minIcon.TextColor3 = Color3.fromRGB(255,255,255) minIcon.TextSize = 12 minIcon.Font = Enum.Font.FredokaOne
minIcon.Visible = false minIcon.Active = true minIcon.Draggable = true
Instance.new("UICorner", minIcon).CornerRadius = UDim.new(0, 10)

local sidebar = Instance.new("Frame", f)
sidebar.Size = UDim2.new(0, 120, 1, -35) sidebar.Position = UDim2.new(0, 0, 0, 35)
sidebar.BackgroundColor3 = Color3.fromRGB(12, 8, 18) sidebar.BorderSizePixel = 0

local pageContainer = Instance.new("Frame", f)
pageContainer.Size = UDim2.new(1, -125, 1, -35) pageContainer.Position = UDim2.new(0, 125, 0, 35)
pageContainer.BackgroundTransparency = 1

local tabs, pages = {}, {}
local function createTab(name, yPos, isFirst)
    local btn = Instance.new("TextButton", sidebar)
    btn.Size = UDim2.new(1,-10,0,30) btn.Position = UDim2.new(0,5,0,yPos)
    btn.Text = name btn.Font = Enum.Font.GothamBold btn.TextSize = 10
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
    
    local page = Instance.new("ScrollingFrame", pageContainer)
    page.Size = UDim2.new(1,0,1,0) page.BackgroundTransparency = 1 page.Visible = isFirst
    page.CanvasSize = UDim2.new(0,0,0,600) page.ScrollBarThickness = 3
    
    btn.BackgroundColor3 = isFirst and Color3.fromRGB(120,30,210) or Color3.fromRGB(22,14,35)
    btn.TextColor3 = isFirst and Color3.fromRGB(255,255,255) or Color3.fromRGB(160,130,200)
    
    table.insert(tabs, btn) table.insert(pages, page)
    btn.MouseButton1Click:Connect(function()
        for i, t in pairs(tabs) do
            t.BackgroundColor3 = Color3.fromRGB(22,14,35) t.TextColor3 = Color3.fromRGB(160,130,200)
            pages[i].Visible = false
        end
        btn.BackgroundColor3 = Color3.fromRGB(120,30,210) btn.TextColor3 = Color3.fromRGB(255,255,255)
        page.Visible = true
    end)
    return page
end

local pageMain = createTab("MAIN", 10, true)
local pagePerf = createTab("PERFORMANCE", 45, false)

local config = { running = false, method = "Fly", targetMode = "All", activeFilterValue = nil }
local baseCFrame = nil

local function createToggle(parent, text, yPos, cb)
    local lbl = Instance.new("TextLabel", parent)
    lbl.Size = UDim2.new(1,-50,0,26) lbl.Position = UDim2.new(0,5,0,yPos)
    lbl.BackgroundTransparency = 1 lbl.Text = text lbl.TextColor3 = Color3.fromRGB(210,190,235)
    lbl.TextSize = 9 lbl.Font = Enum.Font.GothamMedium lbl.TextXAlignment = Enum.TextXAlignment.Left

    local bg = Instance.new("TextButton", parent)
    bg.Size = UDim2.new(0,36,0,18) bg.Position = UDim2.new(1,-42,0,yPos+4)
    bg.BackgroundColor3 = Color3.fromRGB(40,20,60) bg.Text = ""
    Instance.new("UICorner", bg).CornerRadius = UDim.new(1,0)
    local knob = Instance.new("Frame", bg)
    knob.Size = UDim2.new(0,12,0,12) knob.Position = UDim2.new(0,3,0,3)
    knob.BackgroundColor3 = Color3.fromRGB(180,140,220)
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1,0)

    local isOn = false
    bg.MouseButton1Click:Connect(function()
        isOn = not isOn
        TweenService:Create(knob, TweenInfo.new(0.2), {Position = isOn and UDim2.new(1,-15,0,3) or UDim2.new(0,3,0,3)}):Play()
        TweenService:Create(bg, TweenInfo.new(0.2), {BackgroundColor3 = isOn and Color3.fromRGB(120,30,210) or Color3.fromRGB(40,20,60)}):Play()
        cb(isOn)
    end)
end

-- ==========================================
-- MAIN TAB DENGAN UI LAYOUT TERTIB (TANPA SPACE KOSONG)
-- ==========================================
local mainList = Instance.new("UIListLayout", pageMain)
mainList.SortOrder = Enum.SortOrder.LayoutOrder
mainList.Padding = UDim.new(0, 8)

-- 1. Toggle Method
local fToggle = Instance.new("Frame", pageMain)
fToggle.Size = UDim2.new(1, -10, 0, 30) fToggle.BackgroundTransparency = 1 fToggle.LayoutOrder = 1
createToggle(fToggle, "Fly Method (Safe Noclip)", 2, function(st) config.method = st and "Instant" or "Fly" end)

-- 2. Start Button
local btnStart = Instance.new("TextButton", pageMain)
btnStart.Size = UDim2.new(1, -10, 0, 34) btnStart.LayoutOrder = 2
btnStart.Text = "START AUTO STEAL" btnStart.BackgroundColor3 = Color3.fromRGB(120,30,210)
btnStart.TextColor3 = Color3.fromRGB(255,255,255) btnStart.Font = Enum.Font.GothamBold btnStart.TextSize = 10
Instance.new("UICorner", btnStart).CornerRadius = UDim.new(0, 5)

-- 3. Sub-Menu Steal
local sub = Instance.new("Frame", pageMain)
sub.Size = UDim2.new(1, -10, 0, 62) sub.BackgroundColor3 = Color3.fromRGB(20,12,35) sub.LayoutOrder = 3
Instance.new("UICorner", sub).CornerRadius = UDim.new(0, 5)

local bAll = Instance.new("TextButton", sub)
bAll.Size = UDim2.new(0.9,0,0,24) bAll.Position = UDim2.new(0.05,0,0,5)
bAll.Text = "Steal All" bAll.BackgroundColor3 = Color3.fromRGB(120,30,210) bAll.TextColor3 = Color3.fromRGB(255,255,255) bAll.TextSize = 9
Instance.new("UICorner", bAll).CornerRadius = UDim.new(0,4)
local stAll = Instance.new("UIStroke", bAll) stAll.Color = Color3.fromRGB(220,150,255) stAll.Thickness = 1.2

local bFil = Instance.new("TextButton", sub)
bFil.Size = UDim2.new(0.9,0,0,24) bFil.Position = UDim2.new(0.05,0,0,33)
bFil.Text = "Steal (Filter)" bFil.BackgroundColor3 = Color3.fromRGB(30,15,48) bFil.TextColor3 = Color3.fromRGB(170,140,210) bFil.TextSize = 9
Instance.new("UICorner", bFil).CornerRadius = UDim.new(0,4)
local stFil = Instance.new("UIStroke", bFil) stFil.Transparency = 1

bAll.MouseButton1Click:Connect(function() config.targetMode = "All" stAll.Transparency = 0 stFil.Transparency = 1 bAll.BackgroundColor3 = Color3.fromRGB(120,30,210) bFil.BackgroundColor3 = Color3.fromRGB(30,15,48) end)
bFil.MouseButton1Click:Connect(function() config.targetMode = "Filter" stFil.Transparency = 0 stAll.Transparency = 1 bFil.BackgroundColor3 = Color3.fromRGB(120,30,210) bAll.BackgroundColor3 = Color3.fromRGB(30,15,48) end)

-- 4. Filter Egg Dropdown Tertib
local btnF = Instance.new("TextButton", pageMain)
btnF.Size = UDim2.new(1, -10, 0, 30) btnF.LayoutOrder = 4
btnF.Text = "▼ FILTER EGG" btnF.BackgroundColor3 = Color3.fromRGB(22,14,38) btnF.TextColor3 = Color3.fromRGB(220,190,255) btnF.TextSize = 9
Instance.new("UICorner", btnF).CornerRadius = UDim.new(0,5)

local fEx = Instance.new("Frame", pageMain)
fEx.Size = UDim2.new(1, -10, 0, 0) fEx.BackgroundTransparency = 1 fEx.Visible = false fEx.LayoutOrder = 5
local fList = Instance.new("UIListLayout", fEx) fList.SortOrder = Enum.SortOrder.LayoutOrder fList.Padding = UDim.new(0, 4)

local function addCat(name, opts)
    local catHolder = Instance.new("Frame", fEx) catHolder.Size = UDim2.new(1,0,0,0) catHolder.BackgroundTransparency = 1
    local l = Instance.new("TextButton", catHolder) l.Size = UDim2.new(1,0,0,24)
    l.Text = "+ " .. name l.BackgroundColor3 = Color3.fromRGB(18,10,30) l.TextColor3 = Color3.fromRGB(190,160,230) l.TextSize = 9 l.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", l).CornerRadius = UDim.new(0,4)
    
    local c = Instance.new("Frame", catHolder) c.Size = UDim2.new(1,0,0,0) c.Position = UDim2.new(0,0,0,26) c.BackgroundTransparency = 1 c.Visible = false
    local cList = Instance.new("UIListLayout", c) cList.SortOrder = Enum.SortOrder.LayoutOrder cList.Padding = UDim.new(0, 3)
    
    for _, opt in ipairs(opts) do
        local ob = Instance.new("TextButton", c) ob.Size = UDim2.new(0.95,0,0,22)
        ob.Text = opt ob.BackgroundColor3 = Color3.fromRGB(14,8,24) ob.TextColor3 = Color3.fromRGB(160,130,200) ob.TextSize = 8
        Instance.new("UICorner", ob).CornerRadius = UDim.new(0,4)
        local sk = Instance.new("UIStroke", ob) sk.Color = Color3.fromRGB(200,80,255) sk.Thickness = 1.5 sk.Transparency = 1
        ob.MouseButton1Click:Connect(function()
            for _, o in ipairs(c:GetChildren()) do if o:IsA("TextButton") then o.UIStroke.Transparency = 1 o.TextColor3 = Color3.fromRGB(160,130,200) end end
            sk.Transparency = 0 ob.TextColor3 = Color3.fromRGB(255,255,255) config.activeFilterValue = opt
        end)
    end
    
    local isOpen = false
    l.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        c.Visible = isOpen
        c.Size = isOpen and UDim2.new(1,0,0, #opts * 25) or UDim2.new(0,0,0,0)
        catHolder.Size = isOpen and UDim2.new(1,0,0, 26 + (#opts * 25)) or UDim2.new(1,0,0,24)
    end)
    catHolder.Size = UDim2.new(1,0,0,24)
end

addCat("Filter with Size", {"Small", "Medium", "Large", "Giant"})
addCat("Filter with Rarities", {"Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic", "Secret", "Cosmic", "Eternal", "Divine"})
addCat("Filter with Variant", {"Normal", "Golden", "Rainbow", "Dark"})

btnF.MouseButton1Click:Connect(function()
    fEx.Visible = not fEx.Visible
    btnF.Text = fEx.Visible and "▲ FILTER EGG" or "▼ FILTER EGG"
    fEx.Size = fEx.Visible and UDim2.new(1,-10,0, 3 * 28 + (fEx.Visible and 10 or 0)) or UDim2.new(1,-10,0,0)
end)

-- PERFORMANCE CONTENT
local pList = Instance.new("UIListLayout", pagePerf) pList.SortOrder = Enum.SortOrder.LayoutOrder pList.Padding = UDim.new(0, 8)
local function addPerfToggle(txt, cb)
    local fP = Instance.new("Frame", pagePerf) fP.Size = UDim2.new(1, -10, 0, 30) fP.BackgroundTransparency = 1
    createToggle(fP, txt, 2, cb)
end
addPerfToggle("Disable 3D (Pure White Screen)", function(st) whiteScreen.Visible = st pcall(function() RunService:Set3dRenderingEnabled(not st) end) end)
addPerfToggle("Remove Plot, Pets & Map Decors", function(st) if st then pcall(function() for _, v in pairs(Workspace:GetDescendants()) do local n = v.Name:lower() if v:IsA("Model") and (n:find("pet") or n:find("guardian")) and not Players:GetPlayerFromCharacter(v) then v:Destroy() elseif v:IsA("BasePart") and (n:find("plot") or n:find("tree")) then v:Destroy() end end end) end end)
addPerfToggle("Anti-Lag Treadmill (+Speed)", function(st) config.perfAnti = st task.spawn(function() while config.perfAnti do task.wait(0.2) pcall(function() for _, v in pairs(Workspace:GetDescendants()) do if v:IsA("ParticleEmitter") or v:IsA("BillboardGui") then v:Destroy() end end end) end end) end)
addPerfToggle("Super FPS Boost (Potato Graphics)", function(st) if st then pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Level01 game:GetService("Lighting").GlobalShadows = false for _, v in pairs(Workspace:GetDescendants()) do if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic v.Reflectance = 0 end end end) end end)

-- ==========================================
-- AUTO STEAL LOGIC YANG DIPERBAIKI TOTAL (PASTI JALAN)
-- ==========================================
btnStart.MouseButton1Click:Connect(function()
    config.running = not config.running
    btnStart.Text = config.running and "STOP AUTO STEAL" or "START AUTO STEAL"
    btnStart.BackgroundColor3 = config.running and Color3.fromRGB(180,40,40) or Color3.fromRGB(120,30,210)
    
    if config.running then
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if hrp then baseCFrame = hrp.CFrame end
        
        task.spawn(function()
            while config.running do
                task.wait(0.3)
                local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                if not hrp then continue end
                
                local targetPart, targetPrompt = nil, nil
                
                -- Pindai seluruh workspace untuk mencari interaksi ProximityPrompt atau objek telur
                for _, v in pairs(Workspace:GetDescendants()) do
                    if v:IsA("ProximityPrompt") then
                        local parent = v.Parent
                        local part = parent and (parent:IsA("BasePart") and parent or parent:FindFirstChildWhichIsA("BasePart"))
                        if part and not parent.Name:lower():find("treadmill") then
                            targetPart = part
                            targetPrompt = v
                            break
                        end
                    elseif v:IsA("BasePart") and (v.Name:lower():find("egg") or v.Name:lower():find("telur")) then
                        if not v.Name:lower():find("treadmill") then
                            targetPart = v
                            targetPrompt = v.Parent:FindFirstChildWhichIsA("ProximityPrompt", true)
                            break
                        end
                    end
                end
                
                if targetPart then
                    -- Teleport langsung ke atas telur
                    if config.method == "Fly" then
                        local tween = TweenService:Create(hrp, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {CFrame = targetPart.CFrame + Vector3.new(0, 1, 0)})
                        tween:Play()
                        tween.Completed:Wait()
                    else
                        hrp.CFrame = targetPart.CFrame + Vector3.new(0, 1, 0)
                        task.wait(0.1)
                    end
                    
                    -- Ambil telur
                    if targetPrompt then pcall(function() fireproximityprompt(targetPrompt) end) end
                    if firetouchinterest then firetouchinterest(hrp, targetPart, 0) task.wait(0.05) firetouchinterest(hrp, targetPart, 1) end
                    
                    task.wait(0.3)
                    
                    -- Pulang ke Base
                    if baseCFrame then
                        if config.method == "Fly" then
                            local tweenBack = TweenService:Create(hrp, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {CFrame = baseCFrame})
                            tweenBack:Play()
                            tweenBack.Completed:Wait()
                        else
                            hrp.CFrame = baseCFrame
                            task.wait(0.1)
                        end
                    end
                else
                    task.wait(0.5)
                end
            end
        end)
    end
end)

minBtn.MouseButton1Click:Connect(function() f.Visible = false minIcon.Visible = true end)
minIcon.MouseButton1Click:Connect(function() f.Visible = true minIcon.Visible = false end)
