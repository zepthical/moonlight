local WindUI = loadstring(game:HttpGet("https://tree-hub.vercel.app/api/UI/WindUI"))()

-- Set theme:
-- WindUI:SetTheme("Dark")

--- EXAMPLE !!!

function gradient(text, startColor, endColor)
    local result = ""
    local length = #text

    for i = 1, length do
        local t = (i - 1) / math.max(length - 1, 1)
        local r = math.floor((startColor.R + (endColor.R - startColor.R) * t) * 255)
        local g = math.floor((startColor.G + (endColor.G - startColor.G) * t) * 255)
        local b = math.floor((startColor.B + (endColor.B - startColor.B) * t) * 255)

        local char = text:sub(i, i)
        result = result .. "<font color=\"rgb(" .. r ..", " .. g .. ", " .. b .. ")\">" .. char .. "</font>"
    end

    return result
end

local Confirmed = false

WindUI:Popup({
    Title = "Welcome!",
    Icon = "info",
    Content = "This is an Example UI for the " .. gradient("WindUI", Color3.fromHex("#00FF87"), Color3.fromHex("#60EFFF")) .. " Lib",
    Buttons = {
        {
            Title = "Cancel",
            --Icon = "",
            Callback = function() end,
            Variant = "Tertiary", -- Primary, Secondary, Tertiary
        },
        {
            Title = "Continue",
            Icon = "arrow-right",
            Callback = function() Confirmed = true end,
            Variant = "Primary", -- Primary, Secondary, Tertiary
        }
    }
})


repeat wait() until Confirmed

--

local Window = WindUI:CreateWindow({
    Title = "WindUI Library",
    Icon = "door-open",
    Author = "Example UI",
    Folder = "CloudHub",
    Size = UDim2.fromOffset(580, 460),
    Transparent = true,
    Theme = "Dark",
    UserEnabled = false,
    SideBarWidth = 200,
    --Background = "rbxassetid://13511292247", -- rbxassetid only
    HasOutline = true,
    -- remove it below if you don't want to use the key system in your script.
    KeySystem = { 
        Key = { "1234", "5678" },
        Note = "Example Key System. \n\nThe Key is '1234' or '5678",
        -- Thumbnail = {
        --     Image = "rbxassetid://18220445082", -- rbxassetid only
        --     Title = "Thumbnail"
        -- },
        URL = "https://github.com/Footagesus/WindUI", -- remove this if the key is not obtained from the link.
        SaveKey = true, -- optional
    },
})


--Window:SetBackgroundImage("rbxassetid://13511292247")


Window:EditOpenButton({
    Title = "Open Example UI",
    Icon = "monitor",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = ColorSequence.new( -- gradient
        Color3.fromHex("FF0F7B"), 
        Color3.fromHex("F89B29")
    ),
    --Enabled = false,
    Draggable = true,
})


local Tabs = {
    ParagraphTab = Window:Tab({ Title = "Paragraph", Icon = "type" }),
    ButtonTab = Window:Tab({ Title = "Button", Icon = "mouse-pointer-2", Desc = "Contains interactive buttons for various actions." }),
    CodeTab = Window:Tab({ Title = "Code", Icon = "code", Desc = "Displays and manages code snippets." }),
    ColorPickerTab = Window:Tab({ Title = "ColorPicker", Icon = "paintbrush", Desc = "Choose and customize colors easily." }),
    NotificationTab = Window:Tab({ Title = "Notification", Icon = "bell", Desc = "Configure and view notifications." }),
    ToggleTab = Window:Tab({ Title = "Toggle", Icon = "toggle-left", Desc = "Switch settings on and off." }),
    SliderTab = Window:Tab({ Title = "Slider", Icon = "sliders-horizontal", Desc = "Adjust values smoothly with sliders." }),
    InputTab = Window:Tab({ Title = "Input", Icon = "keyboard", Desc = "Accept text and numerical input." }),
    DropdownTab = Window:Tab({ Title = "Dropdown", Icon = "chevrons-up-down", Desc = "Select from multiple options." }),
    b = Window:Divider(),
    WindowTab = Window:Tab({ Title = "Window and File Configuration", Icon = "settings", Desc = "Manage window settings and file configurations." }),
    CreateThemeTab = Window:Tab({ Title = "Create Theme", Icon = "palette", Desc = "Design and apply custom themes." }),
    be = Window:Divider(),
    LongTab = Window:Tab({ Title = "Long and empty tab. Looong and empty.. tab.", Icon = "frown", Desc = "Long Description" }),
    LockedTab = Window:Tab({ Title = "Locked Tab", Icon = "lock", Desc = "This tab is locked", Locked = true }),
}

Window:SelectTab(1)


Tabs.ParagraphTab:Paragraph({
    Title = "Default",
    Desc = "Normal Paragraph",
    Image = "bird",
    --Color = "Red"
    Buttons = {
        {
            Title = "Ok!",
        },
        {
            Title = "Ok!",
        }
    }
})
Tabs.ParagraphTab:Paragraph({
    Title = "Danger (Error)",
    Desc = "Red Paragraph",
    Image = "triangle-alert",
    Color = "Red",
    Buttons = {
        {
            Title = "Ok!",
        },
        {
            Title = "Ok!",
        }
    }
})
Tabs.ParagraphTab:Paragraph({
    Title = "Warning",
    Desc = "Orange Paragraph",
    Image = "triangle-alert",
    Color = "Orange",
    Buttons = {
        {
            Title = "Ok!",
        },
        {
            Title = "Ok!",
        }
    }
})
Tabs.ParagraphTab:Paragraph({
    Title = "Success",
    Desc = "Green Paragraph",
    Image = "check",
    Color = "Green",
    Buttons = {
        {
            Title = "Ok!",
        },
        {
            Title = "Ok!",
        }
    }
})
Tabs.ParagraphTab:Paragraph({
    Title = "Info",
    Desc = "Blue Paragraph",
    Image = "info",
    Color = "Blue",
    Buttons = {
        {
            Title = "Ok!",
        },
        {
            Title = "Ok!",
        }
    }
})
Tabs.ParagraphTab:Paragraph({
    Title = "Grey",
    Desc = "Grey Paragraph",
    Image = "bird",
    Color = "Grey",
    Buttons = {
        {
            Title = "Ok!",
        },
        {
            Title = "Ok!",
        }
    }
})
Tabs.ParagraphTab:Paragraph({
    Title = "White",
    Desc = "White Paragraph",
    Image = "bird",
    Color = "White",
    Buttons = {
        {
            Title = "Ok!",
        },
        {
            Title = "Ok!",
        }
    }
})




Tabs.ButtonTab:Button({
    Title = "Click Me",
    Desc = "This is a simple button",
    Callback = function() print("Button Clicked!") end
})

Tabs.ButtonTab:Button({
    Title = "Locked Button",
    Desc = "This button is locked",
    Locked = true,
})

local destroybtn
destroybtn = Tabs.ButtonTab:Button({
    Title = "Click to destroy me!",
    Callback = function() destroybtn:Destroy() end,
})

Tabs.ButtonTab:Button({
    Title = "Submit",
    Desc = "Click to submit",
    Callback = function() print("Submitted!") end,
})

Tabs.ButtonTab:Button({
    Title = "Set ToggleKey to 'F'",
    Callback = function() Window:SetToggleKey(Enum.KeyCode.F) end,
})


Tabs.CodeTab:Code({
    Title = "example-code.lua",
    Code = [[
local message = "Hello"
print(message)

if message == "Hello" then
    print("Greetings!")
end]],
})

Tabs.CodeTab:Code({
    Title = "example-code-2-longggggg-looooonnnnnnggggggggggggggg.lua",
    Code = [[
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/refs/heads/main/dist/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "WindUI Example",
    Icon = "image",
    Author = ".ftgs",
    Folder = "CloudHub",
    Size = UDim2.fromOffset(580, 460),
})]],
})


Tabs.ColorPickerTab:Colorpicker({
    Title = "Pick a Color",
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(color) print("Selected color: " .. tostring(color)) end
})

Tabs.ColorPickerTab:Colorpicker({
    Title = "Transparency Color",
    Default = Color3.fromRGB(0, 0, 255),
    Transparency = 0,
    Callback = function(color) print("Background color: " .. tostring(color)) end
})


Tabs.NotificationTab:Button({
    Title = "Click to get Notified",
    Callback = function() 
        WindUI:Notify({
            Title = "Notification Example 1",
            Content = "Content",
            Duration = 5,
        })
    end
})

Tabs.NotificationTab:Button({
    Title = "Notification with icon",
    Callback = function() 
        WindUI:Notify({
            Title = "Notification Example 2",
            Content = "Content",
            Icon = "droplet-off",
            Duration = 5,
        })
    end
})

Tabs.NotificationTab:Button({
    Title = "Notification with BackgroundImage",
    Callback = function() 
        WindUI:Notify({
            Title = "Notification Example 3",
            Content = "with BackgroundImage",
            Icon = "image",
            Duration = 5,
            Background = "rbxassetid://13511292247"
        })
    end
})


Tabs.ToggleTab:Toggle({
    Title = "Enable Feature",
    Default = true,
    Callback = function(state) print("Feature enabled: " .. tostring(state)) end
})

Tabs.ToggleTab:Toggle({
    Title = "Activate Mode",
    Default = false,
    Callback = function(state) print("Mode activated: " .. tostring(state)) end
})
Tabs.ToggleTab:Toggle({
    Title = "Toggle with icon",
    Icon = "check",
    Default = false,
    Callback = function(state) print("Toggle with icon activated: " .. tostring(state)) end
})


Tabs.SliderTab:Slider({
    Title = "Volume Slider",
    Value = {
        Min = 0,
        Max = 100,
        Default = 50,
    },
    Callback = function(value) print("Volume set to: " .. value) end
})

Tabs.SliderTab:Slider({
    Title = "Brightness Slider",
    Value = {
        Min = 1,
        Max = 100,
        Default = 75,
    },
    Callback = function(value) print("Brightness set to: " .. value) end
})


Tabs.InputTab:Input({
    Title = "Username",
    Default = "Guest",
    Placeholder = "Enter your username",
    Callback = function(input) print("Username: " .. input) end
})

Tabs.InputTab:Input({
    Title = "Password",
    Default = "",
    Placeholder = "Enter your password",
    Callback = function(input) print("Password entered.") end
})


Tabs.DropdownTab:Dropdown({
    Title = "Select an Option",
    Values = { "Option 1", "Option 2", "Option 3" },
    Value = "Option 1",
    Callback = function(option) print("Selected: " .. option) end
})

Tabs.DropdownTab:Dropdown({
    Title = "Choose a Category",
    Values = { "Category A", "Category B", "Category C" },
    Value = "Category A",
    Callback = function(option) print("Category selected: " .. option) end
})



-- Configuration
-- Optional


local HttpService = game:GetService("HttpService")

local folderPath = "WindUI"
makefolder(folderPath)

local function SaveFile(fileName, data)
    local filePath = folderPath .. "/" .. fileName .. ".json"
    local jsonData = HttpService:JSONEncode(data)
    writefile(filePath, jsonData)
end

local function LoadFile(fileName)
    local filePath = folderPath .. "/" .. fileName .. ".json"
    if isfile(filePath) then
        local jsonData = readfile(filePath)
        return HttpService:JSONDecode(jsonData)
    end
end

local function ListFiles()
    local files = {}
    for _, file in ipairs(listfiles(folderPath)) do
        local fileName = file:match("([^/]+)%.json$")
        if fileName then
            table.insert(files, fileName)
        end
    end
    return files
end

Tabs.WindowTab:Section({ Title = "Window" })

local themeValues = {}
for name, _ in pairs(WindUI:GetThemes()) do
    table.insert(themeValues, name)
end

local themeDropdown = Tabs.WindowTab:Dropdown({
    Title = "Select Theme",
    Multi = false,
    AllowNone = false,
    Value = nil,
    Values = themeValues,
    Callback = function(theme)
        WindUI:SetTheme(theme)
    end
})
themeDropdown:Select(WindUI:GetCurrentTheme())

local ToggleTransparency = Tabs.WindowTab:Toggle({
    Title = "Toggle Window Transparency",
    Callback = function(e)
        Window:ToggleTransparency(e)
    end,
    Value = WindUI:GetTransparency()
})

Tabs.WindowTab:Section({ Title = "Save" })

local fileNameInput = ""
Tabs.WindowTab:Input({
    Title = "Write File Name",
    PlaceholderText = "Enter file name",
    Callback = function(text)
        fileNameInput = text
    end
})

Tabs.WindowTab:Button({
    Title = "Save File",
    Callback = function()
        if fileNameInput ~= "" then
            SaveFile(fileNameInput, { Transparent = WindUI:GetTransparency(), Theme = WindUI:GetCurrentTheme() })
        end
    end
})

Tabs.WindowTab:Section({ Title = "Load" })

local filesDropdown
local files = ListFiles()

filesDropdown = Tabs.WindowTab:Dropdown({
    Title = "Select File",
    Multi = false,
    AllowNone = true,
    Values = files,
    Callback = function(selectedFile)
        fileNameInput = selectedFile
    end
})

Tabs.WindowTab:Button({
    Title = "Load File",
    Callback = function()
        if fileNameInput ~= "" then
            local data = LoadFile(fileNameInput)
            if data then
                WindUI:Notify({
                    Title = "File Loaded",
                    Content = "Loaded data: " .. HttpService:JSONEncode(data),
                    Duration = 5,
                })
                if data.Transparent then 
                    Window:ToggleTransparency(data.Transparent)
                    ToggleTransparency:SetValue(data.Transparent)
                end
                if data.Theme then WindUI:SetTheme(data.Theme) end
            end
        end
    end
})

Tabs.WindowTab:Button({
    Title = "Overwrite File",
    Callback = function()
        if fileNameInput ~= "" then
            SaveFile(fileNameInput, { Transparent = WindUI:GetTransparency(), Theme = WindUI:GetCurrentTheme() })
        end
    end
})

Tabs.WindowTab:Button({
    Title = "Refresh List",
    Callback = function()
        filesDropdown:Refresh(ListFiles())
    end
})

local currentThemeName = WindUI:GetCurrentTheme()
local themes = WindUI:GetThemes()

local ThemeAccent = themes[currentThemeName].Accent
local ThemeOutline = themes[currentThemeName].Outline
local ThemeText = themes[currentThemeName].Text
local ThemePlaceholderText = themes[currentThemeName].PlaceholderText

function updateTheme()
    WindUI:AddTheme({
        Name = currentThemeName,
        Accent = ThemeAccent,
        Outline = ThemeOutline,
        Text = ThemeText,
        PlaceholderText = ThemePlaceholderText
    })
    WindUI:SetTheme(currentThemeName)
end

local CreateInput = Tabs.CreateThemeTab:Input({
    Title = "Theme Name",
    Value = currentThemeName,
    Callback = function(name)
        currentThemeName = name
    end
})

Tabs.CreateThemeTab:Colorpicker({
    Title = "Background Color",
    Default = Color3.fromHex(ThemeAccent),
    Callback = function(color)
        ThemeAccent = color:ToHex()
    end
})

Tabs.CreateThemeTab:Colorpicker({
    Title = "Outline Color",
    Default = Color3.fromHex(ThemeOutline),
    Callback = function(color)
        ThemeOutline = color:ToHex()
    end
})

Tabs.CreateThemeTab:Colorpicker({
    Title = "Text Color",
    Default = Color3.fromHex(ThemeText),
    Callback = function(color)
        ThemeText = color:ToHex()
    end
})

Tabs.CreateThemeTab:Colorpicker({
    Title = "Placeholder Text Color",
    Default = Color3.fromHex(ThemePlaceholderText),
    Callback = function(color)
        ThemePlaceholderText = color:ToHex()
    end
})

Tabs.CreateThemeTab:Button({
    Title = "Update Theme",
    Callback = function()
        updateTheme()
    end
})