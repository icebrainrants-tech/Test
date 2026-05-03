local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- GUI SETUP
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "tubers93_GUI"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

if gethui then ScreenGui.Parent = gethui() end

local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(180, 150, 0) 
MainFrame.Position = UDim2.new(0.5, -250, 1, 10)
MainFrame.Size = UDim2.new(0, 500, 0, 320)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BorderSizePixel = 0 

local FrameCorner = Instance.new("UICorner")
FrameCorner.CornerRadius = UDim.new(0, 8)
FrameCorner.Parent = MainFrame

local FrameStroke = Instance.new("UIStroke")
FrameStroke.Color = Color3.fromRGB(0, 0, 0) 
FrameStroke.Thickness = 3
FrameStroke.Parent = MainFrame

-- SLIDE UP ANIMATION
TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
    Position = UDim2.new(0.5, -250, 0.5, -160)
}):Play()

-- X BUTTON
local CloseButton = Instance.new("TextButton")
CloseButton.Parent = MainFrame
CloseButton.BackgroundTransparency = 1
CloseButton.Position = UDim2.new(1, -40, 0, 10)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(0, 0, 0)
CloseButton.TextSize = 24

CloseButton.MouseButton1Down:Connect(function()
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
end)

CloseButton.MouseButton1Click:Connect(function()
    local slideOut = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
        Position = UDim2.new(0.5, -250, 1, 10)
    })
    slideOut:Play()
    slideOut.Completed:Connect(function() ScreenGui:Destroy() end)
end)

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 20, 0, 15)
Title.Size = UDim2.new(0, 400, 0, 30)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "tubers93 f3x gui v1.0" -- Updated text
Title.TextColor3 = Color3.fromRGB(0, 0, 0)
Title.TextSize = 22
Title.TextXAlignment = Enum.TextXAlignment.Left

local Container = Instance.new("Frame")
Container.Parent = MainFrame
Container.BackgroundTransparency = 1
Container.Position = UDim2.new(0, 20, 0, 60)
Container.Size = UDim2.new(0, 460, 0, 240)

local Grid = Instance.new("UIGridLayout")
Grid.Parent = Container
Grid.CellPadding = UDim2.new(0, 10, 0, 10)
Grid.CellSize = UDim2.new(0, 146, 0, 75)

local function GetF3X()
    for _,v in pairs(LocalPlayer:GetDescendants()) do if v.Name == "SyncAPI" then return v.ServerEndpoint end end
    for _,v in pairs(game.ReplicatedStorage:GetDescendants()) do if v.Name == "SyncAPI" then return v.ServerEndpoint end end
    return nil
end

local msgCount = 0
local hintCount = 0

local function CreateButton(name)
    local btn = Instance.new("TextButton")
    btn.Parent = Container
    btn.BackgroundColor3 = Color3.fromRGB(255, 215, 0) 
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(0, 0, 0)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18
    btn.BorderSizePixel = 0 
    btn.AutoButtonColor = false

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 6)
    BtnCorner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 215, 0)}):Play()
        
        local cmd = game.ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
        local f3x = GetF3X()
        local targetID = "17818914876" 

        if name == "btools" then
            cmd:InvokeServer(";btools")
        elseif name == "unanchor all" and f3x then
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") and v.Name ~= "Skybox" then
                    f3x:InvokeServer("SyncAnchor", {{Part = v, Anchored = false}})
                end
            end
        elseif name == "message" then
            msgCount = msgCount + 1
            if msgCount % 2 == 1 then
                cmd:InvokeServer(";sm tubers93 was here...")
            else
                cmd:InvokeServer(";sm team tubers93 join today!")
            end
        elseif name == "hint" then
            hintCount = hintCount + 1
            if hintCount % 2 == 1 then
                cmd:InvokeServer(";sh tubers93 was here...")
            else
                cmd:InvokeServer(";sh team tubers93 join today!")
            end
        elseif name == "decal spam" and f3x then
            for _,v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") and v.Name ~= "Skybox" then
                    task.spawn(function()
                        f3x:InvokeServer("SetLocked", {v}, false)
                        for _,face in pairs(Enum.NormalId:GetEnumItems()) do
                            f3x:InvokeServer("CreateTextures", {{Part = v, Face = face, TextureType = "Decal"}})
                            f3x:InvokeServer("SyncTexture", {{Part = v, Face = face, TextureType = "Decal", Texture = "rbxassetid://"..targetID}})
                        end
                    end)
                end
            end
        elseif name == "skybox" and f3x then
            local spawn = workspace:FindFirstChildOfClass("SpawnLocation")
            local spawnPos = spawn and (spawn.CFrame * CFrame.new(0, 5, 0)) or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head") and LocalPlayer.Character.Head.CFrame * CFrame.new(0, 5, 0)) or CFrame.new(0,10,0)
            
            f3x:InvokeServer("CreatePart", "Normal", spawnPos, workspace)
            task.spawn(function()
                local sky
                for i = 1, 20 do
                    for _,v in pairs(workspace:GetChildren()) do
                        if v.Name == "Part" and (v.Position - spawnPos.Position).Magnitude < 5 then sky = v break end
                    end
                    if sky then break end
                    task.wait(0.1)
                end
                if sky then
                    f3x:InvokeServer("SetName", {sky}, "Skybox")
                    f3x:InvokeServer("CreateMeshes", {{Part = sky}})
                    f3x:InvokeServer("SyncMesh", {{Part = sky, MeshType = Enum.MeshType.FileMesh, MeshId = "", TextureId = "rbxassetid://"..targetID, Scale = Vector3.new(-10000, -10000, -10000)}})
                    f3x:InvokeServer("SyncAnchor", {{Part = sky, Anchored = true}})
                    f3x:InvokeServer("SyncCollision", {{Part = sky, CanCollide = false}})
                    f3x:InvokeServer("SetLocked", {sky}, true)
                end
            end)
        else
            local commands = {
                ["disco"] = ";disco", ["fire all"] = ";fire all", ["music"] = ";music 1839246711 ;volume 10" 
            }
            if commands[name] then cmd:InvokeServer(commands[name]) end
        end
    end)
end

local buttons = {"btools", "disco", "fire all", "message", "hint", "music", "decal spam", "skybox", "unanchor all"}
for _,v in pairs(buttons) do CreateButton(v) end

