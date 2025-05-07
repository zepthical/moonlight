# Keybind

On this page
[[toc]]

## Keybind
### Create Keybind
```lua
local Keybind = Tab:Keybind({
    Title = "Keybind",
    Desc = "Keybind Desc",
    Value = "LeftShift",
    CanChange = true,
    Callback = function(k)
        if not KeybindClicked then
            Window:Close()
        else
            Window:Open()
        end
        KeybindClicked = not KeybindClicked
    end
})
```

### Edit Keybind
- SetTitle()
```lua
Keybind:SetTitle("New Title!")
```
- SetDesc()
```lua
Keybind:SetDesc("New Description!")
```