local WindUI = {
    Window = nil,
    Theme = nil,
    Themes = nil,
    Transparent = false,
    
    TransparencyValue = .25,
}
local RunService = game:GetService("RunService")

local Themes = require("./Themes/init")
local KeySystem = require("./Components/KeySystem")
local Creator = require("./Creator")

local New = Creator.New
local Tween = Creator.Tween

local LocalPlayer = game:GetService("Players") and game:GetService("Players").LocalPlayer or nil

WindUI.Themes = Themes

local ProtectGui = protectgui or (syn and syn.protect_gui) or function() end


WindUI.ScreenGui = New("ScreenGui", {
    Name = "WindUI",
    Parent = gethui and gethui() or game.CoreGui,
    --Parent = game.CoreGui,
    IgnoreGuiInset = true,
}, {
    New("Folder", {
        Name = "Window"
    }),
    New("Folder", {
        Name = "Notifications"
    }),
    New("Folder", {
        Name = "Dropdowns"
    }),
    New("Folder", {
        Name = "KeySystem"
    }),
    New("Folder", {
        Name = "Popups"
    }),
    New("Folder", {
        Name = "ToolTips"
    })
})
ProtectGui(WindUI.ScreenGui)


local Notify = require("./Components/Notification")
local Holder = Notify.Init(WindUI.ScreenGui.Notifications)

function WindUI:Notify(Config)
    Config.Holder = Holder.Frame
    Config.Window = WindUI.Window
    Config.WindUI = WindUI
    return Notify.New(Config)
end

function WindUI:SetNotificationLower(Val)
    Holder.SetLower(Val)
end

function WindUI:SetFont(FontId)
    Creator.UpdateFont(FontId)
end

function WindUI:AddTheme(LTheme)
    Themes[LTheme.Name] = LTheme
    return LTheme
end

function WindUI:SetTheme(Value)
    if Themes[Value] then
        WindUI.Theme = Themes[Value]
        Creator.SetTheme(Themes[Value])
        Creator.UpdateTheme()
        
        return Themes[Value]
    end
    return nil
end

WindUI:SetTheme("Dark")

function WindUI:GetThemes()
    return Themes
end
function WindUI:GetCurrentTheme()
    return WindUI.Theme.Name
end
function WindUI:GetTransparency()
    return WindUI.Transparent or false
end
function WindUI:GetWindowSize()
    return Window.UIElements.Main.Size
end


function WindUI:Popup(PopupConfig)
    PopupConfig.WindUI = WindUI
    return require("./Components/Popup").new(PopupConfig)
    
end


function WindUI:CreateWindow(Config)
    local CreateWindow = require("./Components/Window")
    
    if not isfolder("WindUI") then
        makefolder("WindUI")
    end
    if Config.Folder then
        makefolder(Config.Folder)
    else
        makefolder(Config.Title)
    end
    
    Config.WindUI = WindUI
    Config.Parent = WindUI.ScreenGui.Window
    
    if WindUI.Window then
        warn("You cannot create more than one window")
        return
    end
    
    local CanLoadWindow = true
    
    local Theme = Themes[Config.Theme or "Dark"]
    
    WindUI.Theme = Theme
    
    Creator.SetTheme(Theme)
    
    local Filename = LocalPlayer.Name or "Unknown"
    
    if Config.KeySystem then
        CanLoadWindow = false
        if Config.KeySystem.SaveKey and Config.Folder then
            if isfile(Config.Folder .. "/" .. Filename .. ".key") then
                local isKey = tostring(Config.KeySystem.Key) == tostring(readfile(Config.Folder .. "/" .. Filename .. ".key" ))
                if type(Config.KeySystem.Key) == "table" then
                    isKey = table.find(Config.KeySystem.Key, readfile(Config.Folder .. "/" .. Filename .. ".key" ))
                end
                if isKey then
                    CanLoadWindow = true
                end
            else
                KeySystem.new(Config, Filename, function(c) CanLoadWindow=c end)
            end
        else
            KeySystem.new(Config, Filename, function(c) CanLoadWindow=c end)
        end
		repeat task.wait() until CanLoadWindow
    end
    
    local Window = CreateWindow(Config)

    WindUI.Transparent = Config.Transparent
    WindUI.Window = Window
    
    
    function Window:ToggleTransparency(Value)
        WindUI.Transparent = Value
        WindUI.Window.Transparent = Value
        
        Window.UIElements.Main.Background.BackgroundTransparency = Value and WindUI.TransparencyValue or 0
        Window.UIElements.Main.Background.ImageLabel.ImageTransparency = Value and WindUI.TransparencyValue or 0
        Window.UIElements.Main.Gradient.UIGradient.Transparency = NumberSequence.new{
            NumberSequenceKeypoint.new(0, 1), 
            NumberSequenceKeypoint.new(1, Value and 0.85 or 0.7),
        }
    end
    
    return Window
end

return WindUI