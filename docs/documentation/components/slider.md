# Slider

On this page
[[toc]]

## Slider
### Create Slider
```lua
local Slider = Tab:Slider({
    Title = "Slider",
    Step = 1,
    Value = {
        Min = 20,
        Max = 120,
        Default = 70,
    },
    Callback = function(value)
        game.Workspace.Camera.FieldOfView = value
    end
})
```

### Edit Slider
- SetTitle()
```lua
Slider:SetTitle("New Title!")
```
- SetDesc()
```lua
Slider:SetDesc("New Description!")
```