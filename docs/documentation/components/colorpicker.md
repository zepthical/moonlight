# Colorpicker

On this page
[[toc]]

## Colorpicker
### Create Colorpicker
```lua
local Colorpicker2 = MainTab:Colorpicker({
    Title = "Colorpicker",
    Desc = "Colorpicker Desc",
    Transparency = 0.5,
    Default = Color3.fromRGB(96, 205, 255),
    Callback = function(color, transparency)
        print("Color: \nR: " .. math.floor(color.R * 255) .. "\nG: " .. math.floor(color.G * 255) .. "\nB: " .. math.floor(color.B * 255) .. "\nTransparency: " .. transparency)
    end
})
```

### Edit Colorpicker
- SetTitle()
```lua
Colorpicker:SetTitle("New Title!")
```
- SetDesc()
```lua
Colorpicker:SetDesc("New Description!")
```

- Update()
```lua
Colorpicker:Update(
    Color3.new(0.5,0.5,0.6), -- Color
    0.8 -- Transparency (Add only if transparency is enabled in the colorpicker)
)
```


> More soon...