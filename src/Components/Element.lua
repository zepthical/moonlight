local Creator = require("../Creator")
local New = Creator.New
local Tween = Creator.Tween

local UserInputService = game:GetService("UserInputService")

return function(Config)
    local Element = {
        Title = Config.Title,
        Desc = Config.Desc or nil,
        Hover = Config.Hover,
        Color = Config.Color,
        Image = Config.Image,
        ImageSize = Config.ImageSize or 30,
        UIPadding = 12,
        UIElements = {}
    }
    
    local ImageSize = Element.ImageSize
    local CanHover = true
    local Hovering = false
    
    local ImageFrame
    if Element.Image then
        local ImageLabel = New("ImageLabel", {
            Size = UDim2.new(1,0,1,0),
            BackgroundTransparency = 1,
            ThemeTag = Creator.Icon(Element.Image) and {
                ImageColor3 = not Element.Color and "Text" 
            } or nil,
            ImageColor3 = Element.Color and ( Element.Color == "White" and Color3.new(0,0,0) or Color3.new(1,1,1) )
        }, {
            New("UICorner", {
                CornerRadius = UDim.new(0,11)
            })
        })
        ImageFrame = New("Frame", {
            Size = UDim2.new(0,ImageSize,0,ImageSize),
            AutomaticSize = "XY",
            BackgroundTransparency = 1,
        }, {
            ImageLabel
        })
        if Creator.Icon(Element.Image) then
            ImageLabel.Image = Creator.Icon(Element.Image)[1]
            ImageLabel.ImageRectOffset = Creator.Icon(Element.Image)[2].ImageRectPosition
            ImageLabel.ImageRectSize = Creator.Icon(Element.Image)[2].ImageRectSize
        end
        if string.find(Element.Image,"http") then
            local success, response = pcall(function()
                if not isfile("WindUI/" .. Config.Window.Folder .. "/Assets/." .. Element.Title .. ".png") then
                    local response = request({
                        Url = Element.Image,
                        Method = "GET",
                    }).Body
                    writefile("WindUI/" .. Config.Window.Folder .. "/Assets/." .. Element.Title .. ".png", response)
                end
                ImageLabel.Image = getcustomasset("WindUI/" .. Config.Window.Folder .. "/Assets/." .. Element.Title .. ".png")
            end)
            if not success then
                ImageLabel:Destroy()
                
                warn("[ WindUI ]  '" .. identifyexecutor() .. "' doesnt support the URL Images. Error: " .. response)
            end
        elseif string.find(Element.Image,"rbxassetid") then
            ImageLabel.Image = Element.Image
        end
    end
    
    Element.UIElements.Main = New("TextButton", {
        Size = UDim2.new(1,0,0,0),
        AutomaticSize = "Y",
        BackgroundTransparency = not Element.Color and 0.95 or 0.1,
        AnchorPoint = Vector2.new(0.5,0.5),
        Position = UDim2.new(0.5,0,0.5,0),
        ThemeTag = {
            BackgroundColor3 = not Element.Color and "Text" or nil
        },
        BackgroundColor3 = Element.Color and Color3.fromHex(Creator.Colors[Element.Color])
    }, {
        New("UICorner", {
            CornerRadius = UDim.new(0,11),
        }),
        New("UIScale", {
            Scale = .98, -- 1
        }),
        ImageFrame,
        New("Frame", {
            Size = UDim2.new(1,Element.Image and -(ImageSize+Element.UIPadding),0,0),
            AutomaticSize = "Y",
            AnchorPoint = Vector2.new(0,0),
            Position = UDim2.new(0,Element.Image and ImageSize+Element.UIPadding or 0,0,0),
            BackgroundTransparency = 1,
            Name = "Title"
        }, {
            New("UIListLayout", {
                Padding = UDim.new(0,6),
                --VerticalAlignment = "Left",
            }),
            New("TextLabel", {
                Text = Element.Title,
                ThemeTag = {
                    TextColor3 = not Element.Color and "Text" or nil
                },
                TextColor3 = Element.Color and ( Element.Color == "White" and Color3.new(0,0,0) or Color3.new(1,1,1) ),
                TextSize = 15, 
                TextWrapped = true,
                RichText = true,
                LayoutOrder = 0,
                Name = "Title",
                TextXAlignment = "Left",
                Size = UDim2.new(1,-Config.TextOffset,0,0),
                FontFace = Font.new(Creator.Font, Enum.FontWeight.Medium),
                BackgroundTransparency = 1,
                AutomaticSize = "Y"
            })
        }),
        -- New("ImageLabel", {
        --     Size = UDim2.new(1,Element.UIPadding*2,1,Element.UIPadding*2+6),
        --     Image = "rbxassetid://110049886226894",
        --     SliceCenter = Rect.new(512,512,512,512),
        --     ScaleType = "Slice",
        --     BackgroundTransparency = 1,
        --     ImageTransparency = .94,
        --     Position = UDim2.new(0.5,0,0.5,0),
        --     AnchorPoint = Vector2.new(0.5,0.5),
        -- }),
        New("UIStroke", {
            Thickness = 1,
            Color = Color3.new(0,0,0),
            Transparency = Element.Color ~= "White" and 1 or 0.88,
            ApplyStrokeMode = "Border",
        }),
        New("Frame", {
            Size = UDim2.new(1,Element.UIPadding*2,1,Element.UIPadding*2+4),
            ThemeTag = {
                BackgroundColor3 = "Text"
            },
            Position = UDim2.new(0.5,0,0.5,0),
            AnchorPoint = Vector2.new(0.5,0.5),
            BackgroundTransparency = 1,
            Name = "Highlight"
        }, {
            New("UICorner", {
                CornerRadius = UDim.new(0,11),
            }),
        }),
        New("Frame", {
            Size = UDim2.new(1,Element.UIPadding*2,1,Element.UIPadding*2+4),
            BackgroundColor3 = Color3.new(0,0,0),
            Position = UDim2.new(0.5,0,0.5,0),
            AnchorPoint = Vector2.new(0.5,0.5),
            BackgroundTransparency = 1,
            ZIndex = 999999,
            Name = "Lock"
        }, {
            New("UICorner", {
                CornerRadius = UDim.new(0,11),
            }),
            New("ImageLabel", {
                Image = Creator.Icon("lock")[1],
                ImageRectOffset = Creator.Icon("lock")[2].ImageRectPosition,
                ImageRectSize = Creator.Icon("lock")[2].ImageRectSize,
                --AnchorPoint = Vector2.new(0.5,0.5),
                --Position = UDim2.new(0.5,0,0.5,0),
                Size = UDim2.new(0,22,0,22),
                ImageTransparency = 1,
                BackgroundTransparency = 1,
                Active = false,
            }),
            New("TextLabel", {
                BackgroundTransparency = 1,
                Text = "Locked",
                TextTransparency = 1,
                AutomaticSize = "XY",
                FontFace = Font.new(Creator.Font, Enum.FontWeight.SemiBold),
                TextSize = 16,
                Active = false,
                TextColor3 = Color3.new(1,1,1),
            }),
            New("UIListLayout", {
                Padding = UDim.new(0, Element.UIPadding),
                FillDirection = "Horizontal",
                VerticalAlignment = "Center",
                HorizontalAlignment = "Center",
            })
        }),
        New("UIPadding", {
            PaddingTop = UDim.new(0,Element.UIPadding+2),
            PaddingLeft = UDim.new(0,Element.UIPadding),
            PaddingRight = UDim.new(0,Element.UIPadding),
            PaddingBottom = UDim.new(0,Element.UIPadding+2),
        }),
    })

    -- Element.UIElements.Main.Title.Title:GetPropertyChangedSignal("TextBounds"):Connect(function()
    --     Element.UIElements.Main.Title.Title.Size = UDim2.new(1,-Config.TextOffset,0,Element.UIElements.Main.Title.Title.TextBounds.Y)
    -- end)

    Element.UIElements.MainContainer = New("CanvasGroup", {
        Size = UDim2.new(1,0,0,0),
        AutomaticSize = "Y",
        BackgroundTransparency = 1,
        Parent = Config.Parent,
        GroupTransparency = 1,
    }, {
        Element.UIElements.Main,
        New("UIPadding", {
            PaddingTop = UDim.new(0,2),
            PaddingLeft = UDim.new(0,2),
            PaddingRight = UDim.new(0,2),
            PaddingBottom = UDim.new(0,2),
        })
    })
    
    -- Element.UIElements.Main.Title.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    --     Element.UIElements.Main.Size = UDim2.new(
    --         1,
    --         0,
    --         0,
    --         Element.UIElements.Main.Title.UIListLayout.AbsoluteContentSize.Y + (Element.UIPadding+3)*2
    --     )
    --     Element.UIElements.Main.Title.Size = UDim2.new(
    --         1,
    --         0,
    --         0,
    --         Element.UIElements.Main.Title.UIListLayout.AbsoluteContentSize.Y
    --     )
    --     Element.UIElements.MainContainer.Size = UDim2.new(
    --         1,
    --         0,
    --         0,
    --         Element.UIElements.Main.AbsoluteSize.Y
    --     )
    -- end)
    
    local Desc
    
    if Element.Desc then
        Desc = New("TextLabel", {
            Text = Element.Desc,
            ThemeTag = {
                    TextColor3 = not Element.Color and "Text" or nil
            },
            TextColor3 = Element.Color and ( Element.Color == "White" and Color3.new(0,0,0) or Color3.new(1,1,1) ),
            TextTransparency = 0.4,
            TextSize = 15,
            TextWrapped = true,
            RichText = true,
            LayoutOrder = 9999,
            Name = "Desc",
            TextXAlignment = "Left",
            Size = UDim2.new(1,-Config.TextOffset,0,0),
            FontFace = Font.new(Creator.Font, Enum.FontWeight.Medium),
            BackgroundTransparency = 1,
            AutomaticSize = "Y",
            Parent = Element.UIElements.Main.Title
        })
        -- Desc:GetPropertyChangedSignal("TextBounds"):Connect(function()
        --     Desc.Size = UDim2.new(1,-Config.TextOffset,0,Desc.TextBounds.Y)
        -- end)
    else
        Element.UIElements.Main.Title.AnchorPoint = Vector2.new(0,Config.IsButtons and 0 or 0.5)
        Element.UIElements.Main.Title.Size = UDim2.new(1,Element.Image and -(ImageSize+Element.UIPadding),0,0)
        Element.UIElements.Main.Title.Position = UDim2.new(0,Element.Image and ImageSize+Element.UIPadding or 0,Config.IsButtons and 0 or 0.5,0)
    end
    
    if Element.Hover then
        Element.UIElements.Main.MouseEnter:Connect(function()
            if CanHover then
                Tween(Element.UIElements.Main.Highlight, 0.066, {BackgroundTransparency = 0.97}):Play()
            end
        end)
        -- Element.UIElements.Main.MouseLeave:Connect(function()
        --     if CanHover then
        --     end
        -- end)
        
        Element.UIElements.Main.MouseButton1Down:Connect(function()
            if CanHover then
                Hovering = true
                Tween(Element.UIElements.Main.UIScale, 0.11, {Scale = .98}, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out):Play()
            end
        end)
        
        Element.UIElements.Main.InputEnded:Connect(function()
            if CanHover then
                Tween(Element.UIElements.Main.Highlight, 0.066, {BackgroundTransparency = 1}):Play()
                Tween(Element.UIElements.Main.UIScale, 0.175, {Scale = 1}, Enum.EasingStyle.Back, Enum.EasingDirection.Out):Play()
                task.wait(.16)
                Hovering = false
            end
        end)
    end
    
    local ElementSizing = Element.UIElements.Main:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
        if not Hovering then
            Element.UIElements.MainContainer.Size = UDim2.new(1,0,0,Element.UIElements.Main.AbsoluteSize.Y)
        end
    end)
    
    function Element:SetTitle(Title)
        Element.UIElements.Main.Title.Title.Text = Title
    end
    function Element:SetDesc(Title)
        if Desc then
            Desc.Text = Title
        else
            Desc = New("TextLabel", {
                Text = Title,
                ThemeTag = {
                    TextColor3 = not Element.Color and "Text" or nil
                },
                TextColor3 = Element.Color and ( Element.Color == "White" and Color3.new(0,0,0) or Color3.new(1,1,1) ),
                TextTransparency = 0.4,
                TextSize = 15,
                TextWrapped = true,
                TextXAlignment = "Left",
                Size = UDim2.new(1,-Config.TextOffset,0,0),
                FontFace = Font.new(Creator.Font, Enum.FontWeight.Medium),
                BackgroundTransparency = 1,
                AutomaticSize = "Y",
                Parent = Element.UIElements.Main.Title
            })
            -- Desc:GetPropertyChangedSignal("TextBounds"):Connect(function()
            --     Desc.Size = UDim2.new(1,-Config.TextOffset,0,Desc.TextBounds.Y)
            -- end)
        end
    end
    
    function Element:Show()
        Tween(Element.UIElements.MainContainer, .1, {GroupTransparency = 0}):Play()
        Tween(Element.UIElements.Main.UIScale, .1, {Scale= 1}):Play()
        
        --ElementSizing:Disconnect()
        --task.wait(.1)
        --Tween(Element.UIElements.MainContainer, .15, {Size = UDim2.new(1,0,0,0)}, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut):Play()
        
        --Element.UIElements.MainContainer:Destroy()
    end
    function Element:Destroy()
        Tween(Element.UIElements.MainContainer, .15, {GroupTransparency = 1}):Play()
        Tween(Element.UIElements.Main.UIScale, .15, {Scale = .98}):Play()
        
        ElementSizing:Disconnect()
        Element.UIElements.MainContainer.AutomaticSize = "None"
        task.wait(.1)
        Tween(Element.UIElements.MainContainer, .18, {Size = UDim2.new(1,0,0,-6)}, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut):Play()
        task.wait(.23)
        Element.UIElements.MainContainer:Destroy()
    end
    
    function Element:Lock()
        Tween(Element.UIElements.Main.Lock, .08, {BackgroundTransparency = .6}):Play()
        Tween(Element.UIElements.Main.Lock.ImageLabel, .08, {ImageTransparency = 0}):Play()
        Tween(Element.UIElements.Main.Lock.TextLabel, .08, {TextTransparency = 0}):Play()
        Element.UIElements.Main.Lock.Active = true
        CanHover = false
    end
    function Element:Unlock()
        Tween(Element.UIElements.Main.Lock, .08, {BackgroundTransparency = 1}):Play()
        Tween(Element.UIElements.Main.Lock.ImageLabel, .08, {ImageTransparency = 1}):Play()
        Tween(Element.UIElements.Main.Lock.TextLabel, .08, {TextTransparency = 1}):Play()
        Element.UIElements.Main.Lock.Active = false
        CanHover = true
    end
    
    task.wait(.015)
    
    Element:Show()
    
    return Element
end