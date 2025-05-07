local PopupModule = {}

local Creator = require("../Creator")
local New = Creator.New
local Tween = Creator.Tween


function PopupModule.new(PopupConfig)
    local Popup = {
        Title = PopupConfig.Title or "Dialog",
        Content = PopupConfig.Content,
        Icon = PopupConfig.Icon,
        Thumbnail = PopupConfig.Thumbnail,
        Buttons = PopupConfig.Buttons
    }
    
    local DialogInit = require("./Dialog").Init(PopupConfig.WindUI.ScreenGui.Popups)
    local Dialog = DialogInit.Create(true)
    
    local ThumbnailSize = 200
    
    local UISize = 430
    if Popup.Thumbnail and Popup.Thumbnail.Image then
        UISize = 430+(ThumbnailSize/2)
    end
    
    Dialog.UIElements.Main.AutomaticSize = "Y"
    Dialog.UIElements.Main.Size = UDim2.new(0,UISize,0,0)
    
    
    
    local IconFrame
    
    if Popup.Icon then
        local themetag = { ImageColor3 = "Text" }
        
        if string.find(Popup.Icon, "rbxassetid://") or not Creator.Icon(tostring(Popup.Icon))[1] then
            themetag = nil
        end
        IconFrame = New("ImageLabel", {
            Size = UDim2.new(0,24,0,24),
            BackgroundTransparency = 1,
            LayoutOrder = -1,
            ThemeTag = themetag
        })
        if string.find(Popup.Icon, "rbxassetid://") or string.find(Popup.Icon, "http://www.roblox.com/asset/?id=") then
            IconFrame.Image = Popup.Icon
        elseif string.find(Popup.Icon,"http") then
            local success, response = pcall(function()
                if not isfile("WindUI/" .. Window.Folder .. "/Assets/.Icon.png") then
                    local response = request({
                        Url = Popup.Icon,
                        Method = "GET",
                    }).Body
                    writefile("WindUI/" .. Window.Folder .. "/Assets/.Icon.png", response)
                end
                IconFrame.Image = getcustomasset("WindUI/" .. Window.Folder .. "/Assets/.Icon.png")
            end)
            if not success then
                IconFrame:Destroy()
                
                warn("[ WindUI ]  '" .. identifyexecutor() .. "' doesnt support the URL Images. Error: " .. response)
            end
        else
            if Creator.Icon(tostring(Popup.Icon))[1] then
                IconFrame.Image = Creator.Icon(Popup.Icon)[1]
                IconFrame.ImageRectOffset = Creator.Icon(Popup.Icon)[2].ImageRectPosition
                IconFrame.ImageRectSize = Creator.Icon(Popup.Icon)[2].ImageRectSize
            end
        end
    end
    
    
    local Title = New("TextLabel", {
        AutomaticSize = "XY",
        BackgroundTransparency = 1,
        Text = Popup.Title,
        FontFace = Font.new(Creator.Font, Enum.FontWeight.SemiBold),
        ThemeTag = {
            TextColor3 = "Text",
        },
        TextSize = 20
    })

    local IconAndTitleContainer = New("Frame", {
        BackgroundTransparency = 1,
        AutomaticSize = "XY",
    }, {
        New("UIListLayout", {
            Padding = UDim.new(0,14),
            FillDirection = "Horizontal",
            VerticalAlignment = "Center"
        }),
        IconFrame, Title
    })
    
    local TitleContainer = New("Frame", {
        AutomaticSize = "Y",
        Size = UDim2.new(1,0,0,0),
        BackgroundTransparency = 1,
    }, {
        -- New("UIListLayout", {
        --     Padding = UDim.new(0,9),
        --     FillDirection = "Horizontal",
        --     VerticalAlignment = "Bottom"
        -- }),
        IconAndTitleContainer,
    })
    
    local NoteText
    if Popup.Content and Popup.Content ~= "" then
        NoteText = New("TextLabel", {
            Size = UDim2.new(1,0,0,0),
            AutomaticSize = "Y",
            FontFace = Font.new(Creator.Font, Enum.FontWeight.Medium),
            TextXAlignment = "Left",
            Text = Popup.Content,
            TextSize = 18,
            TextTransparency = .4,
            ThemeTag = {
                TextColor3 = "Text",
            },
            BackgroundTransparency = 1,
            RichText = true
        })
    end

    local ButtonsContainer = New("Frame", {
        Size = UDim2.new(1,0,0,42),
        BackgroundTransparency = 1,
    }, {
        New("UIListLayout", {
            Padding = UDim.new(0,18/2),
            FillDirection = "Horizontal",
            HorizontalAlignment = "Right"
        })
    })
    
    local ThumbnailFrame
    if Popup.Thumbnail and Popup.Thumbnail.Image then
        local ThumbnailTitle
        if Popup.Thumbnail.Title then
            ThumbnailTitle = New("TextLabel", {
                Text = Popup.Thumbnail.Title,
                ThemeTag = {
                    TextColor3 = "Text",
                },
                TextSize = 18,
                FontFace = Font.new(Creator.Font, Enum.FontWeight.Medium),
                BackgroundTransparency = 1,
                AutomaticSize = "XY",
                AnchorPoint = Vector2.new(0.5,0.5),
                Position = UDim2.new(0.5,0,0.5,0),
            })
        end
        ThumbnailFrame = New("ImageLabel", {
            Image = Popup.Thumbnail.Image,
            BackgroundTransparency = 1,
            Size = UDim2.new(0,ThumbnailSize,1,0),
            Parent = Dialog.UIElements.Main,
            ScaleType = "Crop"
        }, {
            ThumbnailTitle,
            New("UICorner", {
                CornerRadius = UDim.new(0,0),
            })
        })
    end
    
    local MainFrame = New("Frame", {
        --AutomaticSize = "XY",
        Size = UDim2.new(1, ThumbnailFrame and -ThumbnailSize or 0,1,0),
        Position = UDim2.new(0, ThumbnailFrame and ThumbnailSize or 0,0,0),
        BackgroundTransparency = 1,
        Parent = Dialog.UIElements.Main
    }, {
        New("Frame", {
            --AutomaticSize = "XY",
            Size = UDim2.new(1,0,1,0),
            BackgroundTransparency = 1,
        }, {
            New("UIListLayout", {
                Padding = UDim.new(0,18),
                FillDirection = "Vertical",
            }),
            TitleContainer,
            NoteText,
            ButtonsContainer,
            New("UIPadding", {
                PaddingTop = UDim.new(0,16),
                PaddingLeft = UDim.new(0,16),
                PaddingRight = UDim.new(0,16),
                PaddingBottom = UDim.new(0,16),
            })
        }),
    })

    
    local function CreateButton(Title, Icon, Callback, Variant, Parent)
        local themetagbg = "Text"
        
        local IconButtonFrame
        if Icon and Icon ~= "" then
            IconButtonFrame = New("ImageLabel", {
                Image = Creator.Icon(Icon)[1],
                ImageRectSize = Creator.Icon(Icon)[2].ImageRectSize,
                ImageRectOffset = Creator.Icon(Icon)[2].ImageRectPosition,
                Size = UDim2.new(0,24-3,0,24-3),
                BackgroundTransparency = 1,
                ThemeTag = {
                    ImageColor3 = Variant ~= "Primary" and themetagbg or "Accent",
                }
            })
        end
        
        local ButtonFrame = New("TextButton", {
            
            Size = UDim2.new(0,0,1,0),
            AutomaticSize = "XY",
            -- Parent = ButtonsContainer,
            Parent = Parent,
            ThemeTag = {
                BackgroundColor3 = themetagbg,
            },
            BackgroundTransparency = Variant == "Primary" and .1 or Variant == "Secondary" and .85 or .95
        }, {
            New("UICorner", {
                CornerRadius = UDim.new(0,12),
            }),
            
            New("Frame", {
                Size = UDim2.new(1,0,1,0),
                ThemeTag = {
                    BackgroundColor3 = Variant == "Primary" and "Accent" or themetagbg
                },
                BackgroundTransparency = 1 -- .9
            }, {
                New("UIStroke", {
                    Thickness = 1.3,
                    ThemeTag = {
                        Color = "Text",
                    },
                    Transparency = Variant == "Tertiary" and .9 or 1,
                }),
                New("UIPadding", {
                    PaddingLeft = UDim.new(0,12),
                    PaddingRight = UDim.new(0,12),
                }),
                New("UICorner", {
                    CornerRadius = UDim.new(0,12),
                }),
                New("UIListLayout", {
                    FillDirection = "Horizontal",
                    Padding = UDim.new(0,12),
                    VerticalAlignment = "Center",
                    HorizontalAlignment = "Center",
                }),
                IconButtonFrame,
                New("TextLabel", {
                    BackgroundTransparency = 1,
                    FontFace = Font.new(Creator.Font, Enum.FontWeight.Medium),
                    Text = Title,
                    ThemeTag = {
                        TextColor3 = Variant ~= "Primary" and themetagbg or "Accent",
                    },
                    AutomaticSize = "XY",
                    TextSize = 18,
                })
            })
        })
        
        ButtonFrame.MouseEnter:Connect(function()
            Tween(ButtonFrame.Frame, .067, {BackgroundTransparency = .9}):Play()
        end)
        ButtonFrame.MouseLeave:Connect(function()
            Tween(ButtonFrame.Frame, .067, {BackgroundTransparency = 1}):Play()
        end)
        ButtonFrame.MouseButton1Up:Connect(function()
            Dialog:Close()
            Callback()
        end)
        
        return ButtonFrame
    end
    
    for _, values in next, Popup.Buttons do
        CreateButton(values.Title, values.Icon, values.Callback, values.Variant, ButtonsContainer)
    end
    
    Dialog:Open()
end

return PopupModule